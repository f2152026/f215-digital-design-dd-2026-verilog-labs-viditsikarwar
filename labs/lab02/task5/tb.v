`timescale 1ns/1ps

module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;
  reg  [3:0] exp_result;
  integer    err;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    err = 0;

    t_a = 4'd5;
    t_b = 4'd3;
    t_op = 1'b0;
    #5;
    exp_result = (t_a + t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Add 5+3 got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    t_op = 1'b1;
    #5;
    exp_result = (t_a - t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Sub 5-3 (op toggle) got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    t_a = 4'd8;
    t_b = 4'd2;
    t_op = 1'b1;
    #5;
    exp_result = (t_a - t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Sub 8-2 got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    t_a = 4'd3;
    t_b = 4'd7;
    t_op = 1'b1;
    #5;
    exp_result = (t_a - t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Sub 3-7 got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    t_a = 4'd12;
    t_b = 4'd5;
    t_op = 1'b0;
    #5;
    exp_result = (t_a + t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Add 12+5 got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    t_a = 4'd12;
    t_b = 4'd5;
    t_op = 1'b1;
    #5;
    exp_result = (t_a - t_b) & 4'hF;
    if (t_result !== exp_result) begin
      $display("FAIL: Sub 12-5 got %0d expected %0d", t_result, exp_result);
      err = err + 1;
    end

    if (err == 0) begin
      $display("ALL_ALU_TESTS_PASSED");
    end else begin
      $display("ALU TESTS FAILED WITH %0d ERRORS", err);
    end
    $finish;
  end

  initial
    $monitor($time, " a=%0d b=%0d op=%b | result=%0d", t_a, t_b, t_op, t_result);

endmodule
