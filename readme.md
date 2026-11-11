# Hotel Nebula - Sistema de Gestao Hoteleira

Este é um projeto prático que desenvolvi para estruturar, modelar e manipular o banco de dados de uma rede hoteleira em expansão. O meu foco foi construir toda a base de dados do zero, pensando em como o sistema funcionaria no mundo real antes de ser integrado a uma aplicação ou API no futuro.

## Meu Objetivo

Meu objetivo principal com este projeto foi percorrer todas as etapas fundamentais de criação de um banco de dados relacional:
- Compreensão do problema e regras de negócio.
- Modelagem dos dados (Conceitual e Lógico).
- Implementação física do banco de dados.
- Extração e organização de dados para relatórios gerenciais.

## Como estruturei o projeto

Dividi o desenvolvimento em três fases principais para manter tudo organizado:

### Parte 1: Modelagem (Origem do Sistema)
Nesta etapa inicial, analisei as necessidades do hotel e identifiquei as entidades principais (Hóspedes, Quartos, Reservas, Hospedagens, Pagamentos, Funcionários, Consumos e Avaliações). A partir daí, defini os relacionamentos entre elas e construí o Diagrama Entidade-Relacionamento (ER).

### Parte 2: Implementação Física (Montagem do Núcleo)
Com o modelo visual pronto, fui para a codificação. Criei o banco de dados relacional usando SQL (DDL), estruturando as tabelas com seus devidos tipos de dados, chaves primárias (PK) e chaves estrangeiras (FK). Também criei um script de inserção com uma massa de dados inicial e realista para poder testar o sistema na prática.

### Parte 3: Consultas e Relatórios (Radar de Comando)
Para finalizar, desenvolvi várias consultas SQL (DQL) focadas na tomada de decisão e na gestão do hotel. Criei scripts para extrair métricas como:
- Quais quartos estão disponíveis em um determinado período.
- O ranking de hóspedes que mais realizaram reservas.
- O faturamento financeiro mês a mês.
- Os serviços extras mais consumidos e rentáveis.
- A média das avaliações dos quartos e o volume de atendimentos de cada funcionário.

## Tecnologias que utilizei

- DBDesigner (para a construção da modelagem ER)
- MySQL (como Sistema de Gerenciamento de Banco de Dados)
- Linguagem SQL

## Organização dos Arquivos

- /database/01_create_tables.sql : Script de criação do banco de dados e de todas as tabelas.
- /database/02_insert_data.sql : Script de inserção para popular o banco com os dados de teste.
- /database/03_queries.sql : Script contendo as consultas e relatórios gerenciais feitas.
- /docs/modelo_er.png : A imagem do Diagrama Entidade-Relacionamento.

## Como rodar o meu projeto

1. Faça o clone deste repositório na sua máquina:
   git clone https://github.com/Paulo967/hotel-nebula.git

2. Abra o seu gerenciador de banco de dados (recomendo MySQL Workbench).

3. Execute os arquivos SQL exatamente nessa ordem para respeitar a hierarquia das chaves:
   - Primeiro, rode o `database/01_create_tables.sql` para gerar toda a estrutura.
   - Depois, rode o `database/02_insert_data.sql` para preencher as tabelas.
   - Por fim, abra o `database/03_queries.sql` para testar os relatórios.