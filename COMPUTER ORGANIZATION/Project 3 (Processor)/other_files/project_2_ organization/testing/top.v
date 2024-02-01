module top (A, Sel, C, Y);
input A, Sel, C;
output Y;
wire n1;

small_m s1(.A(A),
         .B(Sel),
         .Y(n1));

small_m s2( .A(n1),
            .B(C),
            .Y(Y) );

endmodule
