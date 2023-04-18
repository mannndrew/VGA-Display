

module test;
   reg pclk;
   reg [4:0] r;
   reg [4:0] g;
   reg [4:0] b;
   reg hsync;
   reg vsync;
   reg [19:0] x;
   reg [19:0] y;
   reg [4:0]  mask;

   localparam dots_per_line = 800 + 40 + 128 + 88;
   localparam lines_per_frame = 600 + 1 + 4 + 23;

   wire       in_screen = (x < 800 && y < 600);

   initial begin
      x = 0;
      y = 0;
      pclk = 0;
      hsync = 1;
      vsync = 1;
      mask = 0;

      $vgasimInit(
          dots_per_line,
          lines_per_frame,
          r, g, b,
          hsync, vsync,
          pclk
      );
   end

   always @(negedge pclk) begin
      r <= in_screen ? (~x) ^ mask : 0;
      g <= in_screen ? y ^ mask : 0;
      b <= in_screen ? 0 : 0;

      x <= (x == dots_per_line ? 0 : x + 1);

      if (x == dots_per_line)
        y <= (y == lines_per_frame ? 0 : y + 1);

      mask <= (y == lines_per_frame) ? mask + 1 : mask;

      hsync <= ~(x >= 840 && x < 968);
      vsync <= ~(y >= 601 && y < 615);
   end

   always #1 pclk = ~pclk;
endmodule

/*
module test
(
input [9:0] x,
output reg [3:0] VGA_R,
output reg [3:0] VGA_G,
output reg [3:0] VGA_B
);

always @(x)
begin
if(x>=0 && x<100) 
	begin
		VGA_R <= 4'hF;
		VGA_G <= 4'hF;
		VGA_B <= 4'hF;
	end
end



endmodule


*/