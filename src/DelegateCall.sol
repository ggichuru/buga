// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BeingCalled {
    uint256 public number;

    function setNumber(uint256 _x) public {
        number = _x;
    }
}

contract Calling {
    uint256 public number;
    address public called;

    constructor(address _called) {
        called = _called;
    }

    function callSetNumber(uint256 x) public returns (bool, bytes memory) {
        (bool success, bytes memory data) = called.delegatecall(
            abi.encodeWithSignature("setNumber(uint256)", x)
        );

        return (success, data);
    }
}
