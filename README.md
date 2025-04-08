# Documentação do Projeto job_send_recomendation (Gen by AI)

## Visão Geral

O projeto `job_send_recomendation` é um sistema automatizado de envio de recomendações diárias para usuários através de email e WhatsApp. Este projeto faz parte da iniciativa [MaisFoco.life](https://maisfoco.life), uma plataforma dedicada a fornecer conteúdo curado e recomendações personalizadas para seus usuários.

## Propósito

O principal objetivo deste sistema é enviar recomendações diárias de diferentes categorias de produtos e conteúdos, incluindo:

- Filmes e séries da Netflix
- Produtos da Amazon
- Jogos do Instant Gaming
- Livros gratuitos
- Conteúdo do Mercado Livre Play

## Arquitetura

O projeto é desenvolvido em V (vlang) e segue uma arquitetura modular com os seguintes componentes principais:

### Estrutura de Diretórios

```
job_send_recomendation/
├── .env.template        # Template para configuração de variáveis de ambiente
├── src/                 # Código fonte do projeto
│   ├── amazon/          # Módulo para recomendações da Amazon
│   ├── entities/        # Definições de entidades do sistema
│   ├── errors/          # Tratamento de erros
│   ├── instant_gaming/  # Módulo para recomendações do Instant Gaming
│   ├── livros_gratuitos/# Módulo para recomendações de livros gratuitos
│   ├── main.v           # Ponto de entrada da aplicação
│   ├── mercado_livre_play/ # Módulo para recomendações do Mercado Livre Play
│   ├── netflix/         # Módulo para recomendações da Netflix
│   ├── recomendation/   # Lógica central de recomendações
│   ├── repository/      # Acesso a dados
│   ├── shareds/         # Componentes compartilhados
│   └── wpapi/           # API para integração com WhatsApp
└── v.mod                # Arquivo de configuração do módulo V
```

### Padrão de Design

O projeto segue um padrão de design em camadas:

1. **Controllers**: Gerenciam as requisições e respostas
2. **Services**: Contêm a lógica de negócios
3. **Repositories**: Lidam com o acesso a dados
4. **Entities/Models**: Representam os dados do sistema

## Funcionamento

O sistema opera da seguinte forma:

1. O processo principal é executado continuamente, aguardando até as 7h da manhã do dia seguinte
2. Quando o horário programado é atingido, o sistema coleta recomendações atuais de diferentes fontes
3. As recomendações são enviadas para os contatos cadastrados via email e/ou WhatsApp
4. O processo se repete diariamente

### Seleção de Recomendações

As recomendações são selecionadas do banco de dados com base na data atual, garantindo que o conteúdo seja relevante e atualizado. O sistema utiliza a função `get_date_start_and_end()` para determinar o intervalo de datas válido para as recomendações.

## Configuração

O sistema utiliza variáveis de ambiente para configuração, incluindo:

- Conexão com banco de dados (PostgreSQL)
- Configurações de email (SMTP)
- Configurações de API do WhatsApp
- Domínios e endereços de email

## Integração com MaisFoco.life

Este projeto é uma parte fundamental da iniciativa [MaisFoco.life](https://maisfoco.life), atuando como o motor de recomendações que mantém os usuários engajados com conteúdo relevante e oportuno. Enquanto a plataforma MaisFoco.life fornece a interface e experiência do usuário, este sistema trabalha nos bastidores para garantir que as recomendações sejam entregues de forma confiável e pontual.

A integração com a plataforma principal permite que os usuários recebam recomendações personalizadas com base em suas preferências, aumentando o engajamento e fornecendo valor contínuo aos assinantes do serviço.

## Requisitos Técnicos

- V (vlang)
- PostgreSQL
- Serviço SMTP para envio de emails
- API do WhatsApp para mensagens

## Conclusão

O projeto `job_send_recomendation` é um componente crítico da infraestrutura da iniciativa MaisFoco.life, automatizando o processo de envio de recomendações diárias e mantendo os usuários engajados com conteúdo relevante e atualizado.