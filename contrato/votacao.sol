pragma solidity 0.4.25;

contract VotacaoContratacao {
    
    struct PropostaContratacao {
        string Proposta;
        address presidente;
        address resultado;
        
    }
    
    struct Votante {
        address conta;
        string identificacao;
        uint numeroDeVotos;
        bool existe;
        
    }
    
    modifier somentePresidente() {
        require (msg.sender==presidente, "Somente presidente pode realizar essa opção");
        _;
    }
    
    event Votou(address quemVotou, uint qualVoto);
    
    constructor () public {
        PropostaContratacao = "Contratação de Crédito em Banco";
        presidente = msg.sender;
    }
    
    function definirPropostaContratacao (string qualPropostaContratacao) public {
        PropostaContratacao = qualPropostaContratacao;
    }
    
    function definirVotante (address qualVotante) public somentePresidente {
        require (qualVotante !=address (0), "Endereço de agente invalido");
        Votante (qualVotante);
    }
    
    function Votar () public {
        numeroProposta[Votante] = true;
        require(numeroDeVotos <= 1, "Pode votar somente uma vez");
        if(Votante.votou)
            return (Votante.votou = true);
        require (Votante.votou = numeroDeVotos);
        numeroDeVotos.resultado;
        }
       
    
    function getresultado () {
        return numeroDeVotos;
        require (msg.value >= 0);
    }
    
}
    
