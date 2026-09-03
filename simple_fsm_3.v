module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        next_state[1] = (state[0] & ~in) | (state[1]& ~state[0] & in);
        next_state[0] = in ;
        out = state==D;
        
    end
    // Output logic:  out = f(state) for a Moore state machine

endmodule
