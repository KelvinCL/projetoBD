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
  ORDER BY VALOR DESC;

-- 4ª questão: Liste todas as reservas com duração de um dia.

SELECT * FROM RESERVA 
   WHERE (EXTRACT(day FROM dia_check_out) = (EXTRACT(day FROM dia_check_in) + 1) AND 
         EXTRACT(month FROM dia_check_in)  = EXTRACT(month FROM dia_check_out) 
         AND EXTRACT(year FROM dia_check_in)  = EXTRACT(year FROM dia_check_out));

--- Q5 ---

SELECT HC.CPF, VP.CONSUMO_PRODUTO
FROM (SELECT V.NUMERO_QUARTO, SUM(V.QUANTIDADE * P.VALOR) AS CONSUMO_PRODUTO
      FROM VENDA V, PRODUTO P
      GROUP BY V.NUMERO_QUARTO) VP, 
      (SELECT C.CPF, H.NUMERO_QUARTO
       FROM HOSPEDA H, CLIENTE C
       WHERE C.CPF = H.CPF_CLIENTE) HC
WHERE VP.NUMERO_QUARTO = HC.NUMERO_QUARTO
ORDER BY CONSUMO_PRODUTO DESC;

--- Q6 ---
 
  SELECT CPF, SALARIO
  FROM FUNCIONARIO F FULL OUTER JOIN MANUTENCAO M ON (F.CPF = M.CPF_FUNCIONARIO) 
  GROUP BY CPF,SALARIO
  HAVING COUNT(*)>5
  ORDER BY SALARIO DESC;
  
--- Q7 ---
SELECT CPF
  FROM (SELECT C.CPF AS CLIENTE
        FROM CLIENTE C, TELEFONE T
        WHERE C.CPF = T.CPF_CLIENTE AND T.TELEFONE LIKE '(83)33%') CL INNER JOIN DEPENDENTE D ON (CL.CLIENTE= D.CPF_CLIENTE)
  GROUP BY CPF 
  HAVING COUNT(CPF)>2

  
-- 8ª questão: Liste todos os clientes que reservaram quarto para o ano novo de 2019 (31/12/2018).

SELECT DISTINCT cpf_cliente FROM RESERVA
WHERE (EXTRACT(day FROM dia_check_out) = 31 AND 
         EXTRACT(month FROM dia_check_in)  = 12 
         AND EXTRACT(year FROM dia_check_in)  = 2018);

--- Q9 ---

  SELECT C.CPF, C.NOME
  FROM (SELECT HS.CPF_CLIENTE
        FROM QUARTO Q, HOSPEDA HS
        WHERE HS.NUMERO_QUARTO = Q.NUMERO AND (REGEXP_LIKE (Q.TIPO, 'triplo$') OR REGEXP_LIKE (Q.TIPO, 'duplo casal$'))) H , CLIENTE C
  WHERE H.CPF_CLIENTE = C.CPF;                                                                                             

--- Q10 ---
 SELECT TIPO, NUMERO,VALOR_DIARIA
 FROM QUARTO
 GROUP BY TIPO, NUMERO, VALOR_DIARIA
 ORDER BY VALOR_DIARIA DESC;                                                                                               

--- Q11 --- 
CREATE VIEW COMPRA_P_FRIGO_REST AS
                  SELECT HC.CPF
                  FROM (SELECT C.CPF, H.NUMERO_QUARTO
                        FROM CLIENTE C, HOSPEDA H
                        WHERE C.CPF = H.CPF_CLIENTE) HC,
                        (SELECT V.NUMERO_QUARTO
                        FROM VENDA V, PRODUTO P
                        WHERE REGEXP_LIKE (P.TIPO, '(R|r)estaurante$') OR REGEXP_LIKE (P.TIPO, '(F|f)rigoba$')) PV
                  WHERE PV.NUMERO_QUARTO = HC.NUMERO_QUARTO                                                                                               

--- Q12 ---

  CREATE VIEW DPT_MARIA AS 
        SELECT C.CPF, C.NOME
        FROM (SELECT CPF_CLIENTE, NOME
              FROM DEPENDENTE
              WHERE NOME LIKE '%Maria%') D, CLIENTE C
        WHERE C.CPF = D.CPF_CLIENTE;  

--- Q13 ---

ALTER TABLE QUARTO
ADD CONSTRAINT VALIDATE_COLUMN_NUMERO
CHECK(REGEXP_LIKE(NUMERO,'^[A-Z]-[0-9][0-9][0-9]','c')); 

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

CREATE TRIGGER MANUTENCAO_INVALIDA
    BEFORE INSERT ON MANUTENCAO
    FOR EACH ROW
 BEGIN
  IF (:NEW.NOME = :OLD.NOME) THEN
    raise_application_error(-20001, 'Já foi realizada manutenção por esse funcionario nesse quarto');
  END IF;
END;
                                                                                               
--- Q16 ---
 
 create or replace FUNCTION calculaConsumo(cpf VARCHAR2, inicio DATE, fim DATE)
  RETURN NUMBER
   IS co NUMBER;

BEGIN
  
  SELECT VP.co
  FROM (SELECT V.NUMERO_QUARTO, SUM(V.QUANTIDADE * P.VALOR) AS co
      FROM VENDA V, PRODUTO P
      GROUP BY V.NUMERO_QUARTO
      HAVING DATA BETWEEN inicio AND fim) VP, 
      HOSPEDA H
  WHERE VP.NUMERO_QUARTO = H.NUMERO_QUARTO AND H.CPF_CLIENTE=cpf
  
  RETURN(co);

END calculaConsumo;


--- Q17 ---
 
 CREATE OR REPLACE FUNCTION calculaPagamentoFuncionariosByMes(dt_inicial DATE, dt_final DATE)
    RETURN NUMBER
      IS valorPagamento NUMBER;

  BEGIN

    RETURN(valorPagamento);

  END calculaPagamentoFuncionariosByMes;

