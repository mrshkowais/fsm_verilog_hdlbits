module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    parameter A=0,B=1,C=2,D=3;
    reg [1:0]state ;
    reg [1:0]next_state ;
    always @(*)
        begin
            next_state[1]=state[0]&(~in) | state[1]&(~state[0])&in;
            next_state[0]= in;
            out= state==D;
        end

    // State transition logic
    always @(posedge clk , posedge areset) begin
        if(areset)
            state <= A ;
    else 
        state <= next_state;
    end
    // State flip-flops with asynchronous reset

    // Output logic

endmodule
