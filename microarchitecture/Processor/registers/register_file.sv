/*
Register File parametrizable para N bits
Date: 16/03/24
*/
`timescale 1 ps / 100 fs
module register_file # (parameter N = 24) (
		input  logic         clk,
		input  logic         rst,
		input  logic [N-1:0] reg_write_data,    // WD3 data
		input  logic [3:0]   reg_read_addr_1,   // A1
		input  logic [3:0]   reg_read_addr_2,   // A2
		input  logic [3:0]   reg_write_dest,    // A3 address
		input  logic         reg_write_en,      // WE3
          input  logic [N-1:0] reg_write_r15,     // R15

		output logic [N-1:0] reg_read_data_1,   // RD1
		output logic [N-1:0] reg_read_data_2    // RD2
     );

     logic     [N-1:0]     reg_array [15:0];  
     always @ (posedge clk or posedge rst) begin  
          if(rst) begin  
               reg_array[0]  <= 24'h00000;  // zero
               reg_array[1]  <= 24'hDE000;  // sp
               reg_array[2]  <= 24'h0;      // lr
               reg_array[3]  <= 24'h0;      // cpsr
               reg_array[4]  <= 24'h0;      // r0
               reg_array[5]  <= 24'h0;      // r1
               reg_array[6]  <= 24'h0;      // r2
               reg_array[7]  <= 24'h0;      // r3
               reg_array[8]  <= 24'h0;      // e0
               reg_array[9]  <= 24'h0;      // e1
               reg_array[10] <= 24'h0;      // e2
               reg_array[11] <= 24'h0;      // e3
               reg_array[12] <= 24'h0;      // e4
               reg_array[13] <= 24'h0;      // e5
               reg_array[14] <= 24'h0;      // e6
               reg_array[15] <= 24'h0;      // pc       
          end  
          else begin  
               if(reg_write_en) begin  
                    reg_array[reg_write_dest] <= reg_write_data; 
                    /*$display("reg_write_dest=%b", reg_write_dest,
                    " - reg_write_data=%h", reg_write_data);*/
                    reg_array[15] = reg_write_r15; /* Writes PCPlus8 on reg 15 always */
               end  
          end  
     end 

     assign reg_read_data_1 = ( reg_read_addr_1 == 0)? 24'b0 : reg_array[reg_read_addr_1]; // if reg == $zero -> return 0 
     assign reg_read_data_2 = ( reg_read_addr_2 == 0)? 24'b0 : reg_array[reg_read_addr_2]; // if reg == $zero -> return 0 

endmodule
 