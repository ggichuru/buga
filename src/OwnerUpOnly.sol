// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

error Unauthorized();

contract OwnerUpOnly {
    address public owner;

    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }

        count++;
    }
}
