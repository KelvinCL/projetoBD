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
  
  --- Q3 ---
  
  SELECT TIPO, NOME, VALOR
  FROM PRODUTO 	
  GROUP BY TIPO, NOME, VALOR
  ORDER BY VALOR desc;

-- 4ª questão: Liste todas as reservas com duração de um dia.

SELECT * FROM RESERVA 
   WHERE (EXTRACT(day FROM dia_check_out) = (EXTRACT(day FROM dia_check_in) + 1) AND 
         EXTRACT(month FROM dia_check_in)  = EXTRACT(month FROM dia_check_out) 
         AND EXTRACT(year FROM dia_check_in)  = EXTRACT(year FROM dia_check_out));

--- Q5 ---

--- Q6 ---
 
  SELECT CPF, SALARIO
  FROM FUNCIONARIO F FULL OUTER JOIN MANUTENCAO M ON (F.CPF = M.CPF_FUNCIONARIO) 
  GROUP BY CPF,SALARIO
  HAVING COUNT(*)>5
  ORDER BY SALARIO DESC;
  
--- Q7 ---

  SELECT C.CPF, C.NOME
  FROM (SELECT HS.CPF_CLIENTE
        FROM QUARTO Q, HOSPEDA HS
        WHERE HS.NUMERO_QUARTO = Q.NUMERO AND (REGEXP_LIKE (Q.TIPO, 'triplo$') OR REGEXP_LIKE (Q.TIPO, 'duplo casal$'))) H , CLIENTE C
  WHERE H.CPF_CLIENTE = C.CPF;
  
  
-- 8ª questão: Liste todos os clientes que reservaram quarto para o ano novo de 2019 (31/12/2018).

SELECT DISTINCT cpf_cliente FROM RESERVA
WHERE (EXTRACT(day FROM dia_check_out) = 31 AND 
         EXTRACT(month FROM dia_check_in)  = 12 
         AND EXTRACT(year FROM dia_check_in)  = 2018);

--- Q9 ---

  SELECT TIPO, NUMERO,VALOR_DIARIA
  FROM QUARTO
  GROUP BY TIPO, NUMERO, VALOR_DIARIA
  ORDER BY VALOR_DIARIA DESC

--- Q10 ---

--- Q11 ---     

--- Q12 ---

  CREATE VIEW DPT_MARIA AS 
        SELECT C.CPF, C.NOME
        FROM (SELECT CPF_CLIENTE, NOME
              FROM DEPENDENTE
              WHERE NOME LIKE '%Maria%') D, CLIENTE C
        WHERE C.CPF = D.CPF_CLIENTE  

--- Q13 ---

--- Q14 ---

  CREATE TRIGGER NOME_INVALIDO
      BEFORE INSERT ON PRODUTO
      FOR EACH ROW
   BEGIN
    IF (:NEW.NOME = :OLD.NOME) THEN
      raise_application_error(-20001, 'Já existe produto com este nome');
    END IF;
  END;

--- Q15 ---

--- Q16 ---
 
 CREATE OR REPLACE FUNCTION calculaConsumoByClienteNoPeriodo(client_cpf VARCHAR2(14), dt_inicial DATE, dt_final DATE)
    RETURN NUMBER
     IS valorConsumo  NUMBER;

  BEGIN

    RETURN(valorConsumo);

  END calculaConsumoByClienteNoPeriodo;


--- Q17 ---
 
 CREATE OR REPLACE FUNCTION calculaPagamentoFuncionariosByMes(dt_inicial DATE, dt_final DATE)
    RETURN NUMBER
      IS valorPagamento NUMBER;

  BEGIN

    RETURN(valorPagamento);

  END calculaPagamentoFuncionariosByMes;

