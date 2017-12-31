module dis_top(
               clk,
               rst_n,
               DS,
               SH_CP,
               ST_CP
                );

input clk;
input rst_n;

output DS;
output SH_CP;
output ST_CP;

wire [7:0] sel;
wire [7:0] seg;

wire [31:0] data;

assign data = {4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8};//数码管要显示的数
dis dis(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .sel(sel),
        .seg(seg)
         );
         
HC595 HC595(
            .clk(clk),
            .rst_n(rst_n),
            .sel(sel),
            .seg(seg),
            .en(1'b1),
            .DS(DS),
            .SH_CP(SH_CP),
            .ST_CP(ST_CP)
             );         
endmodule 
                        