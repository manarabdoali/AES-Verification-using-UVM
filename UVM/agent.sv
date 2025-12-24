class agent #(type T = sequence_item) extends uvm_agent;
  `uvm_component_utils(agent)

  my_driver #(T) drv;
  my_monitor #(T) mon;
  uvm_sequencer #(T) seq; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv = my_driver#(T)::type_id::create("drv", this);
    mon = my_monitor#(T)::type_id::create("mon", this);
    seq = uvm_sequencer#(T)::type_id::create("seq", this);

    `uvm_info("AGENT", "Build phase", UVM_LOW)
    $display("AGENT: Build done");
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(seq.seq_item_export);

    `uvm_info("AGENT", "Connect phase", UVM_LOW)
    $display("AGENT: Connect done");
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AGENT", "Run phase", UVM_LOW)
    
  endtask
endclass

