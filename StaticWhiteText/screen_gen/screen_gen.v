module screen_gen
(
	input video_active,
	input [9:0] pixel_x,
	input [9:0] pixel_y,
	output color
);

wire [6:0] block_x = pixel_x[9:3];
wire [4:0] block_y = pixel_y[8:4];
wire [3:0] block_col = pixel_x[2:0];
wire [3:0] block_row = pixel_y[3:0]; 

wire [6:0] ascii;
wire [7:0] font_data;

text_map map_inst 
(
	.addr({block_y, block_x}),
	.data(ascii)	
);

font_rom rom_inst
(
	.addr({ascii, block_row}), //[10:4] for ASCII char code, [3:0] for choosing what row to read on a given character code  
	.data(font_data)
);

assign color=font_data[~block_col] & video_active;

endmodule
