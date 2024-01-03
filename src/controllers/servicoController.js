const jwt = require("jsonwebtoken");

module.exports = {
  async agendamento_cliente(req, res) {
    try {
      const cliente = parseInt(req.params.cliente);

      // Verificar se o usuário já existe
      const clienteExistente = await req.client.query('SELECT * FROM cliente WHERE cod_cli = $1', [cliente]);

      if (!clienteExistente.rows.length) {
        return res.status(404).json({ error: "Cliente não encontrado!" });
      }

      const agendamentos = await req.client.query(`
        SELECT 
          A.COD_CLI, A.STATUS, A.HORA, A.DATA, S.NOME AS SERVICO_NOME, S.VALOR
        FROM 
          AGENDA A JOIN SERVICO S ON A.COD_SER = S.COD_SER 
        WHERE 
          A.COD_CLI = $1;
      `, [cliente]);

      // Enviar resposta de sucesso
      return res.json({ message: "Consulta realizada com sucesso!", agendamentos: agendamentos.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar agendamentos do cliente!" });
    }
  },

  async agendamento_clientes(req, res) {
    try {
      const agendamentos = await req.client.query(`
        SELECT 
          C.COD_CLI, U.NOME AS NOME_CLIENTE, A.COD_FUN, A.COD_SER, A.STATUS, A.HORA, A.DATA
        FROM 
          CLIENTE C RIGHT JOIN AGENDA A ON C.COD_CLI = A.COD_CLI JOIN USUARIO U ON C.COD_USER = U.COD_USER;
      `);

      // Enviar resposta de sucesso
      return res.json({ message: "Consulta realizada com sucesso!", agendamentos: agendamentos.rows });
    } catch(e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar agendamentos dos clientes!" });
    }
  },
  async agendamento_funcionarios(req, res) {
    try {
      const agendamentos = await req.client.query(`
        SELECT 
          F.COD_FUN, U.NOME AS NOME_FUNCIONARIO, COUNT(A.COD_SER) AS QUANTIDADE_SERVICOS_AGENDADOS
        FROM 
          FUNCIONARIO F JOIN USUARIO U ON F.COD_USER = U.COD_USER LEFT JOIN AGENDA A ON F.COD_FUN = A.COD_FUN
        GROUP BY 
          F.COD_FUN, U.NOME;
      `);

      // Enviar resposta de sucesso
      return res.json({ message: "Consulta realizada com sucesso!", agendamentos: agendamentos.rows });
    } catch(e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar agendamentos dos funcionários!" });
    }
  },

  async criar(req, res) {
    const {
      tipo = "",
      valor = 0.0,
      descricao = "",
      duracao = "",
      nome = ""
    } = req.body;
    
  }
};
