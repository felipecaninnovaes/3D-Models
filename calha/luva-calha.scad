// Extensão em "L" para calha 72.0mm X 101.35mm
// Projeto: Túnel em L com fundo fechado e frente aberta para água escoar
//
// ========== DESCRIÇÃO DO MODELO ==========
// Este modelo cria uma extensão em formato "L" para calhas de drenagem.
//
// ESTRUTURA:
// 1. PERNA VERTICAL (Encaixe na calha):
//    - Encaixa diretamente na boca da calha existente
//    - Dimensões: 103mm (largura) x 50mm (profundidade) x 72mm (altura)
//    - Possui cavidade interna para inserir na calha
//    - Espessura das paredes: 2.5mm
//
// 2. PERNA HORIZONTAL (Túnel de escoamento):
//    - Forma um canal que direciona a água para frente
//    - Dimensões: 103mm (largura) x 80mm (comprimento) x 30mm (altura)
//    - FUNDO FECHADO: impede vazamento pela parte inferior
//    - TOPO ABERTO: permite limpeza e visualização do fluxo
//    - FRENTE ABERTA: água sai livremente pela extremidade
//    - Laterais fechadas para conter o fluxo
//
// FIXAÇÃO:
// - Dois buracos para parafusos (3.5mm) nas laterais
// - Permite fixação segura em paredes ou estruturas
// - Posição dos buracos configurável
//
// PARÂMETROS CONFIGURÁVEIS:
// - largura_boca: largura da calha (103mm)
// - altura_boca: altura do encaixe (72mm)
// - profundidade_encaixe: quanto entra na calha (50mm)
// - comprimento_tunel: extensão horizontal (80mm)
// - altura_tunel: altura do canal (30mm)
// - diametro_parafuso: tamanho do furo (3.5mm)
// - espessura: espessura das paredes (2.5mm)
//
// FUNCIONAMENTO:
// A água flui da calha → entra pela perna vertical → passa pelo túnel horizontal
// → sai pela frente aberta, sendo direcionada para longe da estrutura
//
// IMPRESSÃO 3D:
// - Otimizado para impressão sem suportes
// - Base plana na mesa de impressão
// - Espessura de parede adequada (2.5mm)
// =========================================

// ========== PARÂMETROS ==========
// Dimensões da boca da calha (para encaixe traseiro)
largura_boca = 103.0;  // mm (lado maior da calha)
altura_boca = 72.0; // mm (lado menor da calha)

// Espessura da parede
espessura = 2.5; // mm

// Profundidade do encaixe na calha (perna vertical do L)
profundidade_encaixe = 50; // mm - quanto entra na boca da calha

// Comprimento do túnel horizontal (perna horizontal do L)
comprimento_tunel = 80; // mm - extensão para frente

// Largura interna do túnel
largura_interna = largura_boca; // mantém a mesma largura

// Altura interna do túnel (CONFIGURÁVEL - altura do canal do L)
altura_tunel = 30; // mm - altura do canal (desacoplado das outras dimensões)

// Folga para encaixe na calha
folga = 0.5; // mm - folga em cada lado

// Parâmetros para buracos de parafuso
diametro_parafuso = 3.5; // mm - diâmetro do buraco para parafuso
posicao_parafuso_y = -25; // mm - posição do parafuso ao longo do túnel (a partir do início)
posicao_parafuso_z = 30; // mm - altura do parafuso na lateral (a partir do fundo)

// ========== CÁLCULOS ==========
// Dimensões externas do túnel
largura_externa = largura_interna + (2 * espessura);
altura_externa_tunel = altura_tunel + espessura; // altura do túnel (fundo fechado + canal)

// Altura da perna vertical (independente do túnel)
altura_perna_vertical = altura_boca; // mantém a altura da boca da calha

// ========== MODELO ==========
rotate([0, 0, 0])  // Rotaciona para posição de impressão
difference() {
    union() {
        // PERNA VERTICAL DO L (parte traseira que encaixa na calha)
        difference() {
            // Bloco externo da perna vertical
            cube([largura_externa, profundidade_encaixe, altura_perna_vertical]);
            
            // Cavidade interna da perna vertical
            translate([espessura, espessura, espessura])
                cube([largura_interna, profundidade_encaixe + 0.1, altura_perna_vertical - espessura]);
        }
        
        // PERNA HORIZONTAL DO L (túnel com frente toda aberta saindo horizontalmente)
        translate([0, profundidade_encaixe, 0]) {
            // Fundo do túnel
            cube([largura_externa, comprimento_tunel, espessura]);
            
            // Lateral esquerda
            cube([espessura, comprimento_tunel, altura_externa_tunel]);
            
            // Lateral direita
            translate([largura_externa - espessura, 0, 0])
                cube([espessura, comprimento_tunel, altura_externa_tunel]);
        }
    }
    
    // Buracos para parafusos nas laterais
    // Buraco na lateral esquerda
    translate([-0.1, profundidade_encaixe + posicao_parafuso_y, posicao_parafuso_z])
        rotate([0, 90, 0])
            cylinder(h = espessura + 0.2, d = diametro_parafuso, $fn = 32);
    
    // Buraco na lateral direita
    translate([largura_externa - espessura - 0.1, profundidade_encaixe + posicao_parafuso_y, posicao_parafuso_z])
        rotate([0, 90, 0])
            cylinder(h = espessura + 0.2, d = diametro_parafuso, $fn = 32);
}

// ========== INFORMAÇÕES ==========
echo("=================================");
echo("TÚNEL EM 'L' PARA CALHA");
echo("=================================");
echo(str("Dimensões da calha: ", largura_boca, " x ", altura_boca, " mm"));
echo(str("Profundidade encaixe (perna vertical): ", profundidade_encaixe, " mm"));
echo(str("Comprimento túnel (perna horizontal): ", comprimento_tunel, " mm"));
echo(str("Altura do túnel (canal do L): ", altura_tunel, " mm"));
echo(str("Canal interno: ", largura_interna, " x ", altura_tunel, " mm"));
echo(str("Espessura da parede: ", espessura, " mm"));
echo(str("Buracos para parafuso: diâmetro ", diametro_parafuso, "mm"));
echo("Formato: L com FUNDO FECHADO e TOPO ABERTO (tipo calha)");
echo("Água entra pela conexão com a calha e sai pela frente aberta");
echo("=================================");
