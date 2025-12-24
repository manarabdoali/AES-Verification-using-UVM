class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  my_env env;
my_sequence1 seq1;


virtual interface  inter config_virtual;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  env = my_env::type_id::create("env", this);
    seq1 = my_sequence1::type_id::create("seq1", this);


    `uvm_info("TEST", "Build phase", UVM_LOW)
    $display("TEST: build_phase done");

if (!uvm_config_db#(virtual inter.tb_mp)::get(this,"", "my_vif", config_virtual))
     `uvm_fatal(get_full_name(), "Error_my_test!")

  // Pass it to environment
 uvm_config_db#(virtual inter.tb_mp)::set(this, "env", "my_vif", config_virtual);

  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST", "Connect phase", UVM_LOW)
    $display("TEST: Connect_phase done");
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);


    `uvm_info("TEST", "Run phase start", UVM_LOW)  
fork
 phase.raise_objection(this, "Starting sequences");
  seq1.start(env.agt.seq);

join

phase.drop_objection(this, "Finished sequences");
  endtask

endclass

