const jwt = require("jsonwebtoken");

module.exports = {
  async avaliacoes_servicos(req, res) {
    try {
      const consulta = await req.client.query(`
        SELECT 
          AV.COD_CLI, AV.COMENTARIO AS AVALIACAO, AV.TIPO, S.NOME AS SERVICO_NOME
        FROM 
          AVALIA_SERVICO AV JOIN SERVICO S ON AV.COD_SER = S.COD_SER;
      `);

      return res.json({ message: "Consulta realizada com sucesso!", avaliacoes: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar avaliações!" });
    }
  },

  async avaliacoes_funcionarios(req, res) {
    try {
        const consulta = await req.client.query(`
            SELECT 
              AF.COD_CLI, AF.COMENTARIO AS AVALIACAO, AF.TIPO, F.HORARIO1, F.HORARIO2, F.HORARIO3
            FROM 
              AVALIA_FUNCIONARIO AF JOIN FUNCIONARIO F ON AF.COD_FUN = F.COD_FUN;
        `);
  
        return res.json({ message: "Consulta realizada com sucesso!", avaliacoes: consulta.rows });
      } catch (e) {
        console.log(e);
        return res.status(500).json({ error: "Erro ao consultar avaliações!" });
      }
  }
};
