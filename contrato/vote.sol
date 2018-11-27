pragma solidity 0.4.25;


contract VotacaoContratacao {
 
    struct Votante {
        bool votou;  
        address idVotante; 
        bool existe;
    }

    
    struct Proposta
    {
        string nome;   
        uint numVotos; 
    }

    address public presidente;

    mapping(address => Votante) public votantes;

    Proposta public propostaDestaVotacao;
    uint public totalVotantes;

    constructor () public {
        propostaDestaVotacao = Proposta ("Contratação de Crédito", 0);
        presidente=msg.sender;
    }
    
    
    function direitoDeVoto (address enderecoVotante) public {
        require (msg.sender == presidente);        
        Votante memory votante = Votante(false, enderecoVotante, true);
        votantes[enderecoVotante] = votante;
        totalVotantes = totalVotantes+1;
    }


    function votar(uint intencaoDoVoto) public {
        Votante memory quemEstaVotando = votantes[msg.sender];
        require(quemEstaVotando.existe);
        require(quemEstaVotando.votou==false);
        if (intencaoDoVoto>0) {
            propostaDestaVotacao.numVotos = propostaDestaVotacao.numVotos+1;
        }
        quemEstaVotando.votou = true;
    }

    function resultado() public view returns (bool)
    {
        uint quantidadeMinimaDeVotos = (totalVotantes/2);
        if (propostaDestaVotacao.numVotos>quantidadeMinimaDeVotos) 
        {
            return true;
        } else {
            return false;
        }
    }

    
}
