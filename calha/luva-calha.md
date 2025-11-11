# Extensão em "L" para Calha de Drenagem

## Descrição do Modelo

Este modelo cria uma extensão em formato "L" para calhas de drenagem, permitindo direcionar o fluxo de água para longe da estrutura.

---

## Estrutura

### 1. Perna Vertical (Encaixe na Calha)
- Encaixa diretamente na boca da calha existente
- **Dimensões:** 103mm (largura) × 50mm (profundidade) × 72mm (altura)
- Possui cavidade interna para inserir na calha
- **Espessura das paredes:** 2.5mm

### 2. Perna Horizontal (Túnel de Escoamento)
- Forma um canal que direciona a água para frente
- **Dimensões:** 103mm (largura) × 80mm (comprimento) × 30mm (altura)
- **FUNDO FECHADO:** impede vazamento pela parte inferior
- **TOPO ABERTO:** permite limpeza e visualização do fluxo
- **FRENTE ABERTA:** água sai livremente pela extremidade
- **Laterais fechadas** para conter o fluxo

---

## Fixação

- Dois buracos para parafusos (3.5mm) nas laterais
- Permite fixação segura em paredes ou estruturas
- Posição dos buracos configurável

---

## Parâmetros Configuráveis

| Parâmetro | Descrição | Valor Padrão |
|-----------|-----------|--------------|
| `largura_boca` | Largura da calha | 103mm |
| `altura_boca` | Altura do encaixe | 72mm |
| `profundidade_encaixe` | Quanto entra na calha | 50mm |
| `comprimento_tunel` | Extensão horizontal | 80mm |
| `altura_tunel` | Altura do canal | 30mm |
| `diametro_parafuso` | Tamanho do furo | 3.5mm |
| `espessura` | Espessura das paredes | 2.5mm |

---

## Funcionamento

```
Calha → Perna Vertical → Túnel Horizontal → Saída Frontal
```

A água flui da calha, entra pela perna vertical, passa pelo túnel horizontal e sai pela frente aberta, sendo direcionada para longe da estrutura.

---

## Impressão 3D

- ✅ Otimizado para impressão sem suportes
- ✅ Base plana na mesa de impressão
- ✅ Espessura de parede adequada (2.5mm)
- ✅ Parâmetros totalmente configuráveis

---

## Visualização

```
     [Calha]
        |
    [Perna Vertical]
        |
        └─────[Túnel Horizontal]─────→ (saída de água)
```