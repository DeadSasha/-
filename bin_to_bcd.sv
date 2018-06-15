module bin_to_bcd
(
input logic [6:0] 		preobr,
output logic [6:0] 		ssegment1,
output logic [6:0] 		ssegment2,
output logic [6:0] 		ssegment3
);
logic [3:0] hundreds;
logic [3:0] tens;
logic [3:0] ones;

integer i;

always_comb
	begin
		hundreds = 4'd0;
		tens = 4'd0;
		ones = 4'd0;
		for (i = 6; i >= 0; i = i - 1)
		begin
			if (hundreds >= 5) hundreds = hundreds + 3;
			if (tens >= 5) tens = tens + 3;
			if (ones >= 5) ones = ones + 3;
			hundreds = hundreds << 1;
			hundreds[0] = tens[3];
			tens = tens << 1;
			tens[0] = ones[3];
			ones = ones << 1;
			ones[0] = preobr[i];
		end
	end


SEG7 DISPLAY_HEX
(
.i_hundreds (hundreds),
.i_tens	(tens),
.i_ones	(ones),
.seg1		(ssegment1),
.seg2		(ssegment2),
.seg3		(ssegment3)
);

endmodule