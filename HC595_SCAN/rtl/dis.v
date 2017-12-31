module dis(
           clk,
           rst_n,
           data,
           sel,
           seg    
            );
           
input clk;
input rst_n;
input [31:0] data;

output reg [7:0]sel;
output reg [7:0]seg;

reg [3:0] data_tmp;

reg [27:0] cnt;

parameter CNT_MAX=28'd49_999_999;


always@(posedge clk or negedge rst_n)
       begin
            if(!rst_n)
              begin
              	   cnt <= 'b0;
              end       	   
            else if(cnt==CNT_MAX)
                   begin
                   	   cnt <= 'b0;
                   end
            else
                 cnt <= cnt + 1'b1;
       end

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		sel <= 8'b0000_0001;
	else if(cnt == CNT_MAX)
		begin
			if(sel == 8'b1000_0000)
				sel <= 8'b0000_0001;
			else 
				sel <= sel << 1;
		end
	else 
		sel <= sel;
always@(*)
      begin
      	   case(sel)
      	       8'b0000_0001:begin
      	       	                 data_tmp = data[31:28];
       	       	            end
               8'b0000_0010:begin
                                 data_tmp = data[27:24];
                            end
               8'b0000_0100:begin
                                 data_tmp = data[23:20];
                            end
               8'b0000_1000:begin
                                 data_tmp = data[19:16];
                            end
               8'b0001_0000:begin
                                 data_tmp = data[15:12];
                            end
               8'b0010_0000:begin
                                 data_tmp = data[11:8];
                            end
               8'b0100_0000:begin
                                 data_tmp = data[7:4];
                            end
               8'b1000_0000:begin
                                 data_tmp = data[3:0];
                            end
               default:begin
                            data_tmp = 4'b0000;
                       end
      	   endcase      	   	   	      	   	        	   	         
      end

always@(*)
     begin
          case(data_tmp)
              4'h0:begin
                        seg[7:0] = 8'b0100_0000;   //0                      
                   end
              4'h1:begin
                        seg[7:0] = 8'b0111_1001;   //1
                   end
              4'h2:begin
                        seg[7:0] = 8'b0010_0100;    //2
                   end
              4'h3:begin
                        seg[7:0] = 8'b0011_0000;  //3
                   end
              4'h4:begin
                        seg[7:0] = 8'b0001_1001;  //4
                   end
              4'h5:begin
                        seg[7:0] = 8'b0001_0010;  //5                       
                   end
              4'h6:begin
                        seg[7:0] = 8'b0000_0010;  //6
                   end
              4'h7:begin
                        seg[7:0] = 8'b0111_1000;  //7
                   end
              4'h8:begin
                        seg[7:0] = 8'b0000_0000;  //8
                   end
              4'h9:begin
                        seg[7:0] = 8'b0001_0000;  //9
                   end
              default:begin
                           seg[7:0] = 8'b0100_0000;              
                      end
              endcase
     end
              
endmodule