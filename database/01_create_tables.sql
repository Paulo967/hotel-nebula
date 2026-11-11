CREATE TABLE [hospede] (
	[id_hospede] int IDENTITY(1,1) NOT NULL,
	[cpf] nvarchar(14),
	[passaporte] nvarchar(20),
	[nome_completo] nvarchar(100),
	[data_nascimento] date,
	[email] nvarchar(100),
	[telefone] nvarchar(20),
	[cep] nvarchar(10),
	[logradouro] nvarchar(150),
	[numero_endereco] nvarchar(10),
	[cidade] nvarchar(50),
	[estado] nvarchar(20),
	[pais] nvarchar(50),
	[data_cadastro] date,
	PRIMARY KEY ([id_hospede])
);
CREATE TABLE [quarto] (
	[id_quarto] int IDENTITY(1,1) NOT NULL,
	[numero] nvarchar(10),
	[andar] int,
	[tipo] nvarchar(50),
	[capacidade_maxima] int,
	[descricao] nvarchar(max),
	[valor_diaria] decimal(10,2),
	[status] nvarchar(20),
	PRIMARY KEY ([id_quarto])
);
CREATE TABLE [funcionario] (
	[id_funcionario] int IDENTITY(1,1) NOT NULL,
	[cpf] nvarchar(14) UNIQUE,
	[nome_completo] nvarchar(100),
	[data_nascimento] date,
	[email] nvarchar(100),
	[telefone] nvarchar(20),
	[cargo] nvarchar(50),
	[turno] nvarchar(20),
	[salario] decimal(10,2),
	[data_contratacao] date,
	[status_ativo] bit DEFAULT true,
	PRIMARY KEY ([id_funcionario])
);
CREATE TABLE [reserva] (
	[id_reserva] int IDENTITY(1,1) NOT NULL,
	[data_criacao] date,
	[data_entrada_prevista] date,
	[data_saida_prevista] date,
	[qtd_adultos] int,
	[qtd_criancas] int,
	[observacoes_cliente] nvarchar(max),
	[status] nvarchar(20),
	[id_hospede] int,
	[id_quarto] int,
	PRIMARY KEY ([id_reserva])
);
CREATE TABLE [hospedagem] (
	[id_hospedagem] int IDENTITY(1,1) NOT NULL,
	[data_hora_checkin] datetime,
	[data_hora_checkout] datetime,
	[valor_total_conta] decimal(10,2),
	[id_reserva] int UNIQUE,
	[id_funcionario] int,
	PRIMARY KEY ([id_hospedagem])
);
CREATE TABLE [hospede_hospedagem] (
	[id_ocupacao] int IDENTITY(1,1) NOT NULL,
	[id_hospede] int,
	[id_hospedagem] int,
	[is_titular] bit,
	PRIMARY KEY ([id_ocupacao])
);
CREATE TABLE [consumo_servico] (
	[id_consumo] int IDENTITY(1,1) NOT NULL,
	[descricao] nvarchar(100),
	[quantidade] int,
	[valor_unitario] decimal(10,2),
	[data_hora] datetime,
	[id_hospedagem] int,
	PRIMARY KEY ([id_consumo])
);
CREATE TABLE [pagamento] (
	[id_pagamento] int IDENTITY(1,1) NOT NULL,
	[data_pagamento] datetime,
	[valor_pago] decimal(10,2),
	[metodo_pagamento] nvarchar(50),
	[status_pagamento] nvarchar(20),
	[id_hospedagem] int,
	PRIMARY KEY ([id_pagamento])
);
CREATE TABLE [avaliacao] (
	[id_avaliacao] int IDENTITY(1,1) NOT NULL,
	[nota_limpeza] int,
	[nota_atendimento] int,
	[comentario] nvarchar(max),
	[data_avaliacao] date,
	[id_hospedagem] int UNIQUE,
	[id_hospede] int,
	PRIMARY KEY ([id_avaliacao])
);
ALTER TABLE [reserva] ADD CONSTRAINT [fk_reserva_hospede] FOREIGN KEY (id_hospede) REFERENCES hospede (id_hospede);
ALTER TABLE [reserva] ADD CONSTRAINT [fk_reserva_quarto] FOREIGN KEY (id_quarto) REFERENCES quarto (id_quarto);
ALTER TABLE [hospedagem] ADD CONSTRAINT [fk_hospedagem_reserva] FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva);
ALTER TABLE [hospedagem] ADD CONSTRAINT [fk_hospedagem_funcionario] FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario);
ALTER TABLE [hospede_hospedagem] ADD CONSTRAINT [fk_ocupacao_hospede] FOREIGN KEY (id_hospede) REFERENCES hospede (id_hospede);
ALTER TABLE [hospede_hospedagem] ADD CONSTRAINT [fk_ocupacao_hospedagem] FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem);
ALTER TABLE [consumo_servico] ADD CONSTRAINT [fk_consumo_hospedagem] FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem);
ALTER TABLE [pagamento] ADD CONSTRAINT [fk_pagamento_hospedagem] FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem);
ALTER TABLE [avaliacao] ADD CONSTRAINT [fk_avaliacao_hospedagem] FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem);
ALTER TABLE [avaliacao] ADD CONSTRAINT [fk_avaliacao_hospede] FOREIGN KEY (id_hospede) REFERENCES hospede (id_hospede);