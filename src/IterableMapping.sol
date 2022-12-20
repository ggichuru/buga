// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// You cannot iterate over mappings. but you can implement a datastructure and iterate over it

/// @notice The code below implements an IterableMapping library that the User contract then adds data to, and the sum function iterates over to sum all values.

struct IndexValue {
    uint256 keyIndex;
    uint256 value;
}

struct KeyFlag {
    uint256 key;
    bool deleted;
}

struct itmap {
    mapping(uint256 => IndexValue) data;
    KeyFlag[] keys;
    uint256 size;
}

type Iterator is uint;


library IterableMapping {
    function insert(itmap storage self, uint key, uint value) internal returns (bool replaced) {
        uint keyIndex = self.data[key].keyIndex;

        self.data[key].value = value;

        if (keyIndex > 0) {
            return true;
        }
        else {
            keyIndex = self.keys.length;
            self.keys.push();
            self.data[key].keyIndex = keyIndex + 1;
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }

    function remove(itmap storage self, uint key) internal returns(bool success) {
        uint keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0)
            return false;

        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;

        self.size --;
    }

    function contains(itmap storage self, uint key) internal view returns (bool) {
        return self.data[key].keyIndex > 0;
    }

    function iterateStart(itmap storage self) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, 0);
    }

    function iterateValid(itmap storage self, Iterator iterator) internal view returns (bool) {
        return Iterator.unwrap(iterator) < self.keys.length;
    }

    function iterateNext(itmap storage self, Iterator iterator) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, Iterator.unwrap(iterator) + 1);
    }

    function iterateGet(itmap storage self, Iterator iterator) internal view returns (uint key, uint value) {
        uint keyIndex = Iterator.unwrap(iterator);
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }

    function iteratorSkipDeleted(itmap storage self, uint keyIndex) private view returns (Iterator) {
        while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
            keyIndex++;
        return Iterator.wrap(keyIndex);
    }
}

contract User {
    // Just a struct holding our data
    itmap data;

    // Apply library functions to the data type
    using IterableMapping for itmap;

    // Insert Something
    function insert(uint k, uint v) public returns(uint size) {
        // Call iterableMapping.insert
        data.insert(k, v);

        return data.size;
    }

    // Compute the sum of all stored data
    function sum() public view returns (uint s) {
        for (Iterator i = data.iterateStart(); data.iterateValid(i); i = data.iterateNext(i)) {
            (,uint value) = data.iterateGet(i);
            s += value;
        }
    }
}