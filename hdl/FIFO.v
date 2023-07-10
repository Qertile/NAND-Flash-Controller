module fifo (
  input clk,
  input reset,
  input [7:0] din,
  output reg [7:0] dout,
  input write_en,
  input read_en,
  output reg full,
  output reg empty
);

  reg [7:0] data [0:127];
  reg [7:0] rptr, wptr;

  always @(posedge clk) begin
    if (reset) begin
      rptr <= 0;
      wptr <= 0;
      full <= 0;
      empty <= 1;
    end else begin
      if (write_en && !full) begin
        data[wptr] <= din;
        wptr <= wptr + 1;
        if (wptr == 128) begin
          wptr <= 0;
        end
        if (wptr == rptr) begin
          full <= 1;
        end
      end
      if (read_en && !empty) begin
        dout <= data[rptr];
        rptr <= rptr + 1;
        if (rptr == 128) begin
          rptr <= 0;
        end
        if (rptr == wptr) begin
          empty <= 1;
        end
      end
    end
  end

endmodule