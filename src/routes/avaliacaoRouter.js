const { Router } = require('express');
const avaliacaoController = require('../controllers/avaliacaoController');
const loginRequired = require('../middleware/loginRequired');

const router = Router();

router.get('/servicos', avaliacaoController.avaliacoes_servicos);
router.get('/funcionarios', avaliacaoController.avaliacoes_funcionarios);

module.exports = router;