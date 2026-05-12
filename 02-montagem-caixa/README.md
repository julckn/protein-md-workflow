# Etapa 4: Montagem da Caixa de Simulação (VMD)

Nesta etapa, utilizamos o **VMD (Visual Molecular Dynamics)** para preparar o sistema proteico, gerar a topologia, adicionar o solvente (água), neutralizar a carga com íons e calcular os parâmetros de Condições Periódicas de Contorno (PBC).

## 4.1 Configurando o Diretório de Trabalho
Abra o **Tk Console** em `Extensions > Tk Console` e defina a pasta onde os arquivos serão salvos. 

> [!NOTE]
> Lembre-se de inverter as barras para `/` caso esteja trabalhando no Windows.

```tcl
cd D:/Caminho/Para/Sua/Pasta
```

## 4.2 Ajuste de Interface: Resolvendo Conflitos de Hidrogênios (PDB2PQR vs VMD)

Arquivos provenientes do servidor **PDB2PQR** podem conter geometrias de hidrogênio que o VMD interpreta incorretamente, disparando o erro fatal: `Error: atomsel: setbonds: too many bonds in bondlist (Maximum of 12 bonds)`.

Este erro ocorre porque o VMD tenta gerar automaticamente uma rede de ligações baseada na proximidade física dos átomos. Como alguns hidrogênios gerados externamente podem estar "sobrepostos" (com distâncias menores que o permitido), o software tenta criar conexões infinitas e trava o sistema.

Utilizaremos este protocolo para "limpar" a estrutura, removendo as coordenadas conflitantes e garantindo que o **AutoPSF** reconstrua os hidrogênios com geometria ideal, tornando o sistema estável para a simulação.

### Passo 1: Importação da estrutura e restrição de ligações (autobonds Off)

Para iniciar o procedimento, devemos carregar a molécula desativando a função de detecção automática de ligações (`autobonds off`). Isso permite que o VMD leia as coordenadas dos átomos sem tentar "adivinhar" ligações incorretas, evitando que o sistema trave ao encontrar hidrogênios sobrepostos.

Ainda no **Tk Console**, digite:

```tcl
mol new seu_arquivo.pqr autobonds off
```

### Passo 2: Remoção de hidrogênios e exportação do PDB

Nesta etapa, selecionaremos apenas os átomos pesados (noh) para gerar um novo arquivo PDB. Este procedimento descarta as coordenadas problemáticas de hidrogênio, mas mantém os nomes dos resíduos (ex: HSE, HSD) para a reconstrução correta da topologia.

```tcl
# Seleciona a proteína sem hidrogênios
set sel [atomselect top "protein and noh"]
# Exporta a seleção para um novo arquivo
$sel writepdb protein_clean.pdb
# Remove a estrutura da memória do VMD para evitar acúmulo de moléculas
mol delete top
```

## 4.3 Geração da Topologia e Reconstrução de Hidrogênios (AutoPSF)

Nesta etapa, utilizaremos o plugin **AutoPSF** para converter a lista de resíduos do seu PDB "limpo" em um arquivo de estrutura **PSF (Protein Structure File)** completo.

>***O que é a Topologia?***
>Enquanto o arquivo PDB armazena apenas as coordenadas espaciais $(x, y, z)$ , o arquivo PSF define a inteligência química do sistema: ligações, ângulos, diedros, massas e cargas parciais. O AutoPSF utiliza arquivos de topologia do campo de força **CHARMM36** para ler essas regras e reconstruir todos os hidrogênios descartados na etapa anterior com precisão geométrica.

### Passo 1: Abrir o Plugin e Configurar Topologias
No menu principal do VMD, acesse: `Extensions > Modeling > Automatic PSF Builder`.

Na janela que abrir, localize o painel *Topology files*.

Importante: O VMD carrega várias topologias por padrão. Para uma simulação de proteína sem ligantes, selecione e delete os arquivos desnecessários, mantendo apenas:
* `top_all36_prot.rtf` (Parâmetros de proteínas).
* `toppar_water_ions.str` (Parâmetros de água e íons).

### Passo 2: Geração da Estrutura
Clique em **Load input files** para carregar os parâmetros selecionados.
Clique no botão **I'm feeling lucky**. O plugin irá analisar a cadeia, identificar os terminais da proteína e reconstruir os átomos ausentes.
Uma mensagem de "Structure complete" aparecerá confirmando a criação dos novos arquivos.

###Passo 3: Verificação dos Arquivos GeradosO AutoPSF criará dois arquivos essenciais no seu diretório de trabalho:  protein_clean_autopsf.pdb: Sua proteína agora completa, com todos os hidrogênios posicionados corretamente.protein_clean_autopsf.psf: O arquivo de topologia estrutural necessário para o NAMD.
