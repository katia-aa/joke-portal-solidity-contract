// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract JokePortal {
    event NewJoke(address indexed from, uint256 timestamp, string message);

    struct Joke {
        address joker; // address of user who waved.
        string message; // message the user sent.
        uint256 timestamp; // timestamp of wave
    }

    Joke[] jokes;

    constructor() payable {
        console.log("I am a contract that makes funny jokes possible.");
    }

    function joke(string memory _message) public {
        address joker = msg.sender;
        console.log('%s has send us a joke!', joker);
        jokes.push(Joke(joker, _message, block.timestamp));
        emit NewJoke(joker, block.timestamp, _message);
        
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            'Trying to withdraw more money than the contract has.'
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, 'Failed to withdraw money from contract.');
    }
    
    function getAllJokes() public view returns(Joke[] memory)  {
        return jokes;
    }

    function getTotalJokes() public view returns(uint256)  {
        console.log('We have %d total jokes!', jokes.length);
        return jokes.length;
    }
}