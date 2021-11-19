//Definition of the module Multiplexer
module MultiplexerUnit
#(
    //The module receive the number of bits that will be used to select the entry of data.
    parameter SEL = 2,
    //Also receives the number of bits of each element of the input
    parameter WORD = 8
)
(
    //Vector of input that will contain all the inputs.
    input   [(2**SEL)*WORD-1:0] DATAin,
    //Bits of selection for the multiplexer
    input   [SEL-1:0] Select,
    //Output of the module, is the same wordlenght that the input
    output  [WORD-1:0] DATAout
);

//Here we define a wire array to get an easier multiplexor design
wire [WORD-1:0] Ddatas [2**SEL-1:0];

//This "Generate" block "Unpacks" the input and separate the data into Ddatas
genvar i;
generate
    //I treated the DATAin as "Packed", merging all the inputs into a vector, and here I separate this vector
    //and I convert it to an array. This is neccesary because verilog does not support Bidimensional arrays as ports.
    for(i = 0; i < 2**SEL; i = i + 1)begin : Dat
        assign Ddatas[i] = DATAin[(WORD-1+WORD*i):(0+WORD*i)];
    end
endgenerate

//Thanks to the convertion of the vector to an array, I can desing easily a multiplexer, usign an array and the Select
// to indicate the position that I want to transfer to the output.
assign DATAout = Ddatas[Select];

endmodule