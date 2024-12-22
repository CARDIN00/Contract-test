// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld{
  string public greeting;
  address private owner;
  uint public lastUpdate;

  constructor(){
    greeting = "hello world";
    owner = msg.sender;
    lastUpdate = block.timestamp;
  }

  function getGreeting() view public returns(string memory){
    return greeting;
  }
  

  function setGreeting(string memory _newGreeting) public{
    require(msg.sender == owner,"Not Owner");
    require(bytes(_newGreeting).length>0,"can not be empty");
    require(block.timestamp >= lastUpdate + 1 days,"wait an entire day before changing again");
    greeting = _newGreeting;
    lastUpdate = block.timestamp;

  }


}