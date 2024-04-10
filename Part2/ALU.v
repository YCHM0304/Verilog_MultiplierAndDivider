`define None	6'b100010
`define Subu	6'b001010
module ALU (
    input [31:0]Src1,
    input [31:0]Src2,
    input [5:0]Funct,
    input clk,
    output reg[31:0]Result,
    output reg Carry
);
always @(Src1, Src2, Funct) begin
    case (Funct)
        `Subu:	{Carry, Result} = Src1 - Src2;
        default: {Carry, Result} = 0;
    endcase
end
endmodule