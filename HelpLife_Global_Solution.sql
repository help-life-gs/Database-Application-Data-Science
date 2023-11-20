--utilizada para salvar erros na tabela LOGIN e tabela PACIENTE
CREATE TABLE tb_log (
    log_id          NUMBER PRIMARY KEY,
    user_name       VARCHAR2(255),
    occurrence_date DATE,
    error_code      NUMBER,
    error_message   VARCHAR2(4000)
);

CREATE SEQUENCE log_sequence

CREATE TABLE tb_bairro (
    id_bairro NUMBER NOT NULL,
    nm_bairro VARCHAR2(200) NOT NULL,
    id_cidade NUMBER NOT NULL
);

ALTER TABLE tb_bairro ADD CONSTRAINT tb_bairro_pk PRIMARY KEY ( id_bairro );

CREATE TABLE tb_chat (
    id_chat      NUMBER NOT NULL,
    desc_chat    VARCHAR2(1000),
    id_historico NUMBER NOT NULL
);

ALTER TABLE tb_chat ADD CONSTRAINT tb_chat_pk PRIMARY KEY ( id_chat );

CREATE TABLE tb_cidade (
    id_cidade NUMBER NOT NULL,
    nm_cidade VARCHAR2(200),
    id_estado NUMBER NOT NULL
);

ALTER TABLE tb_cidade ADD CONSTRAINT tb_cidade_pk PRIMARY KEY ( id_cidade );

CREATE TABLE tb_endereco_paciente (
    id_end_paciente          NUMBER NOT NULL,
    num_end_paciente         NUMBER(10),
    complemento_end_paciente VARCHAR2(200),
    logradouro_end_paciente  VARCHAR2(200),
    id_bairro              NUMBER NOT NULL
);

ALTER TABLE tb_endereco_paciente ADD CONSTRAINT tb_endereco_paciente_pk PRIMARY KEY ( id_end_paciente );

CREATE TABLE tb_especialidade (
    id_especialidade   NUMBER NOT NULL,
    desc_especialidade VARCHAR2(200)
);

ALTER TABLE tb_especialidade ADD CONSTRAINT tb_especialidade_pk PRIMARY KEY ( id_especialidade );

CREATE TABLE tb_estado (
    id_estado NUMBER NOT NULL,
    nm_estado VARCHAR2(100)
);

ALTER TABLE tb_estado ADD CONSTRAINT tb_estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE tb_historico (
    id_relatorio         NUMBER NOT NULL,
    temp_relatorio       VARCHAR2(10),
    oxigen_relatorio     VARCHAR2(10),
    batimentos_relatorio VARCHAR2(10),
    dt_relatorio         TIMESTAMP,
    id_paciente          NUMBER NOT NULL
);

ALTER TABLE tb_historico ADD CONSTRAINT tb_historico_pk PRIMARY KEY ( id_relatorio );

CREATE TABLE tb_login (
    id_login    NUMBER NOT NULL,
    email_login VARCHAR2(100),
    pass_login  VARCHAR2(100),
    id_paciente NUMBER,
    id_medico   NUMBER
);

ALTER TABLE tb_login ADD CONSTRAINT tb_login_pk PRIMARY KEY ( id_login );

CREATE TABLE tb_medico (
    id_medico        NUMBER NOT NULL,
    crm_medico       VARCHAR2(50),
    nm_medico        VARCHAR2(200),
    id_especialidade NUMBER NOT NULL
);

ALTER TABLE tb_medico ADD CONSTRAINT tb_medico_pk PRIMARY KEY ( id_medico );

CREATE TABLE tb_medico_paciente (
    id_medico_cliente NUMBER NOT NULL,
    id_paciente       NUMBER NOT NULL,
    id_medico         NUMBER NOT NULL
);

ALTER TABLE tb_medico_paciente ADD CONSTRAINT tb_medico_cliente_pk PRIMARY KEY ( id_medico_cliente );

CREATE TABLE tb_paciente (
    id_paciente      NUMBER NOT NULL,
    nm_paciente      VARCHAR2(200),
    cpf_paciente     VARCHAR2(15),
    dt_nasc_paciente DATE,
    tel_paciente     VARCHAR2(17),
    id_sexo          NUMBER NOT NULL,
    id_end_paciente  NUMBER NOT NULL
);

ALTER TABLE tb_paciente ADD CONSTRAINT tb_usuario_pk PRIMARY KEY ( id_paciente );

CREATE TABLE tb_sexo (
    id_sexo   NUMBER NOT NULL,
    desc_sexo VARCHAR2(200)
);

