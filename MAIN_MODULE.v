// module IO(reset,out_req,in_req,flag_req,floor_req,close_door_bnt,open_door_bnt);
// module UPDATE(floor,floor_req,down_available,up_available);
// module FSM(clk,floor_req,reset,down_available,
// up_available,count_door_time,count_run_time,flag_req,close_door_sig,open_door_sig,floor
// ,up_lamp,down_lamp,door_open_lamp,door_close_lamp);
`timescale 1ms/1ms
module main(clk,reset,out_req,in_req,open_door_bnt,close_door_bnt,sys_state_lamp,up_lamp,down_lamp,
door_open_lamp,door_close_lamp,out_display,floor_req,out_door_time,out_run_time,out_floor,block,count_door_time);
input reset;
input clk;
input[7:0] out_req;
input[7:0] in_req;
input open_door_bnt;
input close_door_bnt;
wire [2:0] floor;
output sys_state_lamp;
output up_lamp;
output down_lamp;
output door_open_lamp;
output door_close_lamp;
wire[3:0] count_run_time;
output wire[2:0] count_door_time;
reg[6:0] floor_display;
reg[6:0] door_time_display;
reg[6:0] run_time_display;
assign sys_state_lamp=(reset==0)?1:0;
wire[7:0] flag_req;
output wire[7:0] floor_req;
wire down_available;
wire up_available;
wire down_available_open;
wire up_available_open;
wire flag_close_door_sig;
wire flag_open_door_sig;
wire close_door_sig;
wire open_door_sig;
reg[32:0] counter_M=0;
parameter N_M=50000;
reg clk_N_M;
reg[1:0] choose=0;
output reg[6:0] out_display;
output wire out_floor;
output wire out_door_time;
output wire out_run_time; 
output reg[4:0] block=5'b11111;

always @(posedge clk)  begin  
       if(counter_M==(N_M/2-1))
       begin
            counter_M = 0;
            clk_N_M = ~clk_N_M;
       end                  
       counter_M
       = counter_M + 1;

end 
always @(posedge clk_N_M) 
begin
choose=choose+1;
end

always @(floor) 
begin
case(floor)
3'd0:floor_display=7'b1001111;
3'd1:floor_display=7'b0010010;
3'd2:floor_display=7'b0000110;
3'd3:floor_display=7'b1001100;
3'd4:floor_display=7'b0100100;
3'd5:floor_display=7'b0100000;
3'd6:floor_display=7'b0001111;
3'd7:floor_display=7'b0000000;
default:floor_display=7'b1111111;
endcase
end

always @(count_door_time) 
begin
case(count_door_time)
3'd0:door_time_display=7'b0000001;
3'd1:door_time_display=7'b1001111;
3'd2:door_time_display=7'b0010010;
3'd3:door_time_display=7'b0000110;
3'd4:door_time_display=7'b1001100;
3'd5:door_time_display=7'b0100100;
default:door_time_display=7'b1111111;
endcase
end

always @(count_run_time) 
  begin
    case(count_run_time)
      4'd0:run_time_display=7'b0000001;
      4'd1:run_time_display=7'b1001111;
      4'd2:run_time_display=7'b0010010;
      4'd3:run_time_display=7'b0000110;
      4'd4:run_time_display=7'b1001100;
      4'd5:run_time_display=7'b0100100;
      4'd6:run_time_display=7'b0100000;
      4'd7:run_time_display=7'b0001111;
      4'd8:run_time_display=7'b0000000;
      4'd9:run_time_display=7'b0000100;
      4'd10:run_time_display=7'b1111111;
    default:run_time_display=7'b1111111;
  endcase
 end



//assign out_display=((floor_display&&(choose[0]==choose[1]))||(door_time_display&&(!choose[0])&&(choose[1]))||(run_time_display&&(!choose[1])&&(choose[0])));
always@(*)
 begin
 if(reset)
 out_display=7'b1111111;
 else
 case(choose)
  00:out_display=floor_display;
  01:out_display=run_time_display;
  10:out_display=door_time_display;
  11:out_display=floor_display;
  default:out_display=7'b1111111;
  endcase
end
assign out_floor=!((choose[0]==choose[1]));
assign out_door_time=!((!choose[0])&&(choose[1]));
assign out_run_time=!(!choose[1]&&choose[0]);

IO IO_ins(.reset(reset),.out_req(out_req),.in_req(in_req),.flag_req(flag_req),.floor_req(floor_req),
.close_door_bnt(close_door_bnt),.open_door_bnt(open_door_bnt),.flag_close_door_sig(flag_close_door_sig),
.flag_open_door_sig(flag_open_door_sig),.close_door_sig(close_door_sig),.open_door_sig(open_door_sig));
FSM FSM_ins(.clk(clk),.floor_req(floor_req),.reset(reset),.down_available(down_available),.up_available(up_available),
.flag_req(flag_req),.close_door_sig(close_door_sig),.up_available_open(up_available_open),.down_available_open(down_available_open),
.open_door_sig(open_door_sig),.floor(floor),.up_lamp(up_lamp),.down_lamp(down_lamp),.door_open_lamp(door_open_lamp),.door_close_lamp(door_close_lamp),
.count_run_time(count_run_time),.flag_close_door_sig(flag_close_door_sig),.flag_open_door_sig(flag_open_door_sig),.count_door_time(count_door_time));
UPDATE UPDATE_ins(.floor(floor),.floor_req(floor_req),.down_available(down_available),.up_available(up_available),.down_available_open(down_available_open),.up_available_open(up_available_open));
endmodule

