// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "../src/EtherHandler.sol";

contract etherHandlerTest is Test{
  EtherHandler etherhandler;

  function setUp() public{
    etherhandler = new EtherHandler();
  }

  function testRecieve()public{
    (bool success,)=address (etherhandler).call{value:1 ether}("");
    require(success);

    uint contractBalance = etherhandler.getBalace();
    assertEq(contractBalance, 1 ether,"contract should have 1 ether");
    assertEq(etherhandler.LastFunctionUsed(),"recieve","recieve function should be called");
  }

  function testFallback()public{
    (bool success,) = address(etherhandler).call{value:1 ether}("0x1234");
    require(success);

    assertEq(etherhandler.getBalace(), 1 ether,"contract should have 1 ether");
    assertEq(etherhandler.LastFunctionUsed(), "fallback","fallback function should be called");
  }

}