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
