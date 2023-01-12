// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Base contract X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// Base contract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

/// @dev There ar 2 ways to intialize parent contracts with parameters

/// @notice pass the params hier in the inheritance list
contract B is X("INPUT TO X"), Y("INPUT TO Y") {

}

/// @notice pass the params in the constructor similar to function modifiers
contract C is X, Y {
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

/// @dev Parent constructors are always called in order of inheritance
// regardless of the order of parent contracts listed in the
// constructor of the child contract

/// @notice Order of the constructors called
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X Was Called") Y("Y Was Called") {}
}
