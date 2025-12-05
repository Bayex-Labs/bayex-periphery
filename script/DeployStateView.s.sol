// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console2.sol";
import "forge-std/Script.sol";

import {Deploy, IStateView} from "../test/shared/Deploy.sol";

contract DeployStateView is Script {
    function setUp() public {}

    function run() public returns (IStateView state) {
        address poolManager = 0xfE7582f6d3cb05c55c9DE5a612778D26e5F627a7;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // forge script --broadcast --sig 'run(address)' --rpc-url <RPC_URL> --private-key <PRIV_KEY> --verify script/DeployStateView.s.sol:DeployStateView <POOL_MANAGER_ADDR>
        state = Deploy.stateView(poolManager, hex"00");
        console2.log("StateView", address(state));
        console2.log("PoolManager", address(state.poolManager()));

        vm.stopBroadcast();
    }
}

//forge script script/DeployStateView.s.sol --rpc-url {rpcurl} --verify --ffi --broadcast
