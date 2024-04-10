`define None	6'b100010
`define Addu	6'b001001
module ALU (
    input [31:0]Src1,
    input [31:0]Src2,
    input [5:0]Funct,
    output reg[31:0]Result,
    output reg Carry
);
always @(Src1, Src2, Funct) begin
    case (Funct)
        `Addu:	{Carry, Result} = Src2 + Src1;
		`None:	{Carry, Result} = {1'b0, Src1};
        default: {Carry, Result} = 0;
    endcase
end
endmodule