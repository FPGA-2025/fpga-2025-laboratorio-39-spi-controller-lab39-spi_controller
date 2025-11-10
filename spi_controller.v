/*
============================================================
| TABELA DE MODOS SPI (CPOL/CPHA)                          |
============================================================
| Modo | CPOL | CPHA | Clock Inativo  | Leitura (MISO)    | Escrita (MOSI)     |
|------|------|------|----------------|-------------------|--------------------|
|  0   |  0   |  0   |   Nível baixo  | Borda de subida   | Borda de descida   |
|  1   |  0   |  1   |   Nível baixo  | Borda de descida  | Borda de subida    |
|  2   |  1   |  0   |   Nível alto   | Borda de descida  | Borda de subida    |
|  3   |  1   |  1   |   Nível alto   | Borda de subida   | Borda de descida   |
------------------------------------------------------------

Definições:
- CPOL (Polaridade do Clock):
    0 = Clock inativo em nível baixo
    1 = Clock inativo em nível alto

- CPHA (Fase do Clock):
    0 = Dados são amostrados na primeira borda, enviados na segunda
    1 = Dados são enviados na primeira borda, amostrados na segunda

Temporização:
- Leitura (MISO): quando o mestre lê o dado vindo do escravo
- Escrita (MOSI): quando o mestre envia o dado ao escravo

Este módulo ajusta seu comportamento automaticamente com base no SPI_MODE.
============================================================
*/


module SPI_Controller #(
    parameter SPI_BITS_PER_WORD = 8,
    parameter SPI_MODE          = 0,          // 0: CPOL=0, CPHA=0; 1: CPOL=0, CPHA=1; 2: CPOL=1, CPHA=0; 3: CPOL=1, CPHA=1
    parameter SPI_CLK_FREQ      = 1_000_000,  // 1MHz
    parameter SYS_CLK_FREQ      = 25_000_000  // 25MHz
) (
    input  wire clk,
    input  wire rst,

    output reg  sck,
    output reg  mosi,
    input  wire miso,

    output reg  cs,

    input  wire data_in_valid,
    output reg  data_out_valid,

    input  wire [SPI_BITS_PER_WORD-1:0] data_in,
    output reg  [SPI_BITS_PER_WORD-1:0] data_out,

    output reg  busy
);

    localparam CPOL = (SPI_MODE == 2 || SPI_MODE == 3);
    localparam CPHA = (SPI_MODE == 1 || SPI_MODE == 3);

endmodule
