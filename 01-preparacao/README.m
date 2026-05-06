# Etapa 1: Preparação da Estrutura e Protonação

Nesta fase, preparamos o arquivo PDB bruto para a simulação, garantindo que a proteína esteja corretamente protonada no pH de interesse (ex: pH 7.0).

## 1. Limpeza da Estrutura (Retirada de Hidrogênios)
É necessário remover os hidrogênios originais do PDB para que o servidor de protonação possa reconstruí-los de acordo com o campo de força.
* **Ferramenta:** UCSF Chimera
* **Ação:** `Select > Chemistry > element > H` e depois `Actions > Atoms/Bonds > delete`.

## 2. Protonação em pH de Interesse
Utilizamos o servidor **PDB2PQR** para adicionar os hidrogênios e atribuir estados de ionização adequados.
* **Campo de Força:** Recomenda-se o uso do **CHARMM** (para ser compatível com o NAMD posterior).
* **Configuração:** Marque a opção de usar o **PROPKA** para calcular os pKa dos resíduos.

![Resultado do PDB2PQR](imagem-dos-resultados.png)
