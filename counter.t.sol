// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testOwner() public {
        address nonOwner = address(0x1);
        vm.prank(nonOwner);
        vm.expectRevert("Not Owner");
        counter.setNumber(6);
    }

    // test set number
    function testSetNumber() public {
        counter.setNumber(10);
        assertEq(counter.number(), 10);
    }

    function testFailIncrement()public {
        vm.expectRevert("Enter between 0 and 9");
        counter.setNumber(10);
    }
    function testIncremet() public {
        counter.setNumber(1);
        counter.increment();
        assertEq(counter.number(), 2);
    }

    function testIncrementFail()public {
        counter.setNumber(10);
        vm.expectRevert("Counter: number is at max limit"); 
        counter.increment();
    }
}
