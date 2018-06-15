`timescale 1ns/1ns
//Описание работы тестовой программы
module test

	(
//		input	logic		[3:0] low_sec_dig,
//		input	logic		[2:0]	high_sec_dig,
//		
//		input	logic				second,
//    input	logic				minute
output logic clock,
output logic reset,
output logic button,
output logic switch

	);
  // Объявление внутренних переменных
  
  //Процедурный блок. Все операции процедурного блока между begin и end выполняются последовательно,
  //т.е. как в обычном языке программирования (например С++)
  initial begin
    //Инициализация без затраты модельного времени
    //Инициализация начальных значений выходных линий
    clock = 0;
    reset = 1;
    //Инициализация начальных значений переменных
    button = 0;
	switch = 0;
	    
    //Процедурный блок fork ... join состоит из несккольких последовательных блоков, которые в свою очередь,
    //выполняются параллельно относительно друг друга.
    fork 
      //Первый последовательный блок
      //Определение бесконечного цикла генерации сигнала синхрочастоты
      forever #1 clock = ~clock;        //#5 - означет задержку в модельном времени перед изменением сигнала
                                    //относительно времени от предыдущего оператора. Единица измерения задержки
                                    //первое значение в команде директиве timescale
      //Второй последовательный блок
      //Описание сигнала сброса
      
	  forever begin
	  #2 reset = ~reset;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 button = ~button;
	  #1000 switch = ~switch;
	  #10000 reset = ~reset;
	  end
 
      begin
        $display ("------------------------ATTENTION------------------------------");
        $display ("Please add additional wave to waveform and run simulation");
        $display ("Menu Simulate/Run/Run -all or write command run -all to console");
        $display ("------------------------ATTENTION------------------------------");
        $stop();
      end
      
    join    // Окончание параллельного блока
  
  end
  
  
endmodule