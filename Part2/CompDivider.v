module CompDivider (
	output [31:0]Remainder,
	output [31:0]Quotient,
    output Ready,
    input [31:0]Divisor,
    input [31:0]Dividend,
    input Run,
    input Reset,
    input clk
);
wire [31:0]ALU_Result;
wire [5:0]SUBU_ctrl;
wire [31:0]Divisor_out;
wire ALU_Carry;
wire W_ctrl;
wire MSB;
wire SRL_ctrl;
//wire SLL_ctrl;
Divisor Divisor_Register(
		//	Inputs
		.Divisor_in(Divisor),
		.Reset(Reset),
        .W_ctrl(W_ctrl),
		//	Outputs
		.Divisor_out(Divisor_out)
	);

ALU Artithmetic_Logical_Unit(
		//	Inputs
		.Src1(Remainder),
		.Src2(Divisor_out),
		.Funct(SUBU_ctrl),
		.clk(clk),
		//	Outputs
		.Result(ALU_Result),
		.Carry(ALU_Carry)
	);

Remainder Remainder_Register(
        //	Inputs
		.ALU_Result(ALU_Result),
		.Dividend_in(Dividend),
        .W_ctrl(W_ctrl),
		.Ready(Ready),
		.Reset(Reset),
        .clk(clk),
		.ALU_Carry(ALU_Carry),
		.SRL_ctrl(SRL_ctrl),
		//	Outputs
		.Remainder_out({Remainder, Quotient})
    );

Control Control_Unit(
        //	Inputs
		.Run(Run),
        .Reset(Reset),
		.clk(clk),
		//	Outputs
		.W_ctrl(W_ctrl),
		.SUBU_ctrl(SUBU_ctrl),
		.Ready(Ready),
		.SRL_ctrl(SRL_ctrl)
    );
endmodule