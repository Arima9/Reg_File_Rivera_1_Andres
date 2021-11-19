//Definition of the Register module
module RegisterUnit
#(
    //Parameter that indicates the WordLenght of each register
    parameter W = 8
)(
    //Receive the clock signal, the reset and enable
    input                   clk, rst, en, 
    //Receives the input
    input       [W-1:0]     D,
    //Receives the output
    output reg  [W-1:0]     Q
);

//Here we use an Always block to design his behavior
always @(posedge clk or negedge rst)begin
    //If the reset input is Zero then the register will go to Zero
    if (!rst) Q <= {W{1'b0}};
    //If we have a posedge clk and the enable is high then the output will store the value in the input
    else if (en) Q <= D;
    //If the enable is zero and the reset is one, it mantain its previous value.
    else Q <= Q;
end

endmodule