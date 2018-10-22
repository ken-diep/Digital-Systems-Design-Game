`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2017 17:13:33
// Design Name: 
// Module Name: clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkgen(
    input clk,
    output posclk,
    output wire pixclk
    );
    
clk_wiz_0 instance_name
(
// Clock out ports
.clk_out1(pixclk),     // output clk_out1
// Clock in ports
.clk_in1(clk));      // input clk_in1

reg clk2 = 0;
reg [21:0] counter = 0; 

always@(posedge pixclk) //clock divider, 60Hz
begin
if (counter > 22'd1774483) //1774484
    begin
		counter <= 0;
		clk2 <= ~clk2;
    end
else
	begin
		counter <= counter + 1'd1;
	end
end

assign posclk = clk2;

endmodule
