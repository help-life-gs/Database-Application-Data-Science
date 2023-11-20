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