const express = require('express');
const app = express();
const PORT = Number(process.env.PORT || 6000);

app.get('/', (_req, res) => res.json({ service: 'B', message: 'Hello from Service B' }));
app.get('/health', (_req, res) => res.json({ service: 'B', status: 'healthy' }));

app.listen(PORT, '0.0.0.0', () => console.log(`Service B listening on ${PORT}`));
