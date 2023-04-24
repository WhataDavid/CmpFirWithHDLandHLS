`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 10:21:03 PM
// Design Name: 
// Module Name: bmg_out_with_ena
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


module bmg_out_with_ena(
    input wire [15:0] source_data,
    input wire ena,
    output wire [15:0] output_data
    );
    
    assign output_data = (ena==1 ? source_data : 16'd0 );
endmodule