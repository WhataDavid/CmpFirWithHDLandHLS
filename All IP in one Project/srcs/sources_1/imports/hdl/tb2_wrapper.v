//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Sat Apr  1 20:23:35 2023
//Host        : dx-ThinkStation-P350 running 64-bit Ubuntu 22.04.1 LTS
//Command     : generate_target tb2_wrapper.bd
//Design      : tb2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module tb2_wrapper
   (
//   addra,
//    clk,
//    ena,
    fir_hdl_out,
    fir_hls_out,
    fir_xilinx_out,
    origin_wave
//    rst
    );
//  input [12:0]addra;
//  input clk;
//  input ena;
  output [34:0]fir_hdl_out;
  output [34:0]fir_hls_out;
  output [39:0]fir_xilinx_out;
  output [15:0]origin_wave;
//  input rst;

//  wire [12:0]addra;
//  wire clk;
//  wire ena;
  wire [34:0]fir_hdl_out;
  wire [34:0]fir_hls_out;
  wire [39:0]fir_xilinx_out;
  wire [15:0]origin_wave;
//  wire rst;

    reg clk;
    reg rst;
    reg ena;
    reg[12:0]addra;

    integer dout_file1;
    integer dout_file2;
    integer dout_file3;

    initial
    begin
        #50;
        clk =0;
        rst = 1;
        ena=0;
        dout_file1=$fopen("./fir_hdl.txt"); //打开所创建的文件
        dout_file2=$fopen("./fir_hls.txt"); //打开所创建的文件
        dout_file3=$fopen("./fir_xilinx.txt"); //打开所创建的文件
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
            ena=1;
        end
    else
        begin
            addra<=13'd0;
            ena=0;
            $fclose(dout_file1);
            $fclose(dout_file2);
            $fclose(dout_file3);
            $stop;
        end

    always @(posedge clk)
    begin
        $fdisplay(dout_file1,"%d",$signed(fir_hdl_out)); //保存有符号数据	
    end

    always @(posedge clk)
    begin
        $fdisplay(dout_file2,"%d",$signed(fir_hls_out)); //保存有符号数据	
    end

    always @(posedge clk)
    begin
        $fdisplay(dout_file3,"%d",$signed(fir_xilinx_out)); //保存有符号数据	
    end
    
  tb2 tb2_i
       (.addra(addra),
        .clk(clk),
        .ena(ena),
        .fir_hdl_out(fir_hdl_out),
        .fir_hls_out(fir_hls_out),
        .fir_xilinx_out(fir_xilinx_out),
        .origin_wave(origin_wave),
        .rst(rst));
endmodule
