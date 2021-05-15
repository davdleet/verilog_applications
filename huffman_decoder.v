module huffman_decoder (x, y, clk, reset);
input x;
output [2:0] y;
input clk;
input reset;
reg [5:0] current;
reg[5:0] next;
//states
parameter S0 = 6'b000000, S1= 6'b000001, S2 = 6'b000010, S3 = 6'b000011, S4 = 6'b000100, 
A = 6'b001000, B = 6'b010000, C = 6'b011000, D = 6'b100000, E = 6'b101000, F = 6'b110000;  

initial
    next = S0;

//sequential logic
always @ (posedge clk or posedge reset)
begin
    if (reset == 1) current <= S0;
    else current <= next;
end
//combinational logic
always @ (*)
begin
    case(current)
    S0, A, B, C, D, E, F: 
    if(x) next = S1;
    else next = A;
    S1: 
    if(x) next = S3;
    else next = S2;
    S2: 
    if(x) next = B;
    else next = C;
    S3: 
    if(x) next = D;
    else next = S4;
    S4: 
    if(x) next = E;
    else next = F;
    default: next = S0;
    endcase
end

assign y = current[5:3];

endmodule