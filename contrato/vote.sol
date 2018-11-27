pragma solidity 0.4.25;


contract Vote {
 
    struct Votante {
        uint quantidade; 
        bool votado;  
        address permite; 
        uint voto;  
    }

    
    struct Proposta
    {
        bytes32 nome;   
        uint numVotos; 
    }

    address public presidente;

    mapping(address => Votante) public votantes;

    Proposta [] public propostas;

    
    function Vote (bytes32[] nomeProposta) {
        presidente = msg.sender;
        votantes[presidente].quantidade = 1;

        for (uint i = 0; i < nomeProposta.length; i++) {
            
            propostas.push(Proposta({
                nome: nomeProposta[i],
                numVotos: 0
            }));
        }
    }

    function direitoDeVoto (address votante) {
        if (msg.sender != presidente || votantes[votante].votado) {
            
            require;
        }
        votantes[votante].quantidade = 1;
    }

    
    function permite(address to) {
        
        Votante sender = votantes[msg.sender];
        if (sender.votado)
            require;

        while (
            votantes[to].permite != address(0) &&
            votantes[to].permite != msg.sender
        ) {
            to = votantes[to].permite;
        }

       if (to == msg.sender) {
            require;
        }

        
        sender.votado = true;
        sender.permite = to;
        votante permite = votantes[to];
        if (permite.votado) {
            propostas[permite.voto].numVotos += sender.quantidade;
        } else {
           permite.quantidade += sender.quantidade;
        }
    }

    
    function voto(uint proposta) {
        Votante sender = votantes[msg.sender];
        if (sender.votado)
            require;
        sender.votado = true;
        sender.voto = proposta;

   
        propostas[proposta].numVotos += sender.quantidade;
    }

   function resultado() constant
            returns (uint resultado)
    {
        uint propostaGanha = 0;
        for (uint p = 0; p < propostas.length; p++) {
            if (propostas[p].numVotos > propostaGanha) {
                propostaGanha = propostas[p].numVotos;
                resultado = p;
            }
        }
    }

    function propostaVenc() constant
            returns (bytes32 propostaVenc)
    {
        propostaVenc = propostas[resultado()].nome;
    }
}
