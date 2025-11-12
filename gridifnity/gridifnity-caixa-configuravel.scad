/*
Gridifnity Base Configurável
Este arquivo define quantidade de blocos da caixa do sistema Gridifnity.
Gridifnity é um sistema modular de blocos que permite a construção de estruturas personalizadas.
A configuração da caixa é feita através de variáveis que definem o número de blocos em
cada direção (X, Y).
Quando for mais de 1 bloco em X ou Y, a caixa espaçará os blocos de acordo com a espessura interna definida e os conectar.
O diâmetro da base será ajustável mas o padrão é 37 mm (medida do bloco padrão) pois a base é 37.7mm.
*/

// Configuração da caixa
medida_bloco = 42; // Medida de cada bloco em mm
tamanho_base = 37.2; // Tamanho da base quadrada de encaixe (encaixa no grid de 37.7mm)

// Defina a espessura das paredes da caixa
// Valores padrão: 2.0 mm para espessura das paredes, 2.0 mm para espessura do fundo
espessura_parede = 1.2; // Espessura das paredes da caixa
espessura_fundo = 3.0; // Espessura do fundo da caixa
altura_transicao = 2.5; // Altura da zona de transição suave
// Defina a espessura interna (espaçamento entre blocos quando múltiplos)
espessura_interna = 4.3; // Espessura das linhas entre os blocos

// Defina o número de blocos da caixa
// Valores padrão: 1 bloco em X e 1 bloco em Y
num_blocos_x = 2; // Número de blocos na direção X
num_blocos_y = 2; // Número de blocos na direção Y

// Defina a altura da caixa (altura útil interna)
altura_caixa = 30; // Altura útil da caixa em mm

// Raio de arredondamento dos cantos internos e externos
raio_canto = 3.5; // Raio de arredondamento dos cantos

// =========================================================
// Função para calcular a largura total da caixa
// =========================================================
function calcular_largura_total_caixa(num_blocos) = 
    (num_blocos * medida_bloco);

// =========================================================
// Função para calcular offset do bloco (posição central)
// =========================================================
function calcular_offset_bloco(indice) = 
    (medida_bloco / 2) + (indice * medida_bloco);

// =========================================================
// Módulo para criar uma base quadrada para encaixe
// =========================================================
module base_encaixe() {
    altura_base = 5; // Altura da base de encaixe
    tolerancia = 0.20; // Tolerância para encaixe
    raio_canto_base = 3.75; // Raio de arredondamento dos cantos da base
    
    // Base quadrada com cantos arredondados para encaixe
    hull() {
        translate([raio_canto_base, raio_canto_base, 0])
            cylinder(r=raio_canto_base, h=altura_base, $fn=32);
        translate([tamanho_base - tolerancia - raio_canto_base, raio_canto_base, 0])
            cylinder(r=raio_canto_base, h=altura_base, $fn=32);
        translate([raio_canto_base, tamanho_base - tolerancia - raio_canto_base, 0])
            cylinder(r=raio_canto_base, h=altura_base, $fn=32);
        translate([tamanho_base - tolerancia - raio_canto_base, tamanho_base - tolerancia - raio_canto_base, 0])
            cylinder(r=raio_canto_base, h=altura_base, $fn=32);
    }
}

// =========================================================
// Módulo para criar uma caixa com cantos arredondados
// =========================================================
module caixa_arredondada(largura, profundidade, altura, raio) {
    hull() {
        // Criar cilindros nos 4 cantos para arredondar
        translate([raio, raio, 0])
            cylinder(r=raio, h=altura, $fn=32);
        translate([largura - raio, raio, 0])
            cylinder(r=raio, h=altura, $fn=32);
        translate([raio, profundidade - raio, 0])
            cylinder(r=raio, h=altura, $fn=32);
        translate([largura - raio, profundidade - raio, 0])
            cylinder(r=raio, h=altura, $fn=32);
    }
}

// =========================================================
// Módulo principal para criar a caixa Gridifnity
// =========================================================
module gridifnity_caixa() {
    largura_total_x = calcular_largura_total_caixa(num_blocos_x);
    largura_total_y = calcular_largura_total_caixa(num_blocos_y);
    altura_total = altura_caixa + espessura_fundo;
    
    // Calcular dimensões
    // Cada bloco tem 42mm, as pontes internas têm espessura_interna
    largura_util = medida_bloco; // Largura de cada bloco (42mm)
    
    difference() {
        union() {
            // Criar as bases de encaixe para cada bloco
            for (x = [0:num_blocos_x-1]) {
                for (y = [0:num_blocos_y-1]) {
                    translate([
                        calcular_offset_bloco(x) - (tamanho_base / 2),
                        calcular_offset_bloco(y) - (tamanho_base / 2),
                        0
                    ]) {
                        base_encaixe();
                    }
                }
            }
            
            // Criar estrutura completa conectada (caixas + pontes integradas)
            // Primeiro: transições de cada base para a estrutura superior
            for (x = [0:num_blocos_x-1]) {
                for (y = [0:num_blocos_y-1]) {
                    hull() {
                        // Topo da base de encaixe
                        translate([
                            calcular_offset_bloco(x) - (tamanho_base / 2),
                            calcular_offset_bloco(y) - (tamanho_base / 2),
                            4.9
                        ]) {
                            hull() {
                                translate([3.75, 3.75, 0])
                                    cylinder(r=3.75, h=0.2, $fn=32);
                                translate([tamanho_base - 0.15 - 3.75, 3.75, 0])
                                    cylinder(r=3.75, h=0.2, $fn=32);
                                translate([3.75, tamanho_base - 0.15 - 3.75, 0])
                                    cylinder(r=3.75, h=0.2, $fn=32);
                                translate([tamanho_base - 0.15 - 3.75, tamanho_base - 0.15 - 3.75, 0])
                                    cylinder(r=3.75, h=0.2, $fn=32);
                            }
                        }
                        
                        // Início da estrutura superior (centrada no bloco)
                        translate([
                            calcular_offset_bloco(x) - (largura_util / 2),
                            calcular_offset_bloco(y) - (largura_util / 2),
                            5 + altura_transicao - 0.1
                        ])
                            caixa_arredondada(
                                largura_util, 
                                largura_util, 
                                0.2, 
                                raio_canto
                            );
                    }
                }
            }
            
            // Segundo: criar corpo sólido conectado
            // Calcular dimensão total (cada bloco é 42mm)
            largura_corpo_x = num_blocos_x * medida_bloco;
            largura_corpo_y = num_blocos_y * medida_bloco;
            
            translate([0, 0, 5 + altura_transicao])
                caixa_arredondada(
                    largura_corpo_x,
                    largura_corpo_y,
                    altura_total - 5 - altura_transicao,
                    raio_canto
                );
        }
        
        // Remover o interior da caixa (cavidade única, sem divisórias)
        largura_corpo_x = num_blocos_x * medida_bloco;
        largura_corpo_y = num_blocos_y * medida_bloco;
        
        translate([
            espessura_parede,
            espessura_parede,
            espessura_fundo + 5
        ])
            caixa_arredondada(
                largura_corpo_x - (2 * espessura_parede), 
                largura_corpo_y - (2 * espessura_parede), 
                altura_caixa + altura_transicao + 1, 
                raio_canto - espessura_parede
            );
    }
}

// =========================================================
// Gerar a caixa
// =========================================================
gridifnity_caixa();

