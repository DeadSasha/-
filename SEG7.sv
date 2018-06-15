module SEG7
(
input logic [3:0] i_hundreds,
input logic [3:0] i_tens,
input logic [3:0] i_ones,
output logic [6:0] seg1,
output logic [6:0] seg2,
output logic [6:0] seg3
);

always_comb
begin
case(i_hundreds)
	0: seg3 = 7'b1000000;
	1: seg3 = 7'b1111001;
	2: seg3 = 7'b0100100;
	3: seg3 = 7'b0110000;
	4: seg3 = 7'b0011001;
	5: seg3 = 7'b0010010;
	6: seg3 = 7'b0000010;
	7: seg3 = 7'b1111000;
	8: seg3 = 7'b0000000;
	9: seg3 = 7'b0011000;
	10: seg3 = 7'b0001000;
	11: seg3 = 7'b0000011;
	12: seg3 = 7'b1000110;
	13: seg3 = 7'b0100001;
	14: seg3 = 7'b0000110;
	15: seg3 = 7'b0001110;
	default: seg3 = 7'b1111111;
endcase
case(i_tens)
	0: seg2 = 7'b1000000;
	1: seg2 = 7'b1111001;
	2: seg2 = 7'b0100100;
	3: seg2 = 7'b0110000;
	4: seg2 = 7'b0011001;
	5: seg2 = 7'b0010010;
	6: seg2 = 7'b0000010;
	7: seg2 = 7'b1111000;
	8: seg2 = 7'b0000000;
	9: seg2 = 7'b0011000;
	10: seg2 = 7'b0001000;
	11: seg2 = 7'b0000011;
	12: seg2 = 7'b1000110;
	13: seg2 = 7'b0100001;
	14: seg2 = 7'b0000110;
	15: seg2 = 7'b0001110;
	default: seg2 = 7'b1111111;
endcase
case(i_ones)
	0: seg1 = 7'b1000000;
	1: seg1 = 7'b1111001;
	2: seg1 = 7'b0100100;
	3: seg1 = 7'b0110000;
	4: seg1 = 7'b0011001;
	5: seg1 = 7'b0010010;
	6: seg1 = 7'b0000010;
	7: seg1 = 7'b1111000;
	8: seg1 = 7'b0000000;
	9: seg1 = 7'b0011000;
	10: seg1 = 7'b0001000;
	11: seg1 = 7'b0000011;
	12: seg1 = 7'b1000110;
	13: seg1 = 7'b0100001;
	14: seg1 = 7'b0000110;
	15: seg1 = 7'b0001110;
	default: seg1 = 7'b1111111;
endcase
end

endmodule