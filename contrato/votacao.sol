pragma solidity 0.4.25;

contract VotacaoContratacao {
    
    string public PropostaContratacao;
    address votante;
    address presidente;
    address resultado;
    
    
    modifier somentePresidente() {
        require (msg.sender==presidente, "Somente presidente pode realizar essa opção");
        _;
    }
    
    constructor () public {
        PropostaContratacao = "Contratação de Crédito em Banco";
        presidente = msg.sender;
    }
    
    function definirPropostaContratacao (string qualPropostaContratacao) public {
        PropostaContratacao = qualPropostaContratacao;
    }
    
    function definirVotante (address qualVotante) public somentePresidente {
        require (qualVotante !=address (0), "Endereço de agente invalido");
        votante = qualVotante;
    }
    
    function Votar (numeroProposta) public {
        numeroProposta[votante] = true;
        if(votante.votou)
        throw;
        votante.votou = true;
        votante.votou = numeroProposta;
        numeroProposta.resultado;
        }
       
    
    function getResultado () returns(numeroProposta){
        return resultado;
    }
    }
    
}
