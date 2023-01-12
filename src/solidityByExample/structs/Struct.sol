// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of Todo structs
    Todo[] public todos;

    function create(string calldata _text) public {
        ///@notice there are 3 ways to initialize a struct
        // 1. Calling it like a function
        todos.push(Todo(_text, false));

        // 2. key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // 3. Initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text; // completed remains to be the default which is false
        todos.push(todo);
    }

    function updateText(uint256 _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
