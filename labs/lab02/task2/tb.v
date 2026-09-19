// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;
  wire [7:0] t_dout;
  integer   i;

  // TODO: instantiate DUT here
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    #1;
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i[2:0];
      #5;
      if (t_dout !== (i * i)) begin
        $display("FAIL at sel=%0d: got %0d, expected %0d", i, t_dout, (i * i));
      end
    end
    #5 $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout); // change as required

endmodule
