module RegisterUnit
#(
    parameter W = 8
)(
    input                   clk, rst, en, 
    input       [W-1:0]     D,
    output reg  [W-1:0]     Q
);

always @(posedge clk or negedge rst)begin
    if (!rst) Q <= {W{1'b0}};
    else if (en) Q <= D;
    else Q <= Q;
end

endmodule