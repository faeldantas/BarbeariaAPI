const { Router } = require('express');
const clienteController = require('../controllers/clienteController');
const loginRequired = require('../middleware/loginRequired');

const router = Router();

router.post('/registro', clienteController.registro);
router.post('/login', clienteController.login);
router.put('/atualizar', loginRequired, clienteController.atualizar);
router.delete('/deletar', loginRequired, clienteController.deletar);

router.get('/geral', clienteController.geral);

router.get('/relatorio', clienteController.relatorio);

module.exports = router;