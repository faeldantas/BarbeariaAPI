const jwt = require("jsonwebtoken");

module.exports = {
  async registro(req, res) {
    try {
      const {
        nome = "",
        sobrenome = "",
        email = "",
        senha = "",
        telefone1 = 0,
        telefone2 = null,
      } = req.body;
      
      if (nome.length < 3 || nome.length > 50) {
        return res.status(400).json({ error: "O nome deve ter entre 3 e 50 caracteres!" });
      }

      if (sobrenome.length < 3 || sobrenome.length > 50) {
        return res.status(400).json({ error: "O sobrenome deve ter entre 3 e 50 caracteres!" });
      }

      if (email.indexOf("@") === -1 || email.length < 3 || email.length > 50) {
        return res.status(400).json({ error: "O email deve ser válido!" });
      }

      if (senha.length < 8 || senha.length > 50) {
        return res.status(400).json({ error: "A senha deve ter entre 8 e 50 caracteres!" });
      }

      if (telefone1.toString().length < 8 || telefone1.toString().length > 11) {
        return res.status(400).json({ error: "O telefone deve ter entre 8 e 11 casas decimais!" });
      }

      if (telefone2 != null) {
        if (telefone2.toString().length < 8 || telefone2.toString().length > 11) {
          return res.status(400).json({ error: "O telefone deve ter entre 8 e 11 casas decimais!" });
        }
      }

      // Verificar se o usuário já existe
      const usuarioExistente = await req.client.query('SELECT * FROM usuario WHERE email = $1', [email]);
      
      if (usuarioExistente.rows.length) {
        return res.status(400).json({ error: "Usuário já cadastrado!" });
      }

      const ultimo_cod_usu = await req.client.query('SELECT MAX(cod_user) FROM usuario LIMIT 1');

      const cod_user = ultimo_cod_usu.rows[0].max + 1;

      // Criar usuário
      await req.client.query(`
        INSERT INTO usuario 
          (cod_user, nome, sobrenome, email, senha, telefone1, telefone2, tipo) 
        VALUES 
          ($1, $2, $3, $4, $5, $6, $7, $8)`, 
          [cod_user, nome, sobrenome, email, senha, telefone1, telefone2, 'Cliente']
      );

      const ultimo_cod_cli = await req.client.query('SELECT MAX(cod_cli) FROM cliente LIMIT 1');

      const cod_cli = ultimo_cod_cli.rows[0].max + 1;

      await req.client.query(`
        INSERT INTO cliente
          (cod_cli, cod_user, pontuacao)
        VALUES
          ($1, $2, $3)`,
          [cod_cli, cod_user, 0]
      );

      // Enviar resposta de sucesso
      return res.json({ message: "Usuário cadastrado com sucesso!" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao cadastrar usuário!" });
    }
  },

  async atualizar(req, res) {
    try {
      const {
        nome = "",
        sobrenome = "",
        telefone1 = 0,
        telefone2 = null,
      } = req.body;
      
      if (nome.length < 3 || nome.length > 50) {
        return res.status(400).json({ error: "O nome deve ter entre 3 e 50 caracteres!" });
      }

      if (sobrenome.length < 3 || sobrenome.length > 50) {
        return res.status(400).json({ error: "O sobrenome deve ter entre 3 e 50 caracteres!" });
      }

      if (telefone1.toString().length < 8 || telefone1.toString().length > 11) {
        return res.status(400).json({ error: "O telefone deve ter entre 8 e 11 casas decimais!" });
      }

      if (telefone2 != null) {
        if (telefone2.toString().length < 8 || telefone2.toString().length > 11) {
          return res.status(400).json({ error: "O telefone deve ter entre 8 e 11 casas decimais!" });
        }
      }

      const cod_user = req.usuarioId;

      await req.client.query(`
        UPDATE usuario
        SET nome = $1, sobrenome = $2, telefone1 = $3, telefone2 = $4
        WHERE cod_user = $5`, [nome, sobrenome, telefone1, telefone2, cod_user]);

      // Enviar resposta de sucesso
      return res.json({ message: "Usuário atualizado com sucesso!" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao atualizar usuário!" });
    }
  },

  async deletar(req, res) {
    try {
      const cod_user = req.usuarioId;

      await req.client.query('DELETE FROM cliente WHERE cod_user = $1', [cod_user]);
      await req.client.query('DELETE FROM usuario WHERE cod_user = $1', [cod_user]);

      // Enviar resposta de sucesso
      return res.json({ message: "Usuário deletado com sucesso!" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao deletar usuário!" });
    }
  },

  async login(req, res) {
    try {
      const {
        email = "",
        senha = "",
      } = req.body;

      if (email.indexOf("@") === -1 || email.length < 3 || email.length > 50) {
        return res.status(400).json({ error: "O email deve ser válido!" });
      }

      if (senha.length < 8 || senha.length > 50) {
        return res.status(400).json({ error: "A senha deve ter entre 8 e 50 caracteres!" });
      }

      // Verificar se o usuárioá existe
      const usuarioExistente = await req.client.query('SELECT * FROM usuario WHERE email = $1 and senha = $2', [email, senha]);

      if (usuarioExistente.rows.length == 0) {
        return res.status(404).json({ error: "Credenciais inválidas!" });
      }

      // Enviar resposta de sucesso
      return res.json({ message: "Usuário logado com sucesso!", token: jwt.sign(
        { cod_user: usuarioExistente.rows[0].cod_user }, 
        process.env.TOKEN_SECRET, { expiresIn: process.env.TOKEN_EXPIRATION }) 
      });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao logar usuário!" });
    }  
  },

  async relatorio(req, res) {
    try {
      const consulta = await req.client.query(`
        SELECT U.NOME AS NOME_CLIENTE, C.PONTUACAO,
          (
            SELECT COUNT(*)
            FROM AGENDA A
            WHERE A.COD_CLI = C.COD_CLI
          )
          AS QUANTIDADE_AGENDAMENTOS
        FROM CLIENTE C JOIN USUARIO U ON C.COD_USER = U.COD_USER;
      `);

      return res.json({ message: "Busca realizada com sucesso!", clientes: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar clientes!" });
    }
  },

  async geral(req, res) {
    try {
      const consulta = await req.client.query(`SELECT * FROM VISAO`);

      return res.json({ message: "Busca realizada com sucesso!", geral: consulta.rows });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Erro ao consultar dados!" });
    }
  }
};
