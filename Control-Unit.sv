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

logic [4:0] MK_Adress;
//logic [4:0] next_MK_adress;
input logic [7:0] Reg_1;
input logic [7:0] Reg_2;
input logic [15:0] Reg_SUM;
input logic [7:0] Reg_A;
input logic [7:0] Reg_B;
input logic [1:0] Reg_d
input logic Reg_sd;
logic Tzn;
output logic [7:0]counter;
output logic [3:0]counter_cikl;
output and input logic [7:0] Reg_Com;
logic [7:0] Reg_ReadMem;
logic [7:0] Reg_AdressMem;
logic condition1, condition2, condition3, condition4, condition5, condition6;
logic [7:0] mem [39:0];
logic [7:0] Reg_buf;
logic [38:0] mem_MK [23:0];
//logic [4:0] mem_MK_Adress [23:0];
logic [4:0] mem_next_MK_Adress [23:0];


always_ff @(posedge clock, negedge reset)
if (~reset)
	begin
		mem_MK[23:0][43:0] <= '{/*1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9*/ 
										'{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0},
										'{0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0},
										'{0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
										};
		mem_next_MK_Adress[23:0][43:0] <= '{/*1,2,3,4,5*/ 
												      '{0,0,0,0,1},
												      '{0,0,0,1,0},
												      '{0,0,0,1,1},
												      '{0,0,1,0,0},
												      '{0,0,1,0,1},
												      '{0,0,1,1,0},
												      '{0,0,1,1,1},
												      '{0,1,1,1,1},
												      '{0,1,0,1,1},
												      '{0,1,0,1,0},
												      '{0,1,0,1,1},
												      '{0,1,1,0,0},
												      '{1,0,0,0,1},
												      '{0,1,1,1,0},
												      '{1,0,0,0,1},
												      '{1,0,0,0,0},
												      '{1,0,0,0,1},
												      '{1,0,0,1,1},
												      '{0,0,1,1,1},
												      '{1,0,1,0,0},
												      '{1,0,1,0,1},
												      '{1,0,1,1,0},
														'{1,0,1,1,1},
												      '{0,0,0,0,0}
													  };
//		mem_MK_Adress[23:0][43:0] <= '{/*1,2,3,4,5*/ 
//											    '{0,0,0,0,1},
//											    '{0,0,0,1,0},
//											    '{0,0,0,1,1},
//											    '{0,0,1,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0},
//											    '{0,0,0,0,0}
//												};
		MK_Adress <= 0;
//next_MK_adress <= 0;
	end
