/*
Gridifnity Base Configurável
Este arquivo define quantidade de blocos na base do sistema Gridifnity.
Gridifnity é um sistema modular de blocos que permite a construção de estruturas personalizadas.
A configuração da base é feita através de variáveis que definem o número de blocos em
cada direção (X, Y).
*/

// Configuração da base
medida_bloco = 37.7; // Medida de cada bloco em mm

// Defina a espessura das linhas interna (entre os blocos) e a parte externa do sistema Gridifnity (bordas)
// Valores padrão: 4.3 mm espessura das linhas internas, 2.15 mm espessura externa
espessura_externa = 2.15; // Espessura externa do sistema Gridfinity
espessura_interna = 4.3; // Espessura das linhas entre os blocos

// Defina a altura da base do sistema Gridifnity
// Valor padrão: 4.1 mm
altura_base = 4.1; // Altura da base em mm

// Defina o número de blocos na base do sistema Gridifnity
// Valores padrão: 6 blocos em X e 5 blocos em Y
num_blocos_x = 6; // Número de blocos na direção X
num_blocos_y = 6; // Número de blocos na direção Y

// =========================================================
// Função para calcular a largura total da base
// =========================================================
function calcular_largura_total(num_blocos) = 
    (num_blocos * medida_bloco) + (2 * espessura_externa) + ((num_blocos - 1) * espessura_interna);

// =========================================================
// Módulo principal para criar a base Gridifnity
// =========================================================
module gridifnity_base() {
    largura_total_x = calcular_largura_total(num_blocos_x);
    largura_total_y = calcular_largura_total(num_blocos_y);
    
    difference() {
        // Criar o bloco sólido externo
        cube([largura_total_x, largura_total_y, altura_base]);
        
        // Remover os espaços internos para criar os blocos
        for (x = [0:num_blocos_x-1]) {
            for (y = [0:num_blocos_y-1]) {
                translate([
                    espessura_externa + (x * (medida_bloco + espessura_interna)),
                    espessura_externa + (y * (medida_bloco + espessura_interna)),
                    -0.5
                ]) {
                    cube([medida_bloco, medida_bloco, altura_base + 1]);
                }
            }
        }
    }
}

// =========================================================
// Gerar a base
// =========================================================
gridifnity_base();



