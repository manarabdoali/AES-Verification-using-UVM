class agent #(parameter type T = sequence_item) extends uvm_agent;
  `uvm_component_utils(agent #(T))

  my_driver #(T) drv;
  my_monitor #(T) mon;
  my_sequencer #(T) seq;


  uvm_analysis_port #(T) my_analysis_port;
virtual interface inter config_virtual;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv = my_driver#(T)::type_id::create("drv", this);
    mon = my_monitor#(T)::type_id::create("mon", this);
    seq = my_sequencer#(T)::type_id::create("seq", this);
    my_analysis_port=new("my_analysis_port",this);

    `uvm_info("AGENT", "Build phase", UVM_LOW)
    $display("AGENT: Build done");
if (!uvm_config_db#(virtual inter.tb_mp)::get(this, "", "my_vif", config_virtual))
       `uvm_fatal(get_full_name(), "Error_agent !")

  // Pass it to environment
 uvm_config_db#(virtual inter.tb_mp)::set(this, "drv", "my_vif", config_virtual);
 uvm_config_db#(virtual inter.tb_mp)::set(this, "mon", "my_vif", config_virtual);

  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(seq.seq_item_imp);
    mon.my_analysis_port.connect(my_analysis_port);   
    `uvm_info("AGENT", "Connect phase", UVM_LOW)
    $display("AGENT: Connect done");
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AGENT", "Run phase", UVM_LOW)

 
  endtask
endclass

