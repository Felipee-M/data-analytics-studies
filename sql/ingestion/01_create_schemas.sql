CREATE SCHEMA IF NOT EXISTS olist;

CREATE SCHEMA IF NOT EXISTS superstore;


-- superstore tinha sido criado no público, então utilizei desses comandos para trocar para o schema específico.
ALTER TABLE public.superstore
SET SCHEMA superstore;