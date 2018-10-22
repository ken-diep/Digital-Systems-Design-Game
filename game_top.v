`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2017 15:54:39
// Design Name: 
// Module Name: game_top
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



module game_top(

    
    input wire clk,
    input wire centre,
    input left,
    input right, 
    input up, 
    input wire sw,
    input down,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output [7:0] an,
    output wire hsync,
    output wire vsync

    );
    wire [10:0] curr_x; 
    wire [9:0] curr_y;
    wire [3:0] tpix_r;
    wire [3:0] tpix_g;
    wire [3:0] tpix_b;
    wire [10:0] blkpos_x1;
    wire [9:0] blkpos_y1;
    wire [9:0] top1;
    wire [9:0] top2;
    wire [9:0] top3;
    wire [9:0] top4;
    wire [9:0] top5;
    wire pixclk;
    wire posclk;

    wire [10:0] leftgap1;
    wire [10:0] rightgap1;
    wire [10:0] leftgap2;
    wire [10:0] rightgap2;
    wire [10:0] leftgap3;
    wire[10:0] rightgap3;
    
 clkgen clkgen(.clk(clk), .posclk(posclk), .pixclk(pixclk));        
 vga_out game( .clk(pixclk), .red_in(tpix_r), .blu_in(tpix_b), .gre_in(tpix_g), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));
 drawcon draw( .sw(sw), .top1(top1), .top2(top2),.top3(top3),.top4(top4),.top5(top5), .blkpos_x(blkpos_x1), .blkpos_y(blkpos_y1), .draw_x(curr_x), .draw_y(curr_y), .draw_r(tpix_r), .draw_g(tpix_g), .draw_b(tpix_b),.leftgap1(leftgap1),.rightgap1(rightgap1), .leftgap2(leftgap2),.rightgap2(rightgap2),.leftgap3(leftgap3),.rightgap3(rightgap3)); 
 Position pos(.sw(sw), .posclk(posclk), .centre(centre), .right(right), .left(left), .down(down), .up(up), .blkpos_x(blkpos_x1), .blkpos_y(blkpos_y1), .top1(top1), .top2(top2),.top3(top3),.top4(top4),.top5(top5),.leftgap1(leftgap1),.rightgap1(rightgap1), .leftgap2(leftgap2),.rightgap2(rightgap2),.leftgap3(leftgap3),.rightgap3(rightgap3));    
 level level(.rst(centre), .clk(pixclk), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .an(an));


endmodule
