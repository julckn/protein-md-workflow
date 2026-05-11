# Etapa 2: Montagem da Caixa de Simulação (VMD)

Nesta etapa, utilizamos o **VMD (Visual Molecular Dynamics)** para preparar o sistema proteico, gerar a topologia, adicionar o solvente (água), neutralizar a carga com íons e calcular os parâmetros de Condições Periódicas de Contorno (PBC).

## 1. Configurando o Diretório de Trabalho
Abra o **Tk Console** em `Extensions > Tk Console` e defina a pasta onde os arquivos serão salvos. 
> **Dica para Windows:** Lembre-se de inverter as barras para `/`.

```tcl
cd D:/Caminho/Para/Sua/Pasta
```

## 2. Pré-tratamento: Resolvendo Conflitos de Hidrogênios (PDB2PQR vs VMD)

Arquivos vindos de servidores externos como o **PDB2PQR** podem conter geometrias de hidrogênio que o VMD interpreta incorretamente, gerando o erro fatal **`Maximum of 12 bonds`** (ou `too many bonds in bondlist`). Utilizaremos este protocolo para "limpar" a estrutura, garantindo que o **AutoPSF** reconstrua os hidrogênios com precisão atômica.

Utilizaremos este protocolo para "limpar" a estrutura, garantindo que o AutoPSF reconstrua os hidrogênios com precisão atômica seguindo o campo de força CHARMM36.
Passo 1: Carregar com trava de segurança

Este comando impede o VMD de tentar adivinhar ligações incorretas baseadas em proximidade física.

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
