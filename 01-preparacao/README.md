# Etapa 1: Download do modelo

* Acesse ao site [RCSB PDB](https://www.rcsb.org/structure/)
* Busca pelo código *5XL0* (mioglobina).
* Em **Download Files**, escolha o formato **Legacy PDB format**.

# Etapa 2: Pré-processamento da estrutura (Pymol)

* Remova as moléculas de água (solvente): No painel superior direito clique em **A** (Action) > **remove** **waters**.
* Ative a barra de sequência: No canto inferior direito clicando em **SEQ** (em versões mais atuais) ou **S** (em versões mais antigas).
* Remova os íons *SO4* e o grupo *HEME: No final da sequência selecione-os. No painel superior direito, na linha (sele) clique no botão **A** (Action) > **remove** **atoms**.
*Caso a estrutura original possua hidrogênios, remova-os: No painel superior direito clique em **A** (Action) > **hydrogens** > **remove**.
* Salve o arquivo final em **File** > **Export Molecule...** no formato `.pdb` para manter a compatibilidade com o servidor `pdb2pqr` clicando em **Save...** .

# Etapa 3: Protonação em pH de interesse
