// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Mapping {
    // Mapping from address to uin
    mapping(address => uint256) public myMap;

    function get(address _addr) public view returns (uint256) {
        // Mapping always returns
        return myMap[_addr];
    }

    function set(address _addr, uint256 i) public {
        // Set the value at an address
        myMap[_addr] = i;
    }

    function remove(address _addr) public {
        // Rest to default value
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // mapping of address to another mapping
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr, uint256 i) public view returns (bool) {
        return nested[_addr][i];
    }

    function set(
        address _addr,
        uint256 i,
        bool _bool
    ) public {
        nested[_addr][i] = _bool;
    }

    function remove(address _addr, uint256 i) public {
        delete nested[_addr][i];
    }
}
