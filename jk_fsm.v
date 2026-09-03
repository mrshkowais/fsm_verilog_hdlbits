module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = (~state&j)|(~k&state);
        out = state == ON ; // ye line program k end mai likhne k liye thi
    end

    always @(posedge clk, posedge areset) begin //  fsm with sync reset  always @(posedge clk)
        // State flip-flops with asynchronous reset
        if(areset)
            state <= OFF ;
        else 
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);

endmodule
