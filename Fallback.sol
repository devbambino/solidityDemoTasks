//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Fallback {

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
	
	function getUserDetail() public view returns(User memory _userInfo){
		return users[msg.sender];
	}

	/*modifiers---------------------------------------------------------------------------------------------
	Create a deposit function that allows anybody to send funds. Store the user and the amount in a mapping as the previous task.
	Add a withdraw function and create a modifier that only allows the owner of the contract to withdraw the funds.
	Add an addFund function and create a modifier that only allows users that have deposited using the deposit function, to increase their balance on the mapping.
	The function should accept the amount to be added and update the mapping to have the new balance
	Hint: if their balance is zero on the mapping, it should revert
	Hint: theMapping[userId] = theMapping[userId] + _amount;
	Create a modifier that accepts a value(uint256 _amount):Create a private constant variable called Fee
	In the modifier check if the value(_amount) it accepts is less than the Fee, revert with a custom error AmountToSmall()
	Add it to the addFund function
	Hint: addFund(uint256 _amount)*/
	
	uint fee = 0.05 ether;
	address payable public owner;
	mapping(address => uint256) public balances;
	modifier onlyOwner(){
		require(msg.sender == owner,"Not the owner!");
		_;
	}
	modifier onlyUsers(){
		require(balances[msg.sender] > 0,"You don't have a balance here!");
		_;
	}
	modifier amountTooSmall(uint _amount){
		require(_amount > fee,"Not enough money to pay for the fee!");
		_;
	}
	function withdrawFunds() public view onlyOwner{
		uint _amount = address(this).balance;
		//sent balance to owner
	}

	/*Events---------------------------------------------------------------------------------------------
	The contact should emit the following events when a user deposits and updates their profile information 
	respectively: FundsDeposited(address user, uin256 amount)
	ProfileUpdated(address user)
	*/
	event FundsDeposited(address user, uint amount);
	event ProfileUpdated(address user);

	function setUserDetails(string calldata _name, uint256 _age) public {
		users[msg.sender] = User(_name,_age);
		emit ProfileUpdated(msg.sender);
	}

	/*Payable---------------------------------------------------------------------------------------------
	We will allow users to send real ETH deposits to our smart contract by adding a payable function. 
	Function deposit will be re-written to accept no arguments but receive real ETH deposits and still save 
	and update user balance. deposit() accepts ETH through the payable modifier and updates user balance accordingly*/
	

	constructor(){
		owner = payable(msg.sender);
	}

	function deposit() public payable{ 
		balances[msg.sender] = msg.value; 
		emit FundsDeposited(msg.sender,msg.value);
	}
	function addFund() public payable onlyUsers amountTooSmall(msg.value){
		balances[msg.sender] += msg.value; 
		emit FundsDeposited(msg.sender,msg.value);
	}

	/*Fallback---------------------------------------------------------------------------------------------
	The task is to create the fallback function and make sure when a user transfers ETH to the 
	smart contract, the transaction does not get reverted.*/
	receive() external payable{}
	fallback() external payable{}
}