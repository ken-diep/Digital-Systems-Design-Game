`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2017 16:55:10
// Design Name: 
// Module Name: Position
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


module Position(
    input sw,
    input posclk,
    input centre,
    input right,
    input left,
    input down,
    input up,
	input [10:0] leftgap1,
    input [10:0] rightgap1,
    input [10:0] leftgap2,
    input [10:0] rightgap2,
    input [10:0] leftgap3,
    input [10:0] rightgap3
    output reg [10:0] blkpos_x,
    output reg [9:0] blkpos_y,
    output reg [9:0] top1 = 10'd170,
    output reg [9:0] top2 = 10'd340,
    output reg [9:0] top3 = 10'd510,
    output reg [9:0] top4 = 10'd680,
    output reg [9:0] top5 = 10'd850, 
    );
    
    localparam xmax = 1429;
    localparam xmin = 10;
    localparam ymax = 889;
    localparam ymin = 10;

    always@(posedge posclk)
	begin
		if (top1 + 6'd25 > ymax)
			begin
				top1 <= ymin;
			end
		else
			begin
				if (!sw)
					begin
						top1 <= top1 + 3'd4;
					end
				else
					begin
						top1 <= top1 + 3'd2;
					end
			end

		if (top2 + 6'd25 > ymax)
			begin
				top2 <= ymin;
			end
		else
			begin
			if (!sw)
				begin
					top2 <= top2 + 3'd4;
				end
			else
				begin
					top2 <= top2 + 3'd2;
				end
			end
			   
		if (top3 + 6'd25 > ymax)
			begin
				top3 <= ymin;
			end
		else
			begin
				if (!sw)
					begin
						top3 <= top3 + 3'd4;
					end
				else
					begin
						top3 <= top3 + 3'd2;
					end
			end 
			  
		if (top4 + 6'd25 > ymax)
			begin
				top4 <= ymin;
			end
		else
			begin
				if (!sw)
					begin
						top4 <= top4 + 3'd4;
					end
				else
					begin
						top4 <= top4 + 3'd2;
					end
			end 
			 
		if (top5 + 6'd25 > ymax)
			begin
				top5 <= ymin;
			end
		else
			begin
				if (!sw)
					begin
						top5 <= top5 + 3'd4;
					end
				else
					begin
						top5 <= top5 + 3'd2;
					end
			end 

	end
        
                   
    always@(posedge posclk) 
	begin  
        if (centre) //Centre overrides everything
            begin
                blkpos_x <= 11'd700;
                blkpos_y <= 10'd0;         
            end
           
        else 
            begin //Directional movements
                if (left) 
					begin
						blkpos_x <= blkpos_x - 11'd9;
					end
         
                if (right) 
					begin
						blkpos_x <= blkpos_x + 11'd9;
					end
    
                if (down) 
					begin
						 lkpos_y <= blkpos_y + 10'd9;
					end
            end
            
                 
		if (blkpos_x + 11'd32 > xmax) 
			begin //Right border detection
				blkpos_x <= xmax - 11'd32;
			end    
		
		if (blkpos_y + 10'd32 > ymax) 
			begin //Bottom border detection
				blkpos_y <= ymin;
				blkpos_x <= 11'd700;
			end
				 
		if (blkpos_x < xmin) 
			begin
				blkpos_x <= xmin; //Left border detection
			end
		
		if (blkpos_y < ymin) 
			begin
				blkpos_y <= ymin; //Top border detection
			end

		if ( (blkpos_y +10'd32 >= top1 - 3'd5 && blkpos_y + 10'd32 < top1 + 3'd6) //Top of layer1 detection
					 && ( (blkpos_x < leftgap1) || (blkpos_x  + 6'd32 > rightgap1) )) 
			begin
				blkpos_y <= top1 - 6'd32;
				if ( (up) && 
					(blkpos_x + 6'd32 < rightgap2 + 6'd5 && blkpos_x > leftgap2 - 6'd5) ) 
					begin
						blkpos_y <= blkpos_y - 10'd200;
					end
				 else if ( (up) &&
					!(blkpos_x + 6'd32 < rightgap2 + 6'd5 && blkpos_x > leftgap2 - 6'd5) )
					begin
						blkpos_y <= blkpos_y - 10'd115;
					end
			end                
		
		else if ( (blkpos_y +10'd32 >= top2 - 3'd5&& blkpos_y + 10'd32 < top2 + 3'd6) //Top of layer2 detection
					 && ( (blkpos_x < leftgap2) || (blkpos_x  + 6'd32 > rightgap2) ) ) 
			begin
				blkpos_y <= top2 - 6'd32;
				if ( (up) && 
				 (blkpos_x + 6'd32 < rightgap1 + 6'd5 && blkpos_x > leftgap1 - 6'd5) ) 
					begin
						blkpos_y <= blkpos_y - 10'd200;
					end
				else if ( (up) &&
				 !(blkpos_x + 6'd32 < rightgap1 + 6'd5 && blkpos_x > leftgap1 - 6'd5) )
					begin
						blkpos_y <= blkpos_y - 10'd115;
					end
			end
			
		else if ( (blkpos_y +10'd32 >= top3 - 3'd5 && blkpos_y + 10'd32 < top3 + 3'd6) //Top of layer3 detection
					&& ( (blkpos_x < leftgap3) || (blkpos_x  + 6'd32 > rightgap3) ) ) 
			begin
				blkpos_y <= top3 - 6'd32;
				if ( (up) && 
				(blkpos_x + 6'd32 < rightgap2 + 6'd5 && blkpos_x > leftgap2 - 6'd5) ) 
					begin
						blkpos_y <= blkpos_y - 10'd200;
					end
				else if ( (up) &&
				 !(blkpos_x + 6'd32 < rightgap2 + 6'd5 && blkpos_x > leftgap2 - 6'd5) )
					begin
						blkpos_y <= blkpos_y - 10'd115;
					end
			end

		else if ( (blkpos_y +10'd32 >= top4 - 3'd5 && blkpos_y + 10'd32 < top4 + 3'd6) //Top of layer4 detection
				   && ( (blkpos_x < leftgap1) || (blkpos_x  + 6'd32 > rightgap1) ))
			begin
				blkpos_y <= top4 - 6'd32;
					if ((up) && 
					 (blkpos_x + 6'd32 < rightgap3 + 6'd5 && blkpos_x > leftgap3 - 6'd5)) 
					  blkpos_y <= blkpos_y - 10'd200;
					else if ((up) &&
					 !(blkpos_x + 6'd32 < rightgap3 + 6'd5 && blkpos_x > leftgap3 - 6'd5))
					  blkpos_y <= blkpos_y - 10'd115;
			end

		else if ((blkpos_y +10'd32 >= top5 - 3'd5 && blkpos_y + 10'd32 < top5 + 3'd6) //Top of layer5 detection
				   && ( (blkpos_x < leftgap2) || (blkpos_x  + 6'd32 > rightgap2) )) 
			begin
				blkpos_y <= top5 - 6'd32;
					if ((up) && 
					 (blkpos_x + 6'd32 < rightgap1 + 6'd5 && blkpos_x > leftgap1 - 6'd5)) 
					  blkpos_y <= blkpos_y - 10'd200;
					else if ((up) &&
					 !(blkpos_x + 6'd32 < rightgap1 + 6'd5 && blkpos_x > leftgap1 - 6'd5))
					  blkpos_y <= blkpos_y - 10'd115;
			end  
																													 
		else 
			begin
					if (!sw)
						begin
							blkpos_y <= blkpos_y + 10'd13; //Gravity
						end
					else
						begin
							blkpos_y <= blkpos_y + 10'd7;
						end
			end    
                                         
        if ( (blkpos_x + 6'd32 > rightgap1) &&  //Gap edges of layer1 detection
            ( (blkpos_y + 10'd32 > top1+3'd6 && blkpos_y + 10'd32 < top1 + 10'd25 )
            || ( (blkpos_y + 10'd32 > top4+3'd6) && (blkpos_y + 10'd32 < top4 + 10'd25) ) ) )
            begin
                blkpos_x <= rightgap1 - 11'd33;
            end
        if ( (blkpos_x + 6'd32 > rightgap2) &&    //Gap edges of layer2 detection
            ( (blkpos_y + 10'd32 > top2+3'd6 && blkpos_y + 10'd32 < top2 + 10'd25)
            || ( (blkpos_y + 10'd32 > top5+3'd6) && (blkpos_y + 10'd32 < top5 + 10'd25) ) ) )
            begin
				blkpos_x <= rightgap2 - 11'd33;
			end
        
        if ( (blkpos_x + 6'd32 > rightgap3) && 
            ( (blkpos_y + 10'd32 > top3+3'd6) && (blkpos_y + 10'd32 < top3 + 10'd25) ) ) 
			begin
                blkpos_x <= rightgap3 - 11'd33;
			end
                
        if ( (blkpos_x < leftgap1) &&
               (( (blkpos_y + 10'd32 > top1+3'd6) && (blkpos_y + 10'd32 < top1 + 10'd25) )
               ||((blkpos_y + 10'd32 > top4+3'd6) && (blkpos_y + 10'd32 < top4 + 10'd25))))
            begin
				blkpos_x <= rightgap1 - 11'd33;
            end
               
        if ( (blkpos_x + 6'd32 > rightgap2) &&
               (( (blkpos_y + 10'd32 > top2+3'd6) && (blkpos_y + 10'd32 < top2 + 10'd25))
               || ((blkpos_y + 10'd32 > top5+3'd6) && (blkpos_y + 10'd32 < top5 + 10'd25))))
            begin
				blkpos_x <= rightgap2 - 11'd33;
			end
   
        if ( (blkpos_x + 6'd32 > rightgap3) &&
               ((blkpos_y + 10'd32 > top3+3'd6) && (blkpos_y + 10'd32 < top3 + 10'd25))) 
			begin       
                blkpos_x <= rightgap3 - 11'd33;       
			end
            
    end
     
endmodule
