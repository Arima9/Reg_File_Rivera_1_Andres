module DecoderUnit
#(
    parameter LEN = 2
)
(
    input   [LEN-1:0]   Dir,
    output  [2**LEN-1:0] Sal 
);

localparam [2**LEN-1:0]ONE = 'b1;

assign Sal = ONE << Dir;

endmodule