# protein-md-workflow

Tutorial prático para a preparação, execução e análise de trajetórias de dinâmica molecular. Este workflow utiliza como modelo de estudo a mioglobina (PDB ID: 5XL0), abordando desde o tratamento da estrutura bruta até a extração de métricas estatísticas após simulação.

## 📋 Etapas do Protocolo

* [**01-preparacao**](./01-preparacao): Limpeza da estrutura no `PyMOL` (pré-processamento) e protonação padronizada (pH de interesse) via `PDB2PQR`.
* [**02-montagem-caixa**](./02-montagem-caixa): Protocolo no `VMD` para solvatação, ionização e cálculo automático dos vetores da célula unitária (PBC).
* [**03-configuracao-namd**](./03-configuracao-namd): Edição do arquivo `.conf`. Configuração das variáveis de simulação e dos limites físicos do sistema.
* [**04-execucao-slurm**](./04-execucao-slurm): Scripts de submissão (`bash`) otimizados para uso de GPUs em clusters de alto desempenho.
* [**05-analise-R-python**](./05-analise-R-python): Scripts de pós-processamento para extração de métricas estruturais: `RMSD`, `RMSF`, `SASA` e `RoG`.

---
