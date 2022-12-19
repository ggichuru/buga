// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

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
