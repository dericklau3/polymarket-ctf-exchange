// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import "./ContractCollection.sol";

contract CTFExchangeScript is ContractCollection {

    uint256 privatekey = vm.envUint("PRIVATEKEY");

    function run() public {
        
        vm.startBroadcast(privatekey);

        Config memory cfg = _getConfig();
        
        deployCTFExchange(cfg.usdc, cfg.ctf, cfg.proxyFactory, cfg.safeFactory);
        
        vm.stopBroadcast();
    }
}
