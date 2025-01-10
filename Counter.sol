// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    uint public constant Maxlimit = 10;
    address public Owner;

    constructor() {
        Owner = msg.sender;
    }

    // MODIFIERS
    modifier onlyOwner(){
        require(msg.sender == Owner,"Not Owner");
        _;
    }
    event NumerSet(address Owner, uint Oldnumber, uint newNumber);

    // FUNCITONS
    function setNumber(uint256 newNumber) public onlyOwner() {
        require(newNumber <= 9, "Enter between 0 and 9");
        emit NumerSet(Owner, number, newNumber);

        number = newNumber;

        
    }

    function increment() public {
        require(number <= Maxlimit, "Counter: number is at max limit");
        number++;
    }
}
