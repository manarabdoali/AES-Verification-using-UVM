class my_subscriber extends uvm_subscriber #(sequence_item);
  `uvm_component_utils(my_subscriber)
  
  sequence_item seq_i;
  uvm_analysis_imp #(sequence_item, my_subscriber) my_analysis_imp;
  
  // Temporary variables for covergroup sampling
  bit [127:0] in_cg;
  bit [127:0] key_cg;
  bit         flag_cg;
  
  // Counter to track received transactions
  int transaction_count = 0;
  
  // === AES coverage ===
  covergroup aes_cov;
    option.per_instance = 1;
    
    // Example binning for AES input data
    cp_in : coverpoint in_cg {
      bins all_zero   = {128'h0};
      bins all_one    = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
      bins pattern1   = {128'hA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5};
      bins others[]   = default; // catch all other values
    }
    
    // Example binning for AES key
    cp_key : coverpoint key_cg {
      bins key_zero   = {128'h0};
      bins key_allone = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
      bins key_alt    = {128'h5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A};
      bins others[]   = default;
    }
    
   
    
    // Cross coverage: mode × special patterns
    cross_mode_data : cross cp_key, cp_in;
   // cross_mode_key  : cross cp_flag, cp_key;
  endgroup
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    aes_cov = new(); // Instantiate covergroup
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_i = sequence_item::type_id::create("seq_i", this);
    my_analysis_imp = new("my_analysis_imp", this);
    `uvm_info("SUB", "Build phase completed", UVM_LOW)
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SUB", "Connect phase completed", UVM_LOW)
  endfunction
  
  // Called whenever a sequence_item arrives from analysis port
  virtual function void write(sequence_item t);
    transaction_count++;
    
    // Debug: Print that we received a transaction
    `uvm_info("SUB", $sformatf("Received transaction #%0d", transaction_count), UVM_LOW)
    $display("[%0t] SUB: Coverage sampling - in=%0h, key=%0h, flag=%0b", 
             $time, t.in, t.key, t.flag);
    
    // Copy to covergroup variables
    in_cg   = t.in;
    key_cg  = t.key;
    flag_cg = t.flag;
    
    // Sample coverage
    aes_cov.sample();
    
    // Debug: Print coverage after sampling
    `uvm_info("SUB", $sformatf("Coverage sampled. Current coverage: %.2f%%", 
              aes_cov.get_coverage()), UVM_LOW)
  endfunction
  
  // Add a final phase to report coverage summary
  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("SUB", $sformatf("Final coverage report: %.2f%% (%0d transactions processed)", 
              aes_cov.get_coverage(), transaction_count), UVM_LOW)
  endfunction
endclass
