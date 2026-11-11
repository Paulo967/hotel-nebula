-- 1. Quais quartos estão disponíveis em determinado período?

SELECT 
    q.numero AS Quarto, 
    q.tipo AS Tipo, 
    q.valor_diaria AS Valor_Diaria
FROM Quarto q
WHERE q.id_quarto NOT IN (
    SELECT r.id_quarto
    FROM Reserva r
    WHERE r.status != 'Cancelada' 
      AND r.data_entrada_prevista < '2023-12-10' -- Data de saída desejada pelo cliente
      AND r.data_saida_prevista > '2023-12-01'   -- Data de entrada desejada pelo cliente
)
ORDER BY q.tipo, q.numero;

-- 2. Quais hóspedes mais realizaram reservas?

SELECT 
    h.nome_completo AS Hospede, 
    h.cpf AS CPF, 
    COUNT(r.id_reserva) AS Total_Reservas
FROM Hospede h
JOIN Reserva r ON h.id_hospede = r.id_hospede
GROUP BY h.id_hospede
ORDER BY Total_Reservas DESC
LIMIT 10; -- Mostra o Top 10

-- 3. Qual foi o faturamento por mês?

SELECT 
    DATE_FORMAT(data_pagamento, '%Y-%m') AS Mes_Ano, 
    SUM(valor_pago) AS Faturamento_Total
FROM Pagamento
WHERE status_pagamento = 'Concluído'
GROUP BY Mes_Ano
ORDER BY Mes_Ano DESC;

-- 4. Quais serviços extras são mais consumidos?

SELECT 
    descricao AS Item_Servico, 
    SUM(quantidade) AS Total_Vendido,
    SUM(quantidade * valor_unitario) AS Receita_Gerada
FROM Consumo_Servico
GROUP BY descricao
ORDER BY Total_Vendido DESC;

-- 5. Quais quartos receberam as melhores avaliações?

SELECT 
    q.numero AS Quarto, 
    q.tipo AS Tipo,
    ROUND(AVG((a.nota_limpeza + a.nota_atendimento) / 2.0), 2) AS Media_Geral_Avaliacao,
    COUNT(a.id_avaliacao) AS Total_De_Avaliacoes
FROM Avaliacao a
JOIN Hospedagem h ON a.id_hospedagem = h.id_hospedagem
JOIN Reserva r ON h.id_reserva = r.id_reserva
JOIN Quarto q ON r.id_quarto = q.id_quarto
GROUP BY q.id_quarto
ORDER BY Media_Geral_Avaliacao DESC;

-- 6. Quais reservas foram canceladas?

SELECT 
    r.id_reserva AS Num_Reserva, 
    h.nome_completo AS Hospede, 
    r.data_criacao AS Data_da_Reserva, 
    r.data_entrada_prevista AS Data_Checkin_Prevista
FROM Reserva r
JOIN Hospede h ON r.id_hospede = h.id_hospede
WHERE r.status = 'Cancelada'
ORDER BY r.data_criacao DESC;

-- 7. Quantas hospedagens cada profissional atendeu?

SELECT 
    f.nome_completo AS Funcionario, 
    f.cargo AS Cargo, 
    COUNT(h.id_hospedagem) AS Total_Atendimentos
FROM Funcionario f
LEFT JOIN Hospedagem h ON f.id_funcionario = h.id_funcionario
WHERE f.cargo IN ('Recepcionista', 'Gerente') -- Opcional: filtrar apenas quem faz check-in
GROUP BY f.id_funcionario
ORDER BY Total_Atendimentos DESC;