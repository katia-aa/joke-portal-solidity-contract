// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract JokePortal {
    address[] userAddresses;
    // Add state variable that holds addresses waved so far in an array

    constructor() {
        console.log("yo yo yo");
    }

    function clap() public {
        address senderAddress = msg.sender;
        console.log('%s has waved!', senderAddress);
        userAddresses.push(senderAddress);
    }
    
    function getTotalUserAddresses() public view {
        console.log('We have %d addresses in total who waves at us.', userAddresses.length);
        console.log('Here are the addresses that waved at us:');
        for (uint i=0; i < userAddresses.length; i++) {
            console.log(userAddresses[i]);
        }
    }
}