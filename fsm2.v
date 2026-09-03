// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations\
    reg next_state , present_state ;
    parameter A = 1'b0 , B= 1'b1;
    always @(*) 
        begin
            next_state = present_state ~^ in;
            out = present_state == B ;
            
        end

    always @ (posedge clk) begin
        
        if (reset)
            present_state <= B ;
    else 
        present_state <= next_state;
        
    end
   //assign out = present_state == B ;
   
endmodule
