module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    parameter A=0,B=1,C=2,D=3;
    reg [3:0]state ;
    reg [3:0]next_state ;
    
             assign next_state[A] = state[A]&(~in) | state[C]&(~in);
    assign next_state[B] = state[A]&in|state[B]&in|state[D]&in;
    assign next_state[C] = state[B]&~in | state[D]&~in;
    assign next_state[D] = state[C]&in;

        

    // State transition logic
    always @(posedge clk , posedge areset) begin
        if(areset)
            state <= 4'b0001 ; //one hot
    else 
        state <= next_state;
    end
    // State flip-flops with asynchronous reset

    // Output logic
    assign out = state[D];
    

endmodule
