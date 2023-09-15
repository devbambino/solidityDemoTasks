/*Inheritance---------------------------------------------------------------------------------------------
A simple use case for inheritance is to launch an ERC20 token using the OpenZepellin ERC20 implementation.
Try to launch your custom ERC20 on any test network!
*/
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract SuperDuperToken is ERC20 {
    address public owner;

    modifier onlyOwner(){
        require(owner ==  msg.sender,"You don't have permission for this!");
        _;
    }

    constructor() ERC20("Super Duper Token", "SUPDtk") {
        owner = msg.sender;
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function burn(address _to, uint256 _amount) public onlyOwner{
        _burn(_to, _amount);
    }

    function decimals() public pure override returns (uint8) {
        return 4;
    }    
}