ALTER TABLE tb_sexo ADD CONSTRAINT tb_sexo_pk PRIMARY KEY ( id_sexo );

ALTER TABLE tb_bairro
    ADD CONSTRAINT tb_bairro_tb_cidade_fk FOREIGN KEY ( id_cidade )
        REFERENCES tb_cidade ( id_cidade );

ALTER TABLE tb_chat
    ADD CONSTRAINT tb_chat_tb_relatorio_fk FOREIGN KEY ( id_historico )
        REFERENCES tb_historico ( id_relatorio );

ALTER TABLE tb_cidade
    ADD CONSTRAINT tb_cidade_tb_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES tb_estado ( id_estado );
 
ALTER TABLE tb_endereco_paciente
    ADD CONSTRAINT tb_end_pacient_tb_bairro_fk FOREIGN KEY ( id_bairro )
        REFERENCES tb_bairro ( id_bairro );

ALTER TABLE tb_historico
    ADD CONSTRAINT tb_historico_tb_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES tb_paciente ( id_paciente );

ALTER TABLE tb_login
    ADD CONSTRAINT tb_login_tb_medico_fk FOREIGN KEY ( id_medico )
        REFERENCES tb_medico ( id_medico );

ALTER TABLE tb_login
    ADD CONSTRAINT tb_login_tb_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES tb_paciente ( id_paciente );

ALTER TABLE tb_medico_paciente
    ADD CONSTRAINT tb_med_pac_tb_med_fk FOREIGN KEY ( id_medico )
        REFERENCES tb_medico ( id_medico );

ALTER TABLE tb_medico_paciente
    ADD CONSTRAINT tb_med_pac_tb_pac_fk FOREIGN KEY ( id_paciente )
        REFERENCES tb_paciente ( id_paciente );

ALTER TABLE tb_medico
    ADD CONSTRAINT tb_medico_tb_especialidade_fk FOREIGN KEY ( id_especialidade )
        REFERENCES tb_especialidade ( id_especialidade );

ALTER TABLE tb_paciente
    ADD CONSTRAINT tb_pac_tb_end_client_fk FOREIGN KEY ( id_end_paciente )
        REFERENCES tb_endereco_paciente ( id_end_paciente);

ALTER TABLE tb_paciente
    ADD CONSTRAINT tb_usuario_tb_sexo_fk FOREIGN KEY ( id_sexo )
        REFERENCES tb_sexo ( id_sexo );

--------------------------------------------------------------------------------------------------------------------------------------------------

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

CREATE OR REPLACE PROCEDURE insert_endereco_paciente (
    p_id_end_paciente          IN tb_endereco_paciente.id_end_paciente%TYPE,
    p_num_end_paciente         IN tb_endereco_paciente.num_end_paciente%TYPE,
    p_complemento_end_paciente IN tb_endereco_paciente.complemento_end_paciente%TYPE,
    p_logradouro_end_paciente  IN tb_endereco_paciente.logradouro_end_paciente%TYPE,
    p_id_bairro                IN tb_endereco_paciente.id_bairro%TYPE
)
IS
BEGIN
    INSERT INTO tb_endereco_paciente (
        id_end_paciente,
        num_end_paciente,
        complemento_end_paciente,
        logradouro_end_paciente,
        id_bairro
    )
    VALUES (
        p_id_end_paciente,
        p_num_end_paciente,
        p_complemento_end_paciente,
        p_logradouro_end_paciente,
        p_id_bairro
    );

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de endereço duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_endereco_paciente;

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
    p_id_end_paciente  IN tb_paciente.id_end_paciente%TYPE,
    p_cpf_paciente     IN tb_paciente.cpf_paciente%TYPE
)
IS
    v_valid_cpf BOOLEAN;
BEGIN
    v_valid_cpf := validar_cpf(p_cpf_paciente);

    IF v_valid_cpf THEN
        INSERT INTO tb_paciente (
            id_paciente,
            nm_paciente,
            dt_nasc_paciente,
            tel_paciente,
            id_sexo,
            id_end_paciente,
            cpf_paciente
        )
        VALUES (
            p_id_paciente,
            p_nm_paciente,
            p_dt_nasc_paciente,
            p_tel_paciente,
            p_id_sexo,
            p_id_end_paciente,
            p_cpf_paciente
        );

        COMMIT;

    ELSE
        INSERT INTO tb_log (
            log_id,
            user_name,
            occurrence_date,
            error_code,
            error_message
        )
        VALUES (
            log_sequence.NEXTVAL,
            USER,
            SYSTIMESTAMP,
            -20003,
            'CPF inválido.'
        );
        COMMIT;
        RAISE_APPLICATION_ERROR(-20003, 'CPF inválido.');
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO tb_log (
            log_id,
            user_name,
            occurrence_date,
            error_code,
            error_message
        )
        VALUES (
            log_sequence.NEXTVAL,
            USER,
            SYSTIMESTAMP,
            -20002,
            'ID de paciente duplicado encontrado.'
        );
        COMMIT;
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de paciente duplicado encontrado.');
END insert_paciente;

