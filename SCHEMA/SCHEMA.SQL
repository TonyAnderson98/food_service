------------------------------------------------------------
-- SCHEMA
------------------------------------------------------------


-- ---------------------------------------------------------------------
--  Usuários
--    Clientes e funcionários
-- ---------------------------------------------------------------------
CREATE TYPE user_category AS ENUM('client', 'waiter', 'kitchen', 'admin');
CREATE TABLE users (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(128) NOT NULL,
    username        VARCHAR(64) UNIQUE NOT NULL,
    password_hash   VARCHAR(512) NOT NULL,
    role            user_category NOT NULL DEFAULT 'client',      -- 'client' | 'waiter' | 'kitchen' | 'admin'
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------
--  Mesas
-- ---------------------------------------------------------------------
CREATE TYPE table_status AS ENUM('free', 'occupied', 'waiting_bill', 'waiting_service');
CREATE TABLE tables (
    id              SERIAL PRIMARY KEY,
    table_number    INT UNIQUE NOT NULL,
    status          table_status NOT NULL DEFAULT 'free',        -- 'free' | 'occupied' | 'waiting_bill' | 'waiting_service'
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------
--  Categorias
--    Representa as categorias dos produtos do menu
-- ---------------------------------------------------------------------
CREATE TABLE categories (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(64) UNIQUE NOT NULL,            -- Ex: 'Pizzas', 'Hambúrgueres', 'Bebidas'
    created_at          TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------
--  Cardápio
--    Representa os produtos do menu
-- ---------------------------------------------------------------------
CREATE TABLE products (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(128) NOT NULL,
    description         VARCHAR(512) NOT NULL,
    price               NUMERIC(10,2) NOT NULL,
    category_id         INT NOT NULL REFERENCES categories(id),
    image_base64        TEXT,
    active              BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW() 
);

-- ---------------------------------------------------------------------
--  Pedido
--    Pedidos feitos pelos clientes 
-- ---------------------------------------------------------------------
CREATE TYPE order_status AS ENUM ('pending', 'preparing', 'ready', 'delivered');
CREATE TABLE orders (
    id              SERIAL PRIMARY KEY,
    uuid            UUID UNIQUE NOT NULL,                       -- chave de idempotência
    table_id        INT REFERENCES tables(id),
    user_id         INT REFERENCES users(id),
    waiter_id       INT REFERENCES users(id),
    status          order_status NOT NULL DEFAULT 'pending',
    total           NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------
--  Itens do Pedido
-- ---------------------------------------------------------------------
CREATE TABLE order_items (
    id              SERIAL PRIMARY KEY,
    order_id        INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id      INT NOT NULL REFERENCES products(id),
    quantity        INT NOT NULL CHECK (quantity > 0),
    notes           VARCHAR(255),                               -- Observações (ex: 'Sem cebola', 'Bem passado')              
    unit_price      NUMERIC(10,2) NOT NULL
);

-- ---------------------------------------------------------------------
--  Chamadas de Garçom
-- ---------------------------------------------------------------------
CREATE TYPE waiter_call_status AS ENUM ('pending', 'active', 'resolved');
CREATE TABLE waiter_calls (
    id              SERIAL PRIMARY KEY,
    table_id        INT NOT NULL REFERENCES tables(id),
    status          waiter_call_status NOT NULL DEFAULT 'pending',
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    resolved_by     INT REFERENCES users(id),
    resolved_at     TIMESTAMP
);

-- Índices
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_table_id ON orders(table_id);
CREATE INDEX idx_waiter_calls_status ON waiter_calls(status);
CREATE INDEX idx_product_active ON products(active);


                                                                                                                                        







