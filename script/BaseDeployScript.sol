// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ContractRegistry} from "./ContractRegistry.sol";

/**
 * @title BaseDeployScript
 * @dev Base deployment script providing simple contract saving functionality
 * Only requires one method: saveContract(contractName, contractAddress)
 */
abstract contract BaseDeployScript is Script {
    using ContractRegistry for *;

    /**
     * @dev Reads a contract address from contracts.json. Returns address(0) if missing.
     * @param contractName Contract name key in the registry
     */
    function getContractAddress(
        string memory contractName
    ) internal view returns (address) {
        string memory fileName = "contracts.json";
        string memory content;

        // Bail out if the file does not exist or is empty
        try vm.readFile(fileName) returns (string memory loaded) {
            if (bytes(loaded).length == 0) {
                return address(0);
            }
            content = loaded;
        } catch {
            return address(0);
        }

        string memory path = string.concat(".", contractName, ".address");
        try vm.parseJsonAddress(content, path) returns (address addr) {
            return addr;
        } catch {
            return address(0);
        }
    }

    /**
     * @dev Save contract name and address to contracts.json
     * @param contractName Contract name
     * @param contractAddress Contract address
     */
    function saveContract(
        string memory contractName,
        address contractAddress
    ) internal {
        ContractRegistry.saveContract(vm, contractName, contractAddress);
    }

    struct Config {
        address usdc;
        address ctf;
        address proxyFactory;
        address safeFactory;
    }

    function _getConfig() internal view returns (Config memory cfg) {
        if (block.chainid == 84532) {
            cfg.usdc = 0x8542FC3a56280a3795990E243c2f99Eb2eBcD51E;
            cfg.ctf = 0x5608E0FCE82574071dd083B2a644A24bbE8847e7;
            cfg.proxyFactory = 0x829170f96E5272feCcf1610DdB45adE63d463Fce;
            cfg.safeFactory = 0xeA3065466332534b25DB041d34773C7206F3884A;
        }
    } 
}
