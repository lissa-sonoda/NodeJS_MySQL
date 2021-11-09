const express = require("express");
const app = express();
app.use(express.json());
const mysql = require("mysql2");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "db_hospital",
  password: "root",
});

app.get("/medicos", (req, res) => {
  connection.query("SELECT * FROM tb_medico", (err, results, fields) => {
    res.send(results);
  });
});

app.get("/pacientes", (req, res) => {
  connection.query("SELECT * FROM tb_paciente", (err, results, fields) => {
    res.send(results);
  });
});

app.get("/consultas", (req, res) => {
  connection.query(
    `SELECT m.crm as "CRM do médico", 
        m.nome as "Nome do médico", 
        DATE_FORMAT(data_hora, "%d/%m/%y %H:%i") as "Data da consulta",
        p.nome as "Nome do paciente" 
        FROM tb_medico m
        INNER JOIN tb_consulta c
        ON m.crm = c.crm
        INNER JOIN tb_paciente p
        ON c.cpf = p.cpf;`,
    (err, results, fields) => {
      res.send(results);
    }
  );
});

const porta = 3000;
app.listen(porta, () => console.log(`Executanto porta ${porta}`));
