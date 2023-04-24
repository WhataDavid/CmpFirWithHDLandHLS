//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Sat Apr  1 20:13:08 2023
//Host        : dx-ThinkStation-P350 running 64-bit Ubuntu 22.04.1 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module design_1_wrapper
   (
//   addra,
    bmg_out,
//    clk,
    fir_hdl_out,
//    rst
    );
//  input [12:0]addra;
  output [15:0]bmg_out;
//  input clk;
  output [34:0]fir_hdl_out;
//  input rst;

//  wire [12:0]addra;
  wire [15:0]bmg_out;
//  wire clk;
  wire [34:0]fir_hdl_out;
//  wire rst;

    reg clk;
    reg rst;
    reg[12:0]addra;
    initial
    begin
        #50;
        clk =0;
        rst = 1;
        #50;
        rst = 0;
    end

    always #6.25 clk = ~clk;
    always@(posedge clk or posedge rst)
    if(rst)
        addra <= 13'd0;
    else if(addra<13'b1111111111111)
        begin
            addra <= addra + 1'd1;
        end
    else
        begin
            addra<=13'd0;
            $stop;
        end
        
  design_1 design_1_i
       (.addra(addra),
        .bmg_out(bmg_out),
        .clk(clk),
        .fir_hdl_out(fir_hdl_out),
        .rst(rst));
endmodule
