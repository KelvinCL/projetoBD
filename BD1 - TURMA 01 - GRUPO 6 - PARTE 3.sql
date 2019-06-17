-- Integrantes: 
-- Kelvin Cirne de Lacerda Custódio
-- José Vinícius Lacerda
-- Thiago Cunha
-- José Roberto

-- 1ª questão: Qual o número de reservas feitas no ano de 2018.

SELECT COUNT(*) FROM RESERVA
WHERE dia_check_in LIKE '__/__/2018';

-- 2ª questão: Crie uma view que lista os funcionários que recebem menos que a média dos salários dos funcionários.

CREATE VIEW func_sal_menor_que_media AS
  SELECT *
  FROM FUNCIONARIO
  WHERE (salario < (SELECT AVG(SALARIO) FROM FUNCIONARIO));


-- 4ª questão: Liste todas as reservas com duração de um dia.

SELECT * FROM RESERVA 
   WHERE (EXTRACT(day FROM dia_check_out) = (EXTRACT(day FROM dia_check_in) + 1) AND 
         EXTRACT(month FROM dia_check_in)  = EXTRACT(month FROM dia_check_out) 
         AND EXTRACT(year FROM dia_check_in)  = EXTRACT(year FROM dia_check_out));


-- 8ª questão: Liste todos os clientes que reservaram quarto para o ano novo de 2019 (31/12/2018).

SELECT DISTINCT cpf_cliente FROM RESERVA
WHERE (EXTRACT(day FROM dia_check_out) = 31 AND 
         EXTRACT(month FROM dia_check_in)  = 12 
         AND EXTRACT(year FROM dia_check_in)  = 2018);

