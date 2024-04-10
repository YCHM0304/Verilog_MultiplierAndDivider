`define None	6'b100010
`define Addu	6'b001001
module Control (
    input Run,
    input Reset,
    input clk,
    input LSB,
    output W_ctrl,
    output reg[5:0]ADDU_ctrl,
    output reg SRL_ctrl,
    output reg Ready
);
integer counter;

assign  W_ctrl = (Run == 1)? 1: 0;

always@(LSB,negedge Reset)begin
    if(LSB == 1)ADDU_ctrl <= `Addu;
    else ADDU_ctrl <= `None;
end
always @(posedge clk or Reset) begin
    if (Run == 1 && Reset == 0)begin
        if(counter < 32)begin
            counter = counter + 1;
            SRL_ctrl = 1;
        end
        else begin
            Ready = 1;
            SRL_ctrl = 0;
        end
    end
    else if(Reset == 1)begin
        ADDU_ctrl = 0;
        SRL_ctrl = 0;
        Ready = 0;
        counter = 1;
    end
end
endmodule