module RGBTest
(
	input clk,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue,
	output hsync,
	output vsync
);

// Visible Width (640/1) --- Front Porch (16/1) --- Sync Pulse (96/0) --- Back Porch (48/1) >>> Total Line = 800
// Visible Height (480/1) --- Front Porch (10/1) --- Sync Pulse (2/0) --- Back Porch (33/1) >>> Total Frame = 525
// Refresh Rate 60 Hz @ 25.175MHz

reg [9:0] CounterX;
reg [9:0] CounterY;

//reg [3:0] R;
//reg [3:0] G;
//reg [3:0] B;

wire CounterXmaxed = (CounterX == 799); // 16 + 48 + 96 + 640
wire CounterYmaxed = (CounterY == 524); // 10 + 2 + 33 + 480
wire clk_slow;
wire inDisplayArea;


clock_div clock_div_inst 
(
	.inclk0(clk),
	.c0(clk_slow)
);

	
	always @(posedge clk_slow) begin
	
		if (CounterXmaxed) begin
			CounterX <= 10'd0;
			
			if(CounterYmaxed)
				CounterY <= 10'd0;
				
			else
				CounterY <= CounterY + 10'd1;
		end
		
		
		else
			CounterX <= CounterX + 10'd1;
		
	end
	
	assign hsync = (CounterX <= (640 + 16) || ((640 + 16 + 96) <= CounterX));   // active for 640 clocks
	assign vsync = (CounterY <= (480 + 10) || ((480 + 10 + 2) <= CounterY));   // active for 480 clocks
	assign inDisplayArea = (CounterX < 640) && (CounterY < 480);
	
	
//	always @(posedge clk_slow) begin
//		
//		if (inDisplayArea) begin
//		
//			if (0 <= CounterX && CounterX <= 213) 
//				begin R = 4'b1111; G = 4'b0000; B = 4'b0000; end
//				
//			else if (214 <= CounterX && CounterX <= 428) 
//				begin R = 4'b0000; G = 4'b1111; B = 4'b0000; end
//				
//			else
//				begin R = 4'b0000; G = 4'b0000; B = 4'b1111; end
//		
//		end
//		
//		else 
//		
//			begin R = 4'b0000; G = 4'b0000; B = 4'b0000; end
//			
//	end
//	 
//	
//	assign red = R;
//	assign green = G;
//	assign blue = B;


	wire left 	= (0 <= CounterX && CounterX <= 213 && inDisplayArea);
	wire middle = (214 <= CounterX && CounterX <= 428 && inDisplayArea);
	wire right 	= (429 <= CounterX && CounterX <= 639 && inDisplayArea);
	
	assign red 		= (left) ? 4'b1111 : 4'b0000;
	assign green 	= (middle) ? 4'b1111 : 4'b0000;
	assign blue 	= (right) ? 4'b1111 : 4'b0000;
	

endmodule
