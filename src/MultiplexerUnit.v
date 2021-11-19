module MultiplexerUnit
#(
    parameter SEL = 2,
    parameter WORD = 8
)
(
    input   [(2**SEL)*WORD-1:0] DATAin,
    input   [SEL-1:0] Select,
    output  [WORD-1:0] DATAout
);

wire [WORD-1:0] Ddatas [2**SEL-1:0];

genvar i;
generate
for(i = 0; i < 2**SEL; i = i + 1)begin : Dat
    assign Ddatas[i] = DATAin[(WORD-1+WORD*i):(0+WORD*i)];
end
endgenerate

assign DATAout = Ddatas[Select];

endmodule