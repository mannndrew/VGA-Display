module WhiteText
(
	input clk,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue,
	output hsync,
	output vsync
);


wire clk_slow;
wire video_active;
wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire color;

assign red = (color) ? 4'b1111 : 4'b0000;
assign green = (color) ? 4'b1111 : 4'b0000;
assign blue = (color) ? 4'b1111 : 4'b0000;

clock_div clock_div_inst 
(
	.inclk0(clk),
	.c0(clk_slow)
);

vga_core driver
(
	.clk(clk_slow),
	.hsync(hsync),
	.vsync(vsync),
	.video_active(video_active),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y)
);

screen_gen light
(
	.video_active(video_active),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y),
	.color(color)
);

endmodule


