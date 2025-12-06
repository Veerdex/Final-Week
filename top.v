module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);

    one_hot one_hot(
        .w(sw), .clk(btnC), .reset(btnU), //input
        .z(led[0]), .out(led[6:2]) //output
    );
    
    binary binary(
        .w(sw), .clk(btnC), .reset(btnU), //input
        .z(led[1]), .out(led[9:7]) //output
    );

endmodule