//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Primitives {

	/*default primitives--------------------------------------------------------------------------------------------
	Signed integers Unsigned integers Boolean Addresses Enums Bytes*/
	uint balance;
	int defaultInt;
	bytes1 a = 0xa1;
	bool public variableB = false;
	address public owner = 0xcE2C63f43420E38B8D40CC876bf8E7644bb73005;
	enum Status {
		inactive,
		active
	}
	Status public status;
}