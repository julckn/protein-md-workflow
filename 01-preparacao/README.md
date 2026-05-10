# Etapa 1: Download do modelo

* Acesse ao site [RCSB PDB](https://www.rcsb.org/structure/)
* Busca pelo código *5XL0* (mioglobina).
* Em **Download Files**, escolha o formato **Legacy PDB format**.

# Etapa 2: Pré-processamento da estrutura (Pymol)

* Remova o solvente, geralmente moléculas de água, no painel superior direito. Clique no botão **A** (Action) > **remove** **waters**.
* Ative a barra de sequência no canto inferior direito clicando em **SEQ** (em versões mais atuais) ou **S** (em versões mais antigas).
* No final da sequência selecione os íons *SO4* e o grupo *HEME*. No painel superior direito, na linha (sele) clique no botão **A** (Action) > **remove** **atoms**.
* Na maioria dos casos a estrutura do RCSB PDB não vem acompanhada de hidrogênios. Caso necessário, para garantir uma protonação padronizada nas etapas seguintes, remova hidrogênios pré-existentes clicando no botão **A** (Action) > **hydrogens** > **remove**.
*Salve o arquivo final em **File** > **Export Molecule...** no formato '.pdb' para manter a compatibilidade com o servidor 'pdb2pqr'.

# Etapa 3: Protonação em pH de interesse
