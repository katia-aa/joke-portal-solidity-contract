// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] wavesAddresses;
    // Add state variable that holds addresses waved so far in an array

    constructor() {
        console.log("yo yo yo");
    }

    function wave() public {
        totalWaves += 1;
        address senderAddress = msg.sender;
        console.log('%s has waved!', senderAddress);
        wavesAddresses.push(senderAddress);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waves!', totalWaves);
        return totalWaves;
    }
    
    function getTotalWavesAddresses() public view {
        console.log('Here are the addresses that waved at us:');
        for (uint i=0; i < wavesAddresses.length; i++) {
            console.log(wavesAddresses[i]);
        }
    }
}