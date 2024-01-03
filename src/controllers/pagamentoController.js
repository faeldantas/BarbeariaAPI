const jwt = require("jsonwebtoken");

module.exports = {
  async relatorio(req, res) {
    try {
      const consulta = await req.client.query(`
        SELECT 
          P.COD_PAG, P.TIPO, PR.NOME AS PRODUTO_NOME, PR.PRECO, PP.DATA, PP.HORA
        FROM 
          PAGAMENTO P JOIN PRODUTO_PAGAMENTO PP ON P.COD_PAG = PP.COD_PAG
          JOIN PRODUTO PR ON P.COD_PRO = PR.COD_PRO;
      `);

      return res.json({ message: "Busca realizada com sucesso!", pagamentos: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar pagamentos!" });
    }
  },

  async relatorio_cartao(req, res) {
    try {
      const consulta = await req.client.query(`
        SELECT 
          PP.DATA, PP.HORA, P.NOME AS PRODUTO, P.MARCA, PA.TIPO AS TIPO_PAGAMENTO, CP.BANDEIRA
        FROM 
          PRODUTO_PAGAMENTO PP JOIN PRODUTO P ON PP.COD_PRO = P.COD_PRO JOIN PAGAMENTO PA ON PP.COD_PAG = PA.COD_PAG LEFT JOIN CARTAO CP ON PA.COD_PAG = CP.COD_PAG WHERE PA.TIPO = 'Cartão' ORDER BY PP.DATA, PP.HORA;
      `);

      return res.json({ message: "Busca realizada com sucesso!", pagamentos: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar pagamentos!" });
    }
  },

  async quantidade(req, res) {
    try {
      const consulta = await req.client.query(`
        SELECT 
          TIPO, COUNT(*) AS TOTAL_PAGAMENTOS 
          FROM 
            PAGAMENTO 
          GROUP BY 
            TIPO;
      `);

      return res.json({ message: "Busca realizada com sucesso!", pagamentos: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar pagamentos!" });
    }
  }
};
