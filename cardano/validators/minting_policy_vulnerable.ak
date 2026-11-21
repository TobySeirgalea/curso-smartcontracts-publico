use aiken/collection/list
use cardano/fuzz as cardano_fuzz
use aiken/fuzz as aiken_fuzz
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{PolicyId, AssetName, from_asset, from_asset_list}
use cardano/transaction.{Transaction, placeholder}

validator minting_policy_entradas_final_mundial(organizacion_vkey: ByteArray) {
    mint(_redeemer: Data, _policy_id: PolicyId, tx: Transaction) {
        list.has(tx.extra_signatories, organizacion_vkey)
    }

    else(_) {
        fail @"unsuported purpose"
    }
}

// Tests

const policy_id : PolicyId = "minting_vulnerable"
const token_name: AssetName = "entrada_final_del_mundial"

test test_01_puedo_crear_token_valido() {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, 1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Como la minting policy no chequea que el nombre sea el esperado sino que este firmada por él que solicita el token entonces cualquier otro token con un AssetName distinto pasa como válido
test test_02_puedo_crear_token_no_valido() {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, "entrada_amistoso", 1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Por el dominio del problema puede que tus requerimientos para validar una operación de burn y una de mint no coincidan, así que si no chequeas la cantidad del token los estás forzando a coincidir. En el ejemplo que estamos desarrollando lo ideal sería que no se requiera que la organización del evento firme para anular tu entrada ya que, por ejemplo, haber comprado para dejar el lugar vacío en el evento así que la quemás para no usarla.
test test_03_para_quemar_token_necesito_firma_del_usuario() {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, -1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}
// Test complementario del anterior
test test_04_quemar_token_sin_firma_falla() fail {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, -1)
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// También si no chequeas cantidad, como la minting policy se ejecuta una vez por policyID podrías estar permitiendo una cantidad absurda de tokens sin darte cuenta. En nuestro ejemplo sería no respetar un límite de compra de entradas por persona
test test_05_puedo_crear_muchos_tokens_validos_en_una_transaccion() {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, 100000000),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

// Suponiendo que no hubiera restricción sobre la cantidad de entradas compradas, si no hacés el chequeo de los requisitos sobre cada uno de tokens, te pueden estar pasando uno válido y muchos que no lo son y aceptás todos solo por el válido que viste
test test_06_uno_valido_tapa_resto_invalido() {
    let usuario: VerificationKeyHash = "FIFA"
    let invalid_name: AssetName = "entrada_final_mundial_sub_17"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset_list([Pair(policy_id, [Pair(token_name, 1), Pair(invalid_name, 1000)])]),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

test prop_vulnerable_acepta_otros_nombres(name via cardano_fuzz.asset_name()) fail once {
  let usuario = "FIFA"
  let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, name, 1),
      extra_signatories: [usuario],
    }
  name == token_name || !minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

test prop_vulnerable_pide_firma_para_quemar(quantity via aiken_fuzz.int_at_least(1)) fail once {
  let usuario = "FIFA"
  let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, token_name, -quantity),
    }
    minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)
}

test prop_vulnerable_no_tiene_limite_por_transaccion(quantity via aiken_fuzz.int_at_least(10000)) fail once {
    let usuario = "FIFA"
    let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, token_name, quantity),
      extra_signatories: [usuario]
    }
    !minting_policy_entradas_final_mundial.mint(usuario, Void, policy_id, tx)    
}


