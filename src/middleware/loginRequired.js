const jwt = require('jsonwebtoken');

const loginRequired = async (req, res, next) => {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).json({
      errors: ['O login é requerido'],
    });
  }

  const [, token] = authorization.split(' ');
  try {
    const dados = jwt.verify(token, process.env.TOKEN_SECRET);
    const { cod_user } = dados;

    const usuarioExistente = await req.client.query('SELECT * FROM usuario WHERE cod_user = $1', [cod_user]);
    
    if (usuarioExistente.rows.length == 0) {
      return res.status(404).json({
        errors: ['Usuário não encontrado'],
      });
    }
    
    req.usuarioId = cod_user;

    return next();
  } catch (e) {

    return res.status(401).json({
      errors: ['Token expirado ou inválido.'],
    });
  }
};

module.exports = loginRequired;