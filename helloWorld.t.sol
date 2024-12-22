// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/helloWorld.sol";

contract helloworldTest is Test {
    HelloWorld private helloWorld;

    function setUp() public {
        helloWorld = new HelloWorld();
    }

    function testInitialGreeting() public view {
        string memory greeting = helloWorld.getGreeting();
        assertEq(greeting, "hello world"); // Compare the original greeting
    }

    function testSetGreeting() public {
      
      vm.warp(block.timestamp + 1 days);
      helloWorld.setGreeting("second Greeting");
      string memory greeting = helloWorld.getGreeting();
      assertEq(greeting,"second Greeting");
    }

    function testOnlyOwnerAccess()public{
      address nonOwner = address(0x123);
      vm.startPrank(nonOwner);
      vm.expectRevert("Not Owner");
      helloWorld.setGreeting("The setter is not owner");
      vm.stopPrank();

      
      vm.warp(block.timestamp + 1 days);
      helloWorld.setGreeting("hello , i m Owner");
      string memory greeting  = helloWorld.getGreeting();
      assertEq(greeting,"hello , i m Owner");

    }

    function testTimestamp ()public {
      vm.warp(block.timestamp + 1 days);
      helloWorld.setGreeting("FirstGreeting");
      vm.expectRevert("wait an entire day before changing again");
      helloWorld.setGreeting("second Greeting");

    }

    function testEmptyGreeting(string memory randomgreeting)public{
      vm.assume(bytes(randomgreeting).length > 0);// ensure the valid input
      vm.warp(block.timestamp + 1 days);
      helloWorld.setGreeting(randomgreeting);
      string memory greeting= helloWorld.getGreeting();
      assertEq(greeting ,randomgreeting);
    }
}
