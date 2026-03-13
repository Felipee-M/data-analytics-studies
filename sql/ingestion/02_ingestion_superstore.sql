-- Garante que o schema existe
CREATE SCHEMA IF NOT EXISTS superstore;

-- Move a tabela para o schema correto
ALTER TABLE IF EXISTS public.superstore
SET SCHEMA superstore;

-- versão compacta
CREATE SCHEMA IF NOT EXISTS superstore;

DROP TABLE IF EXISTS superstore.superstore;

CREATE TABLE superstore.superstore (
    row_id              INT,
    order_id            TEXT,
    order_date          DATE,
    ship_date           DATE,
    ship_mode           TEXT,
    customer_id         TEXT,
    customer_name       TEXT,
    segment             TEXT,
    country             TEXT,
    city                TEXT,
    state               TEXT,
    postal_code         TEXT,
    region              TEXT,
    product_id          TEXT,
    category            TEXT,
    sub_category        TEXT,
    product_name        TEXT,
    sales               NUMERIC(12,2),
    quantity            INT,
    discount            NUMERIC(5,2),
    profit              NUMERIC(12,2)
);

-- Exemplo de carga
-- Ajuste o caminho conforme sua máquina
COPY superstore.superstore
FROM '/caminho/para/seu/superstore.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';