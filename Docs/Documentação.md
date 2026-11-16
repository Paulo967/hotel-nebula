## 📖 Documentação do Sistema (Hotel Nebula)

### 1. Descrição das Entidades e Relacionamentos

O sistema foi modelado com base nas seguintes entidades principais e suas interações:

*   **Hóspede:** Armazena os dados pessoais e de contacto dos clientes (CPF, nome, e-mail, telefone, endereço).
    *   *Relacionamentos:* Um hóspede pode fazer várias **Reservas** (1:N), fazer várias **Avaliações** (1:N) e participar em várias **Hospedagens** através da tabela associativa (N:N).
*   **Quarto:** Regista as características físicas e comerciais dos quartos (número, tipo, capacidade, valor da diária, status atual).
    *   *Relacionamentos:* Um quarto pode estar associado a várias **Reservas** ao longo do tempo (1:N).
*   **Funcionário:** Gere os dados da equipa do hotel, incluindo cargo, turno e salário.
    *   *Relacionamentos:* Um funcionário atende/regista várias **Hospedagens** (1:N).
*   **Reserva:** Faz a ponte temporal entre o Hóspede e o Quarto, registando as datas de previsão de entrada e saída, além da quantidade de pessoas e o status (Confirmada, Cancelada, etc.).
    *   *Relacionamentos:* Pertence a um **Hóspede** e a um **Quarto** (N:1). Transforma-se numa **Hospedagem** (1:1 ou 1:N dependendo da regra de negócio de check-in).
*   **Hospedagem:** Representa o check-in efetivo no hotel. Regista a data/hora exata de entrada e saída e consolida o valor total da conta.
    *   *Relacionamentos:* Deriva de uma **Reserva** (1:1), é registada por um **Funcionário** (N:1) e agrega vários **Consumos**, **Pagamentos** e **Avaliações** (1:N).
*   **Hospede_Hospedagem (Tabela Associativa):** Resolve o relacionamento de muitos-para-muitos entre Hóspedes e Hospedagens.
    *   *Regra de Negócio:* Permite registar todos os ocupantes de um quarto durante uma estadia, indicando quem é o hóspede titular (pagante).
*   **Consumo_Servico:** Regista todas as despesas extras realizadas durante uma hospedagem (frigobar, lavandaria, massagem, etc.).
    *   *Relacionamentos:* Pertence a uma **Hospedagem** específica (N:1).
*   **Pagamento:** Guarda o histórico de transações financeiras (cartão, dinheiro, pix) para liquidar a conta da hospedagem.
    *   *Relacionamentos:* Pertence a uma **Hospedagem** (N:1).
*   **Avaliação:** Armazena o feedback de qualidade do cliente após a estadia (notas de limpeza, atendimento e comentários).
    *   *Relacionamentos:* Feita por um **Hóspede** sobre uma **Hospedagem** (N:1).

---

### 2. Estrutura Física e Restrições do Banco de Dados 

O banco de dados relacional foi implementado no MySQL (`hotel_nebula`), seguindo as melhores práticas de integridade referencial:

*   **Chaves Primárias (PK):** Todas as tabelas possuem uma chave primária sintética autoincremental (`id_hospede`, `id_quarto`, etc.) do tipo `INT`. Isso garante performance nas junções (`JOINs`) e evita problemas de lentidão na indexação caso chaves naturais (como CPF) fossem usadas.
*   **Chaves Estrangeiras (FK):** O sistema utiliza `FOREIGN KEY` rigorosamente para garantir a integridade dos dados. Não é possível, por exemplo, inserir um consumo para uma hospedagem inexistente, nem eliminar um quarto que possua histórico de reservas sem tratar a dependência.
*   **Tipos de Dados Otimizados:** 
    *   `VARCHAR` para textos curtos e identificadores (como CPF e E-mail).
    *   `DECIMAL(10,2)` para valores monetários (valor da diária, salário, pagamentos), garantindo precisão nos cálculos financeiros.
    *   `DATE` e `DATETIME` aplicados conforme a necessidade lógica (ex: `DATE` para nascimento, mas `DATETIME` para check-in, que exige precisão de hora).
    *   `ENUM` em colunas de `status` (ex: status do quarto ou da reserva) para bloquear a inserção de dados inválidos no sistema e uniformizar as regras de negócio.