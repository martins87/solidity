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

contract Betting is mortal {
    
    // bet value defined by the contract owner
    // contract owner would be an oracle
    // the oracle is a third person trusted by the bettors
    // he/she would end the election
    uint public betValue;
    
    // only one bettor per candidate
    mapping(uint => address) public bettors;
    
    constructor(uint _betValue) public {
        betValue = _betValue;
    }
    
    // bet value must be the same as defined by contract owner
    // participants bet on the candidate's number
    // TODO: allow more than one bet on the same candidate
    function bet(uint candidate) public payable {
        require(msg.value == betValue);
        bettors[candidate] = msg.sender;
    }
    
    // can only be called by oracle/contract owner
    function endBet(uint winnerCandidate) public onlyowner {
        require(bettors[winnerCandidate] != 0x0);
        address winner = bettors[winnerCandidate];
        winner.transfer(address(this).balance);
    }
    
    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }
}
