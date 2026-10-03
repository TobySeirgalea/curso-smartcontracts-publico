// Double satisfaction contra el devnet: la transacción del taller, de verdad.
//
//     ./scripts/devnet.sh up                      (en otra terminal)
//     npm run demo-double                         # contra escrow_vulnerable: la tx ENTRA
//     npm run demo-double -- escrow_fixed         # contra el arreglado: la cadena la RECHAZA
//     npm run demo-double -- mi_escrow_fixed      # contra el tuyo, si lo escribiste
//
// Es la escena 2 de scripts/demo-bugs-cardano.sh, pero mandada a una cadena: con
// fees, colateral, balanceo y un nodo que decide. Tres actos:
//
//   1. LOCK    Alice bloquea DOS UTXOs de 5 ADA en el escrow, los dos para Bob.
//   2. GASTO   Bob arma UNA transacción que gasta los dos y paga 5 ADA una sola
//              vez; el resto (los otros 5) va al cambio. Bob firma.
//   3. SALDOS  Se liberaron 10; a la dirección de Bob llegaron 5 por el output del
//              escrow, y el resto volvió como cambio menos la fee.
//
// Contra un validator con `single_script_input` el acto 2 se rechaza antes de
// salir: el evaluador corre los validators y uno devuelve False. Entonces hay que
// reclamar los dos UTXOs en DOS transacciones, que es lo que el fix obliga.
//
// Es el espejo on-chain del test vuln_double_satisfaction de escrow_vulnerable.ak:
// el test muestra que el validator aprueba; esto muestra que el nodo lo acepta.

import {
  ada, c, campo, corto, datosDe, esperarTx, linea, nota, pausa,
  relojDelLedger, saldo, script, titulo, txBuilder, utxosDelScript,
  verificarCadenaViva,
} from "./comun.js";
import { mConStr0 } from "@meshsdk/core";

// --- Qué validator ------------------------------------------------------------
const nombre = process.argv[2] ?? "escrow_vulnerable";
let s: ReturnType<typeof script>;
try {
  s = script(`${nombre}.${nombre}.spend`);
} catch {
  console.error(`No hay un validator '${nombre}' en cardano/plutus.json.`);
  if (nombre === "escrow_fixed") {
    console.error("escrow_fixed.ak no está en el repo de los alumnos: es la solución.");
  }
  console.error("Para probar uno tuyo: escribilo en cardano/validators/<nombre>.ak, con un");
  console.error("validator <nombre> y el mismo Datum que escrow_vulnerable, corré 'aiken build',");
  console.error("y después:  npm run demo-double -- <nombre>");
  process.exit(1);
}
const MONTO = 5_000_000n;          // lovelace por UTXO; también el `amount` del datum
const CLAIM = mConStr0([]);        // Redeemer Claim = constructor 0

// Datum { beneficiary, owner, deadline, amount }: constructor 0, cuatro campos.
const datumV = (beneficiary: string, owner: string, deadlineMs: number) =>
  mConStr0([beneficiary, owner, deadlineMs, Number(MONTO)]);

await verificarCadenaViva();
const alice = await datosDe("alice");   // owner: bloquea
const bob = await datosDe("bob");       // beneficiario de los dos UTXOs
const reloj = await relojDelLedger();

titulo(`DOUBLE SATISFACTION contra ${nombre}`);
campo("script", corto(s.address, 14));
campo("hash", s.hash);
nota("Alice bloquea dos UTXOs para Bob; Bob intenta llevarse los dos pagando uno.");
linea();
await pausa();

// --- 1. LOCK: dos UTXOs, los dos para Bob ------------------------------------
titulo("1 · LOCK: Alice bloquea dos UTXOs de 5 ADA, los dos para Bob");

const deadlineMs = (reloj.tiempoDe(reloj.slotActual) + 600) * 1000;
const d = datumV(bob.pubKeyHash, alice.pubKeyHash, deadlineMs);

const lock = txBuilder();
await lock
  .txOut(s.address, [{ unit: "lovelace", quantity: MONTO.toString() }])
  .txOutInlineDatumValue(d)
  .txOut(s.address, [{ unit: "lovelace", quantity: MONTO.toString() }])
  .txOutInlineDatumValue(d)
  .changeAddress(alice.address)
  .selectUtxosFrom(await alice.w.getUtxos())
  .complete();
const hashLock = await alice.w.submitTx(await alice.w.signTx(lock.txHex));
await esperarTx(hashLock);

const bloqueados = (await utxosDelScript(s.address)).filter(
  (u) => u.input.txHash === hashLock,
);
campo("tx", hashLock);
for (const u of bloqueados) {
  campo("UTXO", `${corto(u.input.txHash)} # ${u.input.outputIndex}   ${ada(MONTO)}`);
}
nota(`Depositar no ejecuta el validator. En el escrow hay ${ada(MONTO * 2n)} que son de Bob.`);
linea();
await pausa();

// --- 2. GASTO: una tx, dos inputs del escrow, un solo output al beneficiario --
titulo("2 · La transacción: dos inputs del escrow, UN solo pago de 5 ADA a Bob");

