// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract EtherHandler{
  uint recievedEther;
  string lastFunctionUsed;
  address forwardAddress;
  address Owner;

  constructor(){
    Owner = msg.sender;
  }
  modifier onlyOwner(){
    require(msg.sender == Owner,"Only Owner can call this function");
    _;
  }

  function LastFunctionUsed()public view returns(string memory){
    return lastFunctionUsed;
    }

  receive() external payable{
    recievedEther += msg.value;
    lastFunctionUsed = "recieve";
  }

  fallback()external payable{
    recievedEther += msg.value;
    lastFunctionUsed ="fallback";
  }

  function getBalace()public view returns(uint){
    return address(this).balance;
  }

  function withdraw(uint amount)public onlyOwner {
    require(amount <= address(this).balance,"Insufficient balance");
    payable(msg.sender).transfer(amount);
    
    
  }
    
  
}