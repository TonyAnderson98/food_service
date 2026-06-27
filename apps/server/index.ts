import express from 'express';

const app = express();
const PORT = 3000;

app.get('/health', (req, res) => {
    res.status(200).json({ message: "online" });
});

app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});