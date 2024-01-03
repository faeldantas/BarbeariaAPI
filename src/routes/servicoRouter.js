const { Router } = require('express');
const servicoController = require('../controllers/servicoController');
const loginRequired = require('../middleware/loginRequired');

const router = Router();

router.get('/agendamento/clientes', servicoController.agendamento_clientes);
router.get('/agendamento/clientes/:cliente', servicoController.agendamento_cliente);

router.get('/agendamento/funcionarios', servicoController.agendamento_funcionarios);

router.post('/criar', servicoController.criar)

module.exports = router;