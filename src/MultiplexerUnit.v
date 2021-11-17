module MultiplexerUnit
#(
    parameter W = 8,
    parameter S = 2 
)
(
    input   [W-1:0] DATAin [2**S-1:0],
    input   [S-1:0] Select,
    output  [W-1:0] DATAout
);

assign DATAout = DATAin[Select];

endmodule