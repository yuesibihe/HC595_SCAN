module HC595(
             clk,
             rst_n,
             sel,
             seg,
             en,
             DS,
             SH_CP,
             ST_CP            
              );
              
input clk;
input rst_n;
input en;
input [7:0] sel;
input [7:0] seg;

output reg DS;  //串行数据输出
output reg ST_CP; //存储寄存器时钟输出
output reg SH_CP; //移位寄存器时钟输出

reg [1:0] cnt;     
parameter CNT_MAX = 2'd3;

wire sclk; //分频时钟信号
reg [5:0] sclk_cnt; //序列机计数器

//分频计数器
always@(posedge clk or negedge rst_n)
      begin
      	   if(!rst_n)
      	    begin
      	    	  cnt <= 'b0;
       	    end
       	   else if(en)
       	          begin
       	          	   if(cnt==CNT_MAX)
       	          	     cnt <= 'b0;
       	          	   else
       	          	     cnt <= cnt + 1'b1;
       	          end
       	   else
       	       cnt <= 'b0;       	         	
      end
      
assign sclk = (cnt == CNT_MAX);
      
always@(posedge clk or negedge rst_n)
      begin
      	   if(!rst_n)
      	     begin
      	     	    sclk_cnt <= 'b0;
      	     end   
      	   else if(sclk)
      	         begin
      	         	    if(sclk_cnt==34'd36)
      	         	      sclk_cnt <= 'd0;
      	         	    else
      	         	        sclk_cnt <= sclk_cnt + 1'b1;
      	         end 
      	   else 
      	       sclk_cnt <= sclk_cnt ;
      end
      
//	SHCP：移位寄存器的时钟输入,上升沿时移位寄存器中的数据依次移动一位
// STCP：存储寄存器的时钟输入,上升沿时移位寄存器中的数据进入存储寄存器
//		   应用时通常STCP置为低电平，移位结束后再在ST_CP端产生一个正脉冲更新显示数据
always@(posedge clk or negedge rst_n)
     begin
     	    if(!rst_n)
     	      begin
     	      	   DS <= 'b0;     	      	   
     	      	   ST_CP <= 'b0;
     	      	   SH_CP <= 'b0;
     	      end
     	     else
     	         begin
     	         	    case(sclk_cnt)
     	         	    	 0:begin
     	         	    	 	      SH_CP <= 'b0;     	         	    	 	      
     	         	    	   end      	       
     	         	    	 1:begin
     	         	    	 	      SH_CP <= 1'b1;
     	         	    	 	      ST_CP <= 1'b0;      	         	    	 	          	         	    	 	
     	         	    	   end  	    	   
     	         	    	 2:begin
     	         	    	 	      SH_CP <= 1'b0;
     	         	    	 	      DS <= seg[3];
     	         	    	   end
     	         	    	 3:begin
     	         	    	 	       SH_CP <= 1'b1;     	         	    	 
     	         	    	   end
     	         	    	 4:begin
     	         	    	 	      SH_CP <= 1'b0;
     	         	    	 	      DS <= seg[7];
     	         	    	   end
     	         	    	 5:begin
     	         	    	 	       SH_CP <= 1'b1;     	         	    	 
     	         	    	   end
     	         	    	 6:begin
     	         	    	 	       SH_CP <= 1'b0;
     	         	    	 	       DS <= seg[6];
     	         	    	   end
     	         	    	 7:begin
     	         	    	 	       SH_CP <= 1'b1;
     	         	    	   end
     	         	    	 8:begin
     	         	    	 	       SH_CP <= 1'b0; 
     	         	    	 	       DS <= seg[5];
     	         	    	   end
     	         	    	 9:begin
     	         	    	 	       SH_CP <= 1'b1 ;
     	         	    	   end
     	         	    	 10:begin
     	         	    	 	       SH_CP <= 1'b0;
     	         	    	 	       DS <= seg[4];
     	         	    	 	 end
				
				               11:begin
				               	       SH_CP <= 1;
				               	 end 
				               12:begin 
				               	        SH_CP <= 0;
				               	        DS <= seg[3];
				               	  end
				               13:begin 
				               	        SH_CP <= 1;
				               	  end
				               14:begin 
				               	        SH_CP <= 0;
				               	        DS <= seg[2];
				               	  end
				               15:begin 
				               	        SH_CP <= 1;
				               	  end
				               16:begin 
				               	        SH_CP <= 0;
				               	        DS <= seg[1];
				               	  end
				               17:begin 
				               	        SH_CP <= 1;
				               	  end
				               18:begin 
				               	        SH_CP <= 0;
				               	        DS <= seg[0];
				               	  end
				               19:begin 
				               	        SH_CP <= 1;
				               	  end
				               20:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[7];
				               	  end
				               21:begin 
				               	        SH_CP <= 1;
				               	  end 
				               22:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[6];
				               	  end
				               23:begin 
				               	        SH_CP <= 1;
				               	  end
				               24:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[5];
				               	  end
				               25:begin 
				               	        SH_CP <= 1;
				               	  end
				               26:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[4];
				               	  end
				               27:begin 
				               	        SH_CP <= 1;
				               	  end
				               28:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[3];
				               	  end
				               29:begin 
				               	        SH_CP <= 1;
				               	  end
				               30:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[2];
				               	  end
				               31:begin 
				               	        SH_CP <= 1;
				               	  end
				               32:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[1];
				               	  end
				               33:begin 
				               	        SH_CP <= 1;
				               	  end
				               34:begin 
				               	        SH_CP <= 0;
				               	        DS <= sel[0];
				               	  end
     	         	       35:begin 
				               	        SH_CP <= 1'b1;
				               	  end
				               36:begin 
				               	        ST_CP <= 1'b1;				               	        
				               	  end 				               	  
				               default: ;				               
				            endcase   				            
     	         end     	
     end     
     
endmodule       