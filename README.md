# Deninscore

Este projeto tem como objetivo criar um acompanhamento estatístico das partidas semanais de futebol entre amigos, a partir de dados registrados manualmente após cada jogo.

As estatísticas das partidas são preenchidas em uma planilha do Google Sheets e utilizadas como fonte de dados para análises e visualizações. A partir desses dados, o projeto busca gerar métricas individuais e coletivas, permitindo acompanhar o desempenho dos atletas ao longo do tempo.

O foco é disponibilizar para o grupo da pelada:
- Estatísticas por atleta
- Histórico de vitórias, derrotas e empates
- Desempenho como capitão
- Destaques positivos (MOTM – Man of the Match)
- Destaques negativos (BOTM – Bagre of the Match 😅)

Além do aspecto analítico, o projeto tem um viés de estimular o engajamento entre os participantes através de discussões, rankings informais e premiações simbólicas.

## Stack e arquitetura

A stack foi escolhida priorizando simplicidade, integração nativa e uso de recursos gratuitos:

- **Google Sheets**: entrada manual dos dados após cada partida
- **BigQuery**: armazenamento e modelagem analítica dos dados
- **Looker Studio**: visualização e dashboards
- **GitHub**: documentação do projeto, versionamento de SQL, modelagem de dados e decisões técnicas

Toda a execução ocorre no ecossistema do Google Cloud, aproveitando a integração nativa entre Google Sheets, BigQuery e Looker Studio. O GitHub é utilizado exclusivamente como repositório de documentação e organização do projeto, não sendo necessário executar código diretamente a partir dele.

## Objetivos do projeto

- Criar um histórico estruturado das partidas
- Desenvolver métricas analíticas de desempenho
- Praticar modelagem de dados e SQL em um cenário real
- Servir como projeto pessoal de portfólio em dados
- Gerar valor e entretenimento para o grupo da pelada
