/**
 * API DevOps - TP Docker
 * Formation M2 ESTD - ForEach Academy
 */

const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

// Middleware
app.use(express.json());
app.use(express.static('public'));

// Variables d'environnement (optionnelles pour demo)
const REDIS_URL = process.env.REDIS_URL || 'redis://localhost:6379';
const DATABASE_URL = process.env.DATABASE_URL || 'postgres://localhost:5432/devops_db';

// ==========================================
// Routes API
// ==========================================

/**
 * GET / - Page d'accueil
 */
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

/**
 * GET /api/health - Healthcheck pour Docker
 */
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: NODE_ENV
  });
});

/**
 * GET /api/info - Informations sur l'application
 */
app.get('/api/info', (req, res) => {
  res.json({
    name: 'API DevOps',
    version: '1.0.0',
    environment: NODE_ENV,
    node_version: process.version,
    platform: process.platform,
    uptime_seconds: Math.floor(process.uptime()),
    memory_usage: {
      rss: `${Math.round(process.memoryUsage().rss / 1024 / 1024)}MB`,
      heap_used: `${Math.round(process.memoryUsage().heapUsed / 1024 / 1024)}MB`,
      heap_total: `${Math.round(process.memoryUsage().heapTotal / 1024 / 1024)}MB`
    },
    pid: process.pid,
    connections: {
      redis: REDIS_URL,
      database: DATABASE_URL.replace(/:[^:@]*@/, ':***@') // Hide password
    }
  });
});

/**
 * GET /api/time - Retourne l'heure actuelle
 */
app.get('/api/time', (req, res) => {
  res.json({
    timestamp: new Date().toISOString(),
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
    local_time: new Date().toLocaleString('fr-FR'),
    unix: Math.floor(Date.now() / 1000)
  });
});

/**
 * POST /api/echo - Echo des données envoyées
 */
app.post('/api/echo', (req, res) => {
  res.json({
    received: req.body,
    timestamp: new Date().toISOString()
  });
});

/**
 * GET /api/env - Variables d'environnement (démo uniquement!)
 */
app.get('/api/env', (req, res) => {
  res.json({
    NODE_ENV: NODE_ENV,
    PORT: PORT,
    has_redis: !!REDIS_URL,
    has_database: !!DATABASE_URL
  });
});

// ==========================================
// Route 404
// ==========================================

app.use((req, res) => {
  res.status(404).json({
    error: 'Route not found',
    path: req.path,
    method: req.method
  });
});

// ==========================================
// Démarrage du serveur
// ==========================================

const server = app.listen(PORT, '0.0.0.0', () => {
  console.log('================================================');
  console.log('🚀 API DevOps - TP Docker');
  console.log('================================================');
  console.log(`Environment: ${NODE_ENV}`);
  console.log(`Port: ${PORT}`);
  console.log(`Server: http://localhost:${PORT}`);
  console.log(`Health: http://localhost:${PORT}/api/health`);
  console.log(`Info: http://localhost:${PORT}/api/info`);
  console.log('================================================');
  console.log('Ready to accept requests!');
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
  });
});
