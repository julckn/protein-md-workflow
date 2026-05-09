# protein-md-workflow

Tutorial prático para preparação, execução e análise de dinâmica molecular de uma proteína sem ligante.

## 📋 Etapas do Protocolo
1. Download, preparação e protonação da proteína
2. **Montagem da caixa de simulação pelo VMD** (Detalhada abaixo)
3. Edição do .conf (NAMD)
4. Execução de simulação via slurm
5. Geração de resultados (RMSD, RMSF, SASA e RoG) via Python

---

## 🛠 Etapa 2: Montagem da Caixa de Simulação (VMD)

Nesta etapa, utilizamos o VMD para solvatar a proteína e adicionar íons, preparando o sistema para a simulação no NAMD.

### Comandos Básicos no Tk Console:

**1. Solvatação:**
Adiciona uma caixa de água ao redor da proteína com um padding de 12 Å.
```tcl
package require solvate
solvate proteina.psf proteina.pdb -t 12 -o proteina_wb
