// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevopsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentDeployed) public {
      vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s ETH", SEND_VALUE / 1e18);
    }

    function run() public {
      console.log("Funded FundMe run...");
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        
        fundFundMe(mostRecentDeployed);
        
    }
}

contract WithdrawFundMe is Script {
      uint256 constant SEND_VALUE = 0.1 ether;

    function withdrawFundMe(address mostRecentDeployed) public {
      vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdraw FundMe contract with %s ETH", SEND_VALUE / 1e18);
    }

    function run() public {
      console.log("Withdraw FundMe run...");
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        
        withdrawFundMe(mostRecentDeployed);
    }
}
