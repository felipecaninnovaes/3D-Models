// ============================================================
// CONEXÃO DE COMPRESSÃO - Chuveirinho
// Duas peças: VIROLA (rosca externa) + PORCA (rosca interna)
// ============================================================
//
// Montagem:
//   1) Cole a virola no corpo do chuveirinho (cola de PVC ou epóxi)
//   2) Antes de colocar a mangueira, enfie a porca por ela (rosca p/ fora)
//   3) Empurre a mangueira sobre o espigão
//   4) Rosqueie a porca na virola — o cone aperta a mangueira no espigão
//
// ------------------------------------------------------------

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [Selecionar peça para exportar] */
part = "ambas"; // [porca, virola, ambas]

/* [Mangueira] */
hose_od      = 10.0;  // Ø externo [mm]
hose_id      =  8.5;  // Ø interno [mm]

/* [Espigão do chuveirinho] */
barb_length  = 16.0;  // Comprimento do espigão [mm]
barb_ribs    =  3;    // Número de nervuras

/* [Corpo do chuveirinho] */
body_od      = 11.3;  // Ø do corpo onde a virola encaixa [mm]
body_fit     =  0.3;  // Folga do furo da virola — 0.1 press-fit / 0.3 cola [mm]

/* [Rosca entre virola e porca] */
thread_od    = 18.0;  // Ø externo da rosca [mm]
thread_pitch =  1.5;  // Passo [mm]
thread_len   = 10.0;  // Comprimento roscado [mm]

/* [Geometria] */
taper_angle  = 25;    // Ângulo do cone de compressão [graus]
hex_flats    = 24.0;  // Largura do hexágono entre faces planas [mm]
virola_grip  =  8.0;  // Comprimento da zona lisa da virola no corpo [mm]
chamfer      =  0.8;  // Chanfro nas arestas [mm]

/* [Tolerâncias] */
$slop = 0.25;  // Folga da rosca — aumente se travar (0.2–0.4)
$fn   = 72;

// --- Derivados ---
hex_circ  = hex_flats / cos(30);
hose_r    = hose_od / 2;
thread_r  = thread_od / 2;
taper_h   = (thread_r - hose_r) / tan(taper_angle);
porca_len = taper_h + thread_len;
virola_len = virola_grip + thread_len;

echo(str("=== PORCA: comprimento total = ", porca_len, " mm | cone = ", taper_h, " mm"));
echo(str("=== VIROLA: comprimento total = ", virola_len, " mm"));


// ============================================================
// PORCA DE COMPRESSÃO
// ============================================================
module compression_nut() {
    diff() {
        cyl(h=porca_len, d=hex_circ, $fn=6, chamfer=chamfer, anchor=BOTTOM);

        tag("remove") {
            // Canal passante para a mangueira
            cyl(h=porca_len + 1, d=hose_od, anchor=BOTTOM);

            // Cone de compressão — entrada inferior (mangueira entra aqui)
            cyl(h=taper_h + 0.01,
                d1=(hose_r + taper_h * tan(taper_angle) + chamfer) * 2,
                d2=hose_od,
                anchor=BOTTOM);

            // Rosca interna ISO (BOSL2 aplica $slop automaticamente)
            up(taper_h)
            threaded_rod(d=thread_od, pitch=thread_pitch, l=thread_len + 0.1,
                         shape="iso", internal=true, anchor=BOTTOM);

            // Chanfro de entrada no topo — facilita iniciar o rosqueamento
            up(porca_len - chamfer)
            cyl(h=chamfer + 0.1, d1=thread_od, d2=thread_od + chamfer * 2,
                anchor=BOTTOM);
        }
    }
}


// ============================================================
// VIROLA — cola no chuveirinho, tem rosca externa para a porca
// ============================================================
module collar() {
    difference() {
        union() {
            // Zona de grip — hexagonal, encaixa no corpo do chuveirinho
            cyl(h=virola_grip, d=hex_circ, $fn=6, chamfer=chamfer, anchor=BOTTOM);

            // Zona roscada — rosca externa ISO para receber a porca
            up(virola_grip)
            threaded_rod(d=thread_od, pitch=thread_pitch, l=thread_len,
                         shape="iso", anchor=BOTTOM);
        }

        // Furo central para o corpo do chuveirinho
        cyl(h=virola_len + 0.1, d=body_od + body_fit * 2, anchor=BOTTOM);

        // Chanfro de entrada no furo (facilita encaixar no chuveirinho)
        cyl(h=chamfer + 0.1,
            d1=body_od + chamfer * 2, d2=body_od,
            anchor=BOTTOM);
    }
}


// ============================================================
// RENDER
// ============================================================
if (part == "porca") {
    compression_nut();
} else if (part == "virola") {
    collar();
} else {
    // Exibe as duas peças lado a lado para visualização
    compression_nut();
    right(hex_circ + 4) collar();
}


// Seção transversal — descomente para visualizar o interior:
// difference() {
//     if (part == "porca") compression_nut(); else collar();
//     translate([-50, 0, -1]) cube([100, 100, 60]);
// }
