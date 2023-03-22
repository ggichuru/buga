// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/console.sol";
import "forge-std/Test.sol";

import "../src/mkulyma/WakulimaToken.sol";

contract WakulimaTokenTest is Test {
    WakulimaToken token;

    address user1 = vm.addr(0x1);
    address user2 = vm.addr(0x2);

    function setUp() public {
        token = new WakulimaToken();
    }

    function testName() public {
        assertEq(token.symbol(), "WKM");
    }
}
