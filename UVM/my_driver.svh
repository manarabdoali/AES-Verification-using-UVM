class my_driver #(type T = sequence_item) extends uvm_driver #(T);
T seq_i;
  // Register with factory
  `uvm_component_utils(my_driver)
 uvm_seq_item_pull_port #(T,T) seq_item_port;
virtual interface inter config_virtual;
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 seq_i = T ::type_id::create("seq_i", this);
seq_item_port = new("seq_item_export", this); 

    `uvm_info("DRV", "Build phase", UVM_LOW)
    $display("DRV: build_phase done");
 if (!uvm_config_db#(virtual inter.tb_mp)::get(this, "", "my_vif", config_virtual)) begin
       `uvm_fatal(get_full_name(), "Error_my_driver !")
    `uvm_info("DRV", "Build phase completed", UVM_LOW)
    end

  endfunction

  // Connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRV", "Connect phase", UVM_LOW)
    $display("DRV: connect_phase done");
  endfunction

  // Run phase
virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
wait(config_virtual.rst_n == 1);
    `uvm_info("DRV", "Run phase started", UVM_LOW)
 
    forever begin
 @(posedge config_virtual.clk);
 //@(posedge config_virtual.cb);
      seq_item_port.get_next_item(seq_i);
/*$display("[%0t] [DRV] Driving: in=%0h, key=%0h, flag=%0b",
             $time, seq_i.in, seq_i.key, seq_i.flag);*/

      config_virtual.plan_text_128  = seq_i.in;
      config_virtual.cipher_key_128 = seq_i.key;
      config_virtual.flag           = seq_i.flag;

      $display("[%0t] [DRV] Driving: plan_text_128=%0h, cipher_key_128=%0h, flag=%0b",
               $time, config_virtual.plan_text_128,  config_virtual.cipher_key_128,  config_virtual.flag );



@(posedge config_virtual.clk); // wait 1 cycle before asserting valid_in
config_virtual.valid_in = 1'b1;
@(posedge config_virtual.clk);
config_virtual.valid_in = 1'b0; 
    
/* $display("[%0t] [DRV] Driving: plan_text_128=%0h, cipher_key_128=%0h, flag=%0b",
               $time, config_virtual.plan_text_128,  config_virtual.cipher_key_128,  config_virtual.flag );*/
 @(posedge config_virtual.clk);

 seq_item_port.item_done();     
 @(posedge config_virtual.clk);
    end
  endtask


endclass

