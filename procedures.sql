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

call insert_bairro(17,'Vila Madalena',12);
call insert_bairro(18,'Barra da Tijuca',13);
call insert_bairro(19,'Lourdes',14);
call insert_bairro(20,'Boa Vista',15);
call insert_bairro(21,'Jurerê Internacional',16);

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

call insert_cidade(12,'São Paulo',7);
call insert_cidade(13,'Rio de Janeiro',8);
call insert_cidade(14,'Belo Horizonte',9);
call insert_cidade(15,'Curitiba',10);
call insert_cidade(16,'Florianópolis',11);

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


call INSERT_ENDERECO_PACIENTE(22,234,'casa',
                              'Rua Gomes Pereira',17);

call INSERT_ENDERECO_PACIENTE(23,4356,'casa',
                              'Rua João Batista',18);

call INSERT_ENDERECO_PACIENTE(24,5467,'casa',
                              'Rua Gustavo Alemão',19);

call INSERT_ENDERECO_PACIENTE(25,321,'ap 44',
                              'Rua Oitavo Sexto',20);

call INSERT_ENDERECO_PACIENTE(26,950,'ap 101',
                              'Rua Helio Batista',21);

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

call insert_medico(27,'12345/SP','Augusto Silva',7);
call insert_medico(28,'54326/RJ','Matheus Helio',8);
call insert_medico(29,'43216/BH','Vitorio Silva',5);
call insert_medico(30,'87654/PR','Victor Silva',4);
call insert_medico(31,'53246/MG','Julio Estevam',6);

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
        RAISE_APPLICATION_ERROR(-20003, 'CPF inválido.');
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de paciente duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_paciente;

call insert_paciente(32,'Matheus Sato',TO_DATE('2003-03-15', 'YYYY-MM-DD'),'(11)944398054',3,22,'12321345677');
call insert_paciente(33,'Vitorio Graton',TO_DATE('2002-07-20', 'YYYY-MM-DD'),'(21)932134567',3,23,'54465765799');
call insert_paciente(34,'Victor Hugo',TO_DATE('2002-04-14', 'YYYY-MM-DD'),'(31)944325479',3,24,'87645343277');
call insert_paciente(35,'Matheus Montemurro',TO_DATE('2000-10-10', 'YYYY-MM-DD'),'(41)954357687',3,25,'87654632466');
call insert_paciente(36,'Julio Machado',TO_DATE('1997-08-03', 'YYYY-MM-DD'),'(48)966754357',3,26,'98654345');

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
        RAISE_APPLICATION_ERROR(-20003, 'E-mail inválido.');
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'ID de login duplicado encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END insert_login;

call insert_login(37,'matheussato@gmail.com','123password!',32,NULL);
call insert_login(38,'vitoriograton@gmail.com','324password!',33,NULL);
call insert_login(39,'victorhugo@gmail.com','546password!',34,NULL);
call insert_login(40,'matheusmontemurro@gmail.com','657password!',35,NULL);
call insert_login(41,'juliomachado@gmail.com','875password!',36,NULL);

call insert_login(42,'augustosilva@gmail.com','643password@',NULL,27);
call insert_login(43,'matheushelio@gmail.com','567password@',NULL,28);
call insert_login(44,'vitoriosilva@gmail.com','043password@',NULL,29);
call insert_login(45,'victorsilva@gmail.com','454password@',NULL,30);
call insert_login(46,'julioestevam@gmail.com','521password@',NULL,31);

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

call insert_medico_paciente(47,32,30);
call insert_medico_paciente(48,33,30);
call insert_medico_paciente(49,34,30);
call insert_medico_paciente(50,35,30);
call insert_medico_paciente(51,36,30);

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

call insert_historico(52,'36°C','97%','90BMP',TO_TIMESTAMP('2023-11-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),32);
call insert_historico(53,'37°C','96%','100BMP',TO_TIMESTAMP('2023-11-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),33);
call insert_historico(54,'38°C','99%','110BMP',TO_TIMESTAMP('2023-11-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),34);
call insert_historico(55,'37°C','97%','80BMP',TO_TIMESTAMP('2023-11-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),35);
call insert_historico(56,'39°C','96%','100BMP',TO_TIMESTAMP('2023-11-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),36);

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

call insert_chat(57,'Conversa com cardiologista',52);
call insert_chat(58,'Conversa com cardiologista',53);
call insert_chat(59,'Conversa com cardiologista',54);
call insert_chat(60,'Conversa com cardiologista',55);
call insert_chat(61,'Conversa com cardiologista',56);


