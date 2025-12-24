module AES_wrapper #(parameter DATA_WIDTH = 128)(
    intf.DUT bus  
);

    logic [DATA_WIDTH-1:0] data_in_reg;
    logic [DATA_WIDTH-1:0] key_in_reg;
    logic                  flag_reg;

    logic [DATA_WIDTH-1:0] aes_out;

    // Register the inputs
    always_ff @(posedge bus.clk or negedge bus.rst_n) begin
        if (!bus.rst_n) begin
            data_in_reg <= '0;
            key_in_reg  <= '0;
            flag_reg    <= 1'b0;
        end else begin
            data_in_reg <= bus.data_in;
            key_in_reg  <= bus.key_in;
            flag_reg    <= bus.flag;
        end
    end

    // AES core
    AES aes_core (
        .plan_text_128 (data_in_reg),
        .cipher_key_128(key_in_reg),
        .flag          (flag_reg),
        .data_128      (aes_out)
    );

    // Output register + valid_out signal
    always_ff @(posedge bus.clk or negedge bus.rst_n) begin
        if (!bus.rst_n) begin
            bus.data_out <= '0;
            bus.valid_out <= 1'b0;
        end else begin
            bus.data_out  <= aes_out;
            bus.valid_out <= flag_reg; 
        end
    end

endmodule
