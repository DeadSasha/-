module Control_Unit
(
input logic button,
input logic reset,
input logic clock,
input logic /*[1:0]*/ switch,
output logic [6:0] ssegment0,
output logic [6:0] ssegment1,
output logic [6:0] ssegment2,
//output logic [6:0] ssegment3,
output logic [6:0] ssegment4,
output logic [6:0] ssegment5,
output logic [6:0] ssegment6
//output logic [6:0] ssegment7
);

//logic [1:0] settings;
logic [4:0] counter_settings;
logic /*[2:0]*/ work_button;
logic /*[1:0]*/ work_switch;
logic [6:0] memory;

antidrebezg button0
(
	.clock					(clock),
	.reset					(reset),
	.button					(~button),
	.pulse					(work_button)
);

//antidrebezg button1
//(
//	.clock					(clock),
//	.reset					(reset),
//	.button					(~button[1]),
//	.pulse					(work_button[1])
//);
//
//antidrebezg button2
//(
//	.clock					(clock),
//	.reset					(reset),
//	.button					(~button[2]),
//	.pulse					(work_button[2])
//);

antidrebezg switch0
(
	.clock					(clock),
	.reset					(reset),
	.button					(switch),
	.pulse					(work_switch)
);

//antidrebezg switch1
//(
//	.clock					(clock),
//	.reset					(reset),
//	.button					(switch[1]),
//	.pulse					(work_switch[1])
//);


//always_ff @(posedge clock, negedge reset)								//режим просмотра и настройки массива mem
//begin
//if (~reset) settings <= 0;
//else  
//	begin
//		if (work_switch[1] == 1) settings <= settings + 1;
//      else settings <= settings;
//	end
//end


always_ff @(posedge clock)				
begin
if (reset == 1) counter_settings <= 0;
else  
	begin
		if (work_button == 1) counter_settings <= counter_settings + 1;
      else counter_settings <= 0;
	end
end

always_ff @(posedge clock)				
begin
if (reset == 1) memory <= 0;
else memory <= mem[counter_settings][6:0];
end

SEG7counter display
(
	.clock						(clock),
	.reset						(reset),
	.counter_settings			(counter_settings),
	.memory						(memory),
	.ssegment1					(ssegment0),
	.ssegment2					(ssegment1),
	.ssegment3					(ssegment2),
	.ssegment5					(ssegment4),
	.ssegment6					(ssegment5),
	.ssegment7					(ssegment6)
);

always_ff @(posedge clock)								
begin
if (reset == 1) start <= 0;
else  
	begin
		if (work_switch == 1) start <= 1;
      else start <= 0;
	end
end

logic [4:0] MK_Adress;
//logic [4:0] next_MK_adress;
logic [7:0] Reg_1;
logic [7:0] Reg_2;
logic [15:0] Reg_SUM;
logic [7:0] Reg_A;
logic [7:0] Reg_B;
logic [1:0] Reg_d;
logic Reg_sd;
logic Tzn;
logic [2:0]counter;
logic [3:0]counter_cikl;
logic [7:0] Reg_Com;
logic [7:0] Reg_ReadMem;
logic [7:0] Reg_AdressMem;
logic condition1, condition2, condition3, condition4, condition5, condition6;
logic [7:0] mem [15:0];
logic [7:0] Reg_buf;
logic mem_MK [23:0] [38:0];
//logic [4:0] mem_MK_Adress [23:0];
logic [4:0] mem_next_MK_Adress [23:0];
logic start;
logic work_en;

always_ff @(posedge clock)
begin
	if (reset == 1) work_en <=0;
	else
		begin
			if (counter < 5) work_en <= 1;
			else work_en <= 0;
		end
end

