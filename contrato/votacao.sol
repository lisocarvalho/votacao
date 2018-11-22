pragma  solidity 0.4.25;


contract VotacaoAssembleia {

    struct Proposta {
        string texto;
        address proponente;
        uint quotaDeVotos;
        uint quotaMinimaParaAprovacao;
        bool existe;
    }

    struct Votante {
        address conta;
        string identificationID;
        uint quotaDeVotos;
        bool votou;
        bool existe;
    }

    modifier somenteSecretario() {
        if (precisaSecretario) {
            require(secretario == msg.sender, "Só o secretário pode realizar essa operação");
        }
        _;
    }

    modifier somentePresidente() {
        require(presidente == msg.sender, "Somente o presidente pode realizar essa operação");
        _;
    }

    
    function designarSecretario(address secretarioDesignado) public somentePresidente {
        secretario = secretarioDesignado;
    }

   
    function definirFimVotacao(uint qualDataFimVotacao) public somentePresidente {
        require(qualDataFimVotacao > now, "A data informada deve ser maior que a atual");
        dataFimVotacao = qualDataFimVotacao;
    }

      function definirInicioVotacao(uint qualDataInicioVotacao) public somentePresidente {
        require(qualDataInicioVotacao > now, "A data informada deve ser maior que a atual");
        dataInicioVotacao = qualDataInicioVotacao;
    }

  
    function incluiVotante(address enderecoVotante, uint quotaDeVotos, string qualIDVotante) public somenteSecretario {
        require(quotaDeVotos <= 99, "Quota nao pode ser superior a 99%");
        require(enderecoVotante != address(0), "O votante deve ter um endereco valido");
        Votante memory novoVotante = Votante(enderecoVotante, qualIDVotante, quotaDeVotos, false, true);
        votantes[enderecoVotante] = novoVotante;
        numeroVotantes.push(novoVotante);
    }

   
    function incluiProposta(string qualTextoDaProposta, address qualProponente, uint qualQuotaMinimaParaAprovacao) public somenteSecretario {
        Proposta memory novaProposta = Proposta(qualTextoDaProposta, qualProponente, 0, qualQuotaMinimaParaAprovacao, true);
        propostas.push(novaProposta);
    }
    

   
    function pesquisarVotante(address indiceVotante) public view returns (address, uint, string) {
        Votante memory votanteTemporario = votantes[indiceVotante];
        if (votanteTemporario.existe == true) {
            return (votanteTemporario.conta, votanteTemporario.quotaDeVotos, votanteTemporario.identificationID);
        } else {
            return (0,0);
        }
    }

   
    function pesquisarVotantePorIndice(uint indiceVotante) public view returns (address, uint) {
        require(indiceVotante <= numeroVotantes.length, "Indice informado é maior que o numero de votantes");
        Votante memory votanteTemporario = numeroVotantes[indiceVotante];
        if (votanteTemporario.existe == true) {
            return (votanteTemporario.conta, votanteTemporario.quotaDeVotos);
        } else {
            return (0,0);
        }
    }

   
    function pesquisarProposta(uint numeroProposta) public view returns (uint, string, address, uint, uint)  {
        Proposta memory propostaTemporario = propostas[numeroProposta];
        if (propostaTemporario.existe) {
            return (numeroProposta, propostaTemporario.texto, propostaTemporario.proponente, propostaTemporario.quotaDeVotos, propostaTemporario.quotaMinimaParaAprovacao);
        } else {
            return (0, "", 0, 0, 0);
        }
    }

   function totalDePropostas() public view returns (uint) {
        return propostas.length;
    }

    
    function totalDeVotantes() public view returns (uint) {
        return numeroVotantes.length;
    }

   
    function qualMotivoDaConvocatoria() public view returns (string) {
        return motivoConvocatoria;
    }

   
    function propostaAprovada(uint numeroProposta) public view returns (bool)  {
        Proposta memory propostaTemporario = propostas[numeroProposta];
        if (propostaTemporario.existe) {
            return propostaTemporario.quotaDeVotos>=propostaTemporario.quotaMinimaParaAprovacao;
        } else {
            return false;
        }
    }


    function quandoEncerraVotacao() public view returns (uint) {
        return dataFimVotacao;
    }

    function detalhesAssembleia() public view returns(address, address, string, uint, uint, uint, uint) {
        uint tPropostas = totalDePropostas();
        uint tVotantes = totalDeVotantes();
        return (presidente, secretario, motivoConvocatoria, dataInicioVotacao, dataFimVotacao, tPropostas, tVotantes);
    }

   
    function votar(uint numeroProposta, bool favoravelAProposta) public returns (bool) {
        require(dataFimVotacao>=now, "Votacao encerrada");
        require(dataInicioVotacao<=now, "Votação ainda não foi aberta");
        Proposta storage propostaTemporario = propostas[numeroProposta];
        if (propostaTemporario.existe) {
            Votante storage votanteTemporario = votantes[msg.sender];
            if (votanteTemporario.existe == true) {
                if (votanteTemporario.votou == false) {
                    if (favoravelAProposta == true) {
                        propostaTemporario.quotaDeVotos = propostaTemporario.quotaDeVotos + votanteTemporario.quotaDeVotos;
                    }
                    emit Votou(msg.sender, numeroProposta, favoravelAProposta);
                    votanteTemporario.votou = true;
                    return true;
                } 
            } 
        } 
        return false;
    }
}
