// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

/// @notice This wont compile
/// contract B is A {
///   string public name = "Contract B";
///  }
///

/// @notice This is the right way to override inherited state variables
contract C is A {
    constructor() {
        name = "Contract C";
    }

    // C.getName() returns "Contract C"
}
