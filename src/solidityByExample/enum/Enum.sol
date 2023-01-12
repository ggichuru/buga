// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Enum {
    // Enum Representing shipping status
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Cancelled
    }

    // The default value is the first element listed in the definition of the type (Pending)
    Status public status;

    // Returns uint
    // Pending - 0 | Shipped - 1 | Accepted - 2 | Rejected - 3 | Cancelled - 4
    function get() public view returns (Status) {
        return status;
    }

    // update status by passing uint into input
    function set(Status _status) public {
        status = _status;
    }

    // update to a specific enum
    function cancel() public {
        status = Status.Cancelled;
    }

    // delete resets status to default value
    function reset() public {
        delete status;
    }
}
