`define Subu    6'b001010
module Control (
    input Run,
    input Reset,
    input clk,
    output W_ctrl,
    output [5:0]SUBU_ctrl,
    output reg SRL_ctrl,
    output reg Ready
);

assign  W_ctrl = (SRL_ctrl)? 0: (Run)? 1: 0;
assign  SUBU_ctrl = (Run == 1)? `Subu: 0;
integer counter;
always @(posedge clk or Reset) begin
    if (Run == 1 && Reset == 0)begin
        if(counter < 32)begin
            Ready = 0;
            counter = counter + 1;
        end
        else if(counter == 32)begin
            SRL_ctrl = 1;
            counter = counter + 1;
        end
        else Ready = 1;
    end
    else if(Reset == 1)begin
        Ready = 0;
        SRL_ctrl = 0;
        counter = 1;
    end
end


endmodule