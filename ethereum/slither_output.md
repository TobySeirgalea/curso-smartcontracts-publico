'forge clean' running (wd: /curso/ethereum)
'forge config --json' running
'forge build --build-info --deny never src' running (wd: /curso/ethereum)
**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [reentrancy-eth](#reentrancy-eth) (1 results) (High)
 - [incorrect-shift](#incorrect-shift) (1 results) (High)
 - [shadowing-state](#shadowing-state) (1 results) (High)
 - [uninitialized-local](#uninitialized-local) (6 results) (Medium)
 - [unused-return](#unused-return) (5 results) (Medium)
 - [incorrect-modifier](#incorrect-modifier) (2 results) (Low)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (2 results) (Low)
 - [reentrancy-events](#reentrancy-events) (6 results) (Low)
 - [assembly](#assembly) (363 results) (Informational)
 - [boolean-equal](#boolean-equal) (2 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [costly-loop](#costly-loop) (1 results) (Informational)
 - [solc-version](#solc-version) (1 results) (Informational)
 - [low-level-calls](#low-level-calls) (11 results) (Informational)
 - [naming-convention](#naming-convention) (100 results) (Informational)
 - [redundant-statements](#redundant-statements) (1 results) (Informational)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [unindexed-event-address](#unindexed-event-address) (4 results) (Informational)
 - [cache-array-length](#cache-array-length) (1 results) (Optimization)
 - [constable-states](#constable-states) (1 results) (Optimization)
## reentrancy-eth
Impact: High
Confidence: Medium
 - [ ] ID-0
Reentrancy in [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81):
	External calls:
	- [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas.sol#L73)
	State variables written after the call(s):
	- [cantidad_invertida[inversor] = 0](src/dos_por_gas.sol#L71)
	[plazo_fijo.cantidad_invertida](src/dos_por_gas.sol#L11) can be used in cross function reentrancies:
	- [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81)
	- [plazo_fijo.invertir()](src/dos_por_gas.sol#L45-L61)
	- [inversores.pop()](src/dos_por_gas.sol#L69)
	[plazo_fijo.inversores](src/dos_por_gas.sol#L13) can be used in cross function reentrancies:
	- [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81)
	- [plazo_fijo.inversores](src/dos_por_gas.sol#L13)
	- [plazo_fijo.invertir()](src/dos_por_gas.sol#L45-L61)

src/dos_por_gas.sol#L64-L81


## incorrect-shift
Impact: High
Confidence: High
 - [ ] ID-1
[stdStorageSafe.getMaskByOffsets(uint256,uint256)](lib/forge-std/src/StdStorage.sol#L320-L326) contains an incorrect shift operation: [mask = 1 << 256 - offsetRight + offsetLeft - 1 << offsetRight](lib/forge-std/src/StdStorage.sol#L324)

lib/forge-std/src/StdStorage.sol#L320-L326


## shadowing-state
Impact: High
Confidence: High
 - [ ] ID-2
[StdCheats.vm](lib/forge-std/src/StdCheats.sol#L650) shadows:
	- [StdCheatsSafe.vm](lib/forge-std/src/StdCheats.sol#L9)

lib/forge-std/src/StdCheats.sol#L650


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-3
[StdCheatsSafe.rawToConvertedEIPTx1559(StdCheatsSafe.RawTx1559).transaction](lib/forge-std/src/StdCheats.sol#L391) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L391


 - [ ] ID-4
[StdCheatsSafe.readEIP1559ScriptArtifact(string).artifact](lib/forge-std/src/StdCheats.sol#L371) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L371


 - [ ] ID-5
[StdCheatsSafe.rawToConvertedEIP1559Detail(StdCheatsSafe.RawTx1559Detail).txDetail](lib/forge-std/src/StdCheats.sol#L408) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L408


 - [ ] ID-6
[stdStorageSafe.bytesToBytes32(bytes,uint256).out](lib/forge-std/src/StdStorage.sol#L284) is a local variable never initialized

lib/forge-std/src/StdStorage.sol#L284


 - [ ] ID-7
[stdStorageSafe.root(StdStorage).root_slot](lib/forge-std/src/StdStorage.sol#L268) is a local variable never initialized

lib/forge-std/src/StdStorage.sol#L268


 - [ ] ID-8
[StdCheatsSafe.rawToConvertedReceipt(StdCheatsSafe.RawReceipt).receipt](lib/forge-std/src/StdCheats.sol#L460) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L460


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-9
[stdStorageSafe.root(StdStorage)](lib/forge-std/src/StdStorage.sol#L262-L281) ignores return value by [(found,None,parent_slot) = vm.getMappingKeyAndParentOf(who,bytes32(child))](lib/forge-std/src/StdStorage.sol#L270)

lib/forge-std/src/StdStorage.sol#L262-L281


 - [ ] ID-10
[stdStorageSafe.find(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L106-L170) ignores return value by [(reads,None) = vm.accesses(address(who))](lib/forge-std/src/StdStorage.sol#L121)

lib/forge-std/src/StdStorage.sol#L106-L170


 - [ ] ID-11
[stdStorageSafe.root(StdStorage)](lib/forge-std/src/StdStorage.sol#L262-L281) ignores return value by [(found,None,parent_slot) = vm.getMappingKeyAndParentOf(who,bytes32(root_slot))](lib/forge-std/src/StdStorage.sol#L278)

lib/forge-std/src/StdStorage.sol#L262-L281


 - [ ] ID-12
[StdUtils.getTokenBalances(address,address[])](lib/forge-std/src/StdUtils.sol#L126-L153) ignores return value by [(None,returnData) = StdConstants.MULTICALL3_ADDRESS.aggregate(calls)](lib/forge-std/src/StdUtils.sol#L146)

lib/forge-std/src/StdUtils.sol#L126-L153


 - [ ] ID-13
[StdCheatsSafe.isFork()](lib/forge-std/src/StdCheats.sol#L583-L587) ignores return value by [vm.activeFork()](lib/forge-std/src/StdCheats.sol#L584-L586)

lib/forge-std/src/StdCheats.sol#L583-L587


## incorrect-modifier
Impact: Low
Confidence: High
 - [ ] ID-14
Modifier [StdCheatsSafe.skipWhenNotForking()](lib/forge-std/src/StdCheats.sol#L595-L599) does not always execute _; or revert

lib/forge-std/src/StdCheats.sol#L595-L599


 - [ ] ID-15
Modifier [StdCheatsSafe.skipWhenForking()](lib/forge-std/src/StdCheats.sol#L589-L593) does not always execute _; or revert

lib/forge-std/src/StdCheats.sol#L589-L593


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-16
[plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81) has external calls inside a loop: [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas.sol#L73)

src/dos_por_gas.sol#L64-L81


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-17
Reentrancy in [StdCheatsSafe.noGasMetering()](lib/forge-std/src/StdCheats.sol#L601-L620):
	External calls:
	- [vm.pauseGasMetering()](lib/forge-std/src/StdCheats.sol#L602)
	State variables written after the call(s):
	- [gasMeteringOff = true](lib/forge-std/src/StdCheats.sol#L611)
	- [gasMeteringOff = false](lib/forge-std/src/StdCheats.sol#L617)

lib/forge-std/src/StdCheats.sol#L601-L620


 - [ ] ID-18
Reentrancy in [StdAssertions.fail()](lib/forge-std/src/StdAssertions.sol#L51-L54):
	External calls:
	- [vm.store(address(vm),FAILED_SLOT,bytes32(uint256(1)))](lib/forge-std/src/StdAssertions.sol#L52)
	State variables written after the call(s):
	- [_failed = true](lib/forge-std/src/StdAssertions.sol#L53)

lib/forge-std/src/StdAssertions.sol#L51-L54


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-19
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L1268-L1299):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L1275)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L1276)
	Event emitted after the call(s):
	- [log(Error: Calls were not equal)](lib/forge-std/src/StdAssertions.sol#L1287)
	- [log(Error: Calls were not equal)](lib/forge-std/src/StdAssertions.sol#L1294)
	- [log_named_bytes(  Left call revert data,returnDataA)](lib/forge-std/src/StdAssertions.sol#L1288)
	- [log_named_bytes( Right call return data,returnDataB)](lib/forge-std/src/StdAssertions.sol#L1289)
	- [log_named_bytes(  Left call return data,returnDataA)](lib/forge-std/src/StdAssertions.sol#L1295)
	- [log_named_bytes( Right call revert data,returnDataB)](lib/forge-std/src/StdAssertions.sol#L1296)

lib/forge-std/src/StdAssertions.sol#L1268-L1299


 - [ ] ID-20
Reentrancy in [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81):
	External calls:
	- [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas.sol#L73)
	Event emitted after the call(s):
	- [Interes_devuelto(inversor)](src/dos_por_gas.sol#L79)

src/dos_por_gas.sol#L64-L81


 - [ ] ID-21
Reentrancy in [stdStorageSafe.find(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L106-L170):
	External calls:
	- [vm.record()](lib/forge-std/src/StdStorage.sol#L119)
	- [! checkSlotMutatesCall(self,reads[i])](lib/forge-std/src/StdStorage.sol#L133)
		- [vm.store(self._target,slot,testVal)](lib/forge-std/src/StdStorage.sol#L60)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L64)
	- [(found,offsetLeft,offsetRight) = findOffsets(self,reads[i])](lib/forge-std/src/StdStorage.sol#L141)
		- [vm.store(self._target,slot,bytes32(valueToPut))](lib/forge-std/src/StdStorage.sol#L74)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L92)
	Event emitted after the call(s):
	- [SlotFound(who,fsig,keccak256(bytes)(abi.encodePacked(params,field_depth)),uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L154)
	- [WARNING_UninitedSlot(who,uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L130)

lib/forge-std/src/StdStorage.sol#L106-L170


 - [ ] ID-22
Reentrancy in [stdStorageSafe.parent(StdStorage)](lib/forge-std/src/StdStorage.sol#L248-L260):
	External calls:
	- [vm.startMappingRecording()](lib/forge-std/src/StdStorage.sol#L251)
	- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L252)
		- [vm.store(self._target,slot,testVal)](lib/forge-std/src/StdStorage.sol#L60)
		- [vm.store(self._target,slot,bytes32(valueToPut))](lib/forge-std/src/StdStorage.sol#L74)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L92)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L64)
		- [vm.record()](lib/forge-std/src/StdStorage.sol#L119)
	Event emitted after the call(s):
	- [SlotFound(who,fsig,keccak256(bytes)(abi.encodePacked(params,field_depth)),uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L154)
		- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L252)
	- [WARNING_UninitedSlot(who,uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L130)
		- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L252)

lib/forge-std/src/StdStorage.sol#L248-L260


 - [ ] ID-23
Reentrancy in [plazo_fijo_arreglado.devolver_intereses()](src/dos_por_gas_arreglado.sol#L53-L64):
	External calls:
	- [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas_arreglado.sol#L59)
	Event emitted after the call(s):
	- [Interes_devuelto(inversor)](src/dos_por_gas_arreglado.sol#L63)

src/dos_por_gas_arreglado.sol#L53-L64


 - [ ] ID-24
Reentrancy in [stdStorageSafe.root(StdStorage)](lib/forge-std/src/StdStorage.sol#L262-L281):
	External calls:
	- [vm.startMappingRecording()](lib/forge-std/src/StdStorage.sol#L265)
	- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L266)
		- [vm.store(self._target,slot,testVal)](lib/forge-std/src/StdStorage.sol#L60)
		- [vm.store(self._target,slot,bytes32(valueToPut))](lib/forge-std/src/StdStorage.sol#L74)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L92)
		- [vm.store(self._target,slot,prevSlotValue)](lib/forge-std/src/StdStorage.sol#L64)
		- [vm.record()](lib/forge-std/src/StdStorage.sol#L119)
	Event emitted after the call(s):
	- [SlotFound(who,fsig,keccak256(bytes)(abi.encodePacked(params,field_depth)),uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L154)
		- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L266)
	- [WARNING_UninitedSlot(who,uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L130)
		- [child = find(self,true).slot - field_depth](lib/forge-std/src/StdStorage.sol#L266)

lib/forge-std/src/StdStorage.sol#L262-L281


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-25
[safeconsole.log(uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L1901-L1924) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1906-L1916)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1918-L1923)

lib/forge-std/src/safeconsole.sol#L1901-L1924


 - [ ] ID-26
[safeconsole.log(bytes32,bytes32,uint256,bool)](lib/forge-std/src/safeconsole.sol#L12857-L12905) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12867-L12892)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12894-L12904)

lib/forge-std/src/safeconsole.sol#L12857-L12905


 - [ ] ID-27
[safeconsole.log(uint256,uint256,bool,address)](lib/forge-std/src/safeconsole.sol#L8978-L9005) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8984-L8996)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8998-L9004)

lib/forge-std/src/safeconsole.sol#L8978-L9005


 - [ ] ID-28
[safeconsole.log(bool,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L1421-L1458) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1428-L1448)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1450-L1457)

lib/forge-std/src/safeconsole.sol#L1421-L1458


 - [ ] ID-29
[safeconsole.log(uint256,address,bytes32)](lib/forge-std/src/safeconsole.sol#L1698-L1735) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1705-L1725)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1727-L1734)

lib/forge-std/src/safeconsole.sol#L1698-L1735


 - [ ] ID-30
[safeconsole.log(bytes32,address,uint256)](lib/forge-std/src/safeconsole.sol#L2206-L2243) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2213-L2233)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2235-L2242)

lib/forge-std/src/safeconsole.sol#L2206-L2243


 - [ ] ID-31
[safeconsole.log(bytes32,bytes32,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L12907-L12955) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12917-L12942)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12944-L12954)

lib/forge-std/src/safeconsole.sol#L12907-L12955


 - [ ] ID-32
[safeconsole.log(uint256,bool)](lib/forge-std/src/safeconsole.sol#L389-L408) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L393-L401)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L403-L407)

lib/forge-std/src/safeconsole.sol#L389-L408


 - [ ] ID-33
[safeconsole.log(bool,address,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L5476-L5517) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5484-L5506)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5508-L5516)

lib/forge-std/src/safeconsole.sol#L5476-L5517


 - [ ] ID-34
[safeconsole.log(address,bool,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L3810-L3851) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3818-L3840)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3842-L3850)

lib/forge-std/src/safeconsole.sol#L3810-L3851


 - [ ] ID-35
[StdCheatsSafe.deployCode(string)](lib/forge-std/src/StdCheats.sol#L510-L517) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L512-L514)

lib/forge-std/src/StdCheats.sol#L510-L517


 - [ ] ID-36
[safeconsole.log(bytes32,bytes32,address)](lib/forge-std/src/safeconsole.sol#L2617-L2661) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2626-L2649)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2651-L2660)

lib/forge-std/src/safeconsole.sol#L2617-L2661


 - [ ] ID-37
[safeconsole.log(uint256,uint256,uint256,bool)](lib/forge-std/src/safeconsole.sol#L9137-L9164) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9143-L9155)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9157-L9163)

lib/forge-std/src/safeconsole.sol#L9137-L9164


 - [ ] ID-38
[safeconsole.log(address,bytes32,address)](lib/forge-std/src/safeconsole.sol#L955-L992) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L962-L982)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L984-L991)

lib/forge-std/src/safeconsole.sol#L955-L992


 - [ ] ID-39
[safeconsole.log(address,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L916-L953) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L923-L943)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L945-L952)

lib/forge-std/src/safeconsole.sol#L916-L953


 - [ ] ID-40
[safeconsole.log(uint256,address)](lib/forge-std/src/safeconsole.sol#L368-L387) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L372-L380)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L382-L386)

lib/forge-std/src/safeconsole.sol#L368-L387


 - [ ] ID-41
[safeconsole.log(uint256,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L2004-L2041) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2011-L2031)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2033-L2040)

lib/forge-std/src/safeconsole.sol#L2004-L2041


 - [ ] ID-42
[safeconsole.log(bytes32,bytes32,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L12957-L13012) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12969-L12997)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12999-L13011)

lib/forge-std/src/safeconsole.sol#L12957-L13012


 - [ ] ID-43
[safeconsole.log(bytes32,bytes32,bool,address)](lib/forge-std/src/safeconsole.sol#L12600-L12648) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12610-L12635)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12637-L12647)

lib/forge-std/src/safeconsole.sol#L12600-L12648


 - [ ] ID-44
[safeconsole.log(address,uint256,address)](lib/forge-std/src/safeconsole.sol#L841-L864) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L846-L856)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L858-L863)

lib/forge-std/src/safeconsole.sol#L841-L864


 - [ ] ID-45
[safeconsole.log(bytes32,bytes32,bool,bool)](lib/forge-std/src/safeconsole.sol#L12650-L12698) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12660-L12685)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12687-L12697)

lib/forge-std/src/safeconsole.sol#L12650-L12698


 - [ ] ID-46
[safeconsole.log(bool,uint256,bool,uint256)](lib/forge-std/src/safeconsole.sol#L6585-L6612) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6591-L6603)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6605-L6611)

lib/forge-std/src/safeconsole.sol#L6585-L6612


 - [ ] ID-47
[safeconsole.log(uint256,bool,address,bool)](lib/forge-std/src/safeconsole.sol#L8308-L8335) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8314-L8326)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8328-L8334)

lib/forge-std/src/safeconsole.sol#L8308-L8335


 - [ ] ID-48
[safeconsole.log(bool,bool,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L6261-L6302) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6269-L6291)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6293-L6301)

lib/forge-std/src/safeconsole.sol#L6261-L6302


 - [ ] ID-49
[StdUtils._sendLogPayloadView(bytes)](lib/forge-std/src/StdUtils.sol#L180-L187) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdUtils.sol#L183-L186)

lib/forge-std/src/StdUtils.sol#L180-L187


 - [ ] ID-50
[safeconsole.log(address,bytes32,bool,uint256)](lib/forge-std/src/safeconsole.sol#L4780-L4821) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4788-L4810)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4812-L4820)

lib/forge-std/src/safeconsole.sol#L4780-L4821


 - [ ] ID-51
[safeconsole.log(uint256,uint256,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L9195-L9236) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9203-L9225)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9227-L9235)

lib/forge-std/src/safeconsole.sol#L9195-L9236


 - [ ] ID-52
[safeconsole.log(uint256,bytes32,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L10104-L10159) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10116-L10144)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10146-L10158)

lib/forge-std/src/safeconsole.sol#L10104-L10159


 - [ ] ID-53
[safeconsole.log(bytes32,bool,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L11392-L11440) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11402-L11427)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11429-L11439)

lib/forge-std/src/safeconsole.sol#L11392-L11440


 - [ ] ID-54
[safeconsole.log(bytes32,bytes32,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L13185-L13247) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13199-L13230)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13232-L13246)

lib/forge-std/src/safeconsole.sol#L13185-L13247


 - [ ] ID-55
[safeconsole.log(uint256,uint256,bool)](lib/forge-std/src/safeconsole.sol#L1876-L1899) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1881-L1891)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1893-L1898)

lib/forge-std/src/safeconsole.sol#L1876-L1899


 - [ ] ID-56
[safeconsole.log(address,bytes32)](lib/forge-std/src/safeconsole.sol#L235-L268) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L241-L259)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L261-L267)

lib/forge-std/src/safeconsole.sol#L235-L268


 - [ ] ID-57
[safeconsole.log(bool,bytes32,uint256,bool)](lib/forge-std/src/safeconsole.sol#L7367-L7408) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7375-L7397)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7399-L7407)

lib/forge-std/src/safeconsole.sol#L7367-L7408


 - [ ] ID-58
[safeconsole.log(bool,address,uint256,bool)](lib/forge-std/src/safeconsole.sol#L5548-L5575) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5554-L5566)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5568-L5574)

lib/forge-std/src/safeconsole.sol#L5548-L5575


 - [ ] ID-59
[safeconsole.log(address)](lib/forge-std/src/safeconsole.sol#L90-L105) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L93-L99)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L101-L104)

lib/forge-std/src/safeconsole.sol#L90-L105


 - [ ] ID-60
[safeconsole.log(bool,bytes32)](lib/forge-std/src/safeconsole.sol#L333-L366) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L339-L357)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L359-L365)

lib/forge-std/src/safeconsole.sol#L333-L366


 - [ ] ID-61
[safeconsole.log(address,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L1072-L1116) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1081-L1104)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1106-L1115)

lib/forge-std/src/safeconsole.sol#L1072-L1116


 - [ ] ID-62
[console._castToPure(function(bytes))](lib/forge-std/src/console.sol#L14-L22) uses assembly
	- [INLINE ASM](lib/forge-std/src/console.sol#L19-L21)

lib/forge-std/src/console.sol#L14-L22


 - [ ] ID-63
[safeconsole.log(address,bytes32,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L5202-L5257) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5214-L5242)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5244-L5256)

lib/forge-std/src/safeconsole.sol#L5202-L5257


 - [ ] ID-64
[safeconsole.log(bytes32,bool,bool,address)](lib/forge-std/src/safeconsole.sol#L11084-L11125) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11092-L11114)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11116-L11124)

lib/forge-std/src/safeconsole.sol#L11084-L11125


 - [ ] ID-65
[safeconsole.log(uint256,bytes32,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L9861-L9902) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9869-L9891)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9893-L9901)

lib/forge-std/src/safeconsole.sol#L9861-L9902


 - [ ] ID-66
[safeconsole.log(address,address,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L3327-L3375) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3337-L3362)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3364-L3374)

lib/forge-std/src/safeconsole.sol#L3327-L3375


 - [ ] ID-67
[safeconsole.log(uint256,address,bool,address)](lib/forge-std/src/safeconsole.sol#L7840-L7867) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7846-L7858)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7860-L7866)

lib/forge-std/src/safeconsole.sol#L7840-L7867


 - [ ] ID-68
[safeconsole._sendLogPayload(uint256,uint256)](lib/forge-std/src/safeconsole.sol#L11-L18) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L14-L16)

lib/forge-std/src/safeconsole.sol#L11-L18


 - [ ] ID-69
[safeconsole.log(uint256,bool,bool,address)](lib/forge-std/src/safeconsole.sol#L8409-L8436) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8415-L8427)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8429-L8435)

lib/forge-std/src/safeconsole.sol#L8409-L8436


 - [ ] ID-70
[safeconsole.log(uint256,bytes32,bool,bool)](lib/forge-std/src/safeconsole.sol#L9639-L9680) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9647-L9669)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9671-L9679)

lib/forge-std/src/safeconsole.sol#L9639-L9680


 - [ ] ID-71
[safeconsole.log(uint256,bytes32,uint256,bool)](lib/forge-std/src/safeconsole.sol#L9818-L9859) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9826-L9848)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9850-L9858)

lib/forge-std/src/safeconsole.sol#L9818-L9859


 - [ ] ID-72
[safeconsole.log(bool)](lib/forge-std/src/safeconsole.sol#L107-L122) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L110-L116)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L118-L121)

lib/forge-std/src/safeconsole.sol#L107-L122


 - [ ] ID-73
[safeconsole.log(bool,bool,uint256,bool)](lib/forge-std/src/safeconsole.sol#L6117-L6144) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6123-L6135)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6137-L6143)

lib/forge-std/src/safeconsole.sol#L6117-L6144


 - [ ] ID-74
[safeconsole.log(bool,bytes32,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L7553-L7601) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7563-L7588)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7590-L7600)

lib/forge-std/src/safeconsole.sol#L7553-L7601


 - [ ] ID-75
[safeconsole.log(uint256,bytes32,address,uint256)](lib/forge-std/src/safeconsole.sol#L9503-L9544) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9511-L9533)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9535-L9543)

lib/forge-std/src/safeconsole.sol#L9503-L9544


 - [ ] ID-76
[safeconsole.log(uint256,bool,bool,uint256)](lib/forge-std/src/safeconsole.sol#L8467-L8494) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8473-L8485)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8487-L8493)

lib/forge-std/src/safeconsole.sol#L8467-L8494


 - [ ] ID-77
[safeconsole.log(bool,uint256,address,bytes32)](lib/forge-std/src/safeconsole.sol#L6484-L6525) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6492-L6514)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6516-L6524)

lib/forge-std/src/safeconsole.sol#L6484-L6525


 - [ ] ID-78
[safeconsole.log(bytes32,uint256,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L12286-L12334) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12296-L12321)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12323-L12333)

lib/forge-std/src/safeconsole.sol#L12286-L12334


 - [ ] ID-79
[safeconsole.log(address,address,address,address)](lib/forge-std/src/safeconsole.sol#L2808-L2835) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2814-L2826)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2828-L2834)

lib/forge-std/src/safeconsole.sol#L2808-L2835


 - [ ] ID-80
[safeconsole.log(address,bool,bool,address)](lib/forge-std/src/safeconsole.sol#L3507-L3534) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3513-L3525)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3527-L3533)

lib/forge-std/src/safeconsole.sol#L3507-L3534


 - [ ] ID-81
[safeconsole.log(address,bool,bool)](lib/forge-std/src/safeconsole.sol#L752-L775) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L757-L767)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L769-L774)

lib/forge-std/src/safeconsole.sol#L752-L775


 - [ ] ID-82
[safeconsole.log(bytes32,bytes32,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L13128-L13183) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13140-L13168)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13170-L13182)

lib/forge-std/src/safeconsole.sol#L13128-L13183


 - [ ] ID-83
[safeconsole.log(bytes32,address,bool)](lib/forge-std/src/safeconsole.sol#L2167-L2204) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2174-L2194)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2196-L2203)

lib/forge-std/src/safeconsole.sol#L2167-L2204


 - [ ] ID-84
[safeconsole.log(address,address,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L3025-L3066) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3033-L3055)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3057-L3065)

lib/forge-std/src/safeconsole.sol#L3025-L3066


 - [ ] ID-85
[safeconsole.log(bytes32,uint256,uint256,address)](lib/forge-std/src/safeconsole.sol#L12007-L12048) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12015-L12037)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12039-L12047)

lib/forge-std/src/safeconsole.sol#L12007-L12048


 - [ ] ID-86
[safeconsole.log(uint256,uint256,address,bytes32)](lib/forge-std/src/safeconsole.sol#L8935-L8976) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8943-L8965)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8967-L8975)

lib/forge-std/src/safeconsole.sol#L8935-L8976


 - [ ] ID-87
[safeconsole.log(uint256,address,uint256,bool)](lib/forge-std/src/safeconsole.sol#L7999-L8026) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8005-L8017)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8019-L8025)

lib/forge-std/src/safeconsole.sol#L7999-L8026


 - [ ] ID-88
[safeconsole.log(bool,bytes32,address)](lib/forge-std/src/safeconsole.sol#L1460-L1497) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1467-L1487)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1489-L1496)

lib/forge-std/src/safeconsole.sol#L1460-L1497


 - [ ] ID-89
[safeconsole.log(address,address,bool)](lib/forge-std/src/safeconsole.sol#L638-L661) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L643-L653)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L655-L660)

lib/forge-std/src/safeconsole.sol#L638-L661


 - [ ] ID-90
[safeconsole.log(address,bool,bool,bool)](lib/forge-std/src/safeconsole.sol#L3536-L3563) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3542-L3554)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3556-L3562)

lib/forge-std/src/safeconsole.sol#L3536-L3563


 - [ ] ID-91
[safeconsole.log(bool,bytes32,address,uint256)](lib/forge-std/src/safeconsole.sol#L7052-L7093) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7060-L7082)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7084-L7092)

lib/forge-std/src/safeconsole.sol#L7052-L7093


 - [ ] ID-92
[safeconsole.log(bytes32,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L2571-L2615) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2580-L2603)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2605-L2614)

lib/forge-std/src/safeconsole.sol#L2571-L2615


 - [ ] ID-93
[safeconsole.log(bool,bool,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L6146-L6173) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6152-L6164)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6166-L6172)

lib/forge-std/src/safeconsole.sol#L6146-L6173


 - [ ] ID-94
[safeconsole.log.asm_0.writeString()](lib/forge-std/src/safeconsole.sol#L13200-L13206) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13200-L13206)

lib/forge-std/src/safeconsole.sol#L13200-L13206


 - [ ] ID-95
[safeconsole.log(bytes32,uint256,address,uint256)](lib/forge-std/src/safeconsole.sol#L11735-L11776) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11743-L11765)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11767-L11775)

lib/forge-std/src/safeconsole.sol#L11735-L11776


 - [ ] ID-96
[safeconsole.log(bytes32,address,uint256,address)](lib/forge-std/src/safeconsole.sol#L10519-L10560) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10527-L10549)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10551-L10559)

lib/forge-std/src/safeconsole.sol#L10519-L10560


 - [ ] ID-97
[safeconsole.log(address,bool,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L3724-L3765) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3732-L3754)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3756-L3764)

lib/forge-std/src/safeconsole.sol#L3724-L3765


 - [ ] ID-98
[safeconsole.log(address,bool,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L3695-L3722) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3701-L3713)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3715-L3721)

lib/forge-std/src/safeconsole.sol#L3695-L3722


 - [ ] ID-99
[StdCheatsSafe.deployCode(string,uint256)](lib/forge-std/src/StdCheats.sol#L529-L536) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L531-L533)

lib/forge-std/src/StdCheats.sol#L529-L536


 - [ ] ID-100
[safeconsole.log(uint256,bool,bytes32,address)](lib/forge-std/src/safeconsole.sol#L8669-L8710) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8677-L8699)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8701-L8709)

lib/forge-std/src/safeconsole.sol#L8669-L8710


 - [ ] ID-101
[safeconsole.log(bytes32,bool,address,bytes32)](lib/forge-std/src/safeconsole.sol#L11034-L11082) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11044-L11069)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11071-L11081)

lib/forge-std/src/safeconsole.sol#L11034-L11082


 - [ ] ID-102
[safeconsole.log(address,bytes32,uint256,address)](lib/forge-std/src/safeconsole.sol#L4873-L4914) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4881-L4903)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4905-L4913)

lib/forge-std/src/safeconsole.sol#L4873-L4914


 - [ ] ID-103
[safeconsole.log(address,uint256,bool)](lib/forge-std/src/safeconsole.sol#L866-L889) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L871-L881)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L883-L888)

lib/forge-std/src/safeconsole.sol#L866-L889


 - [ ] ID-104
[safeconsole.log(bytes32,address,address,bool)](lib/forge-std/src/safeconsole.sol#L10204-L10245) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10212-L10234)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10236-L10244)

lib/forge-std/src/safeconsole.sol#L10204-L10245


 - [ ] ID-105
[safeconsole.log(bytes32,uint256,bool,uint256)](lib/forge-std/src/safeconsole.sol#L11914-L11955) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11922-L11944)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11946-L11954)

lib/forge-std/src/safeconsole.sol#L11914-L11955


 - [ ] ID-106
[safeconsole.log(bool,bytes32,bytes32,address)](lib/forge-std/src/safeconsole.sol#L7503-L7551) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7513-L7538)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7540-L7550)

lib/forge-std/src/safeconsole.sol#L7503-L7551


 - [ ] ID-107
[safeconsole.log(address,bool,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L3853-L3894) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3861-L3883)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3885-L3893)

lib/forge-std/src/safeconsole.sol#L3853-L3894


 - [ ] ID-108
[safeconsole.log(address,bool,bool,uint256)](lib/forge-std/src/safeconsole.sol#L3565-L3592) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3571-L3583)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3585-L3591)

lib/forge-std/src/safeconsole.sol#L3565-L3592


 - [ ] ID-109
[safeconsole.log(address,bytes32,address,bool)](lib/forge-std/src/safeconsole.sol#L4558-L4599) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4566-L4588)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4590-L4598)

lib/forge-std/src/safeconsole.sol#L4558-L4599


 - [ ] ID-110
[safeconsole.log(bytes32,bytes32,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L12750-L12805) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12762-L12790)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12792-L12804)

lib/forge-std/src/safeconsole.sol#L12750-L12805


 - [ ] ID-111
[safeconsole.log(bytes32,address,bool,uint256)](lib/forge-std/src/safeconsole.sol#L10426-L10467) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10434-L10456)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10458-L10466)

lib/forge-std/src/safeconsole.sol#L10426-L10467


 - [ ] ID-112
[safeconsole.log(address,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L802-L839) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L809-L829)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L831-L838)

lib/forge-std/src/safeconsole.sol#L802-L839


 - [ ] ID-113
[safeconsole.log(address,address,address,bool)](lib/forge-std/src/safeconsole.sol#L2837-L2864) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2843-L2855)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2857-L2863)

lib/forge-std/src/safeconsole.sol#L2837-L2864


 - [ ] ID-114
[safeconsole.log(uint256,bytes32,address)](lib/forge-std/src/safeconsole.sol#L1965-L2002) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1972-L1992)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1994-L2001)

lib/forge-std/src/safeconsole.sol#L1965-L2002


 - [ ] ID-115
[console._sendLogPayloadImplementation(bytes)](lib/forge-std/src/console.sol#L7-L12) uses assembly
	- [INLINE ASM](lib/forge-std/src/console.sol#L9-L11)

lib/forge-std/src/console.sol#L7-L12


 - [ ] ID-116
[safeconsole.log(uint256,address,address,bytes32)](lib/forge-std/src/safeconsole.sol#L7797-L7838) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7805-L7827)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7829-L7837)

lib/forge-std/src/safeconsole.sol#L7797-L7838


 - [ ] ID-117
[safeconsole.log(address,address,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L3155-L3196) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3163-L3185)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3187-L3195)

lib/forge-std/src/safeconsole.sol#L3155-L3196


 - [ ] ID-118
[safeconsole.log(bool,bool,bool)](lib/forge-std/src/safeconsole.sol#L1257-L1280) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1262-L1272)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1274-L1279)

lib/forge-std/src/safeconsole.sol#L1257-L1280


 - [ ] ID-119
[safeconsole.log(bytes32,address,bytes32)](lib/forge-std/src/safeconsole.sol#L2245-L2289) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2254-L2277)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2279-L2288)

lib/forge-std/src/safeconsole.sol#L2245-L2289


 - [ ] ID-120
[safeconsole.log(bytes32,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L2663-L2707) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2672-L2695)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2697-L2706)

lib/forge-std/src/safeconsole.sol#L2663-L2707


 - [ ] ID-121
[safeconsole.log(uint256,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L2082-L2126) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2091-L2114)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2116-L2125)

lib/forge-std/src/safeconsole.sol#L2082-L2126


 - [ ] ID-122
[safeconsole.log(address,bool)](lib/forge-std/src/safeconsole.sol#L193-L212) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L197-L205)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L207-L211)

lib/forge-std/src/safeconsole.sol#L193-L212


 - [ ] ID-123
[safeconsole.log(uint256,bool,address,uint256)](lib/forge-std/src/safeconsole.sol#L8337-L8364) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8343-L8355)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8357-L8363)

lib/forge-std/src/safeconsole.sol#L8337-L8364


 - [ ] ID-124
[safeconsole.log(bool,address,bool,uint256)](lib/forge-std/src/safeconsole.sol#L5447-L5474) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5453-L5465)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5467-L5473)

lib/forge-std/src/safeconsole.sol#L5447-L5474


 - [ ] ID-125
[safeconsole.log(bytes32,uint256,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L12136-L12184) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12146-L12171)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12173-L12183)

lib/forge-std/src/safeconsole.sol#L12136-L12184


 - [ ] ID-126
[safeconsole.log(bool,address,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L5577-L5604) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5583-L5595)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5597-L5603)

lib/forge-std/src/safeconsole.sol#L5577-L5604


 - [ ] ID-127
[safeconsole.log(bytes32,uint256,bytes32,address)](lib/forge-std/src/safeconsole.sol#L12186-L12234) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12196-L12221)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12223-L12233)

lib/forge-std/src/safeconsole.sol#L12186-L12234


 - [ ] ID-128
[safeconsole.log(bytes32,address,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L10648-L10696) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10658-L10683)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10685-L10695)

lib/forge-std/src/safeconsole.sol#L10648-L10696


 - [ ] ID-129
[safeconsole.log(address,bool,bytes32,address)](lib/forge-std/src/safeconsole.sol#L3767-L3808) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3775-L3797)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3799-L3807)

lib/forge-std/src/safeconsole.sol#L3767-L3808


 - [ ] ID-130
[safeconsole.log(address,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L1033-L1070) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1040-L1060)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1062-L1069)

lib/forge-std/src/safeconsole.sol#L1033-L1070


 - [ ] ID-131
[safeconsole.log(address,uint256,address,uint256)](lib/forge-std/src/safeconsole.sol#L4004-L4031) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4010-L4022)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4024-L4030)

lib/forge-std/src/safeconsole.sol#L4004-L4031


 - [ ] ID-132
[safeconsole.log(address,address,address,uint256)](lib/forge-std/src/safeconsole.sol#L2866-L2893) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2872-L2884)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2886-L2892)

lib/forge-std/src/safeconsole.sol#L2866-L2893


 - [ ] ID-133
[safeconsole.log(bytes32,uint256,uint256,bool)](lib/forge-std/src/safeconsole.sol#L12050-L12091) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12058-L12080)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12082-L12090)

lib/forge-std/src/safeconsole.sol#L12050-L12091


 - [ ] ID-134
[safeconsole.log(bool,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L1499-L1536) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1506-L1526)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1528-L1535)

lib/forge-std/src/safeconsole.sol#L1499-L1536


 - [ ] ID-135
[safeconsole._memcopy(uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L26-L33) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L29-L31)

lib/forge-std/src/safeconsole.sol#L26-L33


 - [ ] ID-136
[safeconsole.log(address,address,bool,uint256)](lib/forge-std/src/safeconsole.sol#L2996-L3023) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3002-L3014)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3016-L3022)

lib/forge-std/src/safeconsole.sol#L2996-L3023


 - [ ] ID-137
[safeconsole.log(bool,uint256,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L6614-L6655) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6622-L6644)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6646-L6654)

lib/forge-std/src/safeconsole.sol#L6614-L6655


 - [ ] ID-138
[safeconsole._sendLogPayloadView(uint256,uint256)](lib/forge-std/src/safeconsole.sol#L20-L24) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L21-L23)

lib/forge-std/src/safeconsole.sol#L20-L24


 - [ ] ID-139
[safeconsole.log(bool,uint256,uint256,bool)](lib/forge-std/src/safeconsole.sol#L6686-L6713) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6692-L6704)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6706-L6712)

lib/forge-std/src/safeconsole.sol#L6686-L6713


 - [ ] ID-140
[safeconsole.log(bool,uint256,bytes32,address)](lib/forge-std/src/safeconsole.sol#L6787-L6828) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6795-L6817)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6819-L6827)

lib/forge-std/src/safeconsole.sol#L6787-L6828


 - [ ] ID-141
[StdUtils._castLogPayloadViewToPure(function(bytes))](lib/forge-std/src/StdUtils.sol#L166-L174) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdUtils.sol#L171-L173)

lib/forge-std/src/StdUtils.sol#L166-L174


 - [ ] ID-142
[safeconsole.log(bool,bool,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L6347-L6395) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6357-L6382)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6384-L6394)

lib/forge-std/src/safeconsole.sol#L6347-L6395


 - [ ] ID-143
[safeconsole.log(uint256,bytes32,address,bool)](lib/forge-std/src/safeconsole.sol#L9460-L9501) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9468-L9490)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9492-L9500)

lib/forge-std/src/safeconsole.sol#L9460-L9501


 - [ ] ID-144
[safeconsole.log(bool,address,address,bytes32)](lib/forge-std/src/safeconsole.sol#L5346-L5387) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5354-L5376)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5378-L5386)

lib/forge-std/src/safeconsole.sol#L5346-L5387


 - [ ] ID-145
[safeconsole.log(uint256,address,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L8186-L8227) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8194-L8216)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8218-L8226)

lib/forge-std/src/safeconsole.sol#L8186-L8227


 - [ ] ID-146
[safeconsole.log(bool,address,address,address)](lib/forge-std/src/safeconsole.sol#L5259-L5286) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5265-L5277)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5279-L5285)

lib/forge-std/src/safeconsole.sol#L5259-L5286


 - [ ] ID-147
[safeconsole.log(bool,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L1577-L1621) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1586-L1609)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1611-L1620)

lib/forge-std/src/safeconsole.sol#L1577-L1621


 - [ ] ID-148
[safeconsole.log(uint256,address,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L8028-L8055) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8034-L8046)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8048-L8054)

lib/forge-std/src/safeconsole.sol#L8028-L8055


 - [ ] ID-149
[safeconsole.log(bool,bool,bool,uint256)](lib/forge-std/src/safeconsole.sol#L6016-L6043) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6022-L6034)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6036-L6042)

lib/forge-std/src/safeconsole.sol#L6016-L6043


 - [ ] ID-150
[safeconsole.log(bool,uint256,bool)](lib/forge-std/src/safeconsole.sol#L1371-L1394) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1376-L1386)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1388-L1393)

lib/forge-std/src/safeconsole.sol#L1371-L1394


 - [ ] ID-151
[safeconsole.log(bytes32,bool,address,bool)](lib/forge-std/src/safeconsole.sol#L10948-L10989) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10956-L10978)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10980-L10988)

lib/forge-std/src/safeconsole.sol#L10948-L10989


 - [ ] ID-152
[safeconsole.log(uint256,bytes32,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L9904-L9952) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9914-L9939)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9941-L9951)

lib/forge-std/src/safeconsole.sol#L9904-L9952


 - [ ] ID-153
[safeconsole.log(uint256,bytes32,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L10004-L10052) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10014-L10039)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10041-L10051)

lib/forge-std/src/safeconsole.sol#L10004-L10052


 - [ ] ID-154
[safeconsole.log(address,address,bool,address)](lib/forge-std/src/safeconsole.sol#L2938-L2965) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2944-L2956)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2958-L2964)

lib/forge-std/src/safeconsole.sol#L2938-L2965


 - [ ] ID-155
[safeconsole.log(address,address,address)](lib/forge-std/src/safeconsole.sol#L613-L636) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L618-L628)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L630-L635)

lib/forge-std/src/safeconsole.sol#L613-L636


 - [ ] ID-156
[safeconsole.log(bytes32,address,address,bytes32)](lib/forge-std/src/safeconsole.sol#L10290-L10338) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10300-L10325)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10327-L10337)

lib/forge-std/src/safeconsole.sol#L10290-L10338


 - [ ] ID-157
[safeconsole.log(bytes32,bool,address)](lib/forge-std/src/safeconsole.sol#L2291-L2328) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2298-L2318)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2320-L2327)

lib/forge-std/src/safeconsole.sol#L2291-L2328


 - [ ] ID-158
[safeconsole.log(address,address,bool,bool)](lib/forge-std/src/safeconsole.sol#L2967-L2994) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2973-L2985)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2987-L2993)

lib/forge-std/src/safeconsole.sol#L2967-L2994


 - [ ] ID-159
[safeconsole.log(uint256,uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L9166-L9193) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9172-L9184)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9186-L9192)

lib/forge-std/src/safeconsole.sol#L9166-L9193


 - [ ] ID-160
[safeconsole.log(bytes32,address,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L10848-L10903) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10860-L10888)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10890-L10902)

lib/forge-std/src/safeconsole.sol#L10848-L10903


 - [ ] ID-161
[safeconsole.log(uint256,uint256,bool,uint256)](lib/forge-std/src/safeconsole.sol#L9036-L9063) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9042-L9054)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9056-L9062)

lib/forge-std/src/safeconsole.sol#L9036-L9063


 - [ ] ID-162
[safeconsole.log(uint256,bool,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L8597-L8624) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8603-L8615)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8617-L8623)

lib/forge-std/src/safeconsole.sol#L8597-L8624


 - [ ] ID-163
[safeconsole.log(bool,bool,uint256)](lib/forge-std/src/safeconsole.sol#L1282-L1305) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1287-L1297)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1299-L1304)

lib/forge-std/src/safeconsole.sol#L1282-L1305


 - [ ] ID-164
[safeconsole.log(uint256,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L1812-L1849) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1819-L1839)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1841-L1848)

lib/forge-std/src/safeconsole.sol#L1812-L1849


 - [ ] ID-165
[safeconsole.log(uint256,bool,uint256,bool)](lib/forge-std/src/safeconsole.sol#L8568-L8595) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8574-L8586)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8588-L8594)

lib/forge-std/src/safeconsole.sol#L8568-L8595


 - [ ] ID-166
[safeconsole.log(uint256,bytes32,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L10054-L10102) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10064-L10089)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10091-L10101)

lib/forge-std/src/safeconsole.sol#L10054-L10102


 - [ ] ID-167
[safeconsole.log(address,bytes32,bytes32,address)](lib/forge-std/src/safeconsole.sol#L5052-L5100) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5062-L5087)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5089-L5099)

lib/forge-std/src/safeconsole.sol#L5052-L5100


 - [ ] ID-168
[safeconsole.log(bytes32,address,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L10798-L10846) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10808-L10833)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10835-L10845)

lib/forge-std/src/safeconsole.sol#L10798-L10846


 - [ ] ID-169
[safeconsole.log(uint256,bool,address,address)](lib/forge-std/src/safeconsole.sol#L8279-L8306) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8285-L8297)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8299-L8305)

lib/forge-std/src/safeconsole.sol#L8279-L8306


 - [ ] ID-170
[safeconsole.log(uint256,address,address,bool)](lib/forge-std/src/safeconsole.sol#L7739-L7766) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7745-L7757)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7759-L7765)

lib/forge-std/src/safeconsole.sol#L7739-L7766


 - [ ] ID-171
[safeconsole.log(address,uint256,address,bool)](lib/forge-std/src/safeconsole.sol#L3975-L4002) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3981-L3993)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3995-L4001)

lib/forge-std/src/safeconsole.sol#L3975-L4002


 - [ ] ID-172
[safeconsole.log(bool,address,address)](lib/forge-std/src/safeconsole.sol#L1118-L1141) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1123-L1133)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1135-L1140)

lib/forge-std/src/safeconsole.sol#L1118-L1141


 - [ ] ID-173
[safeconsole.log(bool,bool,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L6304-L6345) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6312-L6334)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6336-L6344)

lib/forge-std/src/safeconsole.sol#L6304-L6345


 - [ ] ID-174
[safeconsole.log(bytes32,bool,bool,bool)](lib/forge-std/src/safeconsole.sol#L11127-L11168) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11135-L11157)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11159-L11167)

lib/forge-std/src/safeconsole.sol#L11127-L11168


 - [ ] ID-175
[safeconsole.log(uint256,uint256,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L9281-L9322) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9289-L9311)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9313-L9321)

lib/forge-std/src/safeconsole.sol#L9281-L9322


 - [ ] ID-176
[safeconsole.log(bytes32,address,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L10748-L10796) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10758-L10783)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10785-L10795)

lib/forge-std/src/safeconsole.sol#L10748-L10796


 - [ ] ID-177
[safeconsole.log(uint256,bytes32,bytes32,address)](lib/forge-std/src/safeconsole.sol#L9954-L10002) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9964-L9989)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9991-L10001)

lib/forge-std/src/safeconsole.sol#L9954-L10002


 - [ ] ID-178
[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L151-L185) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdChains.sol#L178-L180)

lib/forge-std/src/StdChains.sol#L151-L185


 - [ ] ID-179
[safeconsole.log(address,uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L4264-L4291) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4270-L4282)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4284-L4290)

lib/forge-std/src/safeconsole.sol#L4264-L4291


 - [ ] ID-180
[safeconsole.log(bytes32)](lib/forge-std/src/safeconsole.sol#L141-L170) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L146-L162)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L164-L169)

lib/forge-std/src/safeconsole.sol#L141-L170


 - [ ] ID-181
[safeconsole.log(bool,address,bool)](lib/forge-std/src/safeconsole.sol#L1143-L1166) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1148-L1158)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1160-L1165)

lib/forge-std/src/safeconsole.sol#L1143-L1166


 - [ ] ID-182
[safeconsole.log(bool,address,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L5778-L5826) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5788-L5813)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5815-L5825)

lib/forge-std/src/safeconsole.sol#L5778-L5826


 - [ ] ID-183
[safeconsole.log(uint256,bool,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L8755-L8796) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8763-L8785)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8787-L8795)

lib/forge-std/src/safeconsole.sol#L8755-L8796


 - [ ] ID-184
[safeconsole.log(uint256,bool,bool,bool)](lib/forge-std/src/safeconsole.sol#L8438-L8465) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8444-L8456)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8458-L8464)

lib/forge-std/src/safeconsole.sol#L8438-L8465


 - [ ] ID-185
[safeconsole.log(bool,bytes32,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L7453-L7501) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7463-L7488)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7490-L7500)

lib/forge-std/src/safeconsole.sol#L7453-L7501


 - [ ] ID-186
[safeconsole.log(uint256,uint256,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L9324-L9365) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9332-L9354)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9356-L9364)

lib/forge-std/src/safeconsole.sol#L9324-L9365


 - [ ] ID-187
[safeconsole.log(bytes32,uint256,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L12236-L12284) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12246-L12271)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12273-L12283)

lib/forge-std/src/safeconsole.sol#L12236-L12284


 - [ ] ID-188
[stdStorage.checked_write(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L405-L411) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L407-L409)

lib/forge-std/src/StdStorage.sol#L405-L411


 - [ ] ID-189
[safeconsole.log(bytes32,uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L12093-L12134) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12101-L12123)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12125-L12133)

lib/forge-std/src/safeconsole.sol#L12093-L12134


 - [ ] ID-190
[safeconsole.log(bool,address)](lib/forge-std/src/safeconsole.sol#L270-L289) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L274-L282)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L284-L288)

lib/forge-std/src/safeconsole.sol#L270-L289


 - [ ] ID-191
[safeconsole.log(bytes32,bool,uint256,bool)](lib/forge-std/src/safeconsole.sol#L11306-L11347) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11314-L11336)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11338-L11346)

lib/forge-std/src/safeconsole.sol#L11306-L11347


 - [ ] ID-192
[safeconsole.log(bytes32,bytes32,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L13071-L13126) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13083-L13111)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13113-L13125)

lib/forge-std/src/safeconsole.sol#L13071-L13126


 - [ ] ID-193
[safeconsole.log(address,uint256)](lib/forge-std/src/safeconsole.sol#L214-L233) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L218-L226)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L228-L232)

lib/forge-std/src/safeconsole.sol#L214-L233


 - [ ] ID-194
[safeconsole.log(address,address,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L3241-L3282) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3249-L3271)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3273-L3281)

lib/forge-std/src/safeconsole.sol#L3241-L3282


 - [ ] ID-195
[safeconsole.log(bool,bool,address,bytes32)](lib/forge-std/src/safeconsole.sol#L5915-L5956) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5923-L5945)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5947-L5955)

lib/forge-std/src/safeconsole.sol#L5915-L5956


 - [ ] ID-196
[safeconsole.log(uint256,bytes32,address,bytes32)](lib/forge-std/src/safeconsole.sol#L9546-L9594) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9556-L9581)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9583-L9593)

lib/forge-std/src/safeconsole.sol#L9546-L9594


 - [ ] ID-197
[safeconsole.log(bytes32,address,uint256,bool)](lib/forge-std/src/safeconsole.sol#L10562-L10603) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10570-L10592)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10594-L10602)

lib/forge-std/src/safeconsole.sol#L10562-L10603


 - [ ] ID-198
[safeconsole.log(uint256,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L1926-L1963) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1933-L1953)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1955-L1962)

lib/forge-std/src/safeconsole.sol#L1926-L1963


 - [ ] ID-199
[safeconsole.log(bool,uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L6715-L6742) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6721-L6733)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6735-L6741)

lib/forge-std/src/safeconsole.sol#L6715-L6742


 - [ ] ID-200
[safeconsole.log(bytes32,bytes32,bool,uint256)](lib/forge-std/src/safeconsole.sol#L12700-L12748) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12710-L12735)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12737-L12747)

lib/forge-std/src/safeconsole.sol#L12700-L12748


 - [ ] ID-201
[safeconsole.log(bytes32,uint256,address)](lib/forge-std/src/safeconsole.sol#L2454-L2491) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2461-L2481)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2483-L2490)

lib/forge-std/src/safeconsole.sol#L2454-L2491


 - [ ] ID-202
[safeconsole.log(uint256,address,bool,bool)](lib/forge-std/src/safeconsole.sol#L7869-L7896) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7875-L7887)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7889-L7895)

lib/forge-std/src/safeconsole.sol#L7869-L7896


 - [ ] ID-203
[safeconsole.log(bool,uint256,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L6873-L6914) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6881-L6903)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6905-L6913)

lib/forge-std/src/safeconsole.sol#L6873-L6914


 - [ ] ID-204
[safeconsole.log(bool,bool,address,uint256)](lib/forge-std/src/safeconsole.sol#L5886-L5913) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5892-L5904)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5906-L5912)

lib/forge-std/src/safeconsole.sol#L5886-L5913


 - [ ] ID-205
[safeconsole.log(address,bytes32,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L5102-L5150) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5112-L5137)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5139-L5149)

lib/forge-std/src/safeconsole.sol#L5102-L5150


 - [ ] ID-206
[safeconsole.log(address,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L994-L1031) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1001-L1021)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1023-L1030)

lib/forge-std/src/safeconsole.sol#L994-L1031


 - [ ] ID-207
[safeconsole.log(bool,uint256,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L6744-L6785) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6752-L6774)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6776-L6784)

lib/forge-std/src/safeconsole.sol#L6744-L6785


 - [ ] ID-208
[safeconsole.log(bytes32,bool,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L11349-L11390) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11357-L11379)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11381-L11389)

lib/forge-std/src/safeconsole.sol#L11349-L11390


 - [ ] ID-209
[safeconsole.log(bool,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L1538-L1575) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1545-L1565)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1567-L1574)

lib/forge-std/src/safeconsole.sol#L1538-L1575


 - [ ] ID-210
[safeconsole.log(bytes32,bool,uint256)](lib/forge-std/src/safeconsole.sol#L2369-L2406) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2376-L2396)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2398-L2405)

lib/forge-std/src/safeconsole.sol#L2369-L2406


 - [ ] ID-211
[safeconsole.log(bytes32,uint256,address,address)](lib/forge-std/src/safeconsole.sol#L11649-L11690) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11657-L11679)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11681-L11689)

lib/forge-std/src/safeconsole.sol#L11649-L11690


 - [ ] ID-212
[safeconsole.log(uint256,address,uint256,address)](lib/forge-std/src/safeconsole.sol#L7970-L7997) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7976-L7988)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7990-L7996)

lib/forge-std/src/safeconsole.sol#L7970-L7997


 - [ ] ID-213
[safeconsole.log(address,address,uint256,bool)](lib/forge-std/src/safeconsole.sol#L3097-L3124) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3103-L3115)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3117-L3123)

lib/forge-std/src/safeconsole.sol#L3097-L3124


 - [ ] ID-214
[safeconsole.log(address,bytes32,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L4959-L5000) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4967-L4989)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4991-L4999)

lib/forge-std/src/safeconsole.sol#L4959-L5000


 - [ ] ID-215
[safeconsole.log(bytes32,bytes32,address,uint256)](lib/forge-std/src/safeconsole.sol#L12493-L12541) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12503-L12528)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12530-L12540)

lib/forge-std/src/safeconsole.sol#L12493-L12541


 - [ ] ID-216
[safeconsole.log(bool,bytes32,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L7653-L7708) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7665-L7693)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7695-L7707)

lib/forge-std/src/safeconsole.sol#L7653-L7708


 - [ ] ID-217
[safeconsole.log(bool,address,bytes32)](lib/forge-std/src/safeconsole.sol#L1193-L1230) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1200-L1220)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1222-L1229)

lib/forge-std/src/safeconsole.sol#L1193-L1230


 - [ ] ID-218
[safeconsole.log(uint256,bool,uint256)](lib/forge-std/src/safeconsole.sol#L1787-L1810) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1792-L1802)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1804-L1809)

lib/forge-std/src/safeconsole.sol#L1787-L1810


 - [ ] ID-219
[safeconsole.log(bool,bool)](lib/forge-std/src/safeconsole.sol#L291-L310) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L295-L303)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L305-L309)

lib/forge-std/src/safeconsole.sol#L291-L310


 - [ ] ID-220
[safeconsole.log(uint256,bytes32,address,address)](lib/forge-std/src/safeconsole.sol#L9417-L9458) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9425-L9447)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9449-L9457)

lib/forge-std/src/safeconsole.sol#L9417-L9458


 - [ ] ID-221
[safeconsole.log(uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L431-L464) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L437-L455)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L457-L463)

lib/forge-std/src/safeconsole.sol#L431-L464


 - [ ] ID-222
[StdCheatsSafe._pureChainId()](lib/forge-std/src/StdCheats.sol#L635-L642) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L638-L640)

lib/forge-std/src/StdCheats.sol#L635-L642


 - [ ] ID-223
[safeconsole.log(address,bool,uint256)](lib/forge-std/src/safeconsole.sol#L777-L800) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L782-L792)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L794-L799)

lib/forge-std/src/safeconsole.sol#L777-L800


 - [ ] ID-224
[safeconsole.log(bool,bool,address)](lib/forge-std/src/safeconsole.sol#L1232-L1255) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1237-L1247)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1249-L1254)

lib/forge-std/src/safeconsole.sol#L1232-L1255


 - [ ] ID-225
[safeconsole.log(bytes32,address,address,uint256)](lib/forge-std/src/safeconsole.sol#L10247-L10288) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10255-L10277)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10279-L10287)

lib/forge-std/src/safeconsole.sol#L10247-L10288


 - [ ] ID-226
[safeconsole.log(bytes32,address,bytes32,address)](lib/forge-std/src/safeconsole.sol#L10698-L10746) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10708-L10733)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10735-L10745)

lib/forge-std/src/safeconsole.sol#L10698-L10746


 - [ ] ID-227
[safeconsole.log(bool,address,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L5692-L5733) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5700-L5722)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5724-L5732)

lib/forge-std/src/safeconsole.sol#L5692-L5733


 - [ ] ID-228
[safeconsole.log(bool,address,bool,address)](lib/forge-std/src/safeconsole.sol#L5389-L5416) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5395-L5407)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5409-L5415)

lib/forge-std/src/safeconsole.sol#L5389-L5416


 - [ ] ID-229
[safeconsole.log(bytes32,bytes32,address,bool)](lib/forge-std/src/safeconsole.sol#L12443-L12491) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12453-L12478)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12480-L12490)

lib/forge-std/src/safeconsole.sol#L12443-L12491


 - [ ] ID-230
[safeconsole.log(bool,address,uint256)](lib/forge-std/src/safeconsole.sol#L1168-L1191) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1173-L1183)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1185-L1190)

lib/forge-std/src/safeconsole.sol#L1168-L1191


 - [ ] ID-231
[safeconsole.log(bool,uint256,address,uint256)](lib/forge-std/src/safeconsole.sol#L6455-L6482) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6461-L6473)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6475-L6481)

lib/forge-std/src/safeconsole.sol#L6455-L6482


 - [ ] ID-232
[safeconsole.log(address,address,uint256)](lib/forge-std/src/safeconsole.sol#L663-L686) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L668-L678)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L680-L685)

lib/forge-std/src/safeconsole.sol#L663-L686


 - [ ] ID-233
[safeconsole.log(uint256,uint256,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L9367-L9415) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9377-L9402)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9404-L9414)

lib/forge-std/src/safeconsole.sol#L9367-L9415


 - [ ] ID-234
[safeconsole.log(address,bytes32,address,address)](lib/forge-std/src/safeconsole.sol#L4515-L4556) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4523-L4545)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4547-L4555)

lib/forge-std/src/safeconsole.sol#L4515-L4556


 - [ ] ID-235
[safeconsole.log(uint256,uint256,uint256,address)](lib/forge-std/src/safeconsole.sol#L9108-L9135) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9114-L9126)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9128-L9134)

lib/forge-std/src/safeconsole.sol#L9108-L9135


 - [ ] ID-236
[safeconsole.log(address,address,address,bytes32)](lib/forge-std/src/safeconsole.sol#L2895-L2936) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2903-L2925)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2927-L2935)

lib/forge-std/src/safeconsole.sol#L2895-L2936


 - [ ] ID-237
[safeconsole.log(bytes32,address,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L10605-L10646) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10613-L10635)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10637-L10645)

lib/forge-std/src/safeconsole.sol#L10605-L10646


 - [ ] ID-238
[safeconsole.log(bool,bool,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L6175-L6216) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6183-L6205)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6207-L6215)

lib/forge-std/src/safeconsole.sol#L6175-L6216


 - [ ] ID-239
[safeconsole.log(uint256,bool,address,bytes32)](lib/forge-std/src/safeconsole.sol#L8366-L8407) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8374-L8396)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8398-L8406)

lib/forge-std/src/safeconsole.sol#L8366-L8407


 - [ ] ID-240
[safeconsole.log(uint256,bytes32,bool,uint256)](lib/forge-std/src/safeconsole.sol#L9682-L9723) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9690-L9712)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9714-L9722)

lib/forge-std/src/safeconsole.sol#L9682-L9723


 - [ ] ID-241
[safeconsole.log(bool,bool,address,bool)](lib/forge-std/src/safeconsole.sol#L5857-L5884) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5863-L5875)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5877-L5883)

lib/forge-std/src/safeconsole.sol#L5857-L5884


 - [ ] ID-242
[safeconsole.log(address,uint256,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L4422-L4463) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4430-L4452)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4454-L4462)

lib/forge-std/src/safeconsole.sol#L4422-L4463


 - [ ] ID-243
[safeconsole.log(address,address,uint256,address)](lib/forge-std/src/safeconsole.sol#L3068-L3095) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3074-L3086)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3088-L3094)

lib/forge-std/src/safeconsole.sol#L3068-L3095


 - [ ] ID-244
[safeconsole.log(uint256,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L2043-L2080) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2050-L2070)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2072-L2079)

lib/forge-std/src/safeconsole.sol#L2043-L2080


 - [ ] ID-245
[StdCheatsSafe.assumeUnusedAddress(address)](lib/forge-std/src/StdCheats.sol#L350-L360) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L352-L354)

lib/forge-std/src/StdCheats.sol#L350-L360


 - [ ] ID-246
[safeconsole.log(uint256,address,address,uint256)](lib/forge-std/src/safeconsole.sol#L7768-L7795) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7774-L7786)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7788-L7794)

lib/forge-std/src/safeconsole.sol#L7768-L7795


 - [ ] ID-247
[safeconsole.log(uint256,address,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L7927-L7968) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7935-L7957)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7959-L7967)

lib/forge-std/src/safeconsole.sol#L7927-L7968


 - [ ] ID-248
[safeconsole.log(bool,uint256,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L6830-L6871) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6838-L6860)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6862-L6870)

lib/forge-std/src/safeconsole.sol#L6830-L6871


 - [ ] ID-249
[safeconsole.log(bytes32,bool,bytes32,address)](lib/forge-std/src/safeconsole.sol#L11442-L11490) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11452-L11477)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11479-L11489)

lib/forge-std/src/safeconsole.sol#L11442-L11490


 - [ ] ID-250
[safeconsole.log(uint256,bool,address)](lib/forge-std/src/safeconsole.sol#L1737-L1760) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1742-L1752)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1754-L1759)

lib/forge-std/src/safeconsole.sol#L1737-L1760


 - [ ] ID-251
[safeconsole.log(bytes32,bool,address,address)](lib/forge-std/src/safeconsole.sol#L10905-L10946) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10913-L10935)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10937-L10945)

lib/forge-std/src/safeconsole.sol#L10905-L10946


 - [ ] ID-252
[safeconsole.log(bytes32,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L2408-L2452) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2417-L2440)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2442-L2451)

lib/forge-std/src/safeconsole.sol#L2408-L2452


 - [ ] ID-253
[safeconsole.log(uint256,address,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L8057-L8098) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8065-L8087)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8089-L8097)

lib/forge-std/src/safeconsole.sol#L8057-L8098


 - [ ] ID-254
[StdUtils.getTokenBalances(address,address[])](lib/forge-std/src/StdUtils.sol#L126-L153) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdUtils.sol#L132-L134)

lib/forge-std/src/StdUtils.sol#L126-L153


 - [ ] ID-255
[safeconsole.log(uint256,address,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L8229-L8277) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8239-L8264)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8266-L8276)

lib/forge-std/src/safeconsole.sol#L8229-L8277


 - [ ] ID-256
[safeconsole.log(bool,uint256,bool,address)](lib/forge-std/src/safeconsole.sol#L6527-L6554) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6533-L6545)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6547-L6553)

lib/forge-std/src/safeconsole.sol#L6527-L6554


 - [ ] ID-257
[safeconsole.log(bytes32,address,bool,bool)](lib/forge-std/src/safeconsole.sol#L10383-L10424) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10391-L10413)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10415-L10423)

lib/forge-std/src/safeconsole.sol#L10383-L10424


 - [ ] ID-258
[safeconsole.log(bytes32,bytes32,address,bytes32)](lib/forge-std/src/safeconsole.sol#L12543-L12598) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12555-L12583)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12585-L12597)

lib/forge-std/src/safeconsole.sol#L12543-L12598


 - [ ] ID-259
[safeconsole.log(address,address,bytes32,address)](lib/forge-std/src/safeconsole.sol#L3198-L3239) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3206-L3228)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3230-L3238)

lib/forge-std/src/safeconsole.sol#L3198-L3239


 - [ ] ID-260
[safeconsole.log(address,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L891-L914) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L896-L906)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L908-L913)

lib/forge-std/src/safeconsole.sol#L891-L914


 - [ ] ID-261
[safeconsole.log(bool,bytes32,uint256,address)](lib/forge-std/src/safeconsole.sol#L7324-L7365) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7332-L7354)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7356-L7364)

lib/forge-std/src/safeconsole.sol#L7324-L7365


 - [ ] ID-262
[safeconsole.log(bool,bool,bool,address)](lib/forge-std/src/safeconsole.sol#L5958-L5985) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5964-L5976)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5978-L5984)

lib/forge-std/src/safeconsole.sol#L5958-L5985


 - [ ] ID-263
[safeconsole.log(bytes32,uint256,address,bool)](lib/forge-std/src/safeconsole.sol#L11692-L11733) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11700-L11722)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11724-L11732)

lib/forge-std/src/safeconsole.sol#L11692-L11733


 - [ ] ID-264
[safeconsole.log(bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L536-L569) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L542-L560)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L562-L568)

lib/forge-std/src/safeconsole.sol#L536-L569


 - [ ] ID-265
[safeconsole.log(bool,address,address,bool)](lib/forge-std/src/safeconsole.sol#L5288-L5315) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5294-L5306)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5308-L5314)

lib/forge-std/src/safeconsole.sol#L5288-L5315


 - [ ] ID-266
[safeconsole._memcopyView(uint256,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L35-L39) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L36-L38)

lib/forge-std/src/safeconsole.sol#L35-L39


 - [ ] ID-267
[safeconsole.log(address,uint256,bool,address)](lib/forge-std/src/safeconsole.sol#L4076-L4103) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4082-L4094)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4096-L4102)

lib/forge-std/src/safeconsole.sol#L4076-L4103


 - [ ] ID-268
[safeconsole.log(uint256,bool,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L8712-L8753) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8720-L8742)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8744-L8752)

lib/forge-std/src/safeconsole.sol#L8712-L8753


 - [ ] ID-269
[safeconsole.log(uint256,address,address,address)](lib/forge-std/src/safeconsole.sol#L7710-L7737) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7716-L7728)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7730-L7736)

lib/forge-std/src/safeconsole.sol#L7710-L7737


 - [ ] ID-270
[safeconsole.log(uint256,uint256,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L9065-L9106) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9073-L9095)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9097-L9105)

lib/forge-std/src/safeconsole.sol#L9065-L9106


 - [ ] ID-271
[safeconsole.log(address,bool,uint256,address)](lib/forge-std/src/safeconsole.sol#L3637-L3664) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3643-L3655)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3657-L3663)

lib/forge-std/src/safeconsole.sol#L3637-L3664


 - [ ] ID-272
[safeconsole.log(bytes32,bool,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L11592-L11647) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11604-L11632)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11634-L11646)

lib/forge-std/src/safeconsole.sol#L11592-L11647


 - [ ] ID-273
[StdCheatsSafe._viewChainId()](lib/forge-std/src/StdCheats.sol#L626-L633) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L628-L630)

lib/forge-std/src/StdCheats.sol#L626-L633


 - [ ] ID-274
[safeconsole.log(bool,address,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L5735-L5776) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5743-L5765)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5767-L5775)

lib/forge-std/src/safeconsole.sol#L5735-L5776


 - [ ] ID-275
[safeconsole.log(bytes32,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L2532-L2569) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2539-L2559)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2561-L2568)

lib/forge-std/src/safeconsole.sol#L2532-L2569


 - [ ] ID-276
[safeconsole.log(bytes32,address,address,address)](lib/forge-std/src/safeconsole.sol#L10161-L10202) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10169-L10191)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10193-L10201)

lib/forge-std/src/safeconsole.sol#L10161-L10202


 - [ ] ID-277
[safeconsole.log(bytes32,bytes32,address,address)](lib/forge-std/src/safeconsole.sol#L12393-L12441) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12403-L12428)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12430-L12440)

lib/forge-std/src/safeconsole.sol#L12393-L12441


 - [ ] ID-278
[safeconsole.log(address,bool,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L3896-L3944) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3906-L3931)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3933-L3943)

lib/forge-std/src/safeconsole.sol#L3896-L3944


 - [ ] ID-279
[safeconsole.log(bytes32,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L2709-L2753) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2718-L2741)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2743-L2752)

lib/forge-std/src/safeconsole.sol#L2709-L2753


 - [ ] ID-280
[StdCheatsSafe.assumeNotBlacklisted(address,address)](lib/forge-std/src/StdCheats.sol#L207-L225) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L210-L212)

lib/forge-std/src/StdCheats.sol#L207-L225


 - [ ] ID-281
[safeconsole.log(bool,bool,address,address)](lib/forge-std/src/safeconsole.sol#L5828-L5855) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5834-L5846)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5848-L5854)

lib/forge-std/src/safeconsole.sol#L5828-L5855


 - [ ] ID-282
[safeconsole.log(uint256,bool,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L8496-L8537) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8504-L8526)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8528-L8536)

lib/forge-std/src/safeconsole.sol#L8496-L8537


 - [ ] ID-283
[safeconsole.log(bool,uint256,address,address)](lib/forge-std/src/safeconsole.sol#L6397-L6424) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6403-L6415)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6417-L6423)

lib/forge-std/src/safeconsole.sol#L6397-L6424


 - [ ] ID-284
[StdCheatsSafe.deployCode(string,bytes)](lib/forge-std/src/StdCheats.sol#L501-L508) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L503-L505)

lib/forge-std/src/StdCheats.sol#L501-L508


 - [ ] ID-285
[safeconsole.log(address,bool,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L3594-L3635) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3602-L3624)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3626-L3634)

lib/forge-std/src/safeconsole.sol#L3594-L3635


 - [ ] ID-286
[safeconsole.log(uint256,uint256,address,bool)](lib/forge-std/src/safeconsole.sol#L8877-L8904) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8883-L8895)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8897-L8903)

lib/forge-std/src/safeconsole.sol#L8877-L8904


 - [ ] ID-287
[safeconsole.log(bytes32,uint256,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L11957-L12005) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11967-L11992)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11994-L12004)

lib/forge-std/src/safeconsole.sol#L11957-L12005


 - [ ] ID-288
[stdStorageSafe.getMaskByOffsets(uint256,uint256)](lib/forge-std/src/StdStorage.sol#L320-L326) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L323-L325)

lib/forge-std/src/StdStorage.sol#L320-L326


 - [ ] ID-289
[safeconsole.log(uint256,bytes32,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L9725-L9773) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9735-L9760)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9762-L9772)

lib/forge-std/src/safeconsole.sol#L9725-L9773


 - [ ] ID-290
[safeconsole.log(bool,bytes32,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L7274-L7322) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7284-L7309)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7311-L7321)

lib/forge-std/src/safeconsole.sol#L7274-L7322


 - [ ] ID-291
[safeconsole.log(uint256,uint256,bool,bool)](lib/forge-std/src/safeconsole.sol#L9007-L9034) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9013-L9025)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9027-L9033)

lib/forge-std/src/safeconsole.sol#L9007-L9034


 - [ ] ID-292
[safeconsole.log(bool,uint256,bool,bool)](lib/forge-std/src/safeconsole.sol#L6556-L6583) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6562-L6574)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6576-L6582)

lib/forge-std/src/safeconsole.sol#L6556-L6583


 - [ ] ID-293
[safeconsole.log(bytes32,uint256,bool,bool)](lib/forge-std/src/safeconsole.sol#L11871-L11912) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11879-L11901)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11903-L11911)

lib/forge-std/src/safeconsole.sol#L11871-L11912


 - [ ] ID-294
[safeconsole.log(bytes32,bool)](lib/forge-std/src/safeconsole.sol#L501-L534) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L507-L525)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L527-L533)

lib/forge-std/src/safeconsole.sol#L501-L534


 - [ ] ID-295
[safeconsole.log(uint256,address,bytes32,address)](lib/forge-std/src/safeconsole.sol#L8100-L8141) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8108-L8130)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8132-L8140)

lib/forge-std/src/safeconsole.sol#L8100-L8141


 - [ ] ID-296
[safeconsole.log(uint256,bytes32,bool,address)](lib/forge-std/src/safeconsole.sol#L9596-L9637) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9604-L9626)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9628-L9636)

lib/forge-std/src/safeconsole.sol#L9596-L9637


 - [ ] ID-297
[safeconsole.log(bool,bool,uint256,address)](lib/forge-std/src/safeconsole.sol#L6088-L6115) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6094-L6106)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6108-L6114)

lib/forge-std/src/safeconsole.sol#L6088-L6115


 - [ ] ID-298
[safeconsole.log(bool,bytes32,bool,address)](lib/forge-std/src/safeconsole.sol#L7145-L7186) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7153-L7175)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7177-L7185)

lib/forge-std/src/safeconsole.sol#L7145-L7186


 - [ ] ID-299
[safeconsole.log(address,uint256,address,bytes32)](lib/forge-std/src/safeconsole.sol#L4033-L4074) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4041-L4063)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4065-L4073)

lib/forge-std/src/safeconsole.sol#L4033-L4074


 - [ ] ID-300
[safeconsole.log(address,bytes32,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L5152-L5200) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5162-L5187)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5189-L5199)

lib/forge-std/src/safeconsole.sol#L5152-L5200


 - [ ] ID-301
[safeconsole.log(address,bytes32,bool,address)](lib/forge-std/src/safeconsole.sol#L4694-L4735) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4702-L4724)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4726-L4734)

lib/forge-std/src/safeconsole.sol#L4694-L4735


 - [ ] ID-302
[safeconsole.log(bytes32,bytes32,bytes32,address)](lib/forge-std/src/safeconsole.sol#L13014-L13069) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13026-L13054)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L13056-L13068)

lib/forge-std/src/safeconsole.sol#L13014-L13069


 - [ ] ID-303
[safeconsole.log(address,bytes32,bool,bool)](lib/forge-std/src/safeconsole.sol#L4737-L4778) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4745-L4767)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4769-L4777)

lib/forge-std/src/safeconsole.sol#L4737-L4778


 - [ ] ID-304
[safeconsole.log(bool,bool,bytes32,address)](lib/forge-std/src/safeconsole.sol#L6218-L6259) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6226-L6248)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6250-L6258)

lib/forge-std/src/safeconsole.sol#L6218-L6259


 - [ ] ID-305
[safeconsole.log(uint256,bool,uint256,address)](lib/forge-std/src/safeconsole.sol#L8539-L8566) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8545-L8557)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8559-L8565)

lib/forge-std/src/safeconsole.sol#L8539-L8566


 - [ ] ID-306
[safeconsole.log(bytes32,uint256,bool)](lib/forge-std/src/safeconsole.sol#L2493-L2530) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2500-L2520)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2522-L2529)

lib/forge-std/src/safeconsole.sol#L2493-L2530


 - [ ] ID-307
[safeconsole.log(bool,uint256,address,bool)](lib/forge-std/src/safeconsole.sol#L6426-L6453) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6432-L6444)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6446-L6452)

lib/forge-std/src/safeconsole.sol#L6426-L6453


 - [ ] ID-308
[safeconsole.log(address,uint256,uint256,address)](lib/forge-std/src/safeconsole.sol#L4206-L4233) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4212-L4224)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4226-L4232)

lib/forge-std/src/safeconsole.sol#L4206-L4233


 - [ ] ID-309
[safeconsole.log(bool,uint256,uint256,address)](lib/forge-std/src/safeconsole.sol#L6657-L6684) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6663-L6675)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6677-L6683)

lib/forge-std/src/safeconsole.sol#L6657-L6684


 - [ ] ID-310
[safeconsole.log(address,uint256,bool,uint256)](lib/forge-std/src/safeconsole.sol#L4134-L4161) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4140-L4152)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4154-L4160)

lib/forge-std/src/safeconsole.sol#L4134-L4161


 - [ ] ID-311
[safeconsole.log(bytes32,uint256,bool,address)](lib/forge-std/src/safeconsole.sol#L11828-L11869) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11836-L11858)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11860-L11868)

lib/forge-std/src/safeconsole.sol#L11828-L11869


 - [ ] ID-312
[safeconsole.log(bytes32,bool,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L11492-L11540) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11502-L11527)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11529-L11539)

lib/forge-std/src/safeconsole.sol#L11492-L11540


 - [ ] ID-313
[safeconsole.log(bytes32,address)](lib/forge-std/src/safeconsole.sol#L466-L499) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L472-L490)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L492-L498)

lib/forge-std/src/safeconsole.sol#L466-L499


 - [ ] ID-314
[safeconsole.log(bool,bool,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L6045-L6086) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6053-L6075)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6077-L6085)

lib/forge-std/src/safeconsole.sol#L6045-L6086


 - [ ] ID-315
[safeconsole.logMemory(uint256,uint256)](lib/forge-std/src/safeconsole.sol#L41-L88) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L47-L55)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L57-L61)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L68-L72)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L74-L79)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L82-L86)

lib/forge-std/src/safeconsole.sol#L41-L88


 - [ ] ID-316
[safeconsole.log(address,bool,uint256,bool)](lib/forge-std/src/safeconsole.sol#L3666-L3693) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3672-L3684)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3686-L3692)

lib/forge-std/src/safeconsole.sol#L3666-L3693


 - [ ] ID-317
[safeconsole.log(uint256,address,bool)](lib/forge-std/src/safeconsole.sol#L1648-L1671) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1653-L1663)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1665-L1670)

lib/forge-std/src/safeconsole.sol#L1648-L1671


 - [ ] ID-318
[safeconsole.log(address,bytes32,address,uint256)](lib/forge-std/src/safeconsole.sol#L4601-L4642) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4609-L4631)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4633-L4641)

lib/forge-std/src/safeconsole.sol#L4601-L4642


 - [ ] ID-319
[safeconsole.log(bool,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L1396-L1419) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1401-L1411)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1413-L1418)

lib/forge-std/src/safeconsole.sol#L1396-L1419


 - [ ] ID-320
[safeconsole.log(uint256,address,uint256)](lib/forge-std/src/safeconsole.sol#L1673-L1696) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1678-L1688)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1690-L1695)

lib/forge-std/src/safeconsole.sol#L1673-L1696


 - [ ] ID-321
[safeconsole.log(address,uint256,bool,bool)](lib/forge-std/src/safeconsole.sol#L4105-L4132) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4111-L4123)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4125-L4131)

lib/forge-std/src/safeconsole.sol#L4105-L4132


 - [ ] ID-322
[safeconsole.log(address,bool,address,bytes32)](lib/forge-std/src/safeconsole.sol#L3464-L3505) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3472-L3494)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3496-L3504)

lib/forge-std/src/safeconsole.sol#L3464-L3505


 - [ ] ID-323
[safeconsole.log(bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L571-L611) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L579-L600)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L602-L610)

lib/forge-std/src/safeconsole.sol#L571-L611


 - [ ] ID-324
[safeconsole.log(address,address,bytes32)](lib/forge-std/src/safeconsole.sol#L688-L725) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L695-L715)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L717-L724)

lib/forge-std/src/safeconsole.sol#L688-L725


 - [ ] ID-325
[safeconsole.log(bytes32,bool,uint256,address)](lib/forge-std/src/safeconsole.sol#L11263-L11304) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11271-L11293)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11295-L11303)

lib/forge-std/src/safeconsole.sol#L11263-L11304


 - [ ] ID-326
[safeconsole.log(address,bool,address,bool)](lib/forge-std/src/safeconsole.sol#L3406-L3433) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3412-L3424)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3426-L3432)

lib/forge-std/src/safeconsole.sol#L3406-L3433


 - [ ] ID-327
[safeconsole.log(bytes32,bool,address,uint256)](lib/forge-std/src/safeconsole.sol#L10991-L11032) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10999-L11021)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11023-L11031)

lib/forge-std/src/safeconsole.sol#L10991-L11032


 - [ ] ID-328
[safeconsole.log(address,address)](lib/forge-std/src/safeconsole.sol#L172-L191) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L176-L184)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L186-L190)

lib/forge-std/src/safeconsole.sol#L172-L191


 - [ ] ID-329
[safeconsole.log(uint256,bool,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L8626-L8667) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8634-L8656)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8658-L8666)

lib/forge-std/src/safeconsole.sol#L8626-L8667


 - [ ] ID-330
[safeconsole.log(bool,bytes32,address,bool)](lib/forge-std/src/safeconsole.sol#L7009-L7050) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7017-L7039)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7041-L7049)

lib/forge-std/src/safeconsole.sol#L7009-L7050


 - [ ] ID-331
[StdCheatsSafe.deployCode(string,bytes,uint256)](lib/forge-std/src/StdCheats.sol#L520-L527) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L522-L524)

lib/forge-std/src/StdCheats.sol#L520-L527


 - [ ] ID-332
[safeconsole.log(uint256,uint256,address,uint256)](lib/forge-std/src/safeconsole.sol#L8906-L8933) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8912-L8924)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8926-L8932)

lib/forge-std/src/safeconsole.sol#L8906-L8933


 - [ ] ID-333
[safeconsole.log(bytes32,bool,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L11213-L11261) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11223-L11248)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11250-L11260)

lib/forge-std/src/safeconsole.sol#L11213-L11261


 - [ ] ID-334
[safeconsole.log(uint256,address,bool,uint256)](lib/forge-std/src/safeconsole.sol#L7898-L7925) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7904-L7916)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7918-L7924)

lib/forge-std/src/safeconsole.sol#L7898-L7925


 - [ ] ID-335
[safeconsole.log(uint256,address,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L8143-L8184) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8151-L8173)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8175-L8183)

lib/forge-std/src/safeconsole.sol#L8143-L8184


 - [ ] ID-336
[safeconsole.log(uint256,uint256)](lib/forge-std/src/safeconsole.sol#L410-L429) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L414-L422)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L424-L428)

lib/forge-std/src/safeconsole.sol#L410-L429


 - [ ] ID-337
[safeconsole.log(bool,bytes32,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L7410-L7451) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7418-L7440)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7442-L7450)

lib/forge-std/src/safeconsole.sol#L7410-L7451


 - [ ] ID-338
[safeconsole.log(bytes32,bool,bool,uint256)](lib/forge-std/src/safeconsole.sol#L11170-L11211) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11178-L11200)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11202-L11210)

lib/forge-std/src/safeconsole.sol#L11170-L11211


 - [ ] ID-339
[safeconsole.log(address,uint256,uint256,bool)](lib/forge-std/src/safeconsole.sol#L4235-L4262) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4241-L4253)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4255-L4261)

lib/forge-std/src/safeconsole.sol#L4235-L4262


 - [ ] ID-340
[safeconsole.log(uint256,bool,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L8798-L8846) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8808-L8833)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8835-L8845)

lib/forge-std/src/safeconsole.sol#L8798-L8846


 - [ ] ID-341
[safeconsole.log(uint256,uint256,address,address)](lib/forge-std/src/safeconsole.sol#L8848-L8875) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8854-L8866)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L8868-L8874)

lib/forge-std/src/safeconsole.sol#L8848-L8875


 - [ ] ID-342
[safeconsole.log(bool,uint256,address)](lib/forge-std/src/safeconsole.sol#L1346-L1369) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1351-L1361)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1363-L1368)

lib/forge-std/src/safeconsole.sol#L1346-L1369


 - [ ] ID-343
[safeconsole.log(bool,uint256)](lib/forge-std/src/safeconsole.sol#L312-L331) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L316-L324)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L326-L330)

lib/forge-std/src/safeconsole.sol#L312-L331


 - [ ] ID-344
[safeconsole.log(uint256,uint256,address)](lib/forge-std/src/safeconsole.sol#L1851-L1874) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1856-L1866)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1868-L1873)

lib/forge-std/src/safeconsole.sol#L1851-L1874


 - [ ] ID-345
[safeconsole.log(address,uint256,bytes32,bool)](lib/forge-std/src/safeconsole.sol#L4379-L4420) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4387-L4409)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4411-L4419)

lib/forge-std/src/safeconsole.sol#L4379-L4420


 - [ ] ID-346
[safeconsole.log(address,bytes32,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L5002-L5050) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5012-L5037)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5039-L5049)

lib/forge-std/src/safeconsole.sol#L5002-L5050


 - [ ] ID-347
[safeconsole.log(bool,bytes32,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L7603-L7651) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7613-L7638)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7640-L7650)

lib/forge-std/src/safeconsole.sol#L7603-L7651


 - [ ] ID-348
[safeconsole.log(address,address,uint256,uint256)](lib/forge-std/src/safeconsole.sol#L3126-L3153) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3132-L3144)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3146-L3152)

lib/forge-std/src/safeconsole.sol#L3126-L3153


 - [ ] ID-349
[safeconsole.log(bool,address,bytes32,address)](lib/forge-std/src/safeconsole.sol#L5649-L5690) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5657-L5679)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5681-L5689)

lib/forge-std/src/safeconsole.sol#L5649-L5690


 - [ ] ID-350
[safeconsole.log(bool,address,uint256,address)](lib/forge-std/src/safeconsole.sol#L5519-L5546) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5525-L5537)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5539-L5545)

lib/forge-std/src/safeconsole.sol#L5519-L5546


 - [ ] ID-351
[safeconsole.log(bytes32,uint256,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L12336-L12391) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12348-L12376)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12378-L12390)

lib/forge-std/src/safeconsole.sol#L12336-L12391


 - [ ] ID-352
[safeconsole.log(address,uint256,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L4163-L4204) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4171-L4193)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4195-L4203)

lib/forge-std/src/safeconsole.sol#L4163-L4204


 - [ ] ID-353
[safeconsole.log(bytes32,bool,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L11542-L11590) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11552-L11577)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11579-L11589)

lib/forge-std/src/safeconsole.sol#L11542-L11590


 - [ ] ID-354
[safeconsole.log(address,bytes32,address,bytes32)](lib/forge-std/src/safeconsole.sol#L4644-L4692) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4654-L4679)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4681-L4691)

lib/forge-std/src/safeconsole.sol#L4644-L4692


 - [ ] ID-355
[safeconsole.log(bytes32,address,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L10469-L10517) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10479-L10504)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10506-L10516)

lib/forge-std/src/safeconsole.sol#L10469-L10517


 - [ ] ID-356
[safeconsole.log(address,bool,address,address)](lib/forge-std/src/safeconsole.sol#L3377-L3404) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3383-L3395)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3397-L3403)

lib/forge-std/src/safeconsole.sol#L3377-L3404


 - [ ] ID-357
[safeconsole.log(bool,address,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L5606-L5647) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5614-L5636)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5638-L5646)

lib/forge-std/src/safeconsole.sol#L5606-L5647


 - [ ] ID-358
[safeconsole.log(address,address,bytes32,uint256)](lib/forge-std/src/safeconsole.sol#L3284-L3325) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3292-L3314)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3316-L3324)

lib/forge-std/src/safeconsole.sol#L3284-L3325


 - [ ] ID-359
[safeconsole.log(uint256)](lib/forge-std/src/safeconsole.sol#L124-L139) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L127-L133)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L135-L138)

lib/forge-std/src/safeconsole.sol#L124-L139


 - [ ] ID-360
[safeconsole.log(address,uint256,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L4465-L4513) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4475-L4500)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4502-L4512)

lib/forge-std/src/safeconsole.sol#L4465-L4513


 - [ ] ID-361
[safeconsole.log(address,uint256,address,address)](lib/forge-std/src/safeconsole.sol#L3946-L3973) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3952-L3964)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3966-L3972)

lib/forge-std/src/safeconsole.sol#L3946-L3973


 - [ ] ID-362
[safeconsole.log(uint256,uint256,bytes32,address)](lib/forge-std/src/safeconsole.sol#L9238-L9279) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9246-L9268)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9270-L9278)

lib/forge-std/src/safeconsole.sol#L9238-L9279


 - [ ] ID-363
[safeconsole.log(bytes32,bool,bool)](lib/forge-std/src/safeconsole.sol#L2330-L2367) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2337-L2357)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2359-L2366)

lib/forge-std/src/safeconsole.sol#L2330-L2367


 - [ ] ID-364
[safeconsole.log(bool,address,address,uint256)](lib/forge-std/src/safeconsole.sol#L5317-L5344) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5323-L5335)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5337-L5343)

lib/forge-std/src/safeconsole.sol#L5317-L5344


 - [ ] ID-365
[safeconsole.log(bool,bytes32,address,bytes32)](lib/forge-std/src/safeconsole.sol#L7095-L7143) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7105-L7130)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7132-L7142)

lib/forge-std/src/safeconsole.sol#L7095-L7143


 - [ ] ID-366
[safeconsole.log(bytes32,bytes32,uint256,address)](lib/forge-std/src/safeconsole.sol#L12807-L12855) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12817-L12842)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L12844-L12854)

lib/forge-std/src/safeconsole.sol#L12807-L12855


 - [ ] ID-367
[safeconsole.log(bytes32,address,address)](lib/forge-std/src/safeconsole.sol#L2128-L2165) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2135-L2155)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2157-L2164)

lib/forge-std/src/safeconsole.sol#L2128-L2165


 - [ ] ID-368
[safeconsole.log(bool,bytes32,bool,uint256)](lib/forge-std/src/safeconsole.sol#L7231-L7272) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7239-L7261)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7263-L7271)

lib/forge-std/src/safeconsole.sol#L7231-L7272


 - [ ] ID-369
[safeconsole.log(bytes32,address,bool,address)](lib/forge-std/src/safeconsole.sol#L10340-L10381) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10348-L10370)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L10372-L10380)

lib/forge-std/src/safeconsole.sol#L10340-L10381


 - [ ] ID-370
[safeconsole.log(bool,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L1307-L1344) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1314-L1334)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1336-L1343)

lib/forge-std/src/safeconsole.sol#L1307-L1344


 - [ ] ID-371
[safeconsole.log(bool,bool,bool,bool)](lib/forge-std/src/safeconsole.sol#L5987-L6014) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5993-L6005)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6007-L6013)

lib/forge-std/src/safeconsole.sol#L5987-L6014


 - [ ] ID-372
[safeconsole.log(address,uint256,bytes32,address)](lib/forge-std/src/safeconsole.sol#L4336-L4377) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4344-L4366)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4368-L4376)

lib/forge-std/src/safeconsole.sol#L4336-L4377


 - [ ] ID-373
[safeconsole.log(uint256,bytes32,uint256,address)](lib/forge-std/src/safeconsole.sol#L9775-L9816) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9783-L9805)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L9807-L9815)

lib/forge-std/src/safeconsole.sol#L9775-L9816


 - [ ] ID-374
[safeconsole.log(address,uint256,uint256,bytes32)](lib/forge-std/src/safeconsole.sol#L4293-L4334) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4301-L4323)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4325-L4333)

lib/forge-std/src/safeconsole.sol#L4293-L4334


 - [ ] ID-375
[safeconsole.log(bytes32,uint256,address,bytes32)](lib/forge-std/src/safeconsole.sol#L11778-L11826) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11788-L11813)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L11815-L11825)

lib/forge-std/src/safeconsole.sol#L11778-L11826


 - [ ] ID-376
[safeconsole.log(address,bytes32,bool,bytes32)](lib/forge-std/src/safeconsole.sol#L4823-L4871) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4833-L4858)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4860-L4870)

lib/forge-std/src/safeconsole.sol#L4823-L4871


 - [ ] ID-377
[safeconsole.log(bool,uint256,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L6916-L6964) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6926-L6951)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6953-L6963)

lib/forge-std/src/safeconsole.sol#L6916-L6964


 - [ ] ID-378
[safeconsole.log(address,bool,address)](lib/forge-std/src/safeconsole.sol#L727-L750) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L732-L742)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L744-L749)

lib/forge-std/src/safeconsole.sol#L727-L750


 - [ ] ID-379
[safeconsole.log(bytes32,bytes32,bytes32)](lib/forge-std/src/safeconsole.sol#L2755-L2806) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2766-L2792)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L2794-L2805)

lib/forge-std/src/safeconsole.sol#L2755-L2806


 - [ ] ID-380
[safeconsole.log(uint256,address,address)](lib/forge-std/src/safeconsole.sol#L1623-L1646) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1628-L1638)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1640-L1645)

lib/forge-std/src/safeconsole.sol#L1623-L1646


 - [ ] ID-381
[safeconsole.log(bool,bytes32,address,address)](lib/forge-std/src/safeconsole.sol#L6966-L7007) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6974-L6996)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L6998-L7006)

lib/forge-std/src/safeconsole.sol#L6966-L7007


 - [ ] ID-382
[safeconsole.log(bool,address,bool,bool)](lib/forge-std/src/safeconsole.sol#L5418-L5445) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5424-L5436)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L5438-L5444)

lib/forge-std/src/safeconsole.sol#L5418-L5445


 - [ ] ID-383
[safeconsole.log(uint256,bool,bool)](lib/forge-std/src/safeconsole.sol#L1762-L1785) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1767-L1777)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L1779-L1784)

lib/forge-std/src/safeconsole.sol#L1762-L1785


 - [ ] ID-384
[stdStorageSafe.flatten(bytes32[])](lib/forge-std/src/StdStorage.sol#L297-L307) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L301-L303)

lib/forge-std/src/StdStorage.sol#L297-L307


 - [ ] ID-385
[safeconsole.log(bool,bytes32,bool,bool)](lib/forge-std/src/safeconsole.sol#L7188-L7229) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7196-L7218)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L7220-L7228)

lib/forge-std/src/safeconsole.sol#L7188-L7229


 - [ ] ID-386
[safeconsole.log(address,bytes32,uint256,bool)](lib/forge-std/src/safeconsole.sol#L4916-L4957) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4924-L4946)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L4948-L4956)

lib/forge-std/src/safeconsole.sol#L4916-L4957


 - [ ] ID-387
[safeconsole.log(address,bool,address,uint256)](lib/forge-std/src/safeconsole.sol#L3435-L3462) uses assembly
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3441-L3453)
	- [INLINE ASM](lib/forge-std/src/safeconsole.sol#L3455-L3461)

lib/forge-std/src/safeconsole.sol#L3435-L3462


## boolean-equal
Impact: Informational
Confidence: High
 - [ ] ID-388
[StdCheatsSafe.assumeNotBlacklisted(address,address)](lib/forge-std/src/StdCheats.sol#L207-L225) compares to a boolean constant:
	-[vm.assume(! success || abi.decode(returnData,(bool)) == false)](lib/forge-std/src/StdCheats.sol#L220)

lib/forge-std/src/StdCheats.sol#L207-L225


 - [ ] ID-389
[StdCheatsSafe.assumeNotBlacklisted(address,address)](lib/forge-std/src/StdCheats.sol#L207-L225) compares to a boolean constant:
	-[vm.assume(! success || abi.decode(returnData,(bool)) == false)](lib/forge-std/src/StdCheats.sol#L224)

lib/forge-std/src/StdCheats.sol#L207-L225


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-390
2 different versions of Solidity are used:
	- Version constraint >=0.8.13<0.9.0 is used by:
		-[>=0.8.13<0.9.0](lib/forge-std/src/Base.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdAssertions.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdChains.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdCheats.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdConstants.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdError.sol#L3)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdInvariant.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdJson.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdMath.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdStorage.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdStyle.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdToml.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/StdUtils.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/Test.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/Vm.sol#L4)
		-[>=0.8.13<0.9.0](lib/forge-std/src/console.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/console2.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/interfaces/IMulticall3.sol#L2)
		-[>=0.8.13<0.9.0](lib/forge-std/src/safeconsole.sol#L2)
	- Version constraint ^0.8.26 is used by:
		-[^0.8.26](src/dos_por_gas.sol#L2)
		-[^0.8.26](src/dos_por_gas_arreglado.sol#L2)

lib/forge-std/src/Base.sol#L2


## costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-391
[plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81) has costly operations inside a loop:
	- [inversores.pop()](src/dos_por_gas.sol#L69)

src/dos_por_gas.sol#L64-L81


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-392
Version constraint >=0.8.13<0.9.0 is too complex.
It is used by:
	- [>=0.8.13<0.9.0](lib/forge-std/src/Base.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdAssertions.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdChains.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdCheats.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdConstants.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdError.sol#L3)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdInvariant.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdJson.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdMath.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdStorage.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdStyle.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdToml.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/StdUtils.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/Test.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/Vm.sol#L4)
	- [>=0.8.13<0.9.0](lib/forge-std/src/console.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/console2.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/interfaces/IMulticall3.sol#L2)
	- [>=0.8.13<0.9.0](lib/forge-std/src/safeconsole.sol#L2)

lib/forge-std/src/Base.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-393
Low level call in [StdCheats.dealERC1155(address,address,uint256,uint256,bool)](lib/forge-std/src/StdCheats.sol#L809-L832):
	- [(None,balData) = token.staticcall(abi.encodeWithSelector(0x00fdd58e,to,id))](lib/forge-std/src/StdCheats.sol#L811)
	- [(None,totSupData) = token.staticcall(abi.encodeWithSelector(0xbd85b039,id))](lib/forge-std/src/StdCheats.sol#L819)

lib/forge-std/src/StdCheats.sol#L809-L832


 - [ ] ID-394
Low level call in [StdCheatsSafe.assumeNotBlacklisted(address,address)](lib/forge-std/src/StdCheats.sol#L207-L225):
	- [(success,returnData) = token.staticcall(abi.encodeWithSelector(0xfe575a87,addr))](lib/forge-std/src/StdCheats.sol#L219)
	- [(success,returnData) = token.staticcall(abi.encodeWithSelector(0xe47d6060,addr))](lib/forge-std/src/StdCheats.sol#L223)

lib/forge-std/src/StdCheats.sol#L207-L225


 - [ ] ID-395
Low level call in [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81):
	- [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas.sol#L73)

src/dos_por_gas.sol#L64-L81


 - [ ] ID-396
Low level call in [plazo_fijo_arreglado.devolver_intereses()](src/dos_por_gas_arreglado.sol#L53-L64):
	- [(ok,None) = inversor.call{value: monto_invertido * interes}()](src/dos_por_gas_arreglado.sol#L59)

src/dos_por_gas_arreglado.sol#L53-L64


 - [ ] ID-397
Low level call in [stdStorageSafe.callTarget(StdStorage)](lib/forge-std/src/StdStorage.sol#L44-L50):
	- [(success,rdat) = self._target.staticcall(cd)](lib/forge-std/src/StdStorage.sol#L46)

lib/forge-std/src/StdStorage.sol#L44-L50


 - [ ] ID-398
Low level call in [StdCheatsSafe._isPayable(address)](lib/forge-std/src/StdCheats.sol#L282-L298):
	- [(success,None) = address(addr).call{value: 1}()](lib/forge-std/src/StdCheats.sol#L291)

lib/forge-std/src/StdCheats.sol#L282-L298


 - [ ] ID-399
Low level call in [StdCheats.deployCodeTo(string,bytes,uint256,address)](lib/forge-std/src/StdCheats.sol#L864-L870):
	- [(success,runtimeBytecode) = where.call{value: value}()](lib/forge-std/src/StdCheats.sol#L867)

lib/forge-std/src/StdCheats.sol#L864-L870


 - [ ] ID-400
Low level call in [StdCheats.console2_log_StdCheats(string)](lib/forge-std/src/StdCheats.sol#L873-L876):
	- [(status,None) = address(CONSOLE2_ADDRESS).staticcall(abi.encodeWithSignature(log(string),p0))](lib/forge-std/src/StdCheats.sol#L874)

lib/forge-std/src/StdCheats.sol#L873-L876


 - [ ] ID-401
Low level call in [StdCheats.dealERC721(address,address,uint256)](lib/forge-std/src/StdCheats.sol#L834-L854):
	- [(successMinted,ownerData) = token.staticcall(abi.encodeWithSelector(0x6352211e,id))](lib/forge-std/src/StdCheats.sol#L836)
	- [(None,fromBalData) = token.staticcall(abi.encodeWithSelector(0x70a08231,abi.decode(ownerData,(address))))](lib/forge-std/src/StdCheats.sol#L840-L841)
	- [(None,toBalData) = token.staticcall(abi.encodeWithSelector(0x70a08231,to))](lib/forge-std/src/StdCheats.sol#L845)

lib/forge-std/src/StdCheats.sol#L834-L854


 - [ ] ID-402
Low level call in [StdCheats.deal(address,address,uint256,bool)](lib/forge-std/src/StdCheats.sol#L788-L807):
	- [(None,balData) = token.staticcall(abi.encodeWithSelector(0x70a08231,to))](lib/forge-std/src/StdCheats.sol#L790)
	- [(None,totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd))](lib/forge-std/src/StdCheats.sol#L798)

lib/forge-std/src/StdCheats.sol#L788-L807


 - [ ] ID-403
Low level call in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L1268-L1299):
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L1275)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L1276)

lib/forge-std/src/StdAssertions.sol#L1268-L1299


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-404
Parameter [stdStorage.sig(StdStorage,string)._sig](lib/forge-std/src/StdStorage.sol#L361) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L361


 - [ ] ID-405
Event [StdAssertions.log_named_uint(string,uint256)](lib/forge-std/src/StdAssertions.sol#L25) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L25


 - [ ] ID-406
Function [stdStorageSafe.enable_packed_slots(StdStorage)](lib/forge-std/src/StdStorage.sol#L207-L210) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L207-L210


 - [ ] ID-407
Function [stdStorageSafe.read_uint(StdStorage)](lib/forge-std/src/StdStorage.sol#L240-L242) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L240-L242


 - [ ] ID-408
Constant [StdAssertions.vm](lib/forge-std/src/StdAssertions.sol#L8) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdAssertions.sol#L8


 - [ ] ID-409
Parameter [stdStorage.target(StdStorage,address)._target](lib/forge-std/src/StdStorage.sol#L353) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L353


 - [ ] ID-410
Function [stdStorageSafe.read_int(StdStorage)](lib/forge-std/src/StdStorage.sol#L244-L246) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L244-L246


 - [ ] ID-411
Parameter [stdStorageSafe.sig(StdStorage,bytes4)._sig](lib/forge-std/src/StdStorage.sol#L177) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L177


 - [ ] ID-412
Event [StdAssertions.log_named_decimal_uint(string,uint256,uint256)](lib/forge-std/src/StdAssertions.sol#L23) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L23


 - [ ] ID-413
Parameter [stdStorage.find(StdStorage,bool)._clear](lib/forge-std/src/StdStorage.sol#L349) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L349


 - [ ] ID-414
Function [stdStorage.checked_write(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L413-L447) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L413-L447


 - [ ] ID-415
Parameter [stdStorage.sig(StdStorage,bytes4)._sig](lib/forge-std/src/StdStorage.sol#L357) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L357


 - [ ] ID-416
Event [StdAssertions.log_named_bytes32(string,bytes32)](lib/forge-std/src/StdAssertions.sol#L21) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L21


 - [ ] ID-417
Function [stdStorage.enable_packed_slots(StdStorage)](lib/forge-std/src/StdStorage.sol#L381-L383) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L381-L383


 - [ ] ID-418
Constant [stdJson.vm](lib/forge-std/src/StdJson.sol#L24) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdJson.sol#L24


 - [ ] ID-419
Event [StdAssertions.log_array(address[])](lib/forge-std/src/StdAssertions.sol#L31) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L31


 - [ ] ID-420
Variable [plazo_fijo.inscripcion_abierta](src/dos_por_gas.sol#L14) is not in mixedCase

src/dos_por_gas.sol#L14


 - [ ] ID-421
Parameter [stdStorage.with_calldata(StdStorage,bytes)._calldata](lib/forge-std/src/StdStorage.sol#L377) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L377


 - [ ] ID-422
Event [StdAssertions.log_bytes(bytes)](lib/forge-std/src/StdAssertions.sol#L17) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L17


 - [ ] ID-423
Constant [StdCheatsSafe.vm](lib/forge-std/src/StdCheats.sol#L9) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdCheats.sol#L9


 - [ ] ID-424
Function [stdStorage.checked_write(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L405-L411) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L405-L411


 - [ ] ID-425
Parameter [stdStorageSafe.with_calldata(StdStorage,bytes)._calldata](lib/forge-std/src/StdStorage.sol#L187) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L187


 - [ ] ID-426
Function [stdStorageSafe.with_calldata(StdStorage,bytes)](lib/forge-std/src/StdStorage.sol#L187-L190) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L187-L190


 - [ ] ID-427
Function [plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81) is not in mixedCase

src/dos_por_gas.sol#L64-L81


 - [ ] ID-428
Function [stdStorageSafe.read_bytes32(StdStorage)](lib/forge-std/src/StdStorage.sol#L225-L227) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L225-L227


 - [ ] ID-429
Event [plazo_fijo_arreglado.Interes_devuelto(address)](src/dos_por_gas_arreglado.sol#L15) is not in CapWords

src/dos_por_gas_arreglado.sol#L15


 - [ ] ID-430
Variable [plazo_fijo_arreglado.inscripcion_abierta](src/dos_por_gas_arreglado.sol#L10) is not in mixedCase

src/dos_por_gas_arreglado.sol#L10


 - [ ] ID-431
Function [stdStorage.with_key(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L373-L375) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L373-L375


 - [ ] ID-432
Function [stdStorage.read_uint(StdStorage)](lib/forge-std/src/StdStorage.sol#L461-L463) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L461-L463


 - [ ] ID-433
Constant [StdCheats.vm](lib/forge-std/src/StdCheats.sol#L650) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdCheats.sol#L650


 - [ ] ID-434
Function [plazo_fijo_arreglado.devolver_intereses()](src/dos_por_gas_arreglado.sol#L53-L64) is not in mixedCase

src/dos_por_gas_arreglado.sol#L53-L64


 - [ ] ID-435
Function [stdStorageSafe.read_address(StdStorage)](lib/forge-std/src/StdStorage.sol#L236-L238) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L236-L238


 - [ ] ID-436
Parameter [stdStorage.depth(StdStorage,uint256)._depth](lib/forge-std/src/StdStorage.sol#L385) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L385


 - [ ] ID-437
Event [StdAssertions.log_array(uint256[])](lib/forge-std/src/StdAssertions.sol#L29) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L29


 - [ ] ID-438
Event [StdAssertions.log_uint(uint256)](lib/forge-std/src/StdAssertions.sol#L16) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L16


 - [ ] ID-439
Function [StdCheats.console2_log_StdCheats(string)](lib/forge-std/src/StdCheats.sol#L873-L876) is not in mixedCase

lib/forge-std/src/StdCheats.sol#L873-L876


 - [ ] ID-440
Contract [stdToml](lib/forge-std/src/StdToml.sol#L23-L275) is not in CapWords

lib/forge-std/src/StdToml.sol#L23-L275


 - [ ] ID-441
Event [StdAssertions.log_named_bytes(string,bytes)](lib/forge-std/src/StdAssertions.sol#L26) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L26


 - [ ] ID-442
Event [stdStorageSafe.WARNING_UninitedSlot(address,uint256)](lib/forge-std/src/StdStorage.sol#L26) is not in CapWords

lib/forge-std/src/StdStorage.sol#L26


 - [ ] ID-443
Function [plazo_fijo.cerrar_incripcion()](src/dos_por_gas.sol#L39-L41) is not in mixedCase

src/dos_por_gas.sol#L39-L41


 - [ ] ID-444
Contract [console](lib/forge-std/src/console.sol#L4-L1599) is not in CapWords

lib/forge-std/src/console.sol#L4-L1599


 - [ ] ID-445
Variable [plazo_fijo.cantidad_invertida](src/dos_por_gas.sol#L11) is not in mixedCase

src/dos_por_gas.sol#L11


 - [ ] ID-446
Function [StdUtils.console2_log_StdUtils(string,uint256)](lib/forge-std/src/StdUtils.sol#L193-L195) is not in mixedCase

lib/forge-std/src/StdUtils.sol#L193-L195


 - [ ] ID-447
Event [StdAssertions.log_bytes32(bytes32)](lib/forge-std/src/StdAssertions.sol#L14) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L14


 - [ ] ID-448
Function [stdStorage.read_int(StdStorage)](lib/forge-std/src/StdStorage.sol#L465-L467) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L465-L467


 - [ ] ID-449
Contract [plazo_fijo](src/dos_por_gas.sol#L8-L82) is not in CapWords

src/dos_por_gas.sol#L8-L82


 - [ ] ID-450
Constant [StdChains.vm](lib/forge-std/src/StdChains.sol#L35) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdChains.sol#L35


 - [ ] ID-451
Constant [stdToml.vm](lib/forge-std/src/StdToml.sol#L24) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdToml.sol#L24


 - [ ] ID-452
Event [StdAssertions.log(string)](lib/forge-std/src/StdAssertions.sol#L10) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L10


 - [ ] ID-453
Function [stdStorage.checked_write(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L393-L395) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L393-L395


 - [ ] ID-454
Function [stdStorage.read_bool(StdStorage)](lib/forge-std/src/StdStorage.sol#L453-L455) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L453-L455


 - [ ] ID-455
Contract [stdStorage](lib/forge-std/src/StdStorage.sol#L338-L476) is not in CapWords

lib/forge-std/src/StdStorage.sol#L338-L476


 - [ ] ID-456
Contract [stdJson](lib/forge-std/src/StdJson.sol#L23-L275) is not in CapWords

lib/forge-std/src/StdJson.sol#L23-L275


 - [ ] ID-457
Constant [stdStorageSafe.vm](lib/forge-std/src/StdStorage.sol#L28) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStorage.sol#L28


 - [ ] ID-458
Constant [StdStyle.vm](lib/forge-std/src/StdStyle.sol#L7) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStyle.sol#L7


 - [ ] ID-459
Constant [stdStorage.vm](lib/forge-std/src/StdStorage.sol#L339) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStorage.sol#L339


 - [ ] ID-460
Constant [ScriptBase.vmSafe](lib/forge-std/src/Base.sol#L47) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/Base.sol#L47


 - [ ] ID-461
Function [stdStorage.with_key(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L365-L367) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L365-L367


 - [ ] ID-462
Function [stdStorage.checked_write(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L397-L399) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L397-L399


 - [ ] ID-463
Contract [plazo_fijo_arreglado](src/dos_por_gas_arreglado.sol#L5-L65) is not in CapWords

src/dos_por_gas_arreglado.sol#L5-L65


 - [ ] ID-464
Contract [stdStorageSafe](lib/forge-std/src/StdStorage.sol#L24-L336) is not in CapWords

lib/forge-std/src/StdStorage.sol#L24-L336


 - [ ] ID-465
Event [plazo_fijo.Inversion_realizada(address,uint256)](src/dos_por_gas.sol#L17) is not in CapWords

src/dos_por_gas.sol#L17


 - [ ] ID-466
Function [stdStorageSafe.with_key(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L192-L195) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L192-L195


 - [ ] ID-467
Contract [stdMath](lib/forge-std/src/StdMath.sol#L5-L67) is not in CapWords

lib/forge-std/src/StdMath.sol#L5-L67


 - [ ] ID-468
Event [plazo_fijo_arreglado.Inversion_realizada(address,uint256)](src/dos_por_gas_arreglado.sol#L14) is not in CapWords

src/dos_por_gas_arreglado.sol#L14


 - [ ] ID-469
Event [StdAssertions.log_named_int(string,int256)](lib/forge-std/src/StdAssertions.sol#L24) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L24


 - [ ] ID-470
Contract [stdError](lib/forge-std/src/StdError.sol#L6-L33) is not in CapWords

lib/forge-std/src/StdError.sol#L6-L33


 - [ ] ID-471
Event [StdAssertions.logs(bytes)](lib/forge-std/src/StdAssertions.sol#L11) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L11


 - [ ] ID-472
Variable [Test.IS_TEST](lib/forge-std/src/Test.sol#L31) is not in mixedCase

lib/forge-std/src/Test.sol#L31


 - [ ] ID-473
Function [StdUtils.console2_log_StdUtils(string)](lib/forge-std/src/StdUtils.sol#L189-L191) is not in mixedCase

lib/forge-std/src/StdUtils.sol#L189-L191


 - [ ] ID-474
Function [stdStorage.with_calldata(StdStorage,bytes)](lib/forge-std/src/StdStorage.sol#L377-L379) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L377-L379


 - [ ] ID-475
Parameter [stdStorageSafe.depth(StdStorage,uint256)._depth](lib/forge-std/src/StdStorage.sol#L212) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L212


 - [ ] ID-476
Parameter [stdStorageSafe.find(StdStorage,bool)._clear](lib/forge-std/src/StdStorage.sol#L106) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L106


 - [ ] ID-477
Function [stdStorage.read_address(StdStorage)](lib/forge-std/src/StdStorage.sol#L457-L459) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L457-L459


 - [ ] ID-478
Event [StdAssertions.log_address(address)](lib/forge-std/src/StdAssertions.sol#L13) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L13


 - [ ] ID-479
Event [StdAssertions.log_int(int256)](lib/forge-std/src/StdAssertions.sol#L15) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L15


 - [ ] ID-480
Function [VmSafe.eth_getLogs(uint256,uint256,address,bytes32[])](lib/forge-std/src/Vm.sol#L650-L653) is not in mixedCase

lib/forge-std/src/Vm.sol#L650-L653


 - [ ] ID-481
Parameter [stdStorageSafe.target(StdStorage,address)._target](lib/forge-std/src/StdStorage.sol#L172) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L172


 - [ ] ID-482
Contract [safeconsole](lib/forge-std/src/safeconsole.sol#L6-L13248) is not in CapWords

lib/forge-std/src/safeconsole.sol#L6-L13248


 - [ ] ID-483
Function [plazo_fijo_arreglado.cerrar_incripcion()](src/dos_por_gas_arreglado.sol#L36-L38) is not in mixedCase

src/dos_por_gas_arreglado.sol#L36-L38


 - [ ] ID-484
Constant [StdUtils.vm](lib/forge-std/src/StdUtils.sol#L13) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdUtils.sol#L13


 - [ ] ID-485
Event [StdAssertions.log_array(int256[])](lib/forge-std/src/StdAssertions.sol#L30) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L30


 - [ ] ID-486
Function [stdStorageSafe.with_key(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L197-L200) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L197-L200


 - [ ] ID-487
Event [StdAssertions.log_named_array(string,int256[])](lib/forge-std/src/StdAssertions.sol#L33) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L33


 - [ ] ID-488
Function [StdUtils.console2_log_StdUtils(string,string)](lib/forge-std/src/StdUtils.sol#L197-L199) is not in mixedCase

lib/forge-std/src/StdUtils.sol#L197-L199


 - [ ] ID-489
Parameter [stdStorageSafe.sig(StdStorage,string)._sig](lib/forge-std/src/StdStorage.sol#L182) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L182


 - [ ] ID-490
Function [stdStorageSafe.read_bool(StdStorage)](lib/forge-std/src/StdStorage.sol#L229-L234) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L229-L234


 - [ ] ID-491
Event [StdAssertions.log_named_string(string,string)](lib/forge-std/src/StdAssertions.sol#L27) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L27


 - [ ] ID-492
Function [stdStorage.checked_write_int(StdStorage,int256)](lib/forge-std/src/StdStorage.sol#L401-L403) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L401-L403


 - [ ] ID-493
Event [plazo_fijo.Interes_devuelto(address)](src/dos_por_gas.sol#L18) is not in CapWords

src/dos_por_gas.sol#L18


 - [ ] ID-494
Function [stdStorageSafe.with_key(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L202-L205) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L202-L205


 - [ ] ID-495
Constant [CommonBase.vm](lib/forge-std/src/Base.sol#L40) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/Base.sol#L40


 - [ ] ID-496
Event [StdAssertions.log_named_address(string,address)](lib/forge-std/src/StdAssertions.sol#L20) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L20


 - [ ] ID-497
Event [StdAssertions.log_named_decimal_int(string,int256,uint256)](lib/forge-std/src/StdAssertions.sol#L22) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L22


 - [ ] ID-498
Event [StdAssertions.log_string(string)](lib/forge-std/src/StdAssertions.sol#L18) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L18


 - [ ] ID-499
Variable [plazo_fijo_arreglado.cantidad_invertida](src/dos_por_gas_arreglado.sol#L8) is not in mixedCase

src/dos_por_gas_arreglado.sol#L8


 - [ ] ID-500
Function [stdStorage.with_key(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L369-L371) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L369-L371


 - [ ] ID-501
Function [stdStorage.read_bytes32(StdStorage)](lib/forge-std/src/StdStorage.sol#L449-L451) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L449-L451


 - [ ] ID-502
Event [StdAssertions.log_named_array(string,address[])](lib/forge-std/src/StdAssertions.sol#L34) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L34


 - [ ] ID-503
Event [StdAssertions.log_named_array(string,uint256[])](lib/forge-std/src/StdAssertions.sol#L32) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L32


## redundant-statements
Impact: Informational
Confidence: High
 - [ ] ID-504
Redundant expression "[status](lib/forge-std/src/StdCheats.sol#L875)" in[StdCheats](lib/forge-std/src/StdCheats.sol#L646-L877)

lib/forge-std/src/StdCheats.sol#L875


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-505
[safeconsole.slitherConstructorConstantVariables()](lib/forge-std/src/safeconsole.sol#L6-L13248) uses literals with too many digits:
	- [CONSOLE_ADDR = 0x000000000000000000000000000000000000000000636F6e736F6c652e6c6f67](lib/forge-std/src/safeconsole.sol#L7)

lib/forge-std/src/safeconsole.sol#L6-L13248


## unindexed-event-address
Impact: Informational
Confidence: High
 - [ ] ID-506
Event [StdAssertions.log_address(address)](lib/forge-std/src/StdAssertions.sol#L13) has address parameters but no indexed parameters

lib/forge-std/src/StdAssertions.sol#L13


 - [ ] ID-507
Event [stdStorageSafe.SlotFound(address,bytes4,bytes32,uint256)](lib/forge-std/src/StdStorage.sol#L25) has address parameters but no indexed parameters

lib/forge-std/src/StdStorage.sol#L25


 - [ ] ID-508
Event [stdStorageSafe.WARNING_UninitedSlot(address,uint256)](lib/forge-std/src/StdStorage.sol#L26) has address parameters but no indexed parameters

lib/forge-std/src/StdStorage.sol#L26


 - [ ] ID-509
Event [StdAssertions.log_named_address(string,address)](lib/forge-std/src/StdAssertions.sol#L20) has address parameters but no indexed parameters

lib/forge-std/src/StdAssertions.sol#L20


## cache-array-length
Impact: Optimization
Confidence: High
 - [ ] ID-510
Loop condition [i < inversores.length](src/dos_por_gas.sol#L51) should use cached array length instead of referencing `length` member of the storage array.
 
src/dos_por_gas.sol#L51


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-511
[Test.IS_TEST](lib/forge-std/src/Test.sol#L31) should be constant 

lib/forge-std/src/Test.sol#L31


