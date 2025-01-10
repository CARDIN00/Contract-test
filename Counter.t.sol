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

    function testFailOwner() public {
        address owner = address(0x2);
        assertEq(owner,address(this),"Owner is not set");

        address nonOwner = address(0x1);
        vm.prank(nonOwner);
        vm.expectRevert("Not Owner");
        counter.setNumber(6);
    }

    // test set number
    function testSetNumber() public {
        counter.setNumber(9);
        assertEq(counter.number(), 9);
    }

    function testFailIncrement()public {
        vm.expectRevert("Enter between 0 and 9");
        counter.setNumber(9);
    }

    function testIncremet() public {
        counter.setNumber(1);
        counter.increment();
        assertEq(counter.number(), 2);
    }
}
