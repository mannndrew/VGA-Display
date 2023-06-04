module text_map
#(
	parameter 	ADDR_WIDTH=12, 
					DATA_WIDTH=7
)

(
	input[ADDR_WIDTH-1:0] addr,
	output[DATA_WIDTH-1:0] data	
);

reg [DATA_WIDTH-1:0] data_q;
	

always @(addr) begin
	case (addr)
		{5'd15, 7'd35}: data_q = 7'd072;		// H
		{5'd15, 7'd36}: data_q = 7'd101;		// e
		{5'd15, 7'd37}: data_q = 7'd108;		// l
		{5'd15, 7'd38}: data_q = 7'd108;		// l
		{5'd15, 7'd39}: data_q = 7'd111;		// o
		
		{5'd15, 7'd41}: data_q = 7'd087;		// W
		{5'd15, 7'd42}: data_q = 7'd111;		// o
		{5'd15, 7'd43}: data_q = 7'd114;		// r
		{5'd15, 7'd44}: data_q = 7'd108;		// l
		{5'd15, 7'd45}: data_q = 7'd100;		// d
		{5'd15, 7'd46}: data_q = 7'd033;		// !
		
		default: data_q = 7'd0;

	endcase
end

assign data = data_q;

endmodule
