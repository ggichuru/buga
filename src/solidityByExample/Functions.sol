// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Function {
    // Functions can return multiple values
    function returnMany()
        public
        pure
        returns (
            uint256,
            bool,
            uint256
        )
    {
        return (1, true, 0);
    }

    /// @notice return values can be named
    function named()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        return (1, true, 2);
    }

    /// @notice Return values can be assigned to their name. The return statement can be ommmitted
    function assigned()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        x = 1;
        b = true;
        y = 2;
    }

    /// @notice use destructuring when calling another function that returns multiple values
    function destructuringAssignemts()
        public
        pure
        returns (
            uint256,
            bool,
            uint256,
            uint256,
            uint256
        )
    {
        (uint256 i, bool b, uint256 j) = returnMany();

        // Values can be left out
        (uint256 x, , uint256 y) = (3, 4, 5);

        return (i, b, j, x, y);
    }

    /// @notice cannot use map for either input or output

    /// @notice can use array for input and output
    function arrInputOutput(uint256[] memory _arr)
        public
        pure
        returns (uint256[] memory arr)
    {
        arr = _arr;
    }

    /// @notice call functon with key value inputs
    function someFnWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}

    function callFnWithKeyValue() external pure returns (uint256) {
        return
            someFnWithManyInputs({
                a: address(0),
                b: true,
                c: "c",
                x: 1,
                y: 2,
                z: 3
            });
    }
}
