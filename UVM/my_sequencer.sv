class my_sequencer #( type T = uvm_sequence_item) extends uvm_sequencer #(T);

  `uvm_component_utils(my_sequencer #(T))
uvm_seq_item_pull_imp #(T) seq_item_imp;
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Optional: build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQ", "Build phase entered", UVM_LOW)
  endfunction

  // Optional: connect_phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQ", "Connect phase entered", UVM_LOW)
    $display("SEQ: connect_phase done");
  endfunction

  // Optional: run_phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SEQ", "Run phase entered", UVM_LOW)
  endtask

endclass

