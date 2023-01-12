//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

contract Array {
    /// @notice Several Ways to initialize an array
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    // Fixed size array: all elements initialize to 0
    uint256[10] public fixedSizeArr;

    /// @notice get array element at index
    function get(uint256 i) public view returns (uint256) {
        return arr2[i];
    }

    /// @notice Solidity can return a whole array, but should be avoided for arrays that can grow indefintely in length
    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    /// @notice Actions perfomable to an array
    function arrayMethods(uint256 i) public {
        // append to an array, increasing length by 1
        arr.push(i);

        // get the length of an array
        arr.length;

        // Remove the last element decreasing the array legth by 1
        arr.pop();
    }

    function _remove(uint256 index) internal {
        // reset the value at index to its default value
        delete arr[index];
    }

    /// @notice only a fixed size array can be created in memory
    function example() public pure {
        uint256[] memory a = new uint256[](5);
        assert(a.length == 5);
    }
}

// Remove an array element by shifting elements from right to left
contract ArrayRemoveByShifting {
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bound");

        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2); // [1, 2, 4, 5]

        assert(arr[2] == 4);
        assert(arr.length == 4);

        arr = [1];
        remove(0); // []

        assert(arr.length == 0);
    }
}
