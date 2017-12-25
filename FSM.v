module FSM(clk,floor_req,reset,down_available,
up_available,count_run_time,count_door_time,flag_req,close_door_sig,open_door_sig,floor
,up_lamp,down_lamp,door_open_lamp,door_close_lamp,flag_close_door_sig,flag_open_door_sig,up_available_open,down_available_open);
input wire clk;
input wire reset;
input wire open_door_sig;
input wire close_door_sig;
output reg flag_close_door_sig=0;
output reg flag_open_door_sig=0;
input wire [7:0] floor_req;
input wire down_available;
input wire up_available;
input wire up_available_open;
input wire down_available_open;

output reg[2:0] count_door_time=5;
output reg[3:0] count_run_time=10;
output reg[7:0] flag_req=0; 
output reg[2:0] floor=0;
reg[1:0] direct=0;
output up_lamp;
output down_lamp;
output door_open_lamp;
output door_close_lamp;
parameter N = 100000000;
parameter UP = 4'b00001,
           DOWN = 4'b0010,
           OPEN =4'b0100,
           INITIAL = 4'b1000;
reg[3:0] state=INITIAL;
reg [31:0] counter=0;
reg clk_N=0;

assign door_open_lamp=(state==OPEN&&(!reset))?1:0;
assign door_close_lamp=(state!=OPEN&&(!reset))?1:0;
assign up_lamp=(state==UP&&(!reset))?1:0;
assign down_lamp=(state==DOWN&&(!reset))?1:0;
always @(posedge clk)  begin  
       if(counter==(N/2-1))
       begin
            counter = 0;
            clk_N = ~clk_N;
       end                  
       counter 
       = counter + 1;

end 

always@(posedge clk_N)
begin

 if(reset)
 begin
  state<=INITIAL;
  count_door_time<=0;
  count_run_time<=0;
  flag_close_door_sig<=0;
  flag_open_door_sig<=0;
  flag_req<=0;
  flag_req<=8'b11111111;
end

 else
 begin
  case(state)
      INITIAL:begin 
      state<=OPEN;
      count_run_time<=10;
      count_door_time<=5;
      flag_close_door_sig<=0;
      flag_open_door_sig<=0;
      flag_req<=0;
    //   direct<=1;
      end
      UP:if(count_run_time!=0)
      begin
         state<=UP;
         count_run_time<=count_run_time-1;
         count_door_time<=0;
         flag_close_door_sig<=0;
         flag_open_door_sig<=0;
      end   
         else if((count_run_time==0)&&(floor_req[floor+1]==0)&&(up_available)&&(floor!=6))
         begin
         flag_req[floor]<=1;
         floor<=floor+1;
         state<=UP;
         count_run_time<=10;
         count_door_time<=0;
         flag_req[floor-1]<=0;
         end
         else 
         begin
         flag_req[floor]<=1;
         floor<=floor+1;
         state<=OPEN;
         count_door_time<=5;
         count_run_time<=0;
         flag_close_door_sig<=0;
         flag_open_door_sig<=0;
         flag_req[floor-1]<=0;
         end
      DOWN:if(count_run_time!=0)
          begin
            state<=DOWN;
            count_run_time<=count_run_time-1;
            count_door_time<=0;
            flag_close_door_sig<=0;
            flag_open_door_sig<=0;
          end  
           else if((count_run_time==0)&&(floor_req[floor-1]==0)&&(down_available)&&(floor!=1))
            begin
            flag_req[floor]<=1;
            floor<=floor-1;
            state<=DOWN;
            count_run_time<=10;  
            count_door_time<=0;    
            flag_close_door_sig<=0;
            flag_open_door_sig<=0; 
            flag_req[floor+1]<=0;
            end
            else
            begin
            flag_req[floor]<=1;
            floor<=floor-1;
            state<=OPEN;
            count_door_time<=5;
            count_run_time<=0;
            flag_close_door_sig<=0;
            flag_open_door_sig<=0;
            flag_req[floor+1]<=0;
            end
       OPEN: if(open_door_sig&&!close_door_sig)
             begin
             state<=OPEN;
             count_door_time<=5;
             count_run_time<=0;
             flag_open_door_sig<=1;
             end
             else if((count_door_time!=0)&&(!close_door_sig))
            begin
             state<=OPEN;
             count_door_time<=count_door_time-1;
             count_run_time<=0;
             flag_close_door_sig<=0;
             flag_open_door_sig<=0;
            end
           else if(((count_door_time==0)||(close_door_sig))&&(direct==1)&&up_available_open)
            begin
             state<=UP;
             count_run_time<=10;
             count_door_time<=0;
             flag_open_door_sig<=1;
             flag_close_door_sig<=1;
          
            end
             else if(((count_door_time==0)||(close_door_sig))&&(direct==2)&&down_available_open)
            begin
             state<=DOWN;
             count_run_time<=10;
             count_door_time<=0;
             flag_open_door_sig<=1;
             flag_close_door_sig<=1;
    
            end
            else 
            begin
            state<=OPEN;
            count_door_time<=5;
            count_run_time<=0;
            flag_open_door_sig<=0;
            flag_close_door_sig<=0;
            end
        default:state<=INITIAL;
      endcase
      end
    end
always@(*)
    if(direct==1)
    case(floor)
    3'b000:if(!(floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7]))
           direct=0;
           else
           direct=1;
    3'b001:if(floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else if(floor_req[0])
           direct=2;
           else
           direct=0;
    3'b010:if(floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else if(floor_req[0]||floor_req[1])
           direct=2;
           else 
           direct=0;
    3'b011:if(floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else if(floor_req[0]||floor_req[1]||floor_req[2])
           direct=2;
           else
           direct=0;
    3'b100:if(floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3])
           direct=2;
           else
           direct=0;
    3'b101:if(floor_req[6]||floor_req[7])
           direct=1;
           else if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4])
           direct=2;
           else
           direct=0;
    3'b110:if(floor_req[7])
           direct=1;
           else if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5])
           direct=2;
           else
           direct=0;
    3'b111:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[7])
           direct=2;
           else
           direct=0;
           endcase
else if(direct==2)
case(floor)
    3'b111:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6])
           direct=2;
           else
           direct=0;
    3'b110:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5])
           direct=2;
           else if(floor_req[7])
           direct=1;
           else
           direct=0;
    3'b101:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4])
           direct=2;
           else if(floor_req[6]||floor_req[7])
           direct=1;
           else 
           direct=0;
    3'b100:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3])
           direct=2;
           else if(floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b011:if(floor_req[0]||floor_req[1]||floor_req[2])
           direct=2;
           else if(floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b010:if(floor_req[0]||floor_req[1])
           direct=2;
           else if(floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b001:if(floor_req[0])
           direct=2;
           else if(floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b000:if(floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
           endcase
    else if(direct==0)
    case(floor)
    3'b000:if(!(floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7]))
           direct=0;
           else
           direct=1;
    3'b001:if(floor_req[0])
           direct=2;
           else if(floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b010:if(floor_req[0]||floor_req[1])
           direct=2;
           else if(floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else 
           direct=0;
    3'b011:if(floor_req[0]||floor_req[1]||floor_req[2])
           direct=2;
           else if(floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b100: if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3])
           direct=2;
           else if(floor_req[5]||floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b101:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4])
           direct=2;
           else if(floor_req[6]||floor_req[7])
           direct=1;
           else
           direct=0;
    3'b110:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5])
           direct=2;
           else if(floor_req[7])
           direct=1;
           else
           direct=0;
    3'b111:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[7])
           direct=2;
           else
           direct=0;
           endcase
    else direct=0;
endmodule

