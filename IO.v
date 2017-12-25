module IO(flag_close_door_sig,flag_open_door_sig,close_door_sig,open_door_sig,reset,
out_req,in_req,flag_req,floor_req,close_door_bnt,open_door_bnt);
input reset;
input[7:0] out_req;
input[7:0] in_req;
input[7:0] flag_req;
input close_door_bnt;
input open_door_bnt;
input flag_close_door_sig;
input flag_open_door_sig;
reg [7:0] floor_req_in=0;
reg [7:0] floor_req_out=0;
output reg close_door_sig=0;
output reg open_door_sig=0;
output reg[7:0] floor_req;
always @(*) begin
  if(reset)
  floor_req=0;
  else
  floor_req=floor_req_in|floor_req_out; 
end 

// always@(*)
// begin
// floor_req=floor_req_in|floor_req_out;
// end
// initial
// begin
// floor_req_in=0;
// floor_req_out=0;
//  close_door_sig=0;
//  open_door_sig=0;
// end
// always@(close_door_bnt or flag_close_door_sig or reset)
always@(*)
begin
close_door_sig=close_door_sig;
if(reset) 
begin
close_door_sig=0;
end
else
begin
if(close_door_bnt==1)
close_door_sig=close_door_bnt;
else
close_door_sig=close_door_sig;
if(flag_close_door_sig==1)
begin
close_door_sig=0;
end
else
close_door_sig=close_door_sig;
end
end
// always@(open_door_bnt or flag_open_door_sig or reset)
always@(*)
begin
if(reset) 
begin
open_door_sig=0;
end
else
begin
if(open_door_bnt==1)
open_door_sig=open_door_bnt;
if(flag_open_door_sig==1)
open_door_sig=0;
end
end

always@(posedge out_req[0] or posedge flag_req[0])
begin
if(flag_req[0]==1)
floor_req_out[0]=0;
if(out_req[0]==1)
floor_req_out[0]=1;
end
always@(posedge out_req[1] or posedge flag_req[1])
begin
if(flag_req[1]==1)
floor_req_out[1]=0;
if(out_req[1]==1)
floor_req_out[1]=1;
end
always@(posedge out_req[2] or posedge flag_req[2])
begin
if(flag_req[2]==1)
floor_req_out[2]=0;
if(out_req[2]==1)
floor_req_out[2]=1;
end
always@(posedge out_req[3] or posedge flag_req[3])
begin
if(flag_req[3]==1)
floor_req_out[3]=0;
if(out_req[3]==1)
floor_req_out[3]=1;
end
always@(posedge out_req[4] or posedge flag_req[4])
begin
if(flag_req[4]==1)
floor_req_out[4]=0;
if(out_req[4]==1)
floor_req_out[4]=1;
end
always@(posedge out_req[5] or posedge flag_req[5])
begin
if(flag_req[5]==1)
floor_req_out[5]=0;
if(out_req[5]==1)
floor_req_out[5]=1;
end
always@(posedge out_req[6] or posedge flag_req[6])
begin
if(flag_req[6]==1)
floor_req_out[6]=0;
if(out_req[6]==1)
floor_req_out[6]=1;
end
always@(posedge out_req[7] or posedge flag_req[7])
begin
if(flag_req[7]==1)
floor_req_out[7]=0;
if(out_req[7]==1)
floor_req_out[7]=1;
end

always@(posedge in_req[0] or posedge flag_req[0])
begin
if(flag_req[0]==1)
floor_req_in[0]=0;
if(in_req[0]==1)
floor_req_in[0]=1;
end
always@(posedge in_req[1] or posedge flag_req[1])
begin
if(flag_req[1]==1)
floor_req_in[1]=0;
if(in_req[1]==1)
floor_req_in[1]=1;
end
always@(posedge in_req[2] or posedge flag_req[2])
begin
if(flag_req[2]==1)
floor_req_in[2]=0;
if(in_req[2]==1)
floor_req_in[2]=1;
end
always@(posedge in_req[3] or posedge flag_req[3])
begin
if(flag_req[3]==1)
floor_req_in[3]=0;
if(in_req[3]==1)
floor_req_in[3]=1;
end
always@(posedge in_req[4] or posedge flag_req[4])
begin
if(flag_req[4]==1)
floor_req_in[4]=0;
if(in_req[4]==1)
floor_req_in[4]=1;
end
always@(posedge in_req[5] or posedge flag_req[5])
begin
if(flag_req[5]==1)
floor_req_in[5]=0;
if(in_req[5]==1)
floor_req_in[5]=1;
end
always@(posedge in_req[6] or posedge flag_req[6])
begin
if(flag_req[6]==1)
floor_req_in[6]=0;
if(in_req[6]==1)
floor_req_in[6]=1;
end
always@(posedge in_req[7] or posedge flag_req[7])
begin
if(flag_req[7]==1)
floor_req_in[7]=0;
if(in_req[7]==1)
floor_req_in[7]=1;
end

endmodule