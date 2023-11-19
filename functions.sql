create or replace FUNCTION validar_cpf (p_cpf IN VARCHAR2)
  RETURN BOOLEAN
IS
  v_cpf VARCHAR2(11);
BEGIN
  v_cpf := REGEXP_REPLACE(p_cpf, '[^0-9]', '');

  IF LENGTH(v_cpf) = 11 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RETURN FALSE;
END;

----------------------------------------------------------------------

create or replace FUNCTION validar_email (p_email IN VARCHAR2)
  RETURN BOOLEAN
IS
  v_regex VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
  IF REGEXP_LIKE(p_email, v_regex) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RETURN FALSE;
END;

-----------------------------------------------------------------------