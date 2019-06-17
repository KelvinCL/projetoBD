-- Integrantes: 
-- Kelvin Cirne de Lacerda Custódio
-- José Vinícius Lacerda
-- Thiago Cunha
-- José Roberto

-- 1ª questão

SELECT COUNT(*) FROM RESERVA
WHERE dia_check_in LIKE '__/__/2018';

-- 2ª questão

CREATE VIEW func_sal_menor_que_media AS
  SELECT *
  FROM FUNCIONARIO
  WHERE (salario < (SELECT AVG(SALARIO) FROM FUNCIONARIO));


-- 4ª questão

SELECT * FROM RESERVA 
   WHERE (EXTRACT(day FROM dia_check_out) = (EXTRACT(day FROM dia_check_in) + 1) AND 
         EXTRACT(month FROM dia_check_in)  = EXTRACT(month FROM dia_check_out) 
         AND EXTRACT(year FROM dia_check_in)  = EXTRACT(year FROM dia_check_out));
