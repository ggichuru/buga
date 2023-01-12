// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* Graph of inheritance
     A
    / \
  B    C
 / \  /
F  D  E

*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

/// @notice contract other contracts using keyword is
contract B is A {
    // Override A.foo();
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

/// @notice contracts can inherit multiple parent contract
// When a fn is called that is defined multiple times in
// different contracts, parent contracts are searched from
// right to left and in depth-first manner

contract D is B, C {
    /// @notice D.foo() returns "C"
    // since C is the right most parent contract with function foo
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    /// @notice E.foo() returns "B"
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

/// @notice Inheritance must be ordered from the most base like to the most derived
/// swapping the order of A and D will throw a compilation error
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}
