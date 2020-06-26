module ALU_control(
    input [1:0] ALUOp, [3:0] funct,
    output reg [3:0] operation
);
    always @(*)
    begin
        if (ALUOp == 2'b00)
            operation = 4'b0010;
           
        else if (ALUOp == 2'b01)
            operation = 4'b0110;
           
        else if (ALUOp == 2'b10)
       
            if (funct == 4'b0000)
                operation = 4'b0010;
               
            else if (funct == 4'b1000)
                operation = 4'b0110;
               
            else if (funct == 4'b0111)
                operation = 4'b0000;
               
            else if (funct == 4'b0110)
                operation = 4'b0001;   
    end       
endmodule
