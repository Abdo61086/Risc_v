module MUX2x1 #(
    parameter WIDTH = 32            
)(
    input  wire [WIDTH-1:0] in0,     
    input  wire [WIDTH-1:0] in1,     
    input  wire sel,                
    output wire [WIDTH-1:0] out      
);

    assign out = (sel) ? in1 : in0;

endmodule

