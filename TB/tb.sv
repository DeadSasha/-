//Директива определения точности моделирования 
`timescale 1ns/1ns
//Объявление модуля testbench - являющегося модулем сборки
//тестируемого устройства и программы, которая его тестирует,
//т.е. модуль организует интерфейс между ними
module tb ();

//Объявление самого интерфейса (проводов) между программой и модулем
logic clock;
logic reset;
logic button;
logic switch;

//Объявление экземпляра тестовой программы
test TEST 
  (
	.clock				(clock		),
	.reset				(reset		),
	.button				(button		),
	.switch				(switch		)
  );

//Объявление экземпляра устройства  
Control_Unit CN
(
	.clock				  (clock		),
	.reset				  (reset		),
	.button				  (button		),
	.switch				  (switch		),
	.ssegment0			(),
	.ssegment1			(),
	.ssegment2			(),
	.ssegment4			(),
	.ssegment5			(),
	.ssegment6			()
);

endmodule