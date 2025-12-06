module binary(
    input w,
    input clk, reset,
    output z, [2:0]out
);

    wire [2:0] State;
    wire [2:0] Next;

    dff xPos(
        .Default(1'b0),
        .reset(reset),
        .D(Next[2]),
        .clk(clk),
        .Q(State[2])
    );

    dff yPos(
        .Default(1'b0),
        .reset(reset),
        .D(Next[1]),
        .clk(clk),
        .Q(State[1])
    );
    
    dff zPos(
        .Default(1'b0),
        .reset(reset),
        .D(Next[0]),
        .clk(clk),
        .Q(State[0])
    );

    assign z = ((State == 3'b010) | (State == 3'b100));
 //  assign z=  (State[1] | State[2] ) ? 1'b1 :1'b0;
    assign Next[2] = (~State[2] & State[1] & State[0] & w) | (State[2] & ~State[1] & ~State[0] & w);
    assign Next[1] = (~State[2] & State[1] & ~State[0]) | (~State[2] & ~State[1] & w) | (~State[2] & ~State[1] & State[0]);
    assign Next[0] = (~State[1] & ~State[0] & ~w) | (~State[2] & ~State[1] & w) | (~State[2] & ~State[0] & w) | (~State[2] & State[1] & State[0] & ~w);

    assign out[0] = State[0];
    assign out[1] = State[1];
    assign out[2] = State[2];

endmodule