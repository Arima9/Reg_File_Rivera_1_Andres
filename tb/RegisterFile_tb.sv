`timescale 1ns/100ps
module RegisterFile_tb;
localparam WORD = 32;
localparam ADDR = 5;
logic Mclock, Mreset, RWenable_i;
logic [ADDR-1:0] WrRegAdd_i, ReadRegAdd_1, ReadRegAdd_2;
logic [WORD-1:0] WrData_i, RegDataOut_1, RegDataOut_2;

Register_File #(.N(WORD), .ADDR(ADDR)) RF(
    .clk(Mclock),
    .reset(Mreset),
    .Reg_Write_i(RWenable_i),
    .Write_Register_i(WrRegAdd_i),
    .Read_Register_1_i(ReadRegAdd_1),
    .Read_Register_2_i(ReadRegAdd_2),
    .Write_Data_i(WrData_i),
    .Read_Data_1_o(RegDataOut_1),
    .Read_Data_2_o(RegDataOut_2)
);

task Check_RF;
input [WORD-1:0] RF_output, RF_guide;
    
    if (RF_output != RF_guide) begin
        $display("Ha habido un error, se esperaba %d (%b).\n Se ha encontrado en su lugar %d (%b)."
        , RF_guide, RF_guide, RF_output,RF_output);
        $stop(1);
    end

endtask

initial begin: TB
enum {WRITE_RF, ASYNC_READ, ASYNC_RES, WR_ENABLE} STATES;
logic [WORD-1:0] testArr[2**ADDR];
int i,j;
Mclock = 1'b0;
Mreset = 1'b1;
RWenable_i =  1'b0;
WrRegAdd_i =  0;
ReadRegAdd_1 = 0;
ReadRegAdd_2 = 0;
WrData_i = 0;
for (i=0; i< 2**ADDR; i++)begin
    if (i == 0) testArr[i] = {WORD{1'b0}};
    else testArr[i] = $urandom;
end

//Testing the write, clock, WriteEnable and read asincronous
$display("Testing syncronous write with random values...");
STATES = WRITE_RF;
RWenable_i = 1'b1;
for (i=0; i< 2**ADDR; i++)begin
    WrData_i = testArr[i];
    WrRegAdd_i = i;
    #1; Mclock = ~Mclock;
    #1; Mclock = ~Mclock;
end
RWenable_i = 1'b0;
$display("Finished writing data into the RF...");

//Testing asincronous read and validating the data written in the registers
$display("Starting to test of asyncronous read...");
STATES = ASYNC_READ;
for (i = 0, j=2**ADDR-1; i < 2**ADDR; i++, j--)begin
            ReadRegAdd_1 = i;
            ReadRegAdd_2 = j;
            #1;
            Check_RF(RegDataOut_1, testArr[i]);
            Check_RF(RegDataOut_2, testArr[j]);
            #1;
end
$display("Data test passed...");

//Testing asincronous reset
$display("Testing asyncronous reset of RF...");
STATES = ASYNC_RES;
Mreset = ~Mreset;
#1;
Mreset = ~Mreset;
for (i = 0, j=2**ADDR-1; i < 2**ADDR; i++, j--)begin
            ReadRegAdd_1 = i;
            ReadRegAdd_2 = j;
            #1;
            Check_RF(RegDataOut_1, testArr[0]);
            Check_RF(RegDataOut_2, testArr[0]);
            #1;
end
$display("Asyncronous reset test has been completed...");

$display("Testing WriteRegister enable functionality...");
STATES = WR_ENABLE;
RWenable_i = 1'b0;
for (i=0; i< 2**ADDR; i++)begin
    WrData_i = testArr[i];
    WrRegAdd_i = i;
    ReadRegAdd_1 = i;
    ReadRegAdd_2 = i;
    #1; Mclock = ~Mclock;
    #1; Mclock = ~Mclock;
    Check_RF(RegDataOut_1, testArr[0]);
    Check_RF(RegDataOut_2, testArr[0]);

end
$display("Finished testing WriteRegister enable...");

$display("The simulation has been completed. Good Job...");
$stop(2);
end //initial TB
endmodule