const saldoBob0 = await saldo(bob.address);
const colateral = (await bob.w.getUtxos()).find((u) => u.output.amount.length === 1)!;

const tx = txBuilder();
for (const u of bloqueados) {
  tx
    .spendingPlutusScript("V3")
    .txIn(u.input.txHash, u.input.outputIndex, u.output.amount, u.output.address)
    .txInScript(s.cbor)
    .txInInlineDatumPresent()
    .txInRedeemerValue(CLAIM);
}
tx
  .txOut(bob.address, [{ unit: "lovelace", quantity: MONTO.toString() }])  // UN solo pago
  .requiredSignerHash(bob.pubKeyHash)
  .txInCollateral(colateral.input.txHash, colateral.input.outputIndex,
                  colateral.output.amount, colateral.output.address)
  .invalidHereafter(reloj.slotDe(deadlineMs / 1000))
  .changeAddress(bob.address)
  .selectUtxosFrom(await bob.w.getUtxos());

campo("inputs", `${bloqueados.length} UTXOs del escrow  (${ada(MONTO * 2n)} liberados)`);
campo("output", `${ada(MONTO)} → Bob          ${c.amar}← uno solo${c.r}`);
campo("resto", "al cambio (menos fee)");
nota("`complete()` corre el evaluador: ejecuta los validators y calcula las ExUnits.");
console.log("");

let txHex: string;
try {
  await tx.complete();
  txHex = tx.txHex;
} catch (e) {
  rechazoEnEvaluador(e);
  process.exit(0);
}

const hashGasto = await bob.w.submitTx(await bob.w.signTx(txHex));
await esperarTx(hashGasto);
campo("tx", hashGasto);
if (nombre === "escrow_vulnerable") {
  console.log(`  ${c.rojo}La cadena ACEPTÓ la transacción.${c.r}`);
} else {
  console.log(`  ${c.amar}La cadena aceptó la transacción (el validator de ${nombre} no la frenó).${c.r}`);
}
linea();
await pausa();

// --- 3. SALDOS ---------------------------------------------------------------
titulo("3 · El resultado");
const saldoBob1 = await saldo(bob.address);
const quedan = (await utxosDelScript(s.address)).filter(
  (u) => u.input.txHash === hashLock,
).length;
campo("liberado", `${ada(MONTO * 2n)} salieron del escrow (${quedan} UTXOs quedan sin gastar)`);
campo("a Bob", `por el output del escrow: ${ada(MONTO)}`);
campo("Bob", `${ada(saldoBob0)} → ${ada(saldoBob1)}  ${c.d}(incluye el cambio, menos la fee)${c.r}`);
console.log("");
nota("Se liberaron 10 ADA y el escrow sólo exigió UN pago de 5: las dos corridas del validator");
nota("vieron el mismo output y aprobaron. Los otros 5 quedaron libres en la tx, para quien la");
nota("armó. Acá la armó Bob, así que vuelven a él; con otro armando la tx y Bob firmando,");
nota("serían de ese otro. Eso es la double satisfaction: un pago que satisface a dos.");

// ---------------------------------------------------------------------------
// El evaluador (ogmios) contesta con un volcado JSON enorme. Lo que importa: si
// es un fallo de scripts (código 3010) y cuáles de los validators fallaron. Con
// el fix fallan LOS DOS: cada corrida ve dos inputs del script en la tx.
function rechazoEnEvaluador(e: unknown) {
  const msg = String((e as any)?.message ?? e).replace(/\\n/g, "\n").replace(/\\"/g, '"');
  const esDeScripts = msg.includes("3010") || msg.includes("terminated with error");
  const fallaron = [...msg.matchAll(/"index"\s*:\s*(\d+),\s*"purpose"\s*:\s*"spend"/g)]
    .map((m) => Number(m[1]));

  if (!esDeScripts) {
    console.log(`  ${c.rojo}La transacción falló, pero NO por un validator.${c.r} Mirá el error:`);
    console.log(`  ${c.d}${msg.slice(0, 600)}${c.r}`);
    process.exit(1);
  }
  if (nombre === "escrow_vulnerable") {
    console.log(`  ${c.rojo}Un validator rechazó la transacción, y contra el vulnerable no debería.${c.r}`);
    console.log(`  ${c.d}¿Cambiaste escrow_vulnerable.ak? ¿Corriste 'aiken build'?${c.r}`);
    process.exit(1);
  }
  console.log(`  ${c.verde}${c.b}RECHAZADA.${c.r} El evaluador ejecutó los validators antes de enviarla:`);
  for (const i of fallaron) {
    campo(`input ${i}`, `${c.rojo}False${c.r}`);
  }
  console.log("");
  nota(`${nombre} exige un único input del script, y esta tx tiene dos: cada corrida lo ve y`);
  nota("devuelve False. Para reclamar los dos UTXOs hacen falta DOS transacciones, cada una");
  nota("con su propio pago. Eso es lo que cierra la double satisfaction.");
}
