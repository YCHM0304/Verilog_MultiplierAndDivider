module CompMultiplier (
	output [63:0]Product,
    output Ready,
    input [31:0]Multiplicand,
    input [31:0]Multiplier,
    input Run,
    input Reset,
    input clk
);
wire [31:0]Multiplicand_out;
wire [31:0]ALU_Result;
wire [5:0]ADDU_ctrl;
wire W_ctrl;
wire ALU_Carry;
wire SRL_ctrl;
wire LSB;
Multiplicand Multiplicand_Register(
		//	Inputs
		.Multiplicand_in(Multiplicand),
		.Reset(Reset),
        .W_ctrl(W_ctrl),
		//	Outputs
		.Multiplicand_out(Multiplicand_out)
	);

ALU Arithmetic_Logical_Unit(
		//	Inputs
		.Src1(Product[63:32]),
		.Src2(Multiplicand_out),
		.Funct(ADDU_ctrl),
		//	Outputs
		.Result(ALU_Result),
		.Carry(ALU_Carry)
	);

Product Product_Register(
        //	Inputs
		.ALU_Result(ALU_Result),
		.Multiplier_in(Multiplier),
		.SRL_ctrl(SRL_ctrl),
        .W_ctrl(W_ctrl),
		.Ready(Ready),
		.Reset(Reset),
        .clk(clk),
		.ALU_Carry(ALU_Carry),
		//	Outputs
		.Product_out(Product),
		.LSB(LSB)
    );

Control Control_Unit(
        //	Inputs
		.Run(Run),
        .Reset(Reset),
		.clk(clk),
		.LSB(LSB),
		//	Outputs
		.W_ctrl(W_ctrl),
		.ADDU_ctrl(ADDU_ctrl),
        .SRL_ctrl(SRL_ctrl),
		.Ready(Ready)
    );
endmodule