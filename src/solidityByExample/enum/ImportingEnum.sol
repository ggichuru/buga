// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./DeclaringEnum.sol";

contract EnumImport {
    Status public status;

    function accept() public {
        status = Status.Accepted;
    }
}
