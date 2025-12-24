 class my_monitor #(type T = sequence_item) extends uvm_monitor;
T seq_i;
virtual inter monitor_virt;

uvm_analysis_port #(T) my_analysis_port;
  `uvm_component_utils(my_monitor)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 seq_i = sequence_item ::type_id::create("seq_i", this);
 my_analysis_port=new("my_analysis_port",this);
    `uvm_info("MON", "Build phase", UVM_LOW)
    $display("MON: build_phase done");
if (!uvm_config_db#(virtual inter.tb_mp)::get(this, "", "my_vif", monitor_virt)) 
      `uvm_fatal(get_full_name(), "Error_my_monitor !")   
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MON", "Connect phase", UVM_LOW) 
    $display("MON: connect_phase done");
  endfunction
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MON", "Run phase", UVM_LOW) 
forever begin
//phase.raise_objection(this);

 @(posedge monitor_virt.clk);
 if (monitor_virt.valid_in) begin

        seq_i.in   = monitor_virt.plan_text_128; // plaintext/ciphertext input
        seq_i.key  = monitor_virt.cipher_key_128;
       seq_i.flag = monitor_virt.flag;

        $display("[%0t] MON: AES input: in=%0h, key=%0h, flag=%0b",
                 $time, seq_i.in, seq_i.key, seq_i.flag);

        //my_analysis_port.write(seq_i);
      end

      // Capture AES output transaction
      if (monitor_virt.valid_out) begin
 @(posedge monitor_virt.clk);
        seq_i.out   = monitor_virt.cipher_text_128;
        seq_i.valid = monitor_virt.valid_out;
        $display("[%0t] MON: AES output: out=%0h, valid=%0b",
                 $time, seq_i.out, seq_i.valid);

my_analysis_port.write(seq_i);  
@(posedge monitor_virt.clk); 
end
//phase.drop_objection(this);
end
  endtask
endclass

