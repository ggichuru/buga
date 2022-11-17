// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "forge-std/Test.sol";

contract ExpectEmit {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}

contract EmitContractTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function testExpectEmit() public {
        ExpectEmit emiter = new ExpectEmit();

        //Check that topic 1, 2 and data are the same as the following emmited event.
        // Checking topic 3 doesn't matter coz Transfer has only 2 indexed topics
        vm.expectEmit(true, true, false, true);

        // The event we expected
        emit Transfer(address(this), address(1337), 1337);

        // The event we get
        emiter.t();
    }

    function testExpectEmitDoNotCheckData() public {
        ExpectEmit emiter = new ExpectEmit();

        // Check topic 1 and 2, but dont check data
        vm.expectEmit(true, true, false, false);

        // The event we expected
        emit Transfer(address(this), address(1337), 1338);

        // The event we get
        emiter.t();
    }
}
