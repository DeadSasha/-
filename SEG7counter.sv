module SEG7counter
(
input logic clock,
input logic reset,
input logic [4:0] counter_settings,
input logic [6:0] memory,
output logic [6:0] ssegment1,
output logic [6:0] ssegment2,
output logic [6:0] ssegment3,
//output logic [6:0] ssegment4,
output logic [6:0] ssegment5,
output logic [6:0] ssegment6,
output logic [6:0] ssegment7
//output logic [6:0] ssegment8
);


bin_to_bcd NUMBER
(
	.preobr			(memory),
	.ssegment1		(ssegment0),
	.ssegment2		(ssegment1),
	.ssegment3		(ssegment2)
//	.ssegment4		(ssegment3)
);

bin_to_bcd COUNT
(
	.preobr			(counter_settings),
	.ssegment1		(ssegment4),
	.ssegment2		(ssegment5),
	.ssegment3		(ssegment6)
//	.ssegment4		(ssegment7)
);


endmodule