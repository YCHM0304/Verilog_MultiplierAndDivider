module Product (
    input [31:0]ALU_Result,
    input [31:0]Multiplier_in,
    input SRL_ctrl,
    input W_ctrl,
    input Ready,
    input Reset,
    input clk,
    input ALU_Carry,
    output reg [63:0]Product_out,
    output LSB
);
always @(posedge clk, Reset, Ready, SRL_ctrl) begin
    if (Reset == 0 &&  W_ctrl == 1 && Ready == 0)begin
        Product_out = {ALU_Result,Product_out[31:0]};
        if(SRL_ctrl)Product_out = {ALU_Carry, Product_out[63:1]};
    end
    if(Reset == 1)Product_out = {32'b00000000000000000000000000000000, Multiplier_in};
    if(Ready == 1)Product_out = Product_out;
end
assign LSB = (Reset == 1)? 0: Product_out[0];
endmodule