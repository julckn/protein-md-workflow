# Etapa 1: Download do modelo (RCSB PDB)

* Acesse ao banco de dados [RCSB PDB](https://www.rcsb.org/).
* Busca pelo código *5XL0* (mioglobina).
* Em **Download Files**, escolha o formato **Legacy PDB format**.

# Etapa 2: Pré-processamento da estrutura (Pymol)

* Remova as moléculas de água (solvente): No painel superior direito clique em **A** (Action) > **remove** **waters**.
* Ative a barra de sequência: No canto inferior direito clique em **SEQ** (em versões mais atuais) ou **S** (em versões mais antigas).
* Remova os íons *SO4* e o grupo *HEME* (89R): No final da sequência selecione-os, em seguida no painel superior direito, na linha (sele) clique no botão **A** (Action) > **remove** **atoms**.
* Caso a estrutura original possua hidrogênios, remova-os: No painel superior direito clique em **A** (Action) > **hydrogens** > **remove**.
* Salve o arquivo final em **File** > **Export Structure...** > **Export Molecule...** > **Save...**  no formato `.pdb` para manter a compatibilidade com o servidor `pdb2pqr`.

# Etapa 3: Protonação em pH de interesse (PDB2PQR/APBS)
* Acesse ao servidor [PDB2PQR](https://server.poissonboltzmann.org/pdb2pqr) (APBS).
* Faça o upload do arquivo .pdb gerado no Pymol.
* Em **pKa Options**: Marque a opção `Use PROPKA to assign protonation states` e insira o pH desejado (ex: 7.0).
* Em **Forcefield Options** selecione `CHARMM` e `Internal naming scheme`.
