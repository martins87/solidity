pragma solidity ^0.4.24;

contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyowner{
        if(msg.sender == owner) {
            _;
        }
    }
}

contract mortal is owned {
    function kill() public onlyowner {
        selfdestruct(owner);
    }
}

contract PresidentialElection is mortal {
    
    constructor() public {
        candidates.push(Candidate(12, "PDT", "Ciro Gomes", 0));
        candidates.push(Candidate(13, "PT", "Lula", 0));
        candidates.push(Candidate(15, "MDB", "Henrique Meirelles", 0));
        candidates.push(Candidate(16, "PSTU", "Vera Lúcia", 0));
        candidates.push(Candidate(17, "PSL", "Jair Bolsonaro", 0));
        candidates.push(Candidate(18, "REDE", "Marina Silva", 0));
        candidates.push(Candidate(19, "Podemos", "Álvaro Dias", 0));
        candidates.push(Candidate(27, "DC", "José Maria Eymael", 0));
        candidates.push(Candidate(30, "NOVO", "João Amoedo", 0));
        candidates.push(Candidate(45, "PSDB", "Geraldo Alckmin", 0));
        candidates.push(Candidate(50, "PSOL", "Guilherme Boulos", 0));
        candidates.push(Candidate(51, "Patriota", "Cabo Daciolo", 0));
        candidates.push(Candidate(54, "PPL", "João Goulart Filho", 0));
        candidateIndex[12] = 0;
        candidateIndex[13] = 1;
        candidateIndex[15] = 2;
        candidateIndex[16] = 3;
        candidateIndex[17] = 4;
        candidateIndex[18] = 5;
        candidateIndex[19] = 6;
        candidateIndex[27] = 7;
        candidateIndex[30] = 8;
        candidateIndex[45] = 9;
        candidateIndex[50] = 10;
        candidateIndex[51] = 11;
        candidateIndex[54] = 12;
    }
    
    struct Candidate {
        uint number;
        string politicalParty;
        string name;
        uint votes;
    }
    
    struct Voter {
        address voterAddress;
        string voterID;
        uint candidateNumber;
    }
    
    mapping (string => bool) voterIDAlreadyVoted;
    mapping (address => bool) addressAlreadyVoted;
    
    mapping (uint => uint) candidateIndex;
    
    Candidate[] public candidates;
    Voter[] voters;
    
    bool ended;
    
    function vote(string voterID, uint candidateNumber) public returns (bool) {
        require(ended == false, "Election already ended");
        require(voterIDAlreadyVoted[voterID] == false, "Voter already voted");
        require(addressAlreadyVoted[msg.sender] == false, "Voter already voted");
        
        voters.push(Voter(msg.sender, voterID, candidateNumber));
        candidates[candidateIndex[candidateNumber]].votes++;
        
        voterIDAlreadyVoted[voterID] = true;
        addressAlreadyVoted[msg.sender] = true;
        
        return true;
    }
    
    function getWinner() public view returns (string, uint) {
        uint w;
        uint votes;
        for(uint i = 0; i < candidates.length; i++) {
            if(candidates[i].votes > votes) {
                votes = candidates[i].votes;
                w = i;
            }
        }
        for(i = 0; i < candidates.length; i++) {
            if(i == w) {
                continue;
            }
            if(candidates[i].votes == votes) {
                return ("We have a draw", votes);
            }
        }
        if(votes > 0) {
            return (candidates[w].name, votes);
        }
    }
    
    function endElection() public onlyowner returns (bool) {
        ended = true;
        return true;
    }
    
}
