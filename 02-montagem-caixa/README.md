# Etapa 4: Montagem da Caixa de Simulação (VMD)

Nesta etapa, utilizamos o **VMD (Visual Molecular Dynamics)** para preparar o sistema proteico, gerar a topologia, adicionar o solvente (água), neutralizar a carga com íons e calcular os parâmetros de Condições Periódicas de Contorno (PBC).

## 4.1. Configurando o Diretório de Trabalho
Abra o **Tk Console** em `Extensions > Tk Console` e defina a pasta onde os arquivos serão salvos. 
> **Dica para Windows:** Lembre-se de inverter as barras para `/`.

```tcl
cd D:/Caminho/Para/Sua/Pasta
```

## 4.2. Ajuste de Interface: Resolvendo Conflitos de Hidrogênios (PDB2PQR vs VMD)

Arquivos provenientes do servidor **PDB2PQR** podem conter geometrias de hidrogênio que o VMD interpreta incorretamente, disparando o erro fatal: `Error: atomsel: setbonds: too many bonds in bondlist (Maximum of 12 bonds)`.

Este erro ocorre porque, ao abrir um arquivo, o VMD tenta gerar automaticamente uma rede de ligações baseada na proximidade física dos átomos. Como hidrogênios protonados externamente podem estar "sobrepostos" na visão do software, ele tenta criar conexões infinitas e trava o sistema.

Utilizaremos este protocolo para "limpar" a estrutura, garantindo que o **AutoPSF** reconstrua os hidrogênios com precisão atômica, tornando a estrutura compatível com o campo de força escolhido para a simulação.

Passo 1: Importação da Estrutura e Restrição de Ligações (Autobonds Off)

Para iniciar o procedimento, devemos carregar a molécula desativando a função de detecção automática de ligações (`autobonds off`). Isso permite que o VMD leia as coordenadas dos átomos sem tentar "adivinhar" ligações incorretas, evitando que o sistema trave ao encontrar hidrogênios sobrepostos.

Ainda no Tk Console, digite:

```tcl
mol new seu_arquivo.pqr autobonds off
```

Passo 2: Remover Hidrogênios e Salvar Átomos Pesados

Salvaremos apenas os átomos pesados (noh), preservando os nomes de resíduos (ex: HSE, HSD) definidos na protonação.

```tcl
set sel [atomselect top "protein and noh"]
$sel writepdb protein_clean.pdb
mol delete top
```

💡 Dica de Ouro: Ao usar o protein_clean.pdb no AutoPSF, o plugin consultará a topologia CHARMM36 e reconstruirá todos os hidrogênios seguindo regras químicas rigorosas, eliminando qualquer risco de instabilidade na simulação.
