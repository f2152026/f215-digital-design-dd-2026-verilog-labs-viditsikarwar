`timescale 1ns/1ps

module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  reg        exp_gt, exp_lt, exp_eq;
  integer    i, j, errors;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0];
        t_b = j[1:0];
        exp_gt = (i > j);
        exp_lt = (i < j);
        exp_eq = (i == j);
        #5;
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end
    if (errors == 0) begin
      $display("ALL 16 COMBINATIONS PASSED");
    end else begin
      $display("%0d / 16 passed (%0d errors)", (16 - errors), errors);
    end
    $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);

endmodule
