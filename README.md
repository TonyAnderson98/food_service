# FoodService

Sistema do ramo alimentício cobrindo fluxo compelto: o cliente faz o pedido, a cozinha recebe em tempo real e gerencia o preparo, garçons acompanham os status das mesas. Cliente pode chamar garçom ou solicitar a conta.

## Escopo

### Cliente (Mesa/Mobile)

- **Mesa**: Cada mesa possui um tablet pré configurado com o número da mesa
- **Catálogo**: Lista de produtos organizados por categorias, com foto, nome, descrição, ingredientes e preço
- **Carrinho**: Adicionar/remove itens, adicionar observações e calcular valor total do pedido
- **Fechamento de pedido**: Acompanhamento em tempo real do staus do pedido (`Pendente` → `Preparando` → `Pronto` → `Entregue`)
- **Chamado**: Chamar o garçom ou solicitar a conta pelo aplicativo


### Garçom (Mobile)

- **Status da mesa**: Monitoramento visual dos status da mesa em tempo real ( `free`, `occupied`, `waiting_service`, `waiting_bill`)
- **Acompanhamento de chamados das mesas**:


### Cozinha (Desktop)

- **Fila de pedidos**: Pedidos chegam em tempo real, ordenados por tempo de espera


### Administração

- **CRUD de cardápio**: Adicionar, Editar, Desativar ou Remover produtos do cardápio

# Estrutura de Pastas
O projeto está estruturado da seguinte forma
```text
food-service/
├── apps/
│   ├── server          Backend: API Node + Express
│   └── client          Frontend: Aplicação Flutter
├── doc
├── monitoring          Observabilidade: Grafana + Loki + Prometheus
└── SCHEMA              Schema do Banco de Dados
```