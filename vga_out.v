`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2017 14:17:05
// Design Name: 
// Module Name: vga_out
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


module vga_out(
    input clk,
    input [3:0] red_in,
    input [3:0] blu_in,
    input [3:0] gre_in,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output wire hsync,
    output wire vsync,
    output reg [10:0] curr_x,
    output reg [9:0] curr_y
    );
    
    reg [10:0] hcount = 0;
    reg [9:0]  vcount = 0;

        
    always@(posedge clk)
	begin
	if (hcount <= 11'd1903) //1904
		begin
			hcount <= hcount + 1'b1; 
		end
	else 
		begin
			hcount <= 11'd0;
			if (vcount <= 10'd931) //931
				begin
					vcount <= vcount + 1'b1;
				end
			else
				begin
					vcount <= 10'd0;
				end
		end

	end
        
	assign hsync = (hcount <= 11'd151 && hcount >= 11'd0) ? 0:
					1;
	assign vsync = (vcount <= 2'd2 && vcount >= 0) ? 1:
					0; 
    
    always@(posedge clk)
    begin
        if ((hcount<=11'd1823 && 11'd384<=hcount) && (10'd31<=vcount && vcount<=10'd930))
			begin
				if (curr_x<11'd1439)
					begin
					 curr_x <= curr_x + 1'd1; 
					end
				 else 
					begin 
						curr_x <= 11'd0;
						if (curr_y<10'd899)
							begin
								curr_y <= curr_y + 1'd1;  
							end
						else
							begin
								curr_y <= 10'd0;
							end
					end
           
        
			end
    end      
    
    localparam hmax = 1823;
    localparam hmin = 384;
    localparam vmax = 930;
    localparam vmin = 31;

    assign pix_r = ((hcount <= hmax && hcount >= hmin) && (vcount >= vmin && vcount <= vmax)) ? red_in:
                    0;
    assign pix_b = ((hcount <= hmax && hcount  >= hmin) && (vcount >= vmin && vcount <= vmax)) ? blu_in:
                    0;
    assign pix_g = ((hcount <= hmax && hcount  >= hmin) && (vcount >= vmin && vcount <= vmax)) ? gre_in:
                    0;        
                            
endmodule
