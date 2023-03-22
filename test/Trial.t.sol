// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Trial.sol";

contract TrialTest is Test {
    Trial trialContract;

    function setUp() public {
        trialContract = new Trial();
    }

    // function testAddOne() public {
    //     uint256 x = 10;
    //     emit log_string("Testing with Fuzzing zz. ..zz");
    //     assertEq(x + 1, trialContract.addOne(x));
    // }
}
