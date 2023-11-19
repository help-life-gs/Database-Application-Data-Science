DROP TABLE tb_bairro CASCADE CONSTRAINTS;

DROP TABLE tb_chat CASCADE CONSTRAINTS;

DROP TABLE tb_cidade CASCADE CONSTRAINTS;

DROP TABLE tb_endereco_paciente CASCADE CONSTRAINTS;

DROP TABLE tb_especialidade CASCADE CONSTRAINTS;

DROP TABLE tb_estado CASCADE CONSTRAINTS;

DROP TABLE tb_historico CASCADE CONSTRAINTS;

DROP TABLE tb_login CASCADE CONSTRAINTS;

DROP TABLE tb_medico CASCADE CONSTRAINTS;

DROP TABLE tb_medico_paciente CASCADE CONSTRAINTS;

DROP TABLE tb_paciente CASCADE CONSTRAINTS;

DROP TABLE tb_sexo CASCADE CONSTRAINTS;

CREATE TABLE tb_bairro (
    id_bairro NUMBER NOT NULL,
    nm_bairro VARCHAR2(200) NOT NULL,
    id_cidade NUMBER NOT NULL
);

ALTER TABLE tb_bairro ADD CONSTRAINT tb_bairro_pk PRIMARY KEY ( id_bairro );

CREATE TABLE tb_chat (
    id_chat      NUMBER NOT NULL,
    desc_chat    VARCHAR2(1000),
    id_historico NUMBER NOT NULL,
    CONSTRAINT tabela_json_chk1 CHECK (desc_chat IS JSON)
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
        