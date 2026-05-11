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

**Automação via Console (PyMOL)**

Se preferir, você pode obter o mesmo resultado executando os comandos abaixo diretamente no console do PyMOL:

```python
# 1. Defina o seu caminho onde os arquivos serão salvos
cd [caminho/da/sua/pasta/de/trabalho]
# 2. Baixa a estrutura
fetch 5XL0, async=0
# 3. Limpeza automática do sistema
remove solvent
remove not polymer
remove hydrogens
# 4. Salva o arquivo final diretamente na pasta definida no passo 1
save 5XL0_clean.pdb
```

# Etapa 3: Protonação em pH de interesse (PDB2PQR/APBS)
* Acesse ao servidor [PDB2PQR](https://server.poissonboltzmann.org/pdb2pqr) (APBS).
* Faça o upload do arquivo .pdb gerado no Pymol.
* Em **pKa Options**: Marque a opção `Use PROPKA to assign protonation states` e insira o pH desejado (ex: 7.0).
* Em **Forcefield Options** selecione `CHARMM` e `Internal naming scheme`.
* Em **Additional Options**, deixe as seguintes caixas marcadas: `Ensure that new atoms are not rebuilt too close to existing atoms`, `Optimize the hydrogen bonding network` e `Remove the waters from the output file`.
* Clique em **Start Job** e, ao finalizar, baixe o arquivo com extensão `.pqr`.
