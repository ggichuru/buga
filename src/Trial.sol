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
