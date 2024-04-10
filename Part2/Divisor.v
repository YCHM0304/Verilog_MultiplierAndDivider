module Divisor (
    input [31:0]Divisor_in,
    input Reset,
    input W_ctrl,
    output [31:0]Divisor_out
);
reg [31:0]Divisor_temp;
always@(Divisor_in)begin
    if(Reset)Divisor_temp = Divisor_in;
end
assign Divisor_out = (W_ctrl == 1)? Divisor_temp: 0;
endmodule