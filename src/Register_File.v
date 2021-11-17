module Register_File
#(
    parameter N = 32,
    parameter ADDR = 5
)
(
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

wire [2**ADDR-1:0] DecEnables;
wire [N-1:0]  Words [2**ADDR-1:0];

genvar i;
generate
    for(i = 0; i < 2**ADDR; i = i + 1) begin: REG
        if (i == 0)
            RegisterUnit R(.clk(clk), .rst(reset), .en(Reg_Write_i & DecEnables[i]), .D({N{1'b0}}), .Q(Words[i]));
        else
            RegisterUnit R(.clk(clk), .rst(reset), .en(Reg_Write_i & DecEnables[i]), .D(Write_Data_i), .Q(Words[i]));
    end
endgenerate

DecoderUnit #(.LEN(ADDR)) Decoder(.Dir(Write_Register_i), .Sal(DecEnables));
MultiplexerUnit #(.W(N), .S(ADDR)) Mux0(.DATAin(Words[2**ADDR-1:0]), .Select(Read_Register_1_i), .DATAout(Read_Data_1_o));
MultiplexerUnit #(.W(N), .S(ADDR)) Mux1(.DATAin(Words[2**ADDR-1:0]), .Select(Read_Register_2_i), .DATAout(Read_Data_2_o));


//First Description behavioral of the RF
/* reg [N-1:0] RF [2**ADDR-1:0];

assign Read_Data_1_o = RF[Read_Register_1_i];
assign Read_Data_2_o = RF[Read_Register_2_i];

integer i;
always @(posedge clk or negedge reset) begin
    if (!reset) for(i=0; i < 2**ADDR; i= i+1) RF[i] <= {(N-1){1'b0}};
    else if (Reg_Write_i) RF [Write_Register_i] <= Write_Data_i;
end
 */
endmodule