class my_env extends uvm_env;
  `uvm_component_utils(my_env)

  agent #(sequence_item) agt;      // UVM agent instance
  my_scoreboard sco;  
my_subscriber  sub;             // Scoreboard instance
virtual interface inter config_virtual;
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase: create components
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent#(sequence_item)::type_id::create("agt", this);
    sco = my_scoreboard::type_id::create("sco", this);
    sub = my_subscriber::type_id::create("sub", this);
    `uvm_info("ENV", "Build phase", UVM_LOW)
    $display("ENV: build_phase done");
if (!uvm_config_db#(virtual inter.tb_mp)::get(this, "", "my_vif", config_virtual))
      `uvm_fatal(get_full_name(), "Error_my_env!")

  // Pass it to environment
 uvm_config_db#(virtual inter.tb_mp)::set(this, "agt", "my_vif", config_virtual);
  endfunction

  // Connect phase: connect monitor to scoreboard, etc.
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
 agt.my_analysis_port.connect(sco.my_analysis_imp);
   agt.my_analysis_port.connect(sub.my_analysis_imp); 
    `uvm_info("ENV", "Connect phase", UVM_LOW)
    $display("ENV: connect_phase done");
  endfunction

  // Run phase: control simulation behavior (usually empty here)
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
     
  endtask
endclass

