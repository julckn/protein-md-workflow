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

Este erro ocorre porque o VMD tenta gerar automaticamente uma rede de ligações baseada na proximidade física dos átomos. Como alguns hidrogênios gerados externamente podem estar "sobrepostos" (com distâncias menores que o permitido), o software tenta criar conexões infinitas e trava o sistema.

Utilizaremos este protocolo para "limpar" a estrutura, removendo as coordenadas conflitantes e garantindo que o **AutoPSF** reconstrua os hidrogênios com geometria ideal, tornando o sistema estável para a simulação.



#### Passo 1: Importação da Estrutura e Restrição de Ligações (Autobonds Off)



Para iniciar o procedimento, devemos carregar a molécula desativando a função de detecção automática de ligações (`autobonds off`). Isso permite que o VMD leia as coordenadas dos átomos sem tentar "adivinhar" ligações incorretas, evitando que o sistema trave ao encontrar hidrogênios sobrepostos.

Ainda no **Tk Console**, digite:

```tcl
mol new seu_arquivo.pqr autobonds off
```


#### Passo 2: Remover Hidrogênios e Salvar Átomos Pesados

Utilizaremos este protocolo para higienizar a estrutura, removendo coordenadas de hidrogênio conflitantes enquanto preservamos a identidade química dos resíduos (como HSE e HSD). Isso garante que o AutoPSF reconstrua os hidrogênios "do zero" com geometria ideal, tornando a estrutura plenamente compatível com o campo de força escolhido.

Salvaremos apenas os átomos pesados (noh), preservando os nomes de resíduos (ex: HSE, HSD) definidos na protonação.

```tcl
set sel [atomselect top "protein and noh"]
$sel writepdb protein_clean.pdb
mol delete top
```

💡 Dica de Ouro: Ao usar o protein_clean.pdb no AutoPSF, o plugin consultará a topologia CHARMM36 e reconstruirá todos os hidrogênios seguindo regras químicas rigorosas, eliminando qualquer risco de instabilidade na simulação.
