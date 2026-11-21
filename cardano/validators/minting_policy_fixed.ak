use aiken/collection/list.{all}
use aiken/collection/dict.{keys, filter, foldr, is_empty}
use cardano/fuzz as cardano_fuzz
use aiken/fuzz as aiken_fuzz
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{PolicyId, AssetName, from_asset, from_asset_list, tokens}
use cardano/transaction.{Transaction, placeholder}

validator minting_policy_entradas_final_mundial(organizacion_vkey: ByteArray, token_name: AssetName, limite_por_tx: int256) {
    mint(_redeemer: Data, _policy_id: PolicyId, tx: Transaction) {
        let all_tokens = tokens(tx.mint, policy_id)
        let tokens_to_mint = filter(all_tokens, fn(_name, quantity){quantity > 0})

        // chequeamos que tengan como nombre el único permitido por la minting policy, así no pueden crear otros
        expect True == all(keys(all_tokens), fn(name){name == token_name}) 
        
        // cantidad limite válida
        expect limite_por_tx > 0 
        
        let amount_to_mint = foldr(tokens_to_mint, 0, fn(_asset_name, quantity, rec){rec + quantity})
        // no crear más del limite permitido, no hay restricción para burn
        expect amount_to_mint <= limite_por_tx
        
        !is_empty(tokens_to_mint) == list.has(tx.extra_signatories, organizacion_vkey) // si hay tokens que crear debe estar firmada, si solo quemamos no hace falta
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
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

// Como la minting policy no chequea que el nombre sea el esperado sino que este firmada por él que solicita el token entonces cualquier otro token con un AssetName distinto pasa como válido
test test_02_no_puedo_crear_token_no_valido() fail {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, "entrada_amistoso", 1),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

// Test complementario del anterior
test test_03_quemar_token_sin_firma_no_falla() {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, -1)
    }
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

// También si no chequeas cantidad, como la minting policy se ejecuta una vez por policyID podrías estar permitiendo una cantidad absurda de tokens sin darte cuenta. En nuestro ejemplo sería no respetar un límite de compra de entradas por persona
test test_04_no_puedo_crear_muchos_tokens_validos_en_una_transaccion() fail {
    let usuario: VerificationKeyHash = "FIFA"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset(policy_id, token_name, 100000000),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

// Suponiendo que no hubiera restricción sobre la cantidad de entradas compradas, si no hacés el chequeo de los requisitos sobre cada uno de tokens, te pueden estar pasando uno válido y muchos que no lo son y aceptás todos solo por el válido que viste
test test_05_uno_valido_no_tapa_resto_invalido() fail {
    let usuario: VerificationKeyHash = "FIFA"
    let invalid_name: AssetName = "entrada_amistoso"
    let tx = Transaction {
        ..placeholder, //Todos los campos no especificados vacios
        mint: from_asset_list([Pair(policy_id, [Pair(token_name, 1), Pair(invalid_name, 1000)])]),
        extra_signatories: [usuario]
    }
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

test prop_fixed_no_acepta_otros_nombres(name via cardano_fuzz.asset_name()) fail once{
  let usuario = "FIFA"
  let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, name, 1),
      extra_signatories: [usuario],
    }
  name == token_name || !minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

test prop_fixed_no_pide_firma_para_quemar(quantity via aiken_fuzz.int_at_least(1)) {
  let usuario = "FIFA"
  let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, token_name, -quantity),
    }
    minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)
}

test prop_fixed_tiene_limite_por_transaccion(quantity via aiken_fuzz.int_at_least(100)) fail once {
    let usuario = "FIFA"
    let tx =
    Transaction {
      ..placeholder,
      mint: from_asset(policy_id, token_name, quantity),
      extra_signatories: [usuario]
    }
    !minting_policy_entradas_final_mundial.mint(usuario, token_name, 1, Void, policy_id, tx)    
}