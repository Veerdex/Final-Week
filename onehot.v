module one_hot(
    input w,
    input clk,
    input reset,
    output z, [4:0]out
);
    wire Anext, Bnext, Cnext, Dnext, Enext;
    wire Astate, Bstate, Cstate, Dnext, Enext;

    dff Adff(
        .Default(1'b1),
        .reset(reset),
        .D(Anext),
        .clk(clk),
        .Q(Astate)
    );

    dff Bdff(
        .Default(1'b0),
        .reset(reset),
        .D(Bnext),
        .clk(clk),
        .Q(Bstate)
    );

    dff Cdff(
        .Default(1'b0),
        .reset(reset),
        .D(Cnext),
        .clk(clk),
        .Q(Cstate)
    );
    
    dff Ddff(
        .Default(1'b0),
        .reset(reset),
        .D(Dnext),
        .clk(clk),
        .Q(Dstate)
    );
    
    dff Edff(
        .Default(1'b0),
        .reset(reset),
        .D(Enext),
        .clk(clk),
        .Q(Estate)
    );

    assign z = Cstate | Estate;

    assign Anext = 1'b0;
    assign Bnext = ~w & (Astate | Dstate | Estate);
    assign Cnext = ~w & (Bstate | Cstate);
    assign Dnext = w & (Astate | Bstate | Cstate);
    assign Enext = w & (Dstate | Estate);
    
    assign out[0] = Astate;
    assign out[1] = Bstate;
    assign out[2] = Cstate;
    assign out[3] = Dstate;
    assign out[4] = Estate;
endmodule