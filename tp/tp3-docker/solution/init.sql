-- Script d'initialisation PostgreSQL
-- TP Docker - M2 ESTD

-- Créer une table de démonstration
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insérer des données de test
INSERT INTO users (username, email) VALUES
    ('admin', 'admin@devops.local'),
    ('developer', 'dev@devops.local'),
    ('tester', 'test@devops.local')
ON CONFLICT (username) DO NOTHING;

-- Créer une table pour les logs
CREATE TABLE IF NOT EXISTS app_logs (
    id SERIAL PRIMARY KEY,
    level VARCHAR(20),
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insérer un log initial
INSERT INTO app_logs (level, message) VALUES
    ('INFO', 'Database initialized successfully');

-- Afficher un message de confirmation
DO $$
BEGIN
    RAISE NOTICE 'Database initialization completed!';
    RAISE NOTICE 'Created tables: users, app_logs';
    RAISE NOTICE 'Inserted test data';
END $$;
