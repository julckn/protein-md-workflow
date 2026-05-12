# Etapa 1: Download do modelo (RCSB PDB)

* Acesse ao banco de dados [RCSB PDB](https://www.rcsb.org/).
* Busca pelo código *5XL0* (mioglobina).
* Em **Download Files**, escolha o formato **Legacy PDB format**.

# Etapa 2: Pré-processamento da estrutura (PyMOL)

* Remova as moléculas de água (solvente): No painel superior direito clique em **A** (Action) > **remove** **waters**.
* Ative a barra de sequência: No canto inferior direito clique em **SEQ** (em versões mais atuais) ou **S** (em versões mais antigas).
* Remova os íons *SO4* e o grupo *HEME* (89R): No final da sequência selecione-os, em seguida no painel superior direito, na linha (sele) clique no botão **A** (Action) > **remove** **atoms**.
* Caso a estrutura original possua hidrogênios, remova-os: No painel superior direito clique em **A** (Action) > **hydrogens** > **remove**.
* Salve o arquivo final em **File** > **Export Structure...** > **Export Molecule...** > **Save...**  no formato `.pdb` para manter a compatibilidade com o servidor `pdb2pqr`.

**Automação via Console (PyMOL)**

Comandos para limpeza padronizada da estrutura via linha de comando:

```python
# 1. Defina o seu caminho onde os arquivos serão salvos
cd [caminho/da/sua/pasta]
# 2. Baixe a estrutura (async=0 garante que o PyMOL espere o download)
fetch 5XL0, async=0
# 3. Limpeza automática do sistema (remove águas, íons, ligantes e hidrogênios)
remove solvent
remove not polymer
remove hydrogens
# 4. Salva o arquivo final diretamente na pasta definida no passo 1
save 5XL0_clean.pdb
```

# Etapa 3: Protonação em pH de interesse (PDB2PQR/APBS)
1. Acesse ao servidor [PDB2PQR](https://server.poissonboltzmann.org/pdb2pqr) (APBS).
2. Faça o upload do arquivo .pdb (ex: *5XL0_clean.pdb*) gerado no Pymol.
3. Em **pKa Options**: Marque a opção `Use PROPKA to assign protonation states` e insira o pH desejado (ex: 7.0).
4. **Opções do Campo de Força (Crítico)**
* **Forcefield:** Selecione `CHARMM`.
* **Naming Scheme:** Selecione `Internal naming scheme`.
> [!IMPORTANT]
ALTERAÇÃO (Nota sobre Nomenclatura): Optamos pelo `Internal naming scheme` em vez de `CHARMM` para evitar a inserção de indicadores `TER` no arquivo de output `.prq`. Isso previne a interrupção do processo pela caixa de erro *"Unparametrized Components"* no AutoPSF (VMD) durante a montagem da caixa (**Etapa 4**).
5. Em **Additional Options**, deixe as seguintes caixas marcadas: `Ensure that new atoms are not rebuilt too close to existing atoms`, `Optimize the hydrogen bonding network` e `Remove the waters from the output file`.
6. Por fim clique em **Start Job** e, ao finalizar, baixe o arquivo com extensão `.pqr`.

**Próximos Passos: Entendendo os Arquivos de Estrutura**

Ao final desta etapa, você terá o arquivo PQR necessário para gerar no VMD o arquivo PDB (coordenadas) e o arquivo PSF (topologia).

Esses dois arquivos são complementares e essenciais para a construção do sistema. Sem o arquivo PSF, o software de simulação não saberá como os átomos devem interagir.
