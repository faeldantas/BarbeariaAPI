require('dotenv').config();

const { Client } = require('pg');

const express = require('express');
const cors = require('cors');

const clienteRouter = require('./routes/clienteRouter');
const servicoRouter = require('./routes/servicoRouter');
const avaliacaoRouter = require('./routes/avaliacaoRouter');
const pagamentoRouter = require('./routes/pagamentoRouter');

const app = express();

const client = new Client({ 
    database: process.env.DATABASE_NAME,
    host: process.env.DATABASE_HOST,
    port: process.env.DATABASE_PORT,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD
});

client.connect();

app.use((req, res, next) => {
    req.client = client;
    next();
});

app.use(express.json());
app.use(cors());

app.use('/cliente/', clienteRouter);
app.use('/servico/', servicoRouter);
app.use('/avaliacao/', avaliacaoRouter);
app.use('/pagamento/', pagamentoRouter);

app.get('/', (req, res) => {
    res.send('API');
});

const port = process.env.EXPRESS_PORT || 3001;

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});