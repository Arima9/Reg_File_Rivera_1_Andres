//Definition of the Register File Module
module Register_File
#(
    //Definition of the WordLenght and Address lenght
    parameter N = 32,
    parameter ADDR = 5
)
(
    //Inputs of the module that are defined by DR. Pizano
    input               clk,
    input               reset,
    input               Reg_Write_i,
    input   [ADDR-1:0]  Write_Register_i,
    input   [ADDR-1:0]  Read_Register_1_i,
    input   [ADDR-1:0]  Read_Register_2_i,
    input   [N-1:0]     Write_Data_i,

    output  [N-1:0]     Read_Data_1_o,
    output  [N-1:0]     Read_Data_2_o
);

//We need wires to make interconections between the decoder and the registers ands gates.
wire [2**ADDR-1:0] DecEnables;

//This is a Vector used to store all the values of all registers
wire [(2**ADDR)*N-1:0] Words;

//This generate block creates all the registers needed, and at the same time, conects their outputs to the vector Words
genvar i;
generate
    for(i = 0; i < 2**ADDR; i = i + 1) begin: REG
        //The register zero will store always a Zero value.
        if (i == 0)
            RegisterUnit #(.W(N)) R(.clk(clk), .rst(reset), .en(Reg_Write_i & DecEnables[i]), .D({N{1'b0}}), .Q(Words[(N-1+N*i):(0+N*i)]));
        //The rest of the registers will be propperly conected.
        else
            RegisterUnit #(.W(N)) R(.clk(clk), .rst(reset), .en(Reg_Write_i & DecEnables[i]), .D(Write_Data_i), .Q(Words[(N-1+N*i):(0+N*i)]));
    end
endgenerate

//Instanciation of the decoder and making the conections of its ports
DecoderUnit #(.LEN(ADDR)) Decoder(.Dir(Write_Register_i), .Sal(DecEnables));

//Instanciation of the Multiplexers that will drive the outputs.
//Notice that for both I pass them the vector Words, that contains the all the inputs concantenated
MultiplexerUnit #(.SEL(ADDR), .WORD(N)) Mux0(.DATAin(Words),.Select(Read_Register_1_i),.DATAout(Read_Data_1_o));
MultiplexerUnit #(.SEL(ADDR), .WORD(N)) Mux1(.DATAin(Words),.Select(Read_Register_2_i),.DATAout(Read_Data_2_o));

endmodule
