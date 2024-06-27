*** Settings ***
Resource    ../resources/Testing_events.resource.robot

*** Variables ***

*** Test Cases ***


Cenario 01: Criar um novo evento com sucesso
    [Tags]    Eventos
    Criar um evento novo
    Cadastrar um evento novo    nome=${nome}     status_code_desejado=201
    Conferir se o evento foi cadastrado corretamente
       
Cenario 02: Criar uma nova empresa já existente
    [Tags]    Eventos
    Criar um evento novo
    Cadastrar um evento novo  nome=${nome}    status_code_desejado=201   
    Vou repetir o cadastro do evento
    Vou verificar se a API nao permitiu o cadastro repetido

Cenario 03: Consultar os dados de um novo evento
    [Tags]    Eventos
    Criar um evento novo
    Cadastrar um evento novo  nome=${nome}    status_code_desejado=201   
    Consultar os dados do novo evento
    Conferir os dados retornados
    

Cenario 04: Deletar evento
    [Tags]    Eventos
    Criar um evento novo
    Cadastrar um evento novo  nome=${nome}    status_code_desejado=201  
    Deletar evento
    Conferir se o evento foi deletado 

Cenario 05: Atualizar evento
    Criar um evento novo
    Cadastrar um evento novo  nome=${nome}    status_code_desejado=201  
    Atualizar Evento    nome=${nome}    status_code_desejado=201 
    Conferir se o evento foi atualizado

# Cenario com problemas encontrados
#Cenario 06: Adicionar participante em evento
   # Criar um evento novo
   # Cadastrar um evento novo  nome=${nome}    status_code_desejado=201 
    # Adicionar partipante no evento  nome=${nome}    status_code_desejado=201 
   # Conferir se o participante foi inserido 
    