module DecoderUnit
#(
    parameter LEN = 2
)
(
    input   [LEN-1:0]   Dir,
    output  [2**LEN-1:0] Sal 
);

assign Sal = {2**LEN{1'b1}} << Dir;

endmodule