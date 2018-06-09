module ALU
(
logic [38:0] ventil;
logic [43:0] MK;
logic [4:0] MK_adress;
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
logic [39:0] mem [7:0];
logic [7:0] Reg_buf;
)

if (MK_adress = 0)
	begin
		Reg_AdressMem <= counter;
		Reg_A <= 0;
		Reg_SUM <= 0;
		Reg_d <= 0;
		Reg_sd <= 0;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 1)
	begin
		counter <= counter + 1;
		Reg_ReadMem <= mem [Reg_AdressMem] [7:0];
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 2)
	begin
		Reg_Com = Reg_ReadMem;        sadasdsasdasdas
		Reg_AdressMem <= reg_Com[2:0];
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 3)
	begin
		Reg_ReadMem <= mem [Reg_AdressMem] [7:0];
		Reg_2 <= Reg_ReadMem;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 4)
	begin
		Reg_AdressMem <= reg_Com[5:3];
		Reg_2 <= Reg_ReadMem;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 5)
	begin
		Reg_ReadMem <= mem [Reg_AdressMem] [7:0];
		Reg_buf <= Reg_AdressMem;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 6)
	begin
		Reg_1 = Reg_ReadMem;       /////////////////////////////////////////////!!!!!!!!!!!!!!
		Tzn <= Reg_1[7] ^ Reg_2[7];
		Reg_buf <= Reg_buf + 1
		Counter_cikl <= 7;     
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 7)
	begin
		Reg_1[7] <= 0;
		Reg_2[7] <= 0;
		if (Condition2 = 1) 
			begin
				if (condition3 = 1) MK_adress <= 9;
				else MK_adress <= 8;
			end
		else MK_adress <= MK[4:0];
	end
else if (MK_adress = 8)
	begin
		Reg_B <= Reg_1;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 9)
	begin
		Reg_B[7] <= Reg_1[7];
		Reg_B[6:0] <= !Reg_1[6:0];
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 10)
	begin
		Reg_B <= Reg_B + 1;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 11)
	begin
		Reg_SUM[15:8] <= Reg_A + Reg_B
		if (Condition4 = 1) 
			begin
				if (condition6 = 1) MK_adress <= 13;
				else MK_adress <= 12;
			end
		else MK_adress <= MK[4:0];
	end
else if (MK_adress = 12)
	begin
		Reg_SUM <= Reg_SUM >> 1;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 13)
	begin
		Reg_SUM <= Reg_SUM >> 1;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 14)
	begin
		Reg_SUM[15] <= 1;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 15)
	begin
		Reg_SUM[15:8] <= Reg_A;
		MK_adress <= MK[4:0];
	end
else if (MK_adress = 16)
	begin
		Reg_SUM = Reg_SUM >> 1;
		if (condition5 = 1) MK_adress <= 14;
		else MK_adress <= MK[4:0];
	end
else if (MK_adress = 17)
	begin
		Reg_d <= Reg_d >> 1;
		Reg_sd <= Reg_2[0]
		Reg_A <= Reg_SUM[15:8]
		if (condition1 = 1) MK_adress <= 18;
		else MK_adress <= MK[4:0];
	end
else if (MK_adress = 18)
	begin
		
	end
else if (MK_adress = 19)
	begin
		
	end
else if (MK_adress = 20)
	begin
		
	end
else if (MK_adress = 21)
	begin
		
	end
else if (MK_adress = 22)
	begin
		
	end
else if (MK_adress = 23)
	begin
		
	end
else if (MK_adress = )
	begin
		
	end
else if (MK_adress = )
	begin
		
	end
else MK_adress <= 0;	







	