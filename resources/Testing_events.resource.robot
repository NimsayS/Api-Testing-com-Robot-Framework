*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Keywords ***
Criar um evento novo
    ${nome_aleatorio}    Generate Random String    4    [LETTERS]
    Set Test Variable    ${nome}    ${nome_aleatorio}
    Log    ${nome}
     

Cadastrar um evento novo
  
  [Arguments]  ${nome}    ${status_code_desejado} 
  ${body}  Create Dictionary  
  ...      nome=${nome}  
  ...      data=2024-10-01       
  ...      local=local   
  ...      capacidade=20
  
  Log     ${body}
  Criar sessao api
  ${resposta}    POST On Session  
  ...  alias=Treinamento de Validações de QA
  ...  url=/eventos
  ...  json=${body}
  ...  expected_status=${status_code_desejado}
  
  Log   ${resposta.json()}

  Set Test Variable    ${ID_EMPRESA}    ${resposta.json()["id"]}
  Set Test Variable    ${RESPOSTA}  ${resposta.json()}


Criar sessao api
    ${headers}    Create Dictionary   accept=application/json  Content-Type=application/json
    Create Session    alias=Treinamento de Validações de QA    url=https://api-desafio-qa.onrender.com   headers=${headers}

Conferir se o evento foi cadastrado corretamente
    Log   ${RESPOSTA}
    Dictionary Should Contain Key   ${RESPOSTA}  id
    Status Should Be   201

Vou repetir o cadastro do evento
   Cadastrar um evento novo    nome=${nome}    status_code_desejado=400  

Vou verificar se a API nao permitiu o cadastro repetido
    Dictionary Should Contain Key    ${RESPOSTA}    errors
    ${errors}    Get From Dictionary    ${RESPOSTA}    errors
    ${primeiro_erro}    Get From List    ${errors}    0
    Dictionary Should Contain Item    ${primeiro_erro}    msg    Já existe um evento no local na mesma data

Consultar os dados do novo evento
   ${resposta_consulta}    GET On Session  alias=Treinamento de Validações de QA    url=/eventos/${ID_EMPRESA}   expected_status=200 
   Set Test Variable    ${RESPOSTA_DA_CONSULTA}  ${resposta_consulta.json()}

Conferir os dados retornados
    Log   ${RESPOSTA_DA_CONSULTA}
    Dictionary Should Contain Key    ${RESPOSTA_DA_CONSULTA}    capacidade
    Dictionary Should Contain Key    ${RESPOSTA_DA_CONSULTA}    nome
    Dictionary Should Contain Key    ${RESPOSTA_DA_CONSULTA}    local
    Dictionary Should Contain Item    ${RESPOSTA_DA_CONSULTA}    id    ${ID_EMPRESA}
    Dictionary Should Contain Key    ${RESPOSTA_DA_CONSULTA}    data

Deletar evento
    ${resposta_delecao}  DELETE On Session  alias=Treinamento de Validações de QA    url=/eventos/${ID_EMPRESA}   expected_status=200
    Set Test Variable    ${resposta_delecao_json}  ${resposta_delecao.json()}


Conferir se o evento foi deletado 
      Dictionary Should Contain Item    ${resposta_delecao_json}    message    Evento finalizado.
    


# Este put está dando 201 ao inves de 200 mas está de fato atualizando o dado
Atualizar Evento

  [Arguments]  ${nome}    ${status_code_desejado} 
  ${body}  Create Dictionary  
  ...      nome=${nome}  
  ...      data=2024-08-01     
  ...      local=local   
  ...      capacidade=20
  
  Log     ${body}
  Criar sessao api
  ${resposta}    PUT On Session  
  ...  alias=Treinamento de Validações de QA
  ...  url=/eventos/${ID_EMPRESA}
  ...  json=${body}
  ...  expected_status=${status_code_desejado}
  
  Log   ${resposta.json()}
  Set Test Variable    ${RESPOSTA_ATUALIZADA}  ${resposta.json()}

Conferir se o evento foi atualizado
    Log   ${RESPOSTA_ATUALIZADA}
    Dictionary Should Contain Item    ${RESPOSTA_ATUALIZADA}    id    ${ID_EMPRESA}
    Status Should Be   201

