class my_sequencer #(type T = sequence_item) extends uvm_sequencer #(T);
  `uvm_component_utils(my_sequencer #(T))

 uvm_seq_item_pull_imp #(T, T, my_sequencer #(T)) seq_item_imp;
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   seq_item_imp = new("seq_item_imp", this); 
    `uvm_info("SEQ", "Build phase entered", UVM_LOW)
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQ", "Connect phase entered", UVM_LOW)
    $display("SEQ: connect_phase done");
  endfunction
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SEQ", "Run phase entered", UVM_LOW)
  endtask
  /*// Interface Methods
  // --------------------------
  virtual task get_next_item(output T t);
    super.get_next_item(t);
  endtask

  virtual task try_next_item(output T t);
    super.try_next_item(t);
    `uvm_info("SEQ", "try_next_item called", UVM_MEDIUM)
  endtask

  virtual function void item_done(input T item = null);
    super.item_done(item);
    `uvm_info("SEQ", "item_done called", UVM_MEDIUM)
  endfunction

  virtual function void put_response(input T response);
    super.put_response(response);
    `uvm_info("SEQ", "put_response called", UVM_MEDIUM)
  endfunction

  virtual task get(output T t);
    super.get(t);
    `uvm_info("SEQ", "get called", UVM_MEDIUM)
  endtask

  virtual task peek(output T t);
    super.peek(t);
    `uvm_info("SEQ", "peek called", UVM_MEDIUM)
  endtask
*/
endclass

