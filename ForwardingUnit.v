module ForwardingUnit(
    input  EXMEMRegWrite,MEMWBRegWrite,[4:0]EXMEMRegRd,[4:0]MEMWBRegRd, [4:0]IDEXR1,[4:0] IDEXR2,
    output reg [1:0] ForwardA,reg [1:0] ForwardB
);

always @(*)
begin
    if (EXMEMRegWrite & (EXMEMRegRd != 0) & (EXMEMRegRd == IDEXR1))
    begin
        ForwardA=2'b10;
    end
    if (EXMEMRegWrite & (EXMEMRegRd != 0) & (EXMEMRegRd == IDEXR2))
    begin
        ForwardB=2'b10;
    end
    if (MEMWBRegWrite & (MEMWBRegRd != 0) & (MEMWBRegRd == IDEXR1))
    begin
        ForwardA=2'b01;
    end
    if (MEMWBRegWrite & (MEMWBRegRd != 0) & (MEMWBRegRd == IDEXR2))
    begin
        ForwardB=2'b01;
    end
    
end

initial
begin
    ForwardA=2'b00;
    ForwardB=2'b00;
end

endmodule // ForwardingUnit