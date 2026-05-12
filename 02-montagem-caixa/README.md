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
# O retorno '0' no console indica o ID (identificador) da molécula carregada com sucesso.
mol new seu_arquivo.pqr autobonds off
```

### Passo 2: Remoção de hidrogênios e exportação do PDB

Nesta etapa, selecionaremos apenas os átomos pesados (noh) para gerar um novo arquivo PDB. Este procedimento descarta as coordenadas problemáticas de hidrogênio, mas mantém os nomes dos resíduos (ex: HSE, HSD) para a reconstrução correta da topologia.

```tcl
# 1. Seleciona a proteína ('all'), excluindo os hidrogênios ('noh' ou 'not hydrogen')
# O retorno 'atomselect0' indica o nome interno que o VMD deu a este grupo de átomos na memória
set sel [atomselect top "all and noh"]
# 2. VERIFICAÇÃO CRÍTICA: Exibe o número de átomos selecionados (deve ser maior que 0)
# O comando [$sel num] acessa a seleção e conta quantos átomos ela possui
puts "Átomos selecionados: [$sel num]"
# 3. Exporta a seleção para um novo arquivo PDB limpo
$sel writepdb "protein_clean.pdb"
# 4. Remove a estrutura original da memória para limpar a área de visualização e evitar sobreposição
mol delete top
# 5. Carrega o novo arquivo limpo (este será usado como base para o AutoPSF)
# O retorno '1' indica que esta é a nova molécula ativa na sessão (ID 1)
mol new "protein_clean.pdb" type pdb
```

## 4.3 Geração da Topologia e Reconstrução de Hidrogênios (AutoPSF)

Nesta etapa, utilizaremos o plugin **AutoPSF** para converter a lista de resíduos do seu PDB "limpo" em um arquivo de estrutura **PSF (Protein Structure File)** completo.

>***O que é a Topologia?***
>Enquanto o arquivo PDB armazena apenas as coordenadas espaciais $(x, y, z)$ , o arquivo PSF define a inteligência química do sistema: ligações, ângulos, diedros, massas e cargas parciais. O AutoPSF utiliza arquivos de topologia do campo de força **CHARMM36** para ler essas regras e reconstruir todos os hidrogênios descartados na etapa anterior com precisão geométrica.

### Passo 1: Abrir o plugin e configurar topologias
No menu principal do VMD, acesse: `Extensions > Modeling > Automatic PSF Builder`.

Ao abrir a janela **AutoPSF**, localize o painel *Topology files* na seção **Step 1: Input and Output Files**.

**Importante:** O VMD carrega várias topologias por padrão. Para uma simulação de proteína sem ligantes (deste workflow), selecione e delete os arquivos desnecessários, mantendo apenas:
* `top_all36_prot.rtf` (Parâmetros de proteínas).
* `toppar_water_ions.str` (Parâmetros de água e íons).
* 
### Passo 2: Geração da estrutura
1. Clique em **Load input files** para carregar os parâmetros selecionados.
2. Clique no botão **I'm feeling lucky**. O plugin irá analisar a cadeia, identificar os terminais da proteína e reconstruir os átomos ausentes.
3. Uma mensagem de "Structure complete" aparecerá confirmando a criação dos novos arquivos.

**Resultado esperado:** O VMD criará dois arquivos essenciais no diretório: 
* `protein_clean_autopsf.pdb`: Sua proteína agora completa, com todos os hidrogênios posicionados corretamente.
* `protein_clean_autopsf.psf`: O arquivo de topologia estrutural necessário para o NAMD.

**Confirme se eles foram salvos na pasta de trabalho.**
