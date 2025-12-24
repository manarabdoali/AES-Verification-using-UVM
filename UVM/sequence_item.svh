class sequence_item extends uvm_sequence_item;
  `uvm_object_utils(sequence_item)

  function new(string name = "sequence_item");
    super.new(name);
  endfunction
 // === AES Transaction Fields ===
  rand bit [127:0] in;    // plaintext or ciphertext (plan_text_128)
  rand bit [127:0] key;   // AES key (cipher_key_128)
       bit [127:0] out;   // output from DUT (cipher_text_128)
       bit         valid; // output valid flag
       bit         flag;  // 1 = encrypt, 0 = decrypt
      bit          valid_in;
endclass
