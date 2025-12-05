// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console2.sol";
import "forge-std/Script.sol";

import {IPoolManager} from "@uniswap/v4-core/src/interfaces/IPoolManager.sol";
// import {IAllowanceTransfer} from "permit2/src/interfaces/IAllowanceTransfer.sol";
import {
    Deploy,
    IPositionDescriptor,
    IPositionManager
} from "../test/shared/Deploy.sol";
import {IWETH9} from "../src/interfaces/external/IWETH9.sol";

contract DeployPosmTest is Script {
    function setUp() public {}

    function run()
        public
        returns (IPositionDescriptor positionDescriptor, IPositionManager posm)
    {
        address poolManager = 0xfE7582f6d3cb05c55c9DE5a612778D26e5F627a7;
        address permit2 = 0x000000000022D473030F116dDEE9F6B43aC78BA3;
        uint256 unsubscribeGasLimit = 300000;
        address wrappedNative = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;
        // bytes32 nativeCurrencyLabelBytes = "POL";
        address positionDescriptor = 0x0000000000000000000000000000000000000000;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        //not sure we need a positionDescriptor for now
        // positionDescriptor = Deploy.positionDescriptor(
        //     poolManager,
        //     wrappedNative,
        //     nativeCurrencyLabelBytes,
        //     hex"00"
        // );
        // console2.log("PositionDescriptor", address(positionDescriptor));

        posm = Deploy.positionManager(
            poolManager,
            permit2,
            unsubscribeGasLimit,
            address(positionDescriptor),
            wrappedNative,
            hex"03"
        );
        console2.log("PositionManager", address(posm));

        vm.stopBroadcast();
    }
}
//forge script script/DeployPosm.s.sol --rpc-url {rpcurl} --verify --ffi --broadcast
