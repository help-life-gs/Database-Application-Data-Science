create or replace PROCEDURE insert_sexo(
    p_id_sexo   IN tb_sexo.id_sexo%TYPE,
    p_desc_sexo IN tb_sexo.desc_sexo%TYPE
)
IS
BEGIN
    INSERT INTO tb_sexo(id_sexo, desc_sexo)
    VALUES (p_id_sexo, p_desc_sexo);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de especialidade duplicado encontrado.');

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_sexo;

-----------------------------------------------------------------------------------------

create or replace PROCEDURE insert_estado (
    p_id_estado IN tb_estado.id_estado%TYPE,
    p_nm_estado IN tb_estado.nm_estado%TYPE
)
IS
BEGIN
    INSERT INTO tb_estado (id_estado, nm_estado)
    VALUES (p_id_estado, p_nm_estado);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de especialidade duplicado encontrado.');

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_estado;

---------------------------------------------------------------------------------------------

create or replace PROCEDURE insert_bairro (
    p_id_bairro IN tb_bairro.id_bairro%TYPE,
    p_nm_bairro IN tb_bairro.nm_bairro%TYPE,
    p_id_cidade IN tb_bairro.id_cidade%TYPE
)
IS
BEGIN
    INSERT INTO tb_bairro (id_bairro, nm_bairro, id_cidade)
    VALUES (p_id_bairro, p_nm_bairro, p_id_cidade);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de bairro duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_bairro;

---------------------------------------------------------------------------------------------

create or replace PROCEDURE insert_cidade (
    p_id_cidade IN tb_cidade.id_cidade%TYPE,
    p_nm_cidade IN tb_cidade.nm_cidade%TYPE,
    p_id_estado IN tb_cidade.id_estado%TYPE
)
IS
BEGIN
    INSERT INTO tb_cidade (id_cidade, nm_cidade, id_estado)
    VALUES (p_id_cidade, p_nm_cidade, p_id_estado);

    COMMIT; 
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de cidade duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_cidade;

---------------------------------------------------------------------------------------------

create or replace PROCEDURE insert_especialidade(
    p_id_especialidade   IN tb_especialidade.id_especialidade%TYPE,
    p_desc_especialidade IN tb_especialidade.desc_especialidade%TYPE
)
IS
BEGIN
    INSERT INTO tb_especialidade(id_especialidade, desc_especialidade)
    VALUES (p_id_especialidade, p_desc_especialidade);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de especialidade duplicado encontrado.');

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_especialidade;

---------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_medico (
    p_id_medico        IN tb_medico.id_medico%TYPE,
    p_crm_medico       IN tb_medico.crm_medico%TYPE,
    p_nm_medico        IN tb_medico.nm_medico%TYPE,
    p_id_especialidade IN tb_medico.id_especialidade%TYPE
)
IS
BEGIN
    INSERT INTO tb_medico (id_medico, crm_medico, nm_medico, id_especialidade)
    VALUES (p_id_medico, p_crm_medico, p_nm_medico, p_id_especialidade);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de médico duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_medico;

---------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_paciente (
    p_id_paciente      IN tb_paciente.id_paciente%TYPE,
    p_nm_paciente      IN tb_paciente.nm_paciente%TYPE,
    p_dt_nasc_paciente IN tb_paciente.dt_nasc_paciente%TYPE,
    p_tel_paciente     IN tb_paciente.tel_paciente%TYPE,
    p_id_sexo          IN tb_paciente.id_sexo%TYPE,
    p_id_end_paciente  IN tb_paciente.id_end_paciente%TYPE
)
IS
BEGIN
    INSERT INTO tb_paciente (
        id_paciente,
        nm_paciente,
        dt_nasc_paciente,
        tel_paciente,
        id_sexo,
        id_end_paciente
    )
    VALUES (
        p_id_paciente,
        p_nm_paciente,
        p_dt_nasc_paciente,
        p_tel_paciente,
        p_id_sexo,
        p_id_end_paciente
    );

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de paciente duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_paciente;

-------------------------------------------------------------------------------------------------




