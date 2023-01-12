// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionModifier {
    address owner;
    uint256 x = 10;
    bool locked;

    constructor() {
        // Set the transaction sender as the owner of the contract
        owner = msg.sender;
    }

    /// @notice Modifier to chek tha the caller is the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "owner: NOT OWNER");
        _; // tells solidity to execute the rest of the code
    }

    /// @notice modifier with inputs. verifies address passed isnt zero address
    modifier validAddress(address _addr) {
        require(_addr != address(0), "address: ADDRESS ZERO");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    /// @dev Modifiers can be called before and /or after a function.

    /// @notice Prevents a function from being called while still executing
    modifier noReentrancy() {
        require(!locked, "reentry: NO REENTRACY");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
