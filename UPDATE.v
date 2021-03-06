module UPDATE(floor,floor_req,down_available,up_available,down_available_open,up_available_open);
input[2:0] floor;
input[7:0] floor_req;
output reg down_available=0;
output reg up_available=0;
output reg up_available_open=0;
output reg down_available_open=0;
always@( * )
  begin
  case(floor)
    3'b000:if(floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b001:if(floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b010:if(floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b011:if(floor_req[5]||floor_req[6]||floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b100:if(floor_req[6]||floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b101:if(floor_req[7])
           up_available=1;
           else
           up_available=0;
    3'b110:up_available=0;
    3'b111:up_available=0;
    endcase
    case(floor)
    3'b111:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5])
           down_available=1;
           else
           down_available=0;
    3'b110:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4])
           down_available=1;
           else
           down_available=0;
    3'b101:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3])
           down_available=1;
           else
           down_available=0;
    3'b100:if(floor_req[0]||floor_req[1]||floor_req[2])
           down_available=1;
           else
           down_available=0;
    3'b011:if(floor_req[0]||floor_req[1])
           down_available=1;
           else
           down_available=0;
    3'b010:if(floor_req[0])
           down_available=1;
           else
           down_available=0;
    3'b001:down_available=0;
    3'b000:down_available=0;
    endcase
     case(floor)
    2'b000:if(floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b001:if(floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b010:if(floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b011:if(floor_req[4]||floor_req[5]||floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b100:if(floor_req[5]||floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b101:if(floor_req[6]||floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b110:if(floor_req[7])
           up_available_open=1;
           else
           up_available_open=0;
    3'b111:up_available_open=0;
    endcase
    case(floor)
    3'b111:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5]||floor_req[6])
           down_available_open=1;
           else
           down_available_open=0;
    3'b110:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4]||floor_req[5])
           down_available_open=1;
           else
           down_available_open=0;
    3'b101:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3]||floor_req[4])
           down_available_open=1;
           else
           down_available_open=0;
    3'b100:if(floor_req[0]||floor_req[1]||floor_req[2]||floor_req[3])
           down_available_open=1;
           else
           down_available_open=0;
    3'b011:if(floor_req[0]||floor_req[1]||floor_req[2])
           down_available_open=1;
           else
           down_available_open=0;
    3'b010:if(floor_req[0]||floor_req[1])
           down_available_open=1;
           else
           down_available_open=0;
    3'b001:if(floor_req[0])
           down_available_open=1;
           else
           down_available_open=0;
    3'b000:down_available_open=0;
    endcase
end
endmodule