else
	begin
		if (mem_MK[MK_Adress][0] == 1) Reg_AdressMem <= counter;
		else Reg_AdressMem <= Reg_AdressMem;
		if (mem_MK[MK_Adress][1] == 1) counter <= counter + 1;
		else counter <= counter;
		if (mem_MK[MK_Adress][2] == 1) Reg_ReadMem <= mem[Reg_AdressMem][7:0];
		else Reg_readMem <= Reg_ReadMem;
		if (mem_MK[MK_Adress][3] == 1) mem[Reg_AdressMem][7:0] <= Reg_ReadMem;
		else mem[Reg_AdressMem][7:0] <= mem[Reg_AdressMem][7:0];
		if (mem_MK[MK_Adress][4] == 1) Reg_Com <= Reg_ReadMem;
		else Reg_Com <= Reg_Com;
		if (mem_MK[MK_Adress][5] == 1) Reg_AdressMem <= reg_Com[5:3];
		else Reg_AdressMem <= Reg_AdressMem;
		if (mem_MK[MK_Adress][6] == 1) Reg_AdressMem <= reg_Com[2:0];
		else Reg_AdressMem <= Reg_AdressMem;
		if (mem_MK[MK_Adress][7] == 1) Reg_1 <= Reg_ReadMem;
		else Reg_1 <= Reg_1;
		if (mem_MK[MK_Adress][8] == 1) Reg_2 <= Reg_ReadMem;
		else Reg_2 <= Reg_2;
		if (mem_MK[MK_Adress][9] == 1) Reg_B[7] <= Reg_1[7];
		else Reg_B[7] <= Reg_B[7];
		if (mem_MK[MK_Adress][10] == 1) Reg_SUM[15] <= 1;
		else Reg_SUM[15] <= Reg_SUM[15];
		if (mem_MK[MK_Adress][11] == 1) Reg_B[6:0] <= !Reg_1[6:0];
		else Reg_B[6:0] <= Reg_B[6:0]
		if (mem_MK[MK_Adress][12] == 1) Tzn <= Reg_1[7] ^ Reg_2[7];
		else Tzn <= Tzn;
		if (mem_MK[MK_Adress][13] == 1) Reg_B <= Reg_B + 1;
		else Reg_B <= Reg_B
		if (mem_MK[MK_Adress][14] == 1) Reg_B <= !Reg_2;
		else Reg_B <= Reg_B;
		if (mem_MK[MK_Adress][15] == 1) Reg_d <= 0;
		else Reg_d <= Reg_d;
		if (mem_MK[MK_Adress][16] == 1) Reg_d <= Reg_d >> 1;
		else Reg_d <= Reg_d;
		if (mem_MK[MK_Adress][17] == 1) Reg_sd <= Reg_2[0];
		else Reg_sd <= Reg_sd;
		if (mem_MK[MK_Adress][18] == 1) Reg_2 <= Reg_2 >> 1;
		else Reg_2 <= Reg_2;
		if (mem_MK[MK_Adress][19] == 1) Reg_A <= 0;
		else Reg_A <= Reg_A;
		if (mem_MK[MK_Adress][20] == 1) Reg_AdressMem <= Reg_buf;
		else Reg_AdressMem <= Reg_AdressMem
		if (mem_MK[MK_Adress][21] == 1) Reg_SUM[15:8] <= Reg_A;
		else Reg_SUM[15:8] <= Reg_SUM[15:8];
		if (mem_MK[MK_Adress][22] == 1) Reg_SUM <= 0;
		else Reg_SUM <= Reg_SUM;
		if (mem_MK[MK_Adress][23] == 1) Reg_SUM <= Reg_SUM >> 1;
		else Reg_SUM <= Reg_SUM;
		if (mem_MK[MK_Adress][24] == 1) Reg_A <= Reg_SUM[15:8];
		else Reg_A <= Reg_A;
		if (mem_MK[MK_Adress][25] == 1) Reg_ReadMem <= Reg_SUM[7:0];
		else Reg_ReadMem <= Reg_ReadMem;
		if (mem_MK[MK_Adress][26] == 1) Reg_B <= Reg_1;
		else Reg_B <= Reg_B;
		if (mem_MK[MK_Adress][27] == 1) Reg_ReadMem <= Reg_SUM[15:8]
		else Reg_ReadMem <= Reg_ReadMem;
		if (mem_MK[MK_Adress][28] == 1) Reg_A <= Reg_1;
		else Reg_A <= Reg_A;
		if (mem_MK[MK_Adress][29] == 1) Reg_buf <= Reg_buf + 1;
		else Reg_buf <= Reg_buf;
		if (mem_MK[MK_Adress][30] == 1) Reg_B <= Reg_2;
		else Reg_B <= Reg_B;
		if (mem_MK[MK_Adress][31] == 1) Reg_buf <= Reg_AdressMem;
		else Reg_buf <= Reg_buf;
		if (mem_MK[MK_Adress][32] == 1) Reg_sd <= 0;
		else Reg_sd <= Reg_sd;
		if (mem_MK[MK_Adress][33] == 1) counter_cikl <= 7;
		else counter_cikl <= counter_cikl;
		if (mem_MK[MK_Adress][34] == 1) counter_cikl <= counter_cikl - 1;
		else counter_cikl <= counter_cikl;
		if (mem_MK[MK_Adress][35] == 1) Reg_1[7] <= 0;
		else Reg_1[7] <= Reg_1[7];
		if (mem_MK[MK_Adress][36] == 1) Reg_2[7] <= 0;
		else Reg_2[7] <= Reg_2[7];
		if (mem_MK[MK_Adress][37] == 1) Reg_SUM[15] <= Tzn;
		else Reg_SUM[15] <= Reg_SUM[15];
		if (mem_MK[MK_Adress][38] == 1) Reg_SUM[15:8] <= Reg_A + Reg_B;
		else Reg_SUM[15:8] <= Reg_SUM[15:8];
		if ((MK_Adress == 17)
			begin
				if (condition1 == 1) MK_Adress <= 18
				else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
			end
		else if (MK_Adress == 7)
			begin
				if (condition2 == 1)
					begin
						if (condition3 == 1) MK_Adress <= 9
						else MK_Adress <= 8;
					end
				else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
			end
		else if ((MK_Adress == 11)
			begin
				if (condition4 == 1)
					begin
						if (condition6 == 1) MK_Adress <= 13;
						MK_Adress <= 12;
					end
				else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
			end
		else if (MK_Adress == 16)
			begin
				if (condition5 == 1) MK_Adress <= 14;
				else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
			end
		else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
	end
end

always_ff @(posedge clock)
begin
	if (counter_cikl != 0) condition1 <= 0;
	else condition1 <= 1; 
	condition2 <= (Reg_2[0] ^ Reg_sd) & Reg_d;
	condition3 <= Reg_2 & ((Reg_2[0] ^ Reg_sd) & Reg_d);
	condition4 <= Reg_2[7] | Reg_2[6] | Reg_2[5] | Reg_2[4] | Reg_2[3] | Reg_2[2] | Reg_2[1] | Reg_2[0];
	condition5 <= Reg_A;
	condition6 <= Reg_A | Reg_B;
end













endmodule