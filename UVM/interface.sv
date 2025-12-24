interface inter(input logic clk, input logic rst_n);

  // === DUT Signals ===

 logic[127:0] plan_text_128;
 logic[127:0] cipher_key_128;
  logic         flag;
logic          valid_in;

//---------------------------------
//------------output---------------
//---------------------------------
 logic[127:0] cipher_text_128;
  logic       valid_out;
//
  // === Clocking Block === (FOR TESTBENCH ONLY)
  clocking cb @(posedge clk);
    default input #1step output #1step;

    output plan_text_128;
    output cipher_key_128;
    output flag;
   output  valid_in;

    input cipher_text_128;
 input    valid_out;
  endclocking

  // === Modports ===
  modport tb_mp (
    clocking cb
  );

  modport dut_mp (
    input  clk, rst_n,
    input  plan_text_128,
    input  cipher_key_128,
     input  valid_in,  
    input  flag,
    output cipher_text_128,
    output valid_out    
  );

endinterface

