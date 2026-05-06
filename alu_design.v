`timescale 1ns / 1ps
`default_nettype none
module alu_design #(parameter n=8,m=4)(clk,rst,inp_valid,mode,cmd,ce,opa,opb,cin,err,res,oflow,cout,g,l,e);
input wire clk,rst,cin,ce,mode;
input wire[1:0] inp_valid;
input wire[n-1:0] opa,opb;
input wire [m-1:0] cmd;
output reg [2*n:0] res;
output reg cout,err,oflow,g,l,e;
reg [1:0] count_1,count_2,count_3,count_4;
reg [2*n:0] temp_res1,temp_res2;
always@(posedge clk or posedge rst)
begin
    if(rst)begin
        res <= {2*n{1'b0}};
        err<=1'b0;
        oflow<=1'b0;
        cout<=1'b0;
        g<=1'b0;
        l<=1'b0;
        e<=1'b0;
        count_1 <= 2'd0;
        count_2 <= 2'd0;
        count_3 <= 2'd0;
        count_4 <= 2'd0;
    end
else if(ce) begin
    if(mode) begin
        res <= {2*n{1'b0}};
        err<=1'b0;
        oflow<=1'b0;
        cout<=1'b0;
        g<=1'b0;
        l<=1'b0;
        e<=1'b0;
        count_1 <= 2'd0;
        count_2 <= 2'd0;
        count_3 <= 2'd0;
        count_4 <= 2'd0;
        case(cmd)
            0: begin
                if(inp_valid==2'b11)
                begin
                    res  <= opa + opb;
                    cout <= ({1'b0, opa} + {1'b0, opb})>{n{1'b1}}  ;
                end
            else begin
                res <= {2*n{1'b0}};
                err<=1'b1;
            end
    end
1:begin
    if(inp_valid==2'b11) begin
        if(opb>opa)
        begin
            res<=opa-opb;
            oflow <= 1;
        end else
    begin
        res<=opa-opb;
    end
end
else begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
2:begin
    if(inp_valid==2'b11)begin
        res  <= opa + opb;
        cout <= ({1'b0, opa} + {1'b0, opb})> {n{1'b1}};
 
    end
else
begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
3:begin
    if(inp_valid==2'b11)begin
        res<=opa-opb-cin;
        oflow<=({1'b0,opb}+cin)>opa;
        end
    else
    begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
4:begin
    if(inp_valid==2'b01)
    res<=opa+1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
5:begin
    if(inp_valid==2'b01)
    res<=opa-1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
6:begin
    if(inp_valid==2'b10)
    res<=opb+1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
7:begin
    if(inp_valid==2'b10)
    res<=opb-1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
8:begin
    if(inp_valid==2'b11) begin
        if(opa>opb)
        g<=1'b1;
        else if(opa<opb)
        l<=1'b1;
        else
        e<=1'b1;
    end
else 
err<=1'b1;
end
9:begin
    if(inp_valid==2'b11)
    begin
        if(count_1==0) begin 
            temp_res1<=((opa+1)*(opb+1));
            count_1<=count_1+1;
        end
    else if(count_1 ==2'd2) begin
        res<=temp_res1;
        temp_res1<=((opa+1)*(opb+1));
        count_1<=1;
    end
    else
        count_1<=count_1+1;
    end
else begin
    if(count_2==2'd2) begin
        err<=1'b1;
        count_2<=1;
    end
    else
    count_2<=count_2+1;
end
end
10:begin
    if(inp_valid==2'b11)
    begin
        if(count_3==0)begin
            temp_res2<=(opa<<1)*opb;
            count_3<=count_3+1;
        end
    else if(count_3 ==2'd2)begin
        res<=temp_res2;
        count_3<=1;
        temp_res2<=(opa<<1)*opb;
    end
else
count_3<=count_3+1;
end
else begin
    if(count_4==2'd2) begin
        err<=1'b1;
        count_4<=1;
    end
    else
    count_4<=count_4+1;
end
end
11: begin
    if (inp_valid == 2'b11) begin
        res<=$signed(opa) + $signed(opb);
        oflow <= (opa[n-1] == opb[n-1]) && (res[n-1] != opa[n-1]);
        if ($signed(opa) > $signed(opb)) begin
            g<= 1'b1;
        end
    else if ($signed(opa) < $signed(opb)) begin
        l<=1'b1;
    end
else begin
    e<=1'b1;
end
end
else begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
12: begin
    if (inp_valid == 2'b11) begin
        res <= $signed(opa) - $signed(opb);
        oflow<= (opa[n-1] != opb[n-1]) && (res[n-1] != opa[n-1]);
        if ($signed(opa) > $signed(opb))
        begin
            g <= 1'b1;
        end
    else if ($signed(opa) < $signed(opb))
    begin
        l <= 1'b1;  
    end
else
begin
    e <= 1'b1;
end
end
else begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
default:err<=1'b1;
endcase
end
else begin
    res<={{2*n}{1'b0}};
    err<=1'b0;
    oflow<=1'b0;
    cout<=1'b0;
    g<=1'b0;
    l<=1'b0;
    e<=1'b0;
    count_1 <= 2'd0;
    count_2 <= 2'd0;
    count_3 <= 2'd0;
    count_4 <= 2'd0;
    case (cmd)
        0:begin
            if(inp_valid==2'b11)
            res<=opa&opb;
            else begin
                res <= {2*n{1'b0}};
                err<=1'b1;
            end
    end
1:begin
    if(inp_valid==2'b11)
    res<=~(opa&opb);
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
2:begin
    if(inp_valid==2'b11)
    res<=opa|opb;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
3:begin
    if(inp_valid==2'b11)
    res<=~(opa|opb);
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
4:begin
    if(inp_valid==2'b11)
    res<=opa^opb;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
5:begin
    if(inp_valid==2'b11)
    res<=~(opa^opb);
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
6:begin
    if(inp_valid==2'b11)
    res<=~opa;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
7:begin
    if(inp_valid==2'b11)
    res<=~opb;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
8:begin
    if(inp_valid==2'b01)
    res<=opa>>1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
9:begin
    if(inp_valid==2'b01)
    res<=opa<<1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
10:begin
    if(inp_valid==2'b10)
    res<=opb>>1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
11:begin
    if(inp_valid==2'b10)
    res<=opb<<1;
    else begin
        res <= {2*n{1'b0}};
        err<=1'b1;
    end
end
12:begin
    if(inp_valid==2'b11)
    begin
        if(opb>4'b1111)
        err<=1'b1;
        else
        res<=opa<<opb[2:0] | opa>>(n-opb[2:0]);
    end
else begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
13:begin
    if(inp_valid==2'b11)
    begin
        if(opb>4'b1111)
        err<=1'b1;
        else
        res<=opa>>opb[2:0] | opa<<(n-opb[2:0]);
    end
else begin
    res <= {2*n{1'b0}};
    err<=1'b1;
end
end
default:err<=1'b1;
endcase
end
end
end
endmodule
