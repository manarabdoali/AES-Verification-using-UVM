class my_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(my_scoreboard)

  // Analysis imp to receive transactions
  uvm_analysis_imp #(sequence_item, my_scoreboard) my_analysis_imp;

  // Simple memory model: associative array [addr -> data]
  bit [7:0] model_mem [bit[3:0]];
integer fd;
bit [127:0] exp_out;


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    my_analysis_imp = new("my_analysis_imp", this);
    `uvm_info("SCO", "Build phase", UVM_LOW)
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCO", "Connect phase", UVM_LOW)
  endfunction

  // Main method to receive transactions
  task write (sequence_item t);

    // NOTE: MAKE SURE THE PATH TO CODE AND FILES ARE RIGHT 
    // TIP : RUN THE PYTHON CODE ON TERMINAL FROM THE DIRECTORY 
    //       OF THE UVM SCOREBOARD TO CHECK NO ERRORS

    // Open file "key.txt" for writing

    fd = $fopen("C:/Users/pc/OneDrive/Desktop/New folder/key.txt","w");

    // Writing to file : First line writing the data , Second line writing the key

    $fdisplay(fd,"%h \n%h",t.in , t.key);

    // Close the "key.txt"

    $fclose(fd);

    // "$system" task to run the python code and interact with SCOREBOARD through I/O files

   // $system($sformatf("C:\Users\pc\OneDrive\Desktop\New folder\AES_p.py"));
$system("python \"C:/Users/pc/OneDrive/Desktop/New folder/AES_p.py\"");


    // Open file "output.txt" for reading

  
fd = $fopen("C:/Users/pc/OneDrive/Desktop/New folder/output.txt", "r");

    // Reading the output of python code through "output.txt" file

  //  $fscanf(fd,"%h",exp_out);
 void'($fscanf(fd, "%h", exp_out));

    // Close the "output.txt"

  //  $fclose(fd);

    // COMPARE THE ACTUAL OUTPUT AND EXPECTED OUTPUT
//@(posedge t.valid);
    if(exp_out == t.out)
        $display("SUCCESS , OUT IS %h and EXP OUT IS %h ", t.out , exp_out);
    else 
        $display("FAILURE , OUT IS %h and EXP OUT IS %h ", t.out , exp_out);  
  
endtask

endclass

