`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2023 12:29:22 PM
// Design Name: 
// Module Name: fir16hdl
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


module fir16hdl(
input wire [15:0] input_data, 
input wire clk,
input wire rst,
output wire [31:0] hdl_fir_output
    );

wire [15:0] coe_array [8:0];
assign coe_array[0] = 16'd6;
assign coe_array[1] = 16'd7;
assign coe_array[2] = 16'd55;
assign coe_array[3] = 16'd135;
assign coe_array[4] = 16'd175;
assign coe_array[5] = 16'd135;
assign coe_array[6] = 16'd55;
assign coe_array[7] = 16'd7;
assign coe_array[8] = 16'd6;

reg [4:0] i,j,k;
reg signed [15:0] delay_pipeline_array [8:0];
reg signed [31:0] output_data;
reg valid_pipeline;
/*��һ����ˮ���������źŽ�����ʱ��ÿ����һ��ʱ���źţ��㽫�����źű��浽delay_pipelin1�У�Ȼ��ʣ�µ������ƶ�һλ��*/
always@(posedge clk or posedge rst)
      if(rst)
           for(i=0;i<9;i=i+1)
                delay_pipeline_array[i] <= 16'b0;
       else 
                begin
                      delay_pipeline_array[0] <= input_data;
                      for(i=0;i<8;i=i+1)
                        delay_pipeline_array[i+1] <= delay_pipeline_array[i];                     
                      valid_pipeline = 1'b1;
               end
               
reg signed [31:0] multi_data_array [8:0];
reg   valid_multi ;
always@(posedge clk or posedge rst) 
begin
    if(rst) 
        for(i=0;i<9;i=i+1)
            multi_data_array[i] <= 32'b0;
    else if(valid_pipeline)
        begin
            for(i=0;i<9;i=i+1)
                multi_data_array[i] <= delay_pipeline_array[i]*coe_array[i];
//            multi_data_array[31] <= delay_pipeline_array[31]*coe_array[31];
            valid_multi = 1'b1;
        end
end
//  ���˻��ۼӣ��ۼӵĽ�������˲�����ź�
reg [31:0] sum [1:0];
reg [3:0] m,n;                                           
always@(posedge clk or posedge rst)
      if(rst)                                  
          output_data <= 32'b0 ;
       else if(valid_multi)
          begin
                for(m=0;m<2;m=m+1)
                begin
                 sum[m]<= multi_data_array[m*4] + multi_data_array[m*4+1] + multi_data_array[m*4+2] + multi_data_array[m*4+3];
                end
                 output_data<=sum[0]+sum[1]+multi_data_array[8];
          end
  
  assign hdl_fir_output = output_data;
endmodule
