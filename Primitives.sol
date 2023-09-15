//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";
contract Primitives {

	/*structs---------------------------------------------------------------------------------------------
	The contract should now contain the following: 
	setUserDetails(string calldata name, uint256 age) this function accepts 2 arguments that represent the details 
	of the user calling the smart contract and it saves them into a defined struct, 
	getUserDetail() this function retrieves and returns the details saved for the user calling the contract.*/

	struct User{
		string name;
		uint256 age;
	}
	mapping(address => User) public users; 

	function setUserDetails(string calldata _name, uint256 _age) public {
		users[msg.sender] = User(_name,_age);
	}
	
	function getUserDetail() public view returns(User memory _userInfo){
		return users[msg.sender];
	}
}