-------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_login (
    p_id_login    IN tb_login.id_login%TYPE,
    p_email_login IN tb_login.email_login%TYPE,
    p_pass_login  IN tb_login.pass_login%TYPE,
    p_id_paciente IN tb_login.id_paciente%TYPE DEFAULT NULL,
    p_id_medico   IN tb_login.id_medico%TYPE DEFAULT NULL
)
IS
    v_valid_email BOOLEAN;
BEGIN
    v_valid_email := validar_email(p_email_login);

    IF v_valid_email THEN
        INSERT INTO tb_login (id_login, email_login, pass_login, id_paciente, id_medico)
        VALUES (p_id_login, p_email_login, p_pass_login, p_id_paciente, p_id_medico);
        COMMIT;
    ELSE
        INSERT INTO tb_log (log_id, user_name, occurrence_date, error_code, error_message)
        VALUES (log_sequence.NEXTVAL, USER, SYSTIMESTAMP, -20003, 'E-mail inválido.');
        COMMIT;
        RAISE_APPLICATION_ERROR(-20003, 'E-mail inválido.');
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO tb_log (log_id, user_name, occurrence_date, error_code, error_message)
        VALUES (log_sequence.NEXTVAL, USER, SYSTIMESTAMP, -20002, 'ID de login duplicado encontrado.');
        COMMIT;
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de login duplicado encontrado.');
END insert_login;

--------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_medico_paciente (
    p_id_medico_cliente IN tb_medico_paciente.id_medico_cliente%TYPE,
    p_id_paciente       IN tb_medico_paciente.id_paciente%TYPE,
    p_id_medico         IN tb_medico_paciente.id_medico%TYPE
)
IS
BEGIN
    INSERT INTO tb_medico_paciente (id_medico_cliente, id_paciente, id_medico)
    VALUES (p_id_medico_cliente, p_id_paciente, p_id_medico);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de medico_paciente duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_medico_paciente;

--------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_historico (
    p_id_relatorio         IN tb_historico.id_relatorio%TYPE,
    p_temp_relatorio       IN tb_historico.temp_relatorio%TYPE,
    p_oxigen_relatorio     IN tb_historico.oxigen_relatorio%TYPE,
    p_batimentos_relatorio IN tb_historico.batimentos_relatorio%TYPE,
    p_dt_relatorio         IN tb_historico.dt_relatorio%TYPE,
    p_id_paciente          IN tb_historico.id_paciente%TYPE
)
IS
BEGIN
        INSERT INTO tb_historico (
            id_relatorio,
            temp_relatorio,
            oxigen_relatorio,
            batimentos_relatorio,
            dt_relatorio,
            id_paciente
        )
        VALUES (
            p_id_relatorio,
            p_temp_relatorio,
            p_oxigen_relatorio,
            p_batimentos_relatorio,
            p_dt_relatorio,
            p_id_paciente
        );
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de historico duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_historico;

--------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insert_chat (
    p_id_chat      IN tb_chat.id_chat%TYPE,
    p_desc_chat    IN tb_chat.desc_chat%TYPE,
    p_id_historico IN tb_chat.id_historico%TYPE
)
IS
BEGIN
    INSERT INTO tb_chat (id_chat, desc_chat, id_historico)
    VALUES (p_id_chat, p_desc_chat, p_id_historico);

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de chat duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_chat;

-----------------------------------------------------------------------------------------------------------------
--utilizada na procedure de insert_paciente
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
--utilizando na procedure insert_login
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

-------------------------------------------------------------------------------------

--Utilizado para saber onde determinado cliente mora
--Busca por id_cliente

