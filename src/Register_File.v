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
reg [N-1:0] RF [2**ADDR-1:0];

assign Read_Data_1_o = RF[Read_Register_1_i];
assign Read_Data_2_o = RF[Read_Register_2_i];

integer i;
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        for(i=0; i < 2**ADDR; i= i+1) RF[i] <= {(N-1){1'b0}};
    end
    else if (Reg_Write_i) RF [Write_Register_i] <= Write_Data_i;
end

endmodule