module SEG7counter
(
input logic clock,
input logic reset,
input logic [4:0] counter_settings,
input logic [6:0] memory,
output logic [6:0] ssegment1,
output logic [6:0] ssegment2,
output logic [6:0] ssegment3,
output logic [6:0] ssegment5,
output logic [6:0] ssegment6,
output logic [6:0] ssegment7
);


bin_to_bcd NUMBER
(
	.preobr			(memory),
	.ssegment1		(ssegment1),
	.ssegment2		(ssegment2),
	.ssegment3		(ssegment3)
);

bin_to_bcd COUNT
(
	.preobr			(counter_settings),
	.ssegment1		(ssegment5),
	.ssegment2		(ssegment6),
	.ssegment3		(ssegment7)
);


endmodule