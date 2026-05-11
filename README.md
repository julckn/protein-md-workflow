# protein-md-workflow

Tutorial prático para a preparação, execução e análise de trajetórias de dinâmica molecular. Este workflow utiliza como modelo de estudo a mioglobina (PDB ID: 5XL0), abordando desde o tratamento da estrutura bruta até a extração de métricas estatísticas após simulação.

## 📋 Etapas do Protocolo
01-preparacao: Focada na limpeza da estrutura no PyMOL e na protonação correta no pH de interesse (usando PDB2PQR ou H++).
02-montagem-caixa: Contém o passo a passo no VMD para solvatação, adição de íons e o script para calcular os vetores da célula unitária (PBC).
03-configuracao-namd: Onde você deve colocar o seu arquivo .conf (como o de 1 ns que você usou para benchmarking) e os arquivos de parâmetros do campo de força CHARMM.
03-configuracao-namd: Preparação do arquivo de configuração do NAMD. Nesta etapa, definimos os parâmetros da simulação (como tempo e temperatura) e inserimos as dimensões da caixa geradas no VMD para garantir que o sistema seja infinito.
04-execucao-slurm: Espaço para o seu script de submissão (bash), especificando o uso de GPUs para otimizar o tempo de processamento das trajetórias.
05-analise-R-python: Destinada aos scripts de pós-processamento para extração de dados estruturais como RMSD, RMSF, SASA e Raio de Giro (RoG).

---
