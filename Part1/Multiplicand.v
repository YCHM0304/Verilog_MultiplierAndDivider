module Multiplicand (
    input [31:0]Multiplicand_in,
    input Reset,
    input W_ctrl,
    output [31:0]Multiplicand_out
);
reg [31:0]Multiplicand_temp;
always@(Multiplicand_in)begin
    if(Reset)Multiplicand_temp = Multiplicand_in;
end
assign Multiplicand_out = (W_ctrl == 1)? Multiplicand_temp: 0;
endmodule