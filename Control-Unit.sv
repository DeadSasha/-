module Control_Unit
(
input logic button,
input logic reset,
input logic clock,
input logic switch,
output logic [6:0] ssegment0,
output logic [6:0] ssegment1,
output logic [6:0] ssegment2,
output logic [6:0] ssegment4,
output logic [6:0] ssegment5,
output logic [6:0] ssegment6
);

logic [6:0] counter_settings;
logic work_button;
logic [6:0] memory;

antidrebezg button0
(
	.clock					(clock),
	.reset					(reset),
	.button					(~button),
	.pulse					(work_button)
);



always_ff @(posedge clock)				
begin
if (reset == 1) counter_settings <= 0;
else  
	begin
		if (work_button == 1) 
			begin
				if (counter_settings < 16) counter_settings <= counter_settings + 1;
				else counter_settings <= 0;
			end
      else counter_settings <= counter_settings;
	end
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


logic v1,	v2,	v3,	v4,	v5,	v6,	v7,	v8,	v9,	v10,	v11,	v12,	v13,	v14,	v15,	v16,	v17,	v18,	v19,	v20,	v21,	v22,	v23,	v24,	v25,	v26,	v27,	v28,	v29,	v30,	v31,	v32,	v33,	v34,	v35,	v36,	v37,	v38,	v39;
logic [4:0] MK_Adress;
logic [7:0] Reg_1;
logic [7:0] Reg_2;
logic [15:0] Reg_SUM;
logic [7:0] Reg_A;
logic [7:0] Reg_B;
logic [1:0] Reg_d;
logic Reg_sd;
logic Tzn;
logic [38:0] MK;
logic [3:0]counter;
logic [3:0]counter_cikl;
logic [7:0] Reg_Com;
logic [7:0] Reg_ReadMem;
logic [7:0] Reg_AdressMem;
logic condition1, condition2, condition3, condition4, condition5, condition6;
logic [7:0] mem [16] = '{ 
									{8'b01110111},
									{8'b01100101},
									{8'b01010110},
									{8'b01000100},
									{8'b00000010},	
									{8'b00001010},	
									{8'b01100100},	
									{8'b01111011},	
									{8'b00000010},	
									{8'b00000000},	
									{8'b00000111},	
									{8'b00000000},	
									{8'b00011010},	
									{8'b00000000},	
									{8'b00100111},	
									{8'b00000000}};
logic [7:0] Reg_buf;
logic [38:0] mem_MK [24] = '{   
									  {39'b100000000000000100010010000000001000000},
									  {39'b011000000000000000000000000000000000000},
									  {39'b000010100000000000000000000000000000000},
									  {39'b001000000000000000000000000000000000000},
									  {39'b000001001000000000000000000000000000000},
									  {39'b001000000000000000000000000000010000000},
									  {39'b000000010000100000000000000001000100000},
									  {39'b000000000001000000000000000000000001100},
									  {39'b000000000000000000000000001000000000000},
									  {39'b000000000100000000000000000000000000000},
									  {39'b000000000000010000000000000000000000000},
									  {39'b000000000000000000000000000000000000001},
									  {39'b000000000000000000000001000000000000000},
									  {39'b000000000000000000000001000000000000000},
									  {39'b000000000010000000000000000000000000000},
									  {39'b000000000000000000000100000000000000000},
									  {39'b000000000000000000000001000000000000000},
									  {39'b000000000000000011000000100000000000000},
									  {39'b000000000000000000100000000000000010000},
									  {39'b000000000000000000000000000000000000010},
									  {39'b000000000000000000000000000100000000000},
									  {39'b000100000000000000001000000000000000000},
									  {39'b000000000000000000000000010000000000000},
									  {39'b000100000000000000000000000000000000000}};
logic [4:0] mem_next_MK_Adress [24] = '{ 
														{5'b00001},
														{5'b00010},
														{5'b00011},
														{5'b00100},
														{5'b00101},
														{5'b00110},
														{5'b00111},
														{5'b01111},
														{5'b01011},
														{5'b01010},
														{5'b01011},
														{5'b01100},
														{5'b10001},
														{5'b01110},
														{5'b10001},
														{5'b10000},
														{5'b10001},
														{5'b10011},
														{5'b00111},
														{5'b10100},
														{5'b10101},
														{5'b10110},
														{5'b10111},
														{5'b00000}};
logic start;
logic work_en;


always_comb
begin
	MK = mem_MK[MK_Adress];
end




always_comb
begin
	v1 = MK[0];
	v2 = MK[1];
	v3 = MK[2];
	v4 = MK[3];
	v5 = MK[4];
	v6 = MK[5];
	v7 = MK[6];
	v8 = MK[7];
	v9 = MK[8];
	v10 = MK[9];
	v11 = MK[10];
	v12 = MK[11];
	v13 = MK[12];
	v14 = MK[13];
	v15 = MK[14];
	v16 = MK[15];
	v17 = MK[16];
	v18 = MK[17];
	v19 = MK[18];
	v20 = MK[19];
	v21 = MK[20];
	v22 = MK[21];
	v23 = MK[22];
	v24 = MK[23];
	v25 = MK[24];
	v26 = MK[25];
	v27 = MK[26];
	v28 = MK[27];
	v29 = MK[28];
	v30 = MK[29];
	v31 = MK[30];
	v32 = MK[31];
	v33 = MK[32];
	v34 = MK[33];
	v35 = MK[34];
	v36 = MK[35];
	v37 = MK[36];
	v38 = MK[37];
	v39 = MK[38];
end

always_ff @(posedge clock)				
begin
if (reset == 1) memory <= 0;
else memory <= mem[counter_settings][6:0];
end


always_ff @(posedge clock)								
begin
if (reset == 1) start <= 0;
else  
	begin
		if (switch == 1) start <= 1;
      else start <= 0;
	end
end

always_ff @(posedge clock)
begin
	if (reset == 1) work_en <=0;
	else
		begin
			if (counter < 5) work_en <= 1;
			else work_en <= 0;
		end
end

always_ff @(posedge ~clock)
begin
if (reset == 1)
	begin
		Reg_AdressMem <= 0;
	end
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v39 == 1) Reg_AdressMem = counter;
						if (v34 == 1) Reg_AdressMem = Reg_Com[6:3];
						if (v19 == 1) Reg_AdressMem = Reg_buf;
						if (v33 == 1) Reg_AdressMem = Reg_Com[2:0];
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) counter = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v38 == 1) counter = counter + 1;
					end
			end
	end
end
						
						
always_ff @(posedge clock)
begin
if (reset == 1) Reg_ReadMem = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v37 == 1) Reg_ReadMem = mem[Reg_AdressMem][7:0];
						if (v14 == 1) Reg_ReadMem = Reg_SUM[7:0];
						if (v12 == 1) Reg_ReadMem = Reg_SUM[15:8];
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (start == 1)
	begin	
		if (work_en == 1)
			begin
				if (v36 == 1) mem[Reg_AdressMem][7:0] = Reg_ReadMem;
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_Com = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v35 == 1) Reg_Com = Reg_ReadMem;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_2 = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v31 == 1) Reg_2 = Reg_ReadMem;
						if (v21 == 1) Reg_2 = Reg_2 >> 1;
						if (v3 == 1) Reg_2[7] = 0;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_B = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v30 == 1) Reg_B[7] = 1;
						if (v28 == 1) 
							begin
								Reg_B[7] = ~Reg_1[7];
								Reg_B[6] = ~Reg_1[6];
								Reg_B[5] = ~Reg_1[5];
								Reg_B[4] = ~Reg_1[4];
								Reg_B[3] = ~Reg_1[3];
								Reg_B[2] = ~Reg_1[2];
								Reg_B[1] = ~Reg_1[1];
								Reg_B[0] = ~Reg_1[0];
							end
						if (v26 == 1) Reg_B = Reg_B + 1;
						if (v25 == 1) Reg_B = ~Reg_2;
						if (v13 == 1) Reg_B = Reg_1; 
						if (v9 == 1) Reg_B = Reg_2;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Tzn = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v27 == 1) Tzn = Reg_1[7] ^ Reg_2[7];
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_d = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						Reg_d[1] = (Reg_2[0] ^ Reg_sd) & ~Reg_d[0];
						if (v24 == 1) Reg_d = 0;
						if (v23 == 1) Reg_d = Reg_d >> 1;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_SUM = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v17 == 1) Reg_SUM = 0;
						if (v16 == 1) Reg_SUM = Reg_SUM >> 1;
						if (v2 == 1) Reg_SUM[15] = Tzn;
						if (v18 == 1) Reg_SUM[15:8] = Reg_A;
						if (v29 == 1) Reg_SUM[15] = 1;
						if (v1 == 1) Reg_SUM[15:8] = Reg_A + Reg_B;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_A = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v15 == 1) Reg_A = Reg_SUM[15:8];
						if (v11 == 1) Reg_A = Reg_1;
						if (v20 == 1) Reg_A = 0;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_buf = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v10 == 1) Reg_buf = Reg_buf + 1;
						if (v8 == 1) Reg_buf = Reg_AdressMem;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_sd = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v7 == 1) Reg_sd = 0;
						if (v22 == 1) Reg_sd = Reg_2[0];
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) counter_cikl = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v6 == 1) counter_cikl = 7;
						if (v5 == 1) counter_cikl = counter_cikl - 1;
					end
			end
	end
end

always_ff @(posedge clock)
begin
if (reset == 1) Reg_1 = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (v4 == 1) Reg_1[7] = 0;
						if (v32 == 1) Reg_1 = Reg_ReadMem;
					end
			end
	end
end

always_ff @(posedge ~clock)
begin
if (reset == 1) MK_Adress = 0;
else
	begin
		if (start == 1)
			begin	
				if (work_en == 1)
					begin
						if (MK_Adress == 17)
							begin
								if (condition1 == 1) MK_Adress = 18;
								else MK_Adress = mem_next_MK_Adress[MK_Adress][4:0];
							end
						else if (MK_Adress == 7)
							begin
								if (condition2 == 1)
									begin
										if (condition3 == 1) MK_Adress = 9;
										else MK_Adress = 8;
									end
								else MK_Adress = mem_next_MK_Adress[MK_Adress][4:0];
							end
						else if (MK_Adress == 11)
							begin
								if (condition4 == 1)
									begin
										if (condition6 == 1) MK_Adress = 13;
										else MK_Adress = 12;
									end
								else MK_Adress = mem_next_MK_Adress[MK_Adress][4:0];
							end
						else if (MK_Adress == 16)
							begin
								if (condition5 == 1) MK_Adress = 14;
								else MK_Adress = mem_next_MK_Adress[MK_Adress][4:0];
							end
						else MK_Adress = mem_next_MK_Adress[MK_Adress][4:0];
					end
			end
	end
end

			

always_ff @(posedge clock)
begin
	if (counter_cikl > 0) condition1 = 1;
	else condition1 = 0; 
	condition2 = (Reg_2[0] ^ Reg_sd) & ~Reg_d[0];
	condition3 = Reg_2[1] & Reg_d[1];
	condition4 = Reg_2[7] | Reg_2[6] | Reg_2[5] | Reg_2[4] | Reg_2[3] | Reg_2[2] | Reg_2[1] | Reg_2[0];
	condition5 = Reg_A[7];
	condition6 = Reg_A[7] | Reg_B[7];
end



endmodule