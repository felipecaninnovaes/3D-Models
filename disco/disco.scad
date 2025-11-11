// ============================================
// Disco 3D - OpenSCAD Model
// ============================================

// Configurações globais
$fn = 100; // Resolução das curvas (aumentar para mais suavidade)

// Parâmetros do disco
DISC_LENGTH = 10;        // Comprimento do perfil do disco
DISC_WIDTH = 1.67;       // Largura da base
CORNER_MULTIPLIER = 3;   // Multiplicador para o canto arredondado (1.67 * 3 = 5mm)

// ============================================
// Módulo: punch
// Cria um perfil 2D com canto arredondado
// Parâmetros:
//   length - comprimento do perfil
//   width - largura da base (opcional)
// ============================================
module punch(length, width = DISC_WIDTH) {
    corner_width = width * CORNER_MULTIPLIER;
    corner_radius = corner_width / 2;
    
    translate([length, 0, 0])
    union() {
        // Canto arredondado (quadrante superior direito)
        intersection() {
            circle(r = corner_radius);
            polygon([
                [0, corner_radius],
                [0, -corner_radius],
                [corner_radius, -corner_radius],
                [corner_radius, corner_radius]
            ]);
        }
        
        // Retângulo principal
        polygon([
            [0, width/2],
            [0, -width/2],
            [-length, -width/2],
            [-length, width/2]
        ]);
    }
}

// ============================================
// Geração do modelo 3D
// ============================================
rotate_extrude(convexity = 10)
    punch(DISC_LENGTH);
