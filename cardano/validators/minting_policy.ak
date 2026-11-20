use aiken/collection/list
use aiken/interval
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{PolicyId, AssetName, from_asset, from_asset_list}
use cardano/transaction.{OutputReference, Transaction, placeholder}

validator minting_policy_entradas_final_mundial(owner_vkey: ByteArray) {
    mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
        list.has(tx.extra_signatories, owner_vkey)
    }

    else(_) {
        fail @"unsuported purpose"
    }
}

// Tests

const policy_id : PolicyId = "minting_vulnerable"
const token_name: AssetName = "entrada_final_del_mundial"

test puedo_crear_token_valido() {
    let usuario: VerificationKeyHash = "usuario"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, 1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Como la minting policy no chequea que el nombre sea el esperado sino que este firmada por él que solicita el token entonces cualquier otro token con un AssetName distinto pasa como válido
test puedo_crear_token_no_valido() {
    let usuario: VerificationKeyHash = "usuario"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, "ticket_supermercado", 1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Por el dominio del problema puede que tus requerimientos para validar una operación de burn y una de mint no coincidan, así que si no chequeas la cantidad del token los estás forzando a coincidir. En el ejemplo que estamos desarrollando lo ideal sería que la organización del evento no requiera de tu autorización para anular tu entrada ya que, por ejemplo, podrías estar vetado de por vida de esos eventos, no querer firmar y que tu entrada siga siendo válida.
test para_quemar_token_necesito_firma_del_usuario() {
    let usuario: VerificationKeyHash = "usuario"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, -1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}
// Test complementario del anterior
test quemar_token_sin_firma_falla() fail {
    let usuario: VerificationKeyHash = "usuario"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, -1)
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// También si no chequeas cantidad, como la minting policy se ejecuta una vez por policyID podrías estar permitiendo una cantidad absurda de tokens sin darte cuenta. En nuestro ejemplo sería no respetar un límite de compra de entradas por persona
test puedo_crear_muchos_tokens_validos_en_una_transaccion() {
    let usuario: VerificationKeyHash = "usuario"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, 100000000),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Suponiendo que no hubiera restricción sobre la cantidad de entradas compradas, si no hacés el chequeo de los requisitos sobre cada uno de tokens, te pueden estar pasando uno válido y muchos que no lo son y aceptás todos solo por el válido que viste
test uno_valido_tapa_resto_invalido() {
    let usuario: VerificationKeyHash = "usuario"
    let invalid_name: AssetName = "ticket_supermercado"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset_list([Pair(policy_id, [Pair(token_name, 1)]), Pair(policy_id, [Pair(invalid_name, 1000)])]),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}