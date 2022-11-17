// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Trial {
    function addOne(uint256 x) external pure returns (uint256) {
        return ++x;
    }
}
