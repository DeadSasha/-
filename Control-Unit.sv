module Control-Unit
(
input logic [3:1] button,
input logic reset,
input logic clock,
output logic [6:0] ssegment0,
output logic [6:0] ssegment1,
output logic [6:0] ssegment2,
output logic [6:0] ssegment3,
output logic [6:0] ssegment4,
output logic [6:0] ssegment5,
output logic [6:0] ssegment6,
output logic [6:0] ssegment7
);

logic [1:0] settings;
logic [2:0] work_button;
logic [38:0] ventil;
logic [43:0] MK;
logic [4:0] MK_adress;
logic Tzn;
logic [7:0] Reg_1;
logic [7:0] Reg_2;
logic [15:0] Reg_SUM;
logic [7:0] Reg_A;
logic [7:0] Reg_B;
logic [1:0] Reg_d
logic Reg_sd;
logic [7:0]counter;
logic [3:0]counter_cikl;
logic [7:0] Reg_Com;
logic [7:0] Reg_ReadMem;
logic [7:0] Reg_AdressMem;
logic Condition1, Condition2, Condition3, Condition4, Condition5, Condition6;
logic [39:0] mem [7:0];
logic [7:0] Reg_buf;


antidrebezg button1
(
	.clock					(clock),
	.reset					(reset),
	.button					(~button[3]),
	.pulse					(work_button[0])
);

antidrebezg button2
(
	.clock					(clock),
	.reset					(reset),
	.button					(~button[2]),
	.pulse					(work_button[1])
);

antidrebezg button3
(
	.clock					(clock),
	.reset					(reset),
	.button					(~button[1]),
	.pulse					(work_button[2])
);



always_ff @(posedge clock, negedge reset)								//выбор того, что настраивается на плате
begin
if (~reset) settings <= 0;
else  
	begin
		if (work_button[0] == 1) settings <= settings + 1;
      else settings <= settings;
	end
end

always_ff @(posedge clock, negedge reset)
begin
if (~reset) settings <= 0;
else  
	begin
		if (work_button[0] == 1) settings <= settings + 1;
      else settings <= settings;
	end
end
always_ff @(posedge clock, negedge reset)
begin
if (~reset) MK_adress <= 0;
else  
	begin
		if (MK_adress = 7) 
			begin
				Condition <= settings + 1;
				
      else settings <= settings;
	end
end






endmodule