create or replace PROCEDURE BuscarPacientePorID(
    p_ID_PACIENTE INT
)
AS
    CURSOR PacienteCursor IS
        SELECT
            paciente.NM_PACIENTE AS Nome,
            paciente.TEL_PACIENTE AS Telefone,
            TEP.LOGRADOURO_END_PACIENTE AS Rua,
            TEP.NUM_END_PACIENTE AS Número,
            TEP.COMPLEMENTO_END_PACIENTE AS Complemento,
            B.NM_BAIRRO AS Bairro,
            C.NM_CIDADE AS Cidade,
            E.NM_ESTADO AS Estado
        FROM
            TB_PACIENTE paciente
        JOIN
            TB_ENDERECO_PACIENTE TEP ON paciente.ID_END_PACIENTE = TEP.ID_END_PACIENTE
        JOIN
            TB_BAIRRO B ON TEP.ID_BAIRRO = B.ID_BAIRRO
        JOIN
            TB_CIDADE C ON B.ID_CIDADE = C.ID_CIDADE
        JOIN
            TB_ESTADO E ON C.ID_ESTADO = E.ID_ESTADO
        WHERE
            paciente.ID_PACIENTE = p_ID_PACIENTE;

    PacienteRec PacienteCursor%ROWTYPE;

BEGIN
    OPEN PacienteCursor;
    FETCH PacienteCursor INTO PacienteRec;
    CLOSE PacienteCursor;

    DBMS_OUTPUT.PUT_LINE('Nome: ' || PacienteRec.Nome);
    DBMS_OUTPUT.PUT_LINE('Telefone: ' || PacienteRec.Telefone);
    DBMS_OUTPUT.PUT_LINE('Rua: ' || PacienteRec.Rua);
    DBMS_OUTPUT.PUT_LINE('Número: ' || PacienteRec.Número);
    DBMS_OUTPUT.PUT_LINE('Complemento: ' || PacienteRec.Complemento);
    DBMS_OUTPUT.PUT_LINE('Bairro: ' || PacienteRec.Bairro);
    DBMS_OUTPUT.PUT_LINE('Cidade: ' || PacienteRec.Cidade);
    DBMS_OUTPUT.PUT_LINE('Estado: ' || PacienteRec.Estado);
END;

--------------------------------------------------------------------------------------------

--Relatório para saber batimentos,oxigenação, temperatura corporal de um paciente, também o nome e a especialidade do médico que conversou com o paciente
--Busca por id_cliente

CREATE OR REPLACE PROCEDURE RelatorioMedicoPorPaciente(
    p_ID_PACIENTE INT
)
AS
    CURSOR RelatorioCursor IS
        SELECT
            paciente.NM_PACIENTE AS Nome,
            TH.BATIMENTOS_RELATORIO AS Batimentos,
            TH.OXIGEN_RELATORIO AS Oxigenacao,
            TH.TEMP_RELATORIO AS Temperatura,
            TH.DT_RELATORIO AS DataHoraMedicao,
            TM.CRM_MEDICO AS CRM,
            TM.NM_MEDICO AS Medico,
            TE.DESC_ESPECIALIDADE AS Especialidade
        FROM
            TB_PACIENTE paciente
        JOIN
            TB_HISTORICO TH ON paciente.ID_PACIENTE = TH.ID_PACIENTE
        JOIN
            TB_MEDICO_PACIENTE MP ON paciente.ID_PACIENTE = MP.ID_PACIENTE
        JOIN
            TB_MEDICO TM ON MP.ID_MEDICO = TM.ID_MEDICO
        JOIN
            TB_ESPECIALIDADE TE ON TM.ID_ESPECIALIDADE = TE.ID_ESPECIALIDADE
        WHERE
            paciente.ID_PACIENTE = p_ID_PACIENTE;

    RelatorioRec RelatorioCursor%ROWTYPE;

BEGIN
    OPEN RelatorioCursor;
    FETCH RelatorioCursor INTO RelatorioRec;
    CLOSE RelatorioCursor;

    DBMS_OUTPUT.PUT_LINE('Nome: ' || RelatorioRec.Nome);
    DBMS_OUTPUT.PUT_LINE('Batimentos: ' || RelatorioRec.Batimentos);
    DBMS_OUTPUT.PUT_LINE('Oxigenação: ' || RelatorioRec.Oxigenacao);
    DBMS_OUTPUT.PUT_LINE('Temperatura: ' || RelatorioRec.Temperatura);
    DBMS_OUTPUT.PUT_LINE('Data e Hora da Medição: ' || RelatorioRec.DataHoraMedicao);
    DBMS_OUTPUT.PUT_LINE('CRM: ' || RelatorioRec.CRM);
    DBMS_OUTPUT.PUT_LINE('Médico: ' || RelatorioRec.Medico);
    DBMS_OUTPUT.PUT_LINE('Especialidade: ' || RelatorioRec.Especialidade);
END;

