module addsub_cla (A,B,S,C,M,V);
parameter W=1;
input [W-1:0] A,B;
output [W-1:0] S;
output C;
input M;
output V;

wire [W-1:0] G,P, A, B;
wire [W:0] Carry;
assign Carry[0] = M;
genvar i;
cla_gen #(.W(W)) CLAGEN
(
    .P(P),
    .G(G),
    .C0(M),
    .C(Carry)
);
generate
    for(i = 0; i< W; i= i+1)
    begin
        assign S[i] = (A[i] ^ (B[i]^M)) ^ Carry[i];
        assign G[i] = A[i] & (B[i]^M);
        assign P[i] = A[i] ^ (B[i]^M);
    end
endgenerate
assign C = Carry[W];
assign V = Carry[W] ^ Carry[W-1];
endmodule

module cla_gen (P,G,C0,C);
parameter W = 1;
input [W-1:0] P,G;
input C0;
wire C0;
output [W:0] C;
wire [W-1:0] P,G;
assign C[0] = C0;
genvar j;
generate
    for(j = 0; j < W; j=j+1)
    begin
        assign C[j+1] = G[j] | (P[j] & C[j]);
    end
endgenerate
endmodule