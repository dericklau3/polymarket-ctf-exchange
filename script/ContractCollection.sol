// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseDeployScript} from "./BaseDeployScript.sol";

import {CTFExchange} from "../src/exchange/CTFExchange.sol";

contract ContractCollection is BaseDeployScript {


    function deployCTFExchange(
        address collateral,
        address ctf,
        address proxyFactory,
        address safeFactory
    ) public returns (CTFExchange exchange) {
        exchange = new CTFExchange(collateral, ctf, proxyFactory, safeFactory);
        saveContract("ctfExchange", address(exchange));
    }
}
