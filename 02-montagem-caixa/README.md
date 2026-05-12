# Etapa 4: Montagem da Caixa de Simulação (VMD)

Nesta etapa, utilizamos o **VMD (Visual Molecular Dynamics)** para preparar o sistema proteico, gerar a topologia, adicionar o solvente (água), neutralizar a carga com íons e calcular os parâmetros de Condições Periódicas de Contorno (PBC).

## 4.1 Configurando o Diretório de Trabalho
Abra o **Tk Console** em `Extensions` > `Tk Console` e defina a pasta onde os arquivos serão salvos. 

> [!NOTE]
> **Atenção usuários de Windows:** O VMD utiliza a sintaxe do Linux/Tcl. Você deve inverter as barras do seu caminho de \ para /. 

```tcl
# No VMD, use sempre barras inclinadas para a direita (/) mesmo no Windows
cd D:/Caminho/Para/Sua/Pasta
```

## 4.2 Ajuste de Interface: Resolvendo Conflitos de Hidrogênios (PDB2PQR vs VMD)

Arquivos provenientes do servidor **PDB2PQR** podem conter geometrias de hidrogênio que o VMD interpreta incorretamente, disparando o erro fatal: `Error: atomsel: setbonds: too many bonds in bondlist (Maximum of 12 bonds)`.

Este erro ocorre porque o VMD tenta gerar automaticamente uma rede de ligações baseada na proximidade física dos átomos. Como alguns hidrogênios gerados externamente podem estar "sobrepostos" (com distâncias menores que o permitido), o software tenta criar conexões infinitas e trava o sistema.

### Passo 1: Importação controlada da estrutura

Para evitar o travamento, carregamos a molécula desativando a detecção automática de ligações, evitando que o sistema trave ao encontrar hidrogênios sobrepostos.

Ainda no **Tk Console**, digite:

```tcl
# Importa o arquivo PQR desabilitando a busca automática de ligações para evitar travamentos por sobreposição atômica.
# O comando retorna o ID da molécula criada (ex: 0).
mol new seu_arquivo.pqr autobonds off
```

### Passo 2: Remoção de hidrogênios e exportação do PDB

Nesta etapa, selecionaremos apenas os átomos pesados (carbonos, oxigênios, etc.), descartando as coordenadas problemáticas de hidrogênio para que o **AutoPSF** as reconstrua corretamente.

```tcl
# 1. Seleciona a proteína ('all'), excluindo os hidrogênios ('noh' ou 'not hydrogen')
# O retorno 'atomselect0' indica o nome interno da seleção na memória.
set sel [atomselect top "all and noh"]
# 2. VERIFICAÇÃO CRÍTICA: Exibe o número de átomos selecionados (deve ser > 0)
# O comando [$sel num] acessa a seleção e conta quantos átomos ela possui
puts "Átomos selecionados: [$sel num]"
# 3. Exporta a seleção para um novo arquivo PDB limpo
$sel writepdb "protein_clean.pdb"
# 4. Remove a estrutura original da memória para evitar sobreposição
mol delete top
# 5. Carrega o novo arquivo limpo (ID 1)
mol new "protein_clean.pdb" type pdb
```

## 4.3 Geração da Topologia e Reconstrução de Hidrogênios (AutoPSF)

Nesta etapa, utilizaremos o plugin **AutoPSF** para converter a lista de resíduos do seu PDB "limpo" em um arquivo de estrutura **PSF (Protein Structure File)** completo.

>***O que é a Topologia?***
>Enquanto o arquivo PDB armazena apenas as coordenadas espaciais $(x, y, z)$ , o arquivo PSF define a inteligência química do sistema: ligações, ângulos, diedros, massas e cargas parciais. O AutoPSF utiliza arquivos de topologia do campo de força **CHARMM36** para ler essas regras e reconstruir todos os hidrogênios descartados na etapa anterior com precisão geométrica.

### Passo 1: Abrir o plugin e configurar topologias
No menu principal do VMD, acesse: `Extensions` > `Modeling` > `Automatic PSF Builder`.

Ao abrir a janela **AutoPSF**, localize o painel *Topology files* na seção **Step 1: Input and Output Files**.

**Importante:** O VMD carrega várias topologias por padrão. Para uma simulação de proteína sem ligantes (deste workflow), selecione e delete os arquivos desnecessários, mantendo apenas:
* `top_all36_prot.rtf` (Parâmetros de proteínas).
* `toppar_water_ions.str` (Parâmetros de água e íons).

### Passo 2: Geração da estrutura
1. Clique em **Load input files** para carregar os parâmetros selecionados.
2. Clique no botão **I'm feeling lucky**. O plugin irá analisar a cadeia, identificar os terminais da proteína e reconstruir os átomos ausentes.
3. Uma mensagem de *"Structure complete"* aparecerá confirmando a criação dos novos arquivos.

**Resultado esperado:** O VMD criará dois arquivos essenciais no diretório: 
* `protein_clean_autopsf.pdb`: proteína com todos os hidrogênios posicionados corretamente.
* `protein_clean_autopsf.psf`: arquivo de topologia necessário para o NAMD.

**Confirme se eles foram salvos na pasta de trabalho.**
