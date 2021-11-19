//Definition of the decoder module
module DecoderUnit
#(
    //The module will receive how many bits will be used to address the registers
    parameter LEN = 2
)
(
    //Input that indicates what bit is going to be 1
    input   [LEN-1:0]   Dir,
    //Output of the module
    output  [2**LEN-1:0] Sal

    //Both input and output lenghts are dependant of the parameter LEN
);

//This is a local constant of 1 used to design the decoder.
localparam [2**LEN-1:0]ONE = 'b1;

//As a decoder, only one bit will be one, so this determines which bit will be 1 in function fo the input.
assign Sal = ONE << Dir;

endmodule