pragma solidity ^0.4.24;

contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyowner() {
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

contract Bet is mortal {
    
    uint public betValue;
    
    mapping(uint => address) public bettors;
    
    constructor(uint _betValue) public {
        betValue = _betValue;
    }
    
    function bet(uint candidate) public payable {
        require(msg.value == betValue);
        bettors[candidate] = msg.sender;
    }
    
    function endBet(uint winnerCandidate) public onlyowner {
        address winner = bettors[winnerCandidate];
        winner.transfer(address(this).balance);
    }
    
    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }
}
