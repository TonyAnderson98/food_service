# Arquitetura do Servidor Backend

Este documento detalha a arquitetura do backend `FoodService`

# 1. Estrutura do Projeto

O servidor backend é estruturado seguindo o padrão de **arquitetura em camadas fechadas com separação de responsabilidades**. A estrutura dos diretórios em `apps/server/src` é dada por:

```text
src /
├── routes/         # Definição de Rotas
├── controllers/    # Controladores de requisições HTTP
├── services/       # Lógicas das Regras de Negócios
├── respositories   # Comunicação SQL com o Banco de Dados
├── middlewares/    # Interceptadores de rotas de autenticação, los de erros
├── models/         # Interface de tipos de dados e DTOs
├── config/         # Configuração do banco de dados e variáveis de ambientes
├── utils/          # Funções auxiliares
├── index.ts        # Ponto de entrada do Servidor
└── server.ts       # Inicialização do Servidor
```

# 2. Camadas do Sistema

Para garantir a manutenibilidade e facilidade de testes automatizados, as camadas comunicam-se apenas com a camada abaixo:

```text
Router → Controller → Service → Repository → Banco de Dados
```

### Router

- **Responsabilidade**: Declarar os endpoints HTTP e registrar os middlewares
- **Regra**: Não executam lógica, apenas repassam as requisições para os controllers

### Controllers

- **Responsabilidade**: Tratar a requisição HTTP recebida. Ler headers, params, body e repassar a requisição ao service correspondente
- **Regra**: Nunca realiza regras de negócios ou consultas SQL

### Service

- **Responsabilidade**: Validar regras de negócios
- **Regras**: São idenpendentes do framework `Express`: Recebem dados tipados e retornam DTOs

### Repositories

- **Responsabilidade**: Interação direta com o Banco de Dados, contendo todas as querys `SQL`
- **Regra**: Não tomam decisões, apenas excecutam `querys` e retornam o resultado para o `Service`