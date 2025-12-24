class my_sequence1 extends uvm_sequence #(sequence_item);
  `uvm_object_utils(my_sequence1)

  function new(string name = "my_sequence1");
    super.new(name);
  endfunction

  virtual task body();
    sequence_item seq;
    `uvm_info("my_sequence1", "Starting AES sequence for high coverage", UVM_LOW)

    repeat (150) begin  // increased count for better coverage
      seq = sequence_item::type_id::create("seq");
      start_item(seq);

      // 20% of the time, hit special values for bins
      if ($urandom_range(0, 99) < 20) begin
        int pattern_sel = $urandom_range(0, 3);
        case (pattern_sel)
          0: seq.in  = 128'h0;                                   // all zero
          1: seq.in  = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;    // all one
          2: seq.in  = 128'hA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5;    // alt pattern
          3: seq.in  = $urandom(); // partial random for variety
        endcase

        pattern_sel = $urandom_range(0, 3);
        case (pattern_sel)
          0: seq.key = 128'h0;
          1: seq.key = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
          2: seq.key = 128'h5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A;
          3: seq.key = $urandom();
        endcase

      end
      else begin
        // Otherwise, fully randomize everything within full range
        if (!seq.randomize() with {
            in  inside {[128'h0 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF]};
            key inside {[128'h0 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF]};
           
        }) begin
          `uvm_error("my_sequence1", "Randomization failed")
          return;
        end
      end

        seq.flag = 1 ;
      $display("[%0t] [SEQ1] Sending: in=%0h, key=%0h, flag=%0b", 
               $time, seq.in, seq.key, seq.flag);

      finish_item(seq);
    end
  endtask
endclass

