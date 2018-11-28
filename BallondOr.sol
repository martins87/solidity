pragma solidity ^0.4.24;

contract BallondOr {

  struct Candidate {
    uint id;
    string name;
    uint votes;
  }

  uint public totalCandidates;

  mapping (address => bool) public hasAddressVoted;
  mapping (uint => Candidate) public candidates;

  event Voted(uint indexed _candidateId);

  constructor() public {
    addCandidate("Lionel Messi");
    addCandidate("Cristiano Ronaldo");
    addCandidate("Neymar Jr");
    addCandidate("Kylian Mbappé");
    addCandidate("Luka Modric");
    addCandidate("Mohammed Salah");
  }

  function addCandidate(string _name) private {
    totalCandidates++;
    candidates[totalCandidates] = Candidate(totalCandidates, _name, 0);
  }

  function vote(uint _candidateId) public {
    require(hasAddressVoted[msg.sender] == false, "Endereço já votou");
    require(_candidateId >= 1 && _candidateId <= 6, "Candidato inválido");

    candidates[_candidateId].votes++;
    hasAddressVoted[msg.sender] = true;

    emit Voted(_candidateId);
  }
}
