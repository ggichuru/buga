// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./libraries/ArrayUtils.sol";

contract Trial {
    function _getContractBalance() external view returns (uint256 _balance) {
        _balance = address(this).balance;
    }

    receive() external payable {}
}

contract EnumTest {
    // Create an enum
    enum ActionChoices {
        GoUp,
        GoDown,
        StayStill,
        TurnAround
    }

    // Statevariables to access enum
    ActionChoices choice;
    ActionChoices constant DEFAULT_CHOICE = ActionChoices.StayStill;

    function setGoUp() public {
        choice = ActionChoices.GoUp;
    }

    function getChoice() public view returns (ActionChoices) {
        return choice;
    }

    function getDefaultChoice() public pure returns (uint256) {
        return uint256(DEFAULT_CHOICE);
    }
}

contract Pyramid {
    using ArrayUtils for *;

    function pyramid(uint256 l) public pure returns (uint256) {
        return ArrayUtils.range(l).map(square).reduce(sum);
    }

    function square(uint256 x) internal pure returns (uint256) {
        return x * x;
    }

    function sum(uint256 x, uint256 y) internal pure returns (uint256) {
        return x + y;
    }
}

contract DataLocations {
    /// @notice b2n storage and memory (or from calldata) always create an independent copy.
    /// @notice from memory to memory -> only create references.
    //         changes to 1 memory variable are visible in all ohter mem vars refering to the same data
    /// @notice from storage to a local storage variable -> only assign a reference.

    /// @notice the data location of x is storage.
    // This is the only place where the data location can be ommited
    uint256[] x;

    /// @notice the data location memoryArray is memory
    function f(uint256[] memory memoryArray) public {
        x = memoryArray; /// @dev copies the whole array to storage

        uint256[] storage y = x; /// @dev assigns a pointer // data location of y is storage
        y[7]; /// @return 8th element;
        y.pop(); /// @dev remove the last element in x
        delete x; /// @dev clears the array and also modifies y

        /// @dev `delete y` is not valid as assignmnets to local variables ref storage can only be made from exisiting storage objects.
        // it would resset the pointer but there's no sensible location it could point to.

        g(x); /// @dev calls g handing over a reference to x
        h(x); /// @dev calls h and creates an independent, temporary copy in memory
    }

    function g(uint256[] storage) internal pure {}

    function h(uint256[] memory) public pure {}
}
