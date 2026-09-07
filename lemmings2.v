module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    parameter left=2'b00,right=2'b01,left_fall=2'b10,right_fall=2'b11;
    reg [1:0] state , next_state;
// state transition logic ;
    always @(*) begin 
        case(state) 
            left : next_state = ground ? (bump_left ? right : left) : left_fall ;
            right : next_state = ground ? (bump_right ? left : right ) : right_fall ;
            left_fall : next_state =ground ? left : left_fall ;
            right_fall : next_state = ground ? right : right_fall ;
            default : next_state = 'x;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk , posedge areset) begin 
        if(areset) 
            state <= left;
        else 
            state <= next_state ;  
    end
    // output logic
    assign walk_left = state==left;
    assign walk_right = state==right ;
    assign aaah = (state==left_fall)||(state==right_fall);
endmodule
