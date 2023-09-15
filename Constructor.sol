/*Constructor---------------------------------------------------------------------------------------------
contract A should have a variable called owner and it should be immutable
Set the owner as the person deploying the contract in the constructor
contract A should accept a parameter in its constructor called uint _fee and should be assigned to a variable called FEE
contract B should inherit contract A and pass in the required constructor parameters that A requires
*/
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract A {
	address immutable public owner;
	uint public fee;
	constructor (uint _fee){
		owner = msg.sender;
		fee = _fee;
	}
    
}
contract B is A {
	constructor(uint _fee) A(_fee) {}
    function getFee() public view returns(uint){ 
		return fee;
	}
    function getOwner() public view returns(address){ 
		return owner;
	}
}