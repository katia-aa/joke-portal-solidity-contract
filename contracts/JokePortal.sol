// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract JokePortal {
    uint256 private seed;
    event NewJoke(address indexed from, uint256 timestamp, string message);

    struct Joke {
        address joker; // address of user who waved.
        string message; // message the user sent.
        uint256 timestamp; // timestamp of wave
    }

    Joke[] jokes;

    mapping(address => uint256) public lastJokedAt;

    constructor() payable {
        console.log("I am a contract that makes funny jokes possible.");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function joke(string memory _message) public {
        address sender = msg.sender;
        // current timestamp should be more than 15 minutes after the last joke form the same address
        require(lastJokedAt[sender] + 15 minutes < block.timestamp, 'Wait 15m');

        lastJokedAt[sender] = block.timestamp;
        console.log('%s has send us a joke!', sender);

        jokes.push(Joke(sender, _message, block.timestamp));

        // Generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) & 100;
        console.log("Random # generated : %d", seed);
        
        // User gets a 10% chance to win the prize
        if (seed <= 10) {
            console.log("%s won!", sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                'Trying to withdraw more money than the contract has.'
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, 'Failed to withdraw money from contract.');
        }

        emit NewJoke(sender, block.timestamp, _message);
    }
    
    function getAllJokes() public view returns(Joke[] memory)  {
        return jokes;
    }

    function getTotalJokes() public view returns(uint256)  {
        console.log('We have %d total jokes!', jokes.length);
        return jokes.length;
    }

    function laugh(address _jokerAddress) public {
        console.log('User with address: %s has laughed at user with address: %s joke!', msg.sender, _jokerAddress);
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            'Trying to withdraw more money than the contract has.'
        );
        (bool success, ) = (_jokerAddress).call{value: prizeAmount}("");
        require(success, 'Failed to withdraw money from contract.');
    }
}