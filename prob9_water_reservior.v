module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter a=0 ,rb=1,fb=2,rc=3,fc=4,d=5;
    reg [5:0] state ;
    reg [5:0] next_state ;
    //state transition logic
    assign next_state[a] = ((s[3]&s[2]&s[1]&state[a]) | (s[3]&s[2]&s[1]&state[rb]) | (s[3]&s[2]&s[1]&state[fb]) | (s[3]&s[2]&s[1]&state[rc])
    						| (s[3]&s[2]&s[1]&state[fc]) | (s[3]&s[2]&s[1]&state[d]) );
	assign next_state[rb] = ((~s[3]&s[2]&s[1]&state[rb]) | (~s[3]&s[2]&s[1]&state[rc]) | (~s[3]&s[2]&s[1]&state[fc])
                         		| (~s[3]&s[2]&s[1]&state[d]));
	assign next_state[fb] = ((~s[3]&s[2]&s[1]&state[a]) | (~s[3]&s[2]&s[1]&state[fb]) );
    
	assign next_state[rc] =  (((~s[3])&(~s[2])&s[1]&state[rc]) | ((~s[3])&(~s[2])&s[1]&state[d])) ;
    
	assign next_state[fc] = (((~s[3])&(~s[2])&s[1]&state[a]) | ((~s[3])&(~s[2])&s[1]&state[rb]) | ((~s[3])&(~s[2])&s[1]&state[fb])
                         			| ((~s[3])&(~s[2])&s[1]&state[fc]) );
    
	assign next_state[d] = (((~s[3])&(~s[2])&(~s[1])&state[a]) |  ((~s[3])&(~s[2])&(~s[1])&state[rb])| ((~s[3])&(~s[2])&(~s[1])&state[fb]) 
                       			 | ((~s[3])&(~s[2])&(~s[1])&state[rc]) |  ((~s[3])&(~s[2])&(~s[1])&state[fc])| ((~s[3])&(~s[2])&(~s[1])&state[d]) );
    //
    always @(posedge clk) begin
        if (reset)
            state <= 6'b100000; // 1 hot method
            else 
                state <= next_state;
    end
    // output logic
    assign fr1 = state[rb] | state[fb] | state [rc] | state[fc] | state[d] ;
    assign fr2 = state [rc] | state[fc] | state[d] ;
    assign fr3 = state[d];
    assign dfr = state[fb] | state[fc] | state[d];
    
endmodule
