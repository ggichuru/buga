// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    // You emit an event from your fn and its logged into transaction log
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo() called");
    }

    function bar() public virtual {
        emit Log("B.foo called");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo() called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar() Called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo() Called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar() Called");
        super.bar();
    }
}

contract D is B, C {
    /// @notice Try:
    // - call D.foo() and check the transactions logs
    //   Although D inherits A, B and C, its only called C then A
    // - call D.bar() and check logs
    //   Although super was called twice (by B and C) it only called A once.

    function foo() public override(B, C) {
        super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}
