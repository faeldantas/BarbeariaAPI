const { Router } = require('express');
const pagamentoController = require('../controllers/pagamentoController');
const loginRequired = require('../middleware/loginRequired');

const router = Router();

router.get('/relatorio', pagamentoController.relatorio);
router.get('/relatorio/cartao', pagamentoController.relatorio_cartao);

router.get('/quantidade', pagamentoController.quantidade);

module.exports = router;