*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Keywords ***
   
Criar um heroi novo
    ${nome_aleatorio}    Generate Random String    4    [LETTERS]
    Set Test Variable    ${nome}    ${nome_aleatorio}
    Log    ${nome} 
    ${habilidade_aleatorio}    Generate Random String    14    [LETTERS]
    Set Test Variable    ${habilidade}    ${habilidade_aleatorio}
    Log    ${habilidade}
    ${problema_aleatorio}    Generate Random String    15    [LETTERS]
    Set Test Variable    ${problema}    ${problema_aleatorio}
    Log    ${problema}
     
Cadastrar um heroi novo
  
  [Arguments]  ${nome}  ${habilidade}   ${problema}  ${status_code_desejado} 
  ${body}  Create Dictionary  
  ...      id=1
  ...      nome=${nome}     
  ...      habilidade=${habilidade}
  ...      problema=${problema}
  
  Log     ${body}
  Criar sessao api
  ${resposta}    POST On Session  
  ...  alias=Treinamento de Validações de QA
  ...  url=/herois
  ...  json=${body}
  ...  expected_status=${status_code_desejado}
  
  Log   ${resposta.json()}
 
  
  Set Test Variable    ${RESPOSTA}  ${resposta.json()}
    ${newUser}    Get From Dictionary    ${RESPOSTA}    newUser
    # Verificar se o dicionário 'newUser' contém a chave 'id'
    Run Keyword If    'id' not in ${newUser}    Fail    A chave 'id' não está presente no dicionário 'newUser'
    # Obter o valor de 'id' de 'newUser'
    ${ID}    Get From Dictionary    ${newUser}    id
    Log    ${ID}
     Set Test Variable    ${ID_heroi}    ${ID}
Criar sessao api 
    ${headers}    Create Dictionary   accept=application/json  Content-Type=application/json
    Create Session    alias=Treinamento de Validações de QA    url=https://api-desafio-qa.onrender.com   headers=${headers}

Conferir se o heroi foi cadastrado corretamente

    Log   ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Héroi *${nome}* adicionado a lista de hérois.
    Status Should Be   201

Consultar os dados do novo heroi
   ${resposta_consulta_heroi}    GET On Session  alias=Treinamento de Validações de QA    url=/herois/${ID_HEROI}   expected_status=200 
   Set Test Variable    ${RESPOSTA_DA_CONSULTA}  ${resposta_consulta_heroi.json()}

Conferir os dados retornados
   
    Log   ${RESPOSTA_DA_CONSULTA}
    Dictionary Should Contain Item    ${RESPOSTA_DA_CONSULTA}    id    ${ID_heroi}
