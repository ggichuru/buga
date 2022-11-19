// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TestCall {
    string public message;
    uint256 public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    // Function to be called by call
    function foo(string memory _message, uint256 _x)
        external
        payable
        returns (bool, uint256)
    {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

contract Call {
    bytes public data;

    function callFoo(address _testCallAddr) external payable {
        (bool success, bytes memory _data) = _testCallAddr.call{value: 1000}(
            abi.encodeWithSignature("foo(string,uint256)", "calling foo", 123)
        );

        require(success, "Call failed");
        data = _data;
    }

    // calling a function that doesnt exist will invoke the fallback
    // Without fallback ,the tx would fail
    function callDoesntExist(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("callDoesnt()"));

        require(success, "call failed");
    }
}
