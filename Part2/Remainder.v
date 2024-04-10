module Remainder (
    input [31:0]ALU_Result,
    input [31:0]Dividend_in,
    input W_ctrl,
    input Ready,
    input Reset,
    input clk,
    input ALU_Carry,
    input SRL_ctrl,
    output reg [63:0]Remainder_out
);
//把ALU_Result放進來+存值+位移
always@(posedge W_ctrl)Remainder_out = Remainder_out << 1;
always@(posedge SRL_ctrl)Remainder_out[63:32] <= Remainder_out[63:32] >> 1;
always @(posedge clk, Reset, Ready) begin
    if (Reset == 0 &&  W_ctrl == 1 && Ready == 0)begin
        if(ALU_Carry)Remainder_out = Remainder_out << 1;
        else Remainder_out = {ALU_Result[30:0],Remainder_out[31:0], 1'b1};
    end
    if(Reset == 1)Remainder_out = {32'b00000000000000000000000000000000, Dividend_in};
    if(Ready == 1)Remainder_out = Remainder_out;
end
endmodule