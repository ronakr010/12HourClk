module wall_clock(	/////////////testbench is below this module 
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,//we have 8 bits having lower and upper nibbles
    output reg [7:0] mm,//upper nibble indicates the ten's place
    output reg [7:0] ss);// lower nibble indicates the one's place 

	
    always@(posedge clk) begin
	//resets the clock to 12:00 AM
        if (reset) begin
            hh <= 8'h12;
        	mm <= 0;
        	ss <= 0;
        	pm <= 0;
        end
        else begin
            if (ena) begin
				//pm=0 for AM 
				//pm=1 for PM
				//11:59:59 AM to 12:00:00 PM
              
				pm <= (hh == 8'h11 && mm == 8'h59 && ss == 8'h59)? ~pm : pm;
                if (ss == 8'h59) begin // as soon s get 59 it will then go to 0.
                    ss <= 0;
                    
                    if (mm == 8'h59) begin // as soon m get 59 it will then go to 0.
                        mm <= 0;
                        
                        if (hh == 8'h12) begin //as soon h get 12 it will then go to 1.
                            hh <= 8'h1;
							
                        end
                       //we are dividing the upper nibble and lower nibble because the values
						// are in bcd, after 9 lower nibble must be 0 to give 10 and at same 
						//time upper nibble need to be incremented by 1.
                        else begin
                            if (hh[3:0] == 4'h9) begin//as h get 9 then after it will go to 10
                                hh[3:0] <= 0;			// so lower nibble will now get 0
                                hh[7:4] <= hh[7:4] + 4'h1; // and upper nipple starts increament
                            end							// by 1.
                            else 
                                hh[3:0] <= hh[3:0] + 4'h1; //if h is les than 9 then this  
                        end								// lower nibble will get increament
														// by 1.
                    end
                    else begin
                        if (mm[3:0] == 4'h9) begin//as m get 9 then after it will go to 10
                            mm[3:0] <= 0;// so lower nibble will now get 0
                            mm[7:4] <= mm[7:4] + 4'h1;// and upper nipple starts increament
                        end								//by 1.
                        else 
                            mm[3:0] <= mm[3:0] + 4'h1; //if m is les than 9 then this
                    end									// lower nibble will get increament
														// by 1.
                    
                end
                else begin
                    if (ss[3:0] == 4'h9) begin		//similarly this s will follow.
                        ss[3:0] <= 0;
                        ss[7:4] <= ss[7:4] + 4'h1;
                    end
                    else 
                        ss[3:0] <= ss[3:0] + 4'h1;
                end
            end   
        end
        
        
    end
	

endmodule



//////////////////////////TESTBENCH///////////////
module tb_wall_clock;
    reg clk;
    reg reset;
	reg ena;
	 
	wire pm;
    wire [7:0] ss;
    wire [7:0] mm;
    wire [7:0] hh;

    wall_clock inst0 (.clk(clk),.reset(reset),.ena(ena),.ss(ss),.mm(mm),.hh(hh),.pm(pm));
	
initial
begin
$dumpvars();
end
    

initial begin
	clk=1'b0;//initially clock is set to 0
	#1 ena=1'b0;//initially enable is set to 0
	#5 ena=1'b1;// // after 5 time unit enable will set to 0
	end

initial begin
	#1 reset=1'b1;//initially reset is set to 1
	#100 reset=1'b0;// after 5 time unit reset will set to 0
	
end
	
always #5   //after every 5 time unit the clock will toggle.
		clk = ~clk;
		
initial begin
	#864000;// sufficient delay so that it includes whole 24 hours. Simulation stops after this. 
	$finish;
end
		
		
endmodule





