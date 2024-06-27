*** Settings ***
Resource    ../resources/Testing_heros.resource.robot

*** Test Cases ***

Cenario 01: Criar um Heroi novo
    [Tags]    Herois
    Criar um heroi novo
    Cadastrar um heroi novo   ${nome}  ${habilidade}   ${problema}  status_code_desejado=201
    Conferir se o heroi foi cadastrado corretamente
       
Cenario 02: Consultar os dados de um novo evento
    [Tags]    Herois
    Criar um heroi novo
    Cadastrar um heroi novo   ${nome}  ${habilidade}   ${problema}  status_code_desejado=201   
    Consultar os dados do novo heroi
    Conferir os dados retornados