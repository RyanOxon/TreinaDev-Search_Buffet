# Cade Buffet?

![Cade Buffet?](https://img.shields.io/badge/vers%C3%A3o-1.0-blue)
[![GitHub last commit](https://img.shields.io/github/last-commit/RyanOxon/TreinaDev-Search_Buffet)](https://github.com/RyanOxon/TreinaDev-Search_Buffet/commits/main/)
![GitHub language count](https://img.shields.io/github/languages/count/RyanOxon/TreinaDev-Search_Buffet)
[![Commit Acitivity](https://img.shields.io/github/commit-activity/m/RyanOxon/TreinaDev-Search_Buffet)](https://github.com/RyanOxon/TreinaDev-Search_Buffet/commits/main/)
[![Code Size](https://img.shields.io/github/languages/code-size/RyanOxon/TreinaDev-Search_Buffet)](mpp-backend)

O "Cade Buffet?" é uma plataforma que permite que empresas cadastrem seus buffets, ofereçam eventos e seus valores, e que clientes encontrem esses buffets para contratá-los.

<details>
  <summary>Índice</summary>
  <ol>
    <li><a href="#Introdução">Introdução</a></li>
    <li><a href="#Tecnologias">Tecnologias</a></li>
    <li><a href="#Instalação">Instalação</a></li>
    <li><a href="#Funcionalidades">Funcionalidades</a></li>
    <li><a href="#API">API</a></li>
    <li><a href="#Autor">Autor</a></li>
  </ol>
</details>

## Introdução

O "Cade Buffet?" foi criado para facilitar a interação entre empresas de buffet e clientes. As empresas podem cadastrar seus serviços e eventos, enquanto os clientes podem pesquisar e encontrar o buffet ideal para suas necessidades, além de visualizar preços e detalhes dos eventos oferecidos.

Este projeto foi desenvolvido como parte do programa de treinamento TreinaDev, da CampusCode, com o propósito de aprender programação fullstack. No projeto, foram utilizados Ruby e Rails, e todo ele foi desenvolvido com base na metodologia TDD (Test-Driven Development).

## Tecnologias

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-A10E3B?style=for-the-badge&amp;logo=rubyonrails&amp;logoColor=white)
![Javascript](https://img.shields.io/badge/JavaScript-323330?style=for-the-badge&logo=javascript&logoColor=F7DF1E)
![html](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![css](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![Bulma](https://img.shields.io/badge/bulma-00D0B1?style=for-the-badge&logo=bulma&logoColor=white)

### Gems utilizadas

- [Devise](https://github.com/heartcombo/devise) para autenticação
- [RSpec](https://rspec.info/) para testes
- [Capybara](https://teamcapybara.github.io/capybara/) para testes

## Instalação

No terminal, clone o projeto: 
```
$ git clone https://github.com/RyanOxon/TreinaDev-Search_Buffet.git
```
Em seguida execute o instalador de gems do rails: 
```
$ bundle install
```
Apos a configuraçao das gems pelo rails é necessario rodar, para garantir que alguns seletores existam a priori
```
$ rails db:setup
```
> Caso deseje que o banco de dados ja esteja populado com exemplos gerais de funcionalidade do codigo, é necessario ir no arquivo `/db/seeds.rb` e descomentar o bloco de codigo apartir da `linha 16`, após isso execute `rails db:setup`. ⚠️ **Atenção:** isso irá limpa o banco de dados atual 
> - as duas crendeciais geradas pelos exemplos são: 
>   - Empresa
>     - Login: empresa@empresa.com
>     - Senha: password
>   - Cliente
>     - Login: cliente@cliente.com:
>     - Senha: password

## Funcionalidades

Existem dois tipos de conta: **Dono de Buffet** e **Cliente**. Aqui estão as funcionalidades detalhadas para cada tipo de conta:

### Registro

- **Dono de Buffet**: 
  - Deve ir até o dropdown `Para empresas` e clicar em `Registrar-se`.
  - O dono de buffet deve registrar seu buffet antes de poder registrar eventos e seus valores.
  - No registro do buffet, deve indicar todos os meios de pagamento aceitos atualmente.

- **Cliente**: 
  - Pode se registrar através dos botões na barra de navegação.

### Dono de Buffet

1. **Registrar Eventos**:
   - Indicar se o evento é exclusivo para o endereço do buffet ou pode ser realizado em outros locais.
   - Registrar o valor do evento, especificando se é um preço para dias úteis ou para fins de semana e feriados.
   - Adicionar fotos aos detalhes do evento.

2. **Gerenciar Eventos**:
   - Desativar eventos que não são mais realizados.
   - Desativar o buffet se não desejar mais aceitar pedidos, fazendo com que não apareça nas listas respectivas.

### Visitante

- Pode ver a lista de buffets registrados.
- Pesquisar por buffets na barra de navegação.
- Ver eventos oferecidos pelo buffet selecionado.
- Para acessar funcionalidades adicionais, deve fazer login como cliente.

### Cliente Logado

1. **Pedidos de Evento**:
   - Pode abrir um pedido para a realização de um evento a partir da tela de detalhes daquele evento.
   - Informar a data pretendida, a quantidade de pessoas e adicionar um campo de texto para mais detalhes.
   - O dono do buffet pode avaliar o pedido e oferecer um orçamento adequado, informando o tipo do preço, o total de taxas ou descontos, e uma descrição do motivo delas. Esse orçamento terá uma data de validade.
   - Se o pedido ficar mais de 20 dias sem um orçamento ou a data do orçamento expirar, o pedido será cancelado automaticamente e deverá ser criado um novo.

2. **Chat de Pedidos**:
   - Existe um chat entre o cliente e o dono do buffet na tela de pedido para troca de informações e alinhamento.

3. **Gerenciamento de Pedidos**:
   - O cliente pode aceitar um orçamento, rejeitar e aguardar um novo, ou cancelar o pedido.
   - Pedidos confirmados indicam que o evento será realizado.

4. **Avaliação de Eventos**:
   - Após a data de realização de um evento confirmado, o cliente pode registrar uma avaliação sobre o buffet, indicando uma nota de 0 a 5 e um texto.
   - Nos detalhes da avaliação, o cliente pode anexar imagens do evento.
   - Uma média é calculada e exibida nos detalhes do buffet, juntamente com um campo contendo as 3 últimas avaliações.

## API

### Buffets

- `GET /api/v1/buffets`: Retorna uma lista de todos os buffets registrados com seus IDs, nomes, cidade, código do estado e métodos de pagamento aceitos atualmente. Você pode passar um parâmetro `search` para buscar buffets pelo nome, assim: `/api/v1/buffets/?search=<termo_de_busca>`.

<details>
  <summary>Exemplo de Resposta</summary>

```json
[
  {
    "id": 1,
    "brand_name": "Buffet Gourmet",
    "city": "São Paulo",
    "state_code": "SP",
    "description": "Um buffet de alta qualidade com diversas opções de eventos.",
    "payment_methods": [
      {
        "id": 1,
        "humanized_method_name": "Cartão de Crédito"
      },
      {
        "id": 2,
        "humanized_method_name": "Transferência Bancária"
      }
    ]
  },
  {
    "id": 2,
    "brand_name": "Buffet Festa Alegre",
    "city": "Rio de Janeiro",
    "state_code": "RJ",
    "description": "Especializado em festas infantis e eventos corporativos.",
    "payment_methods": [
      {
        "id": 1,
        "humanized_method_name": "Cartão de Crédito"
      },
      {
        "id": 3,
        "humanized_method_name": "Boleto"
      }
    ]
  }
]

```
</details>

### Detalhes do Buffet

- `GET /api/v1/buffets/:buffet_id`: Retorna todas as informações disponíveis sobre um buffet específico, incluindo seus métodos de pagamento aceitos. Retorna 404 caso não exista o buffet ou ele esteja desativado.

<details>
  <summary>Exemplo de Resposta</summary>

```json
{
  "id": 1,
  "brand_name": "Buffet Gourmet",
  "phone_number": "(11) 1234-5678",
  "email": "contato@buffetgourmet.com",
  "address": "Rua Exemplo, 123",
  "district": "Centro",
  "city": "São Paulo",
  "state_code": "SP",
  "zip_code": "01000-000",
  "description": "Um buffet de alta qualidade com diversas opções de eventos.",
  "average": 4.5,
  "payment_methods": [
    {
      "id": 1,
      "humanized_method_name": "Cartão de Crédito"
    },
    {
      "id": 2,
      "humanized_method_name": "Transferência Bancária"
    }
  ]
}

```
</details>

### Eventos do Buffet

- `GET /api/v1/buffets/:buffet_id/events`: Retorna uma lista detalhada de todos os eventos que um buffet específico está oferecendo. Retorna 404 caso o ID do buffet não encontre nenhum evento.

<details>
  <summary>Exemplo de Resposta</summary>

```json
[
  {
    "id": 1,
    "name": "Festa de Aniversário",
    "description": "Uma festa de aniversário completa com decoração temática.",
    "min_capacity": 20,
    "max_capacity": 100,
    "default_duration": 4,
    "menu": "Buffet completo com salgados, doces e bebidas.",
    "exclusive_address": true,
    "event_category": {
      "id": 1,
      "category": "Aniversário"
    },
    "features": [
      {
        "id": 1,
        "humanized_feature_name": "Decoração temática"
      },
      {
        "id": 2,
        "humanized_feature_name": "DJ"
      }
    ],
    "event_prices": [
      {
        "base_value": 2000,
        "extra_per_person": 50,
        "extra_per_hour": 200,
        "humanized_price_name": "Preço para dias úteis"
      },
      {
        "base_value": 2500,
        "extra_per_person": 60,
        "extra_per_hour": 250,
        "humanized_price_name": "Preço para fins de semana e feriados"
      }
    ]
  },
  {
    "id": 2,
    "name": "Casamento",
    "description": "Celebração de casamento com buffet completo.",
    "min_capacity": 50,
    "max_capacity": 300,
    "default_duration": 6,
    "menu": "Buffet completo com entrada, prato principal, sobremesa e bebidas.",
    "exclusive_address": false,
    "event_category": {
      "id": 2,
      "category": "Casamento"
    },
    "features": [
      {
        "id": 3,
        "humanized_feature_name": "Serviço de garçom"
      },
      {
        "id": 4,
        "humanized_feature_name": "Banda ao vivo"
      }
    ],
    "event_prices": [
      {
        "base_value": 5000,
        "extra_per_person": 100,
        "extra_per_hour": 500,
        "humanized_price_name": "Preço para dias úteis"
      },
      {
        "base_value": 6000,
        "extra_per_person": 120,
        "extra_per_hour": 600,
        "humanized_price_name": "Preço para fins de semana e feriados"
      }
    ]
  }
]

```
</details>

### Disponibilidade do Buffet

- `GET /api/v1/buffets/:buffet_id/events/:event_id/availability?date=<DATA>&num_people=<INT>`: Verifica se um buffet específico está disponível em uma data específica para realizar um evento e se pode suportar um certo número de pessoas. Ambos os parâmetros `date` e `num_people` são obrigatórios. Retorna 400 caso falte algum parâmetro, retorna 404 se não existir o buffet ou o evento, pode retornar 200 com `true` caso esteja disponível, ou pode retornar `false` com um dos seguintes erros: `date is not available` ou `number of people exceed event limit`.

<details>
  <summary>Exemplo de Resposta</summary>

1. Quando os parâmetros estão faltando:

    ```json
    {
      "error": "Missing required parameters"
    }
    ```

2. Quando o evento não é encontrado:

    ```json
    {
      "status": 404,
      "message": "Event not found"
    }
    ```

3. Quando a data não está disponível:

    ```json
    {
      "available": false,
      "reason": "date is not available"
    }
    ```

4. Quando a capacidade é excedida:

    ```json
    {
      "available": false,
      "reason": "number of people exceed event limit"
    }
    ```

5. Quando o evento está disponível:

    ```json
    {
      "available": true
    }
    ```
</details>

## Autor
### Rafael Salgado
<ul>
<li>Github: https://github.com/RyanOxon</li>
<li>LinkedIn:  https://www.linkedin.com/in/rafael-salgado-dev/</li>
</ul>