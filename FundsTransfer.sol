pragma solidity ^0.4.24;

/* example of an Access Control contract */
contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyowner(){
        if (msg.sender == owner) {
            _;
        }
    }
}

contract mortal is owned {
    function kill() public onlyowner {
        selfdestruct(owner);
    } 
}

contract FundsTransfer is mortal {

    function sendETHToContract() public payable returns (bool success) {
        return true;
    }
    
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function getMyBalance() public view returns (uint) {
        return msg.sender.balance;
    }
    
    function sendETHTo(address _to, uint _amount) public onlyowner payable returns (bool success){
        require(address(this).balance >= _amount);
        _to.transfer(_amount);
        return true;
    }
    
}
