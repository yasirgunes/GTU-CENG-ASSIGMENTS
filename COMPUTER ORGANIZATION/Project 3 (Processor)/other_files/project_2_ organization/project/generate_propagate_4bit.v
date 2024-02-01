module generate_propagate_4bit(
    output g_3_0,
    output p_3_0,
    input [3:0] a,
    input [3:0] b
);

/* 
P3:0 = p3p2p1p0
G3:0 = g3 + p3g2 + p3p2g1 + p3p2p1g0
*/

wire p3, p2, p1, p0;
wire g3, g2, g1, g0;

and and1(g3, a[3], b[3]);
and and2(g2, a[2], b[2]);
and and3(g1, a[1], b[1]);
and and4(g0, a[0], b[0]);

or or1(p3, a[3], b[3]);
or or2(p2, a[2], b[2]);
or or3(p1, a[1], b[1]);
or or4(p0, a[0], b[0]);

and and5(p3p2, p3, p2);
and and6(p1p0, p1, p0);
and and7(p_3_0, p3p2, p1p0);

and and8(p3g2, p3, g2);
or or5(g3_p3g2, g3, p3g2); // g3 + p3g2

and and9(p3p2g1, p3p2, g1); // p3p2g1
or or6(g3_p3g2_p3p2g1, g3_p3g2, p3p2g1); // g3 + p3g2 + p3p2g1
and and10(p3p2p1, p3p2, p1); // p3p2p1
and and11(p3p2p1g0, p3p2p1, g0); // p3p2p1g0
or or7(g_3_0, g3_p3g2_p3p2g1, p3p2p1g0);

endmodule