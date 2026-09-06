module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
parameter a=3'b000 , rb=3'b001 , fb=3'b010, rc=3'b011 , fc=3'b100 , d=3'b101;
    reg [2:0] state ;
    reg [2:0] next_state;
    // nextstate transition logic 
    always @(*) 
        begin
            case(state)
                a : next_state = s[3] ? a : fb;
                rb : next_state = s[3] ? a : (s[2] ? rb : fc);
                fb : next_state = s[3] ? a : (s[2] ? fb : fc);
                rc : next_state = s[2] ? rb : (s[1] ? rc : d) ;
                fc : next_state = s[2] ? rb : (s[1] ? fc : d) ;
                d : next_state = s[1] ? rc : d ;
                default next_state = 'x;
            endcase
        end
    //seq logic
    always @(posedge clk) begin
        if(reset)
            state <= d;
        else 
            state <= next_state;
        
    end
    // out logic
    always @(*) 
        begin
            case(state)
                a : {fr3,fr2,fr1,dfr} = 4'b0000;
                rb : {fr3,fr2,fr1,dfr} = 4'b0010;
                fb : {fr3,fr2,fr1,dfr} = 4'b0011;
                rc : {fr3,fr2,fr1,dfr} = 4'b0110;
                fc : {fr3,fr2,fr1,dfr} = 4'b0111;
                d : {fr3,fr2,fr1,dfr} = 4'b1111;
                default : {fr3,fr2,fr1,dfr} = 4'bxxxx;
            endcase
        end
endmodule
