# protein-md-workflow

Tutorial prático para a preparação, execução e análise de trajetórias de dinâmica molecular. Este workflow utiliza como modelo de estudo a mioglobina (PDB ID: 5XL0), abordando desde o tratamento da estrutura bruta até a extração de métricas estatísticas após simulação.

## 📋 Etapas do Protocolo
1. Download, pré-processamento (Pymol) e protonação da proteína (pdb2pqr)
2. Montagem da caixa de simulação pelo VMD
3. Edição do .conf (NAMD)
4. Execução de simulação via slurm
5. Geração de resultados (RMSD, RMSF, SASA e RoG) via Python

---
