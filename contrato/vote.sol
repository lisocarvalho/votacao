pragma solidity 0.4.25;

contract Voto {

  mapping(address => uint) private votes;

  mapping(uint => uint) private totals;

  address VotanteA;
  address VotanteB;
  address VotanteC;

  function SecretBallot(address _votanteA, address _votanteB, address _votanteC){
    VotanteA = _votanteA;
    VotanteB = _votanteB;
    VotanteC = _votanteC;
  }

  
  function vote(uint _option) public {
    
    require(msg.sender == VotanteA || msg.sender == VotanteB || msg.sender == VotanteC);
    
    require(votes[msg.sender] == 0);
    
    require(_option == 1 || _option == 2);

    
    votes[msg.sender] = _option;

    
    totals[_option] = totals[_option] + 1;
  }

  
  function getTotalVotes(uint _option) constant public returns (uint total) {
    return totals[_option];
  }

}
