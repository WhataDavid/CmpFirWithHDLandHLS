`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2023 10:51:57 AM
// Design Name: 
// Module Name: fir_out_with_ena
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


module fir_out_with_ena(
    input wire clk,
    input wire rst,
    input wire [31:0] source_data,
    
    output wire data_valid,
    output wire data_last,
    output wire [31:0] output_data
    );
   
    reg signed [31:0] delay_pipeline_array [1:0];
    reg signed data_valid_tmp;
    reg signed data_last_tmp;
    
    always@(posedge clk or posedge rst)
    if(rst)
        begin
                delay_pipeline_array[0] <= 0;
                delay_pipeline_array[1] <= 0;
        end
    else 
        begin
                delay_pipeline_array[0] <= source_data;
                
                delay_pipeline_array[1] <= delay_pipeline_array[0];            
        end
    
    always@(posedge clk or posedge rst)
    if(rst)
        begin
            data_valid_tmp <= 0;
            data_last_tmp <= 0;        
        end
    else
        begin
            if(delay_pipeline_array[0]!=0)
                begin
                    data_valid_tmp <= 1;
                end
            else if(delay_pipeline_array[0]==0&&delay_pipeline_array[1]==0&&data_valid_tmp==1)
                begin
                    data_last_tmp = 1;
                    data_valid_tmp = 0;
                end
        end
        
        assign output_data = delay_pipeline_array[0];
        assign data_valid = data_valid_tmp;
        assign data_last = data_last_tmp;
endmodule
