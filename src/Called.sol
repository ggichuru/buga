// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * This contract will be invoked by another contract
 */

contract Called {
    uint256 public number;

    function increment(uint256 _increment) public returns (uint256) {
        number = number + _increment;

        return number;
    }
}

/*
 * This contact will be doing the calling
 *  The called contract has to be delpoyed first
 */
contract Caller {
    // Create a state variable that will sotre the address of the contract to be invoked.
    address public called;

    constructor(address addr) {
        called = addr;
    }

    function callCalled() public returns (bool, bytes memory) {
        (bool success, bytes memory data) = called.call(
            abi.encodeWithSignature("increment(uint256)", 2)
        );

        return (success, data);
    }
}
