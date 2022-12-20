// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * The contract defines a public balances mapping with the key type addr, and value uint
    mapping an ethereum address to an unsigned integer
 */
contract MappingExample {
    mapping(address => uint256) public balances;

    function update(uint256 newBalance) public {
        balances[msg.sender] = newBalance;
    }
}

/// @title Mapping user
/// @notice get the current balance of an address
/// @dev as uint is a value type, the getter returns a value that matches the type
contract MappingUser {
    function f() public returns (uint256) {
        MappingExample m = new MappingExample();
        m.update(100);

        return m.balances(address(this));
    }
}

/// @title Mapping Allowances
/// @notice A simplified version of ERC20, with _allowances as a mapping type within another
/// @dev _allowacnces is uses to record the amount someone else is allowed to withdraw from your account
contract MappingAllowances {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(
            _allowances[from][msg.sender] >= amount,
            "ERC20: Insufficient Allowance"
        );
        _allowances[from][msg.sender] -= amount;

        _transfer(from, to, amount);

        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(from != address(0), "ERC20: transfer from address 0");
        require(to != address(0), "ERC20: transfer to address 0");
        require(_balances[from] >= amount, "ERC20: Not Enough funds");

        _balances[from] -= amount;

        _balances[to] += amount;

        emit Transfer(from, to, amount);
    }
}
