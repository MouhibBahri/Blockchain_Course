// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage {
    uint256 favoriteNumber; // default value is 0 like in java
    People person  = People({favoriteNumber: 2, name: "Patrick"});
    
    // dynamic array unless specify the size of the array: People[3]
    People[] public people;
    
    mapping(string=>uint256) public nameToFavoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }


    function store(uint256 _favoriteNumber) public  virtual {
        favoriteNumber=_favoriteNumber;
    }

    // view and pure functions have 0 cost of gas unless called inside a function
    // view functions do not modify state variables
    // pure functions do not read or modify the state variables,
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    // memory => temporarily
    // calldata => temporarily + const
    // storage => default/permanent
    // map, struct and array need memory/calldata keyword when passed as params
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        // People memory newPerson = People(_favoriteNumber, _name);
        // People memory newPerson = People({favoriteNumber: _favoriteNumber,name: _name});
        // people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
    
    function getAllPeople() public view returns(People[] memory){
        return people;
    }
} 

// 0xd9145CCE52D386f254917e481eB44e9943F39138