module ALU
(
logic [38:0] ventil;
logic [43:0] MK;
logic [4:0] MK_Adress;
logic [4:0] next_MK_adress;
input logic [7:0] Reg_1;
input logic [7:0] Reg_2;
input logic [15:0] Reg_SUM;endmodule
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
logic Condition1, Condition2, Condition3, Condition4, Condition5, Condition6;
logic [7:0] mem [39:0];
logic [7:0] Reg_buf;
logic [38:0] mem_MK [23:0];
//logic [4:0] mem_MK_Adress [23:0];
logic [4:0] mem_next_MK_Adress [23:0];
)

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


/*1 */ Reg_AdressMem <= counter;
/*2 */ counter <= counter + 1;
/*3 */ Reg_ReadMem <= mem[Reg_AdressMem][7:0];
/*4 */ mem[Reg_AdressMem][7:0] <= Reg_ReadMem;
/*5 */ Reg_Com = Reg_ReadMem;
/*6 */ Reg_AdressMem <= reg_Com[5:3];
/*7 */ Reg_AdressMem <= reg_Com[2:0];
/*8 */ Reg_1 <= Reg_ReadMem;
/*9 */ Reg_2 <= Reg_ReadMem; 
/*10*/ Reg_B[7] <= Reg_1[7];
/*11*/ Reg_SUM[15] <= 1;
/*12*/ Reg_B[6:0] <= !Reg_1[6:0];
/*13*/ Tzn <= Reg_1[7] ^ Reg_2[7];
/*14*/ Reg_B <= Reg_B + 1;
/*15*/ Reg_B <= !Reg_2;
/*16*/ Reg_d <= 0;
/*17*/ Reg_d <= Reg_d >> 1;
/*18*/ Reg_sd <= Reg_2[0];
/*19*/ Reg_2 <= Reg_2 >> 1;
/*20*/ Reg_A <= 0;
/*21*/ Reg_AdressMem <= Reg_buf;
/*22*/ Reg_SUM[15:8] <= Reg_A;
/*23*/ Reg_SUM <= 0;
/*24*/ Reg_SUM <= Reg_SUM >> 1;
/*25*/ Reg_A <= Reg_SUM[15:8];
/*26*/ Reg_ReadMem <= Reg_SUM[7:0];
/*27*/ Reg_B <= Reg_1;
/*28*/ Reg_ReadMem <= Reg_SUM[15:8]
/*29*/ Reg_A <= Reg_1;
/*30*/ Reg_buf <= Reg_buf + 1
/*31*/ Reg_B <= Reg_2;
/*32*/ Reg_buf <= Reg_AdressMem;
/*33*/ Reg_sd <= 0;     
/*34*/ counter_cikl <= 7; 
/*35*/ counter_cikl <= counter_cikl - 1;
/*36*/ Reg_1[7] <= 0;
/*37*/ Reg_2[7] <= 0;
/*38*/ Reg_SUM[15] <= Tzn;
/*39*/ Reg_SUM[15:8] <= Reg_A + Reg_B;    
















































if (MK_Adress = 0)
	begin
		Reg_AdressMem <= counter;
		Reg_A <= 0;
		Reg_SUM <= 0;
		Reg_d <= 0;
		Reg_sd <= 0;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 1)
	begin
		counter <= counter + 1;
		Reg_ReadMem <= mem[Reg_AdressMem][7:0];
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 2)
	begin
		Reg_Com = Reg_ReadMem;
		Reg_AdressMem <= reg_Com[2:0];
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 3)
	begin
		Reg_ReadMem <= mem [Reg_AdressMem][7:0];
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 4)
	begin
		Reg_AdressMem <= reg_Com[5:3];
		Reg_2 <= Reg_ReadMem;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 5)
	begin
		Reg_ReadMem <= mem [Reg_AdressMem] [7:0];
		Reg_buf <= Reg_AdressMem;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 6)
	begin
		Reg_1 = Reg_ReadMem;      
		Tzn <= Reg_1[7] ^ Reg_2[7];
		Reg_buf <= Reg_buf + 1
		counter_cikl <= 7;     
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 7)
	begin
		Reg_1[7] <= 0;
		Reg_2[7] <= 0;
		if (Condition2 = 1) 
			begin
				if (condition3 = 1) MK_Adress <= 9;
				else MK_Adress <= 8;
			end
		else MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 8)
	begin
		Reg_B <= Reg_1;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 9)
	begin
		Reg_B[7] <= Reg_1[7];
		Reg_B[6:0] <= !Reg_1[6:0];
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 10)
	begin
		Reg_B <= Reg_B + 1;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 11)
	begin
		Reg_SUM[15:8] <= Reg_A + Reg_B
		if (Condition4 = 1) 
			begin
				if (condition6 = 1) MK_Adress <= 13;
				else MK_Adress <= 12;
			end
		else MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 12)
	begin
		Reg_SUM <= Reg_SUM >> 1;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 13)
	begin
		Reg_SUM <= Reg_SUM >> 1;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 14)
	begin
		Reg_SUM[15] <= 1;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 15)
	begin
		Reg_SUM[15:8] <= Reg_A;
		MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 16)
	begin
		Reg_SUM = Reg_SUM >> 1;
		if (condition5 = 1) MK_Adress <= 14;
		else MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 17)
	begin
		Reg_d <= Reg_d >> 1;
		Reg_sd <= Reg_2[0]
		Reg_A <= Reg_SUM[15:8]
		if (condition1 = 1) MK_Adress <= 18;
		else MK_Adress <= MK[4:0];
	end
else if (MK_Adress = 18)
	begin
		Reg_2 = Reg_2 >> 1;
		counter_cikl <= counter_cikl - 1;
	end
else if (MK_Adress = 19)
	begin
		Reg_SUM[15] <= Tzn;
	end
else if (MK_Adress = 20)
	begin
		Reg_ReadMem <= Reg_SUM[15:8]
	end
else if (MK_Adress = 21)
	begin
		mem[Reg_AdressMem][7:0] = Reg_ReadMem;
		Reg_AdressMem = Reg_buf;
	end
else if (MK_Adress = 22)
	begin
		Reg_ReadMem <= Reg_SUM[7:0]
	end
else if (MK_Adress = 23)
	begin
		mem[Reg_AdressMem][7:0] = Reg_ReadMem;
	end
else MK_Adress <= 0;	







	