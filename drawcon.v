`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2017 14:19:23
// Design Name: 
// Module Name: drawcon
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


module drawcon(
    input sw, //Switch will determine game difficulty
    input [9:0] top1, //Informs module where the platform is
    input [9:0] top2,
    input [9:0] top3,
    input [9:0] top4,
    input [9:0] top5,
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    input [10:0] draw_x,
    input [9:0] draw_y,
    output wire [3:0] draw_r,
    output wire [3:0] draw_g,
    output wire [3:0] draw_b,
    output reg [10:0] leftgap1, //x coordinate of where gap begins in platform 1
    output reg [10:0] rightgap1, //x coordinate of where gap end in platform 1
    output  reg [10:0] leftgap2,
    output reg [10:0] rightgap2,
    output  reg [10:0] leftgap3,
    output  reg [10:0] rightgap3
    );
    
    reg [3:0] bg_r; //colour of background
    reg [3:0] bg_g;
    reg [3:0] bg_b;
    reg [3:0] blk_r; //colour of block
    reg [3:0] blk_g;
    reg [3:0] blk_b;
    
    localparam xmax = 1429; //right border
    localparam xmin = 10;	//left border
    localparam ymax = 889;	//top border
    localparam ymin = 10;	//bottom border
    localparam white = 4'b1111;
    localparam black = 4'b0000;
    reg [3:0] colour, colour2;
    

    
    always@(*)
    begin
        if (sw) //colour of stage and gap size change depending on switch 
        begin
            leftgap1 = 11'd150; 
            rightgap1 = 11'd550;
            leftgap2 = 11'd950;
            rightgap2 = 11'd1350;
            leftgap3 = 11'd520;
            rightgap3 = 11'd870;
            colour2 = 4'b1010; 
            colour = 4'b0011;
        end
        else 
        begin
            leftgap1 = 11'd200; 
            rightgap1 = 11'd450;
            leftgap2 = 11'd900;
            rightgap2 = 11'd1200;
            leftgap3 = 11'd580;
            rightgap3 = 11'd800;
            colour2 = 4'b0100;
            colour = 4'b1011;
        end
    end
    

    always@(*)
        begin
            if ( (draw_y >= top1 && draw_y <= top1 + 6'd25 && (draw_x > rightgap1 || draw_x < leftgap1) ) 
                || (draw_y >= top2 && draw_y <= top2 + 6'd25 && (draw_x > rightgap2 || draw_x < leftgap2)) 
                || (draw_y >= top3 && draw_y <= top3 + 6'd25 && (draw_x > rightgap3 || draw_x < leftgap3))
                || (draw_y >= top4 && draw_y <= top4 + 6'd25 && (draw_x > rightgap1 || draw_x < leftgap1)) 
                || (draw_y >= top5 && draw_y <= top5 + 6'd25 && (draw_x > rightgap2 || draw_x < leftgap2)) ) //platform drawing
                begin
                    bg_r <= colour2;
                    bg_g <= colour2;
                    bg_b <= colour2;
                end
            else if ((draw_x < xmax) && (xmin < draw_x)  && (draw_y < ymax) && (ymin < draw_y))
                begin
                    bg_r <= colour;
                    bg_g <= colour;
                    bg_b <= colour;
                end
            else
                begin
                    bg_r <= white;
                    bg_g <= 0;
                    bg_b <= 0;
                end
        
        end
        
    always@(*)
        begin
           if ( (blkpos_x <= draw_x)  && (draw_x <= blkpos_x+6'd32) && (blkpos_y <= draw_y) && (draw_y <= blkpos_y+6'd32) )
                begin
                    blk_r <= 4'b0101;
                    blk_g <= 4'b0101;
                    blk_b <= 4'b0101;
                end 
            else
                begin
                    blk_r <= 0;
                    blk_g <= 0;
                    blk_b <= 0;
                end
        end
    
    assign draw_r = (blk_r > 0) ? blk_r: 
                     bg_r;
    assign draw_g = (blk_g > 0) ? blk_g: 
                     bg_g;
    assign draw_b = (blk_b > 0) ? blk_b: 
                     bg_b;
                     

endmodule