always_ff @(posedge clock)
begin
if (reset == 1)
	begin
		mem_MK <= '{/*1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9*/ 
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
						'{0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
		mem_next_MK_Adress <= '{/*1,2,3,4,5*/ 
									   '{5'b00001},
									   '{5'b00010},
									   '{5'b00011},
									   '{5'b00100},
									   '{5'b00101},
									   '{5'b00110},
									   '{5'b00111},
									   '{5'b01111},
									   '{5'b01011},
									   '{5'b01010},
									   '{5'b01011},
									   '{5'b01100},
									   '{5'b10001},
									   '{5'b01110},
									   '{5'b10001},
									   '{5'b10000},
									   '{5'b10001},
									   '{5'b10011},
									   '{5'b00111},
									   '{5'b10100},
									   '{5'b10101},
									   '{5'b10110},
										'{5'b10111},
									   '{5'b00000}};
		mem <= '{/*7,6,5,4,3,2,1,0*/ 
					'{01110100},
					'{01100101},
					'{01010110},
					'{01000101},
					'{00000010},	 //2
					'{00001010},	 //10
					'{01100100},	 //100
					'{11111011},	 //123
					'{00000010},	 //2
					'{00000000},	 //4
					'{00000111},	 //7
					'{00000000},	 //70
					'{00011010},	 //26
					'{00000000},	 //2600
					'{00100111},	 //39 
					'{00000000}};  //4797 1 0010 1011 1101 [18]
				
		MK_Adress <= 0;
		Reg_AdressMem <= Reg_AdressMem;
		counter <= counter;
		Reg_ReadMem <= Reg_ReadMem;
		mem[Reg_AdressMem] <= mem[Reg_AdressMem];
		Reg_Com = Reg_Com;
		Reg_AdressMem <= Reg_AdressMem;
		Reg_1 <= Reg_1;
		Reg_2 <= Reg_2;
		Reg_B <= Reg_B;
		Reg_SUM <= Reg_SUM;
		Tzn <= Tzn;
		Reg_d <= Reg_d;
		Reg_sd <= Reg_sd;
		Reg_A <= Reg_A;
		Reg_buf <= Reg_buf;
		counter_cikl <= counter_cikl;
		MK_Adress <= MK_Adress;
	end
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (mem_MK[MK_Adress][38] == 1) Reg_AdressMem <= counter;
						else Reg_AdressMem <= Reg_AdressMem;
						if (mem_MK[MK_Adress][37] == 1) counter <= counter + 1;
						else counter <= counter;
						if (mem_MK[MK_Adress][36] == 1) Reg_ReadMem <= mem[Reg_AdressMem];
						else Reg_ReadMem <= Reg_ReadMem;
						if (mem_MK[MK_Adress][35] == 1) mem[Reg_AdressMem] <= Reg_ReadMem;
						else mem[Reg_AdressMem] <= mem[Reg_AdressMem];
						if (mem_MK[MK_Adress][34] == 1) Reg_Com <= Reg_ReadMem;
						else Reg_Com <= Reg_Com;
						if (mem_MK[MK_Adress][33] == 1) Reg_AdressMem <= Reg_Com[6:3];
						else Reg_AdressMem <= Reg_AdressMem;
						if (mem_MK[MK_Adress][32] == 1) Reg_AdressMem <= Reg_Com[2:0];
						else Reg_AdressMem <= Reg_AdressMem;
						if (mem_MK[MK_Adress][31] == 1) Reg_1 <= Reg_ReadMem;
						else Reg_1 <= Reg_1;
						if (mem_MK[MK_Adress][30] == 1) Reg_2 <= Reg_ReadMem;
						else Reg_2 <= Reg_2;
						if (mem_MK[MK_Adress][29] == 1) Reg_B[7] <= Reg_1[7];
						else Reg_B[7] <= Reg_B[7];
						if (mem_MK[MK_Adress][28] == 1) Reg_SUM[15] <= 1;
						else Reg_SUM[15] <= Reg_SUM[15];
						if (mem_MK[MK_Adress][27] == 1) Reg_B[6:0] <= !Reg_1[6:0];
						else Reg_B[6:0] <= Reg_B[6:0];
						if (mem_MK[MK_Adress][26] == 1) Tzn <= Reg_1[7] ^ Reg_2[7];
						else Tzn <= Tzn;
						if (mem_MK[MK_Adress][25] == 1) Reg_B <= Reg_B + 1;
						else Reg_B <= Reg_B;
						if (mem_MK[MK_Adress][24] == 1) Reg_B <= !Reg_2;
						else Reg_B <= Reg_B;
						if (mem_MK[MK_Adress][23] == 1) Reg_d <= 0;
						else Reg_d <= Reg_d;
						if (mem_MK[MK_Adress][22] == 1) Reg_d <= Reg_d >> 1;
						else Reg_d <= Reg_d;
						if (mem_MK[MK_Adress][21] == 1) Reg_sd <= Reg_2[0];
						else Reg_sd <= Reg_sd;
						if (mem_MK[MK_Adress][20] == 1) Reg_2 <= Reg_2 >> 1;
						else Reg_2 <= Reg_2;
						if (mem_MK[MK_Adress][19] == 1) Reg_A <= 0;
						else Reg_A <= Reg_A;
						if (mem_MK[MK_Adress][18] == 1) Reg_AdressMem <= Reg_buf;
						else Reg_AdressMem <= Reg_AdressMem;
						if (mem_MK[MK_Adress][17] == 1) Reg_SUM[15:8] <= Reg_A;
						else Reg_SUM[15:8] <= Reg_SUM[15:8];
						if (mem_MK[MK_Adress][16] == 1) Reg_SUM <= 0;
						else Reg_SUM <= Reg_SUM;
						if (mem_MK[MK_Adress][15] == 1) Reg_SUM <= Reg_SUM >> 1;
						else Reg_SUM <= Reg_SUM;
						if (mem_MK[MK_Adress][14] == 1) Reg_A <= Reg_SUM[15:8];
						else Reg_A <= Reg_A;
						if (mem_MK[MK_Adress][13] == 1) Reg_ReadMem <= Reg_SUM[7:0];
						else Reg_ReadMem <= Reg_ReadMem;
						if (mem_MK[MK_Adress][12] == 1) Reg_B <= Reg_1;
						else Reg_B <= Reg_B;
						if (mem_MK[MK_Adress][11] == 1) Reg_ReadMem <= Reg_SUM[15:8];
						else Reg_ReadMem <= Reg_ReadMem;
						if (mem_MK[MK_Adress][10] == 1) Reg_A <= Reg_1;
						else Reg_A <= Reg_A;
						if (mem_MK[MK_Adress][9] == 1) Reg_buf <= Reg_buf + 1;
						else Reg_buf <= Reg_buf;
						if (mem_MK[MK_Adress][8] == 1) Reg_B <= Reg_2;
						else Reg_B <= Reg_B;
						if (mem_MK[MK_Adress][7] == 1) Reg_buf <= Reg_AdressMem;
						else Reg_buf <= Reg_buf;
						if (mem_MK[MK_Adress][6] == 1) Reg_sd <= 0;
						else Reg_sd <= Reg_sd;
						if (mem_MK[MK_Adress][5] == 1) counter_cikl <= 7;
						else counter_cikl <= counter_cikl;
						if (mem_MK[MK_Adress][4] == 1) counter_cikl <= counter_cikl - 1;
						else counter_cikl <= counter_cikl;
						if (mem_MK[MK_Adress][3] == 1) Reg_1[7] <= 0;
						else Reg_1[7] <= Reg_1[7];
						if (mem_MK[MK_Adress][2] == 1) Reg_2[7] <= 0;
						else Reg_2[7] <= Reg_2[7];
						if (mem_MK[MK_Adress][1] == 1) Reg_SUM[15] <= Tzn;
						else Reg_SUM[15] <= Reg_SUM[15];
						if (mem_MK[MK_Adress][0] == 1) Reg_SUM[15:8] <= Reg_A + Reg_B;
						else Reg_SUM[15:8] <= Reg_SUM[15:8];
						if (MK_Adress == 17)
							begin
								if (condition1 == 1) MK_Adress <= 18;
								else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
							end
						else if (MK_Adress == 7)
							begin
								if (condition2 == 1)
									begin
										if (condition3 == 1) MK_Adress <= 9;
										else MK_Adress <= 8;
									end
								else MK_Adress <= mem_next_MK_Adress[MK_Adress][4:0];
							end
						else if (MK_Adress == 11)
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
				else
					begin
						Reg_AdressMem <= Reg_AdressMem;
						counter <= counter;
						Reg_ReadMem <= Reg_ReadMem;
						mem[Reg_AdressMem] <= mem[Reg_AdressMem];
						Reg_Com = Reg_Com;
						Reg_AdressMem <= Reg_AdressMem;
						Reg_1 <= Reg_1;
						Reg_2 <= Reg_2;
						Reg_B <= Reg_B;
						Reg_SUM <= Reg_SUM;
						Tzn <= Tzn;
						Reg_d <= Reg_d;
						Reg_sd <= Reg_sd;
						Reg_A <= Reg_A;
						Reg_buf <= Reg_buf;
						counter_cikl <= counter_cikl;
						MK_Adress <= MK_Adress;
					end
			end
		else
			begin
				Reg_AdressMem <= Reg_AdressMem;
				counter <= counter;
				Reg_ReadMem <= Reg_ReadMem;
				mem[Reg_AdressMem] <= mem[Reg_AdressMem];
				Reg_Com = Reg_Com;
				Reg_AdressMem <= Reg_AdressMem;
				Reg_1 <= Reg_1;
				Reg_2 <= Reg_2;
				Reg_B <= Reg_B;
				Reg_SUM <= Reg_SUM;
				Tzn <= Tzn;
				Reg_d <= Reg_d;
				Reg_sd <= Reg_sd;
				Reg_A <= Reg_A;
				Reg_buf <= Reg_buf;
				counter_cikl <= counter_cikl;
				MK_Adress <= MK_Adress;
			end
	end
end

always_ff @(posedge clock)
begin
	if (reset == 1)
		begin
			condition1 <= condition1;
			condition2 <= condition2;
			condition3 <= condition3;
			condition4 <= condition4;
			condition5 <= condition5;
			condition6 <= condition6;
		end
	else
		begin
			if (counter_cikl != 0) condition1 <= 0;
			else condition1 <= 1; 
			condition2 <= (Reg_2[0] ^ Reg_sd) & Reg_d;
			condition3 <= Reg_2 & ((Reg_2[0] ^ Reg_sd) & Reg_d);
			condition4 <= Reg_2[7] | Reg_2[6] | Reg_2[5] | Reg_2[4] | Reg_2[3] | Reg_2[2] | Reg_2[1] | Reg_2[0];
			condition5 <= Reg_A;
			condition6 <= Reg_A | Reg_B;
		end
end

endmodule