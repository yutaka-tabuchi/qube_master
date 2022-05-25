`default_nettype none

module config_memory_wrapper(
			     input wire clk,
			     input wire reset,
			     
			     output wire [31:0] MYIPADDR0_o,
			     output wire [31:0] MYNETMASK0_o,
			     output wire [31:0] MYDEFAULTGATEWAY0_o,
			     output wire [31:0] MYTARGETIPADDR0_o,
			     output wire [47:0] MYMACADDR0_o,

			     output wire [31:0] MYIPADDR1_o,
			     output wire [31:0] MYNETMASK1_o,
			     output wire [31:0] MYDEFAULTGATEWAY1_o,
			     output wire [31:0] MYTARGETIPADDR1_o,
			     output wire [47:0] MYMACADDR1_o,

			     output wire [31:0] MYIPADDR2_o,
			     output wire [31:0] MYNETMASK2_o,
			     output wire [31:0] MYDEFAULTGATEWAY2_o,
			     output wire [31:0] MYTARGETIPADDR2_o,
			     output wire [47:0] MYMACADDR2_o,

			     output wire [31:0] MYIPADDR3_o,
			     output wire [31:0] MYNETMASK3_o,
			     output wire [31:0] MYDEFAULTGATEWAY3_o,
			     output wire [31:0] MYTARGETIPADDR3_o,
			     output wire [47:0] MYMACADDR3_o
			     );
    
    reg [31:0] myipaddr0 = 32'h0a0300ff;
    reg [31:0] mynetmask0 = 32'hff000000;
    reg [31:0] mydefaultgateway0 = 32'h0a000001;
    reg [31:0] mytargetipaddr0 = 32'h0a000001;
    reg [47:0] mymacaddr0 = 48'h001b1affff00;

    reg [31:0] myipaddr1 = 32'h0a0400ff;
    reg [31:0] mynetmask1 = 32'hff000000;
    reg [31:0] mydefaultgateway1 = 32'h0a000001;
    reg [31:0] mytargetipaddr1 = 32'h0a000001;
    reg [47:0] mymacaddr1 = 48'h001b1affff01;

    reg [31:0] myipaddr2 = 32'h0afe00ff;
    reg [31:0] mynetmask2 = 32'hff000000;
    reg [31:0] mydefaultgateway2 = 32'h0a000001;
    reg [31:0] mytargetipaddr2 = 32'h0a000001;
    reg [47:0] mymacaddr2 = 48'h001b1affff02;

    reg [31:0] myipaddr3 = 32'h0aff00ff;
    reg [31:0] mynetmask3 = 32'hff000000;
    reg [31:0] mydefaultgateway3 = 32'h0a000001;
    reg [31:0] mytargetipaddr3 = 32'h0a000001;
    reg [47:0] mymacaddr3 = 48'h001b1affff03;

    assign MYIPADDR0_o = myipaddr0;
    assign MYNETMASK0_o = mynetmask0;
    assign MYDEFAULTGATEWAY0_o = mydefaultgateway0;
    assign MYTARGETIPADDR0_o = mytargetipaddr0;
    assign MYMACADDR0_o = mymacaddr0;

    assign MYIPADDR1_o = myipaddr1;
    assign MYNETMASK1_o = mynetmask1;
    assign MYDEFAULTGATEWAY1_o = mydefaultgateway1;
    assign MYTARGETIPADDR1_o = mytargetipaddr1;
    assign MYMACADDR1_o = mymacaddr1;

    assign MYIPADDR2_o = myipaddr2;
    assign MYNETMASK2_o = mynetmask2;
    assign MYDEFAULTGATEWAY2_o = mydefaultgateway2;
    assign MYTARGETIPADDR2_o = mytargetipaddr2;
    assign MYMACADDR2_o = mymacaddr2;

    assign MYIPADDR3_o = myipaddr3;
    assign MYNETMASK3_o = mynetmask3;
    assign MYDEFAULTGATEWAY3_o = mydefaultgateway3;
    assign MYTARGETIPADDR3_o = mytargetipaddr3;
    assign MYMACADDR3_o = mymacaddr3;

    (* keep *) reg [9:0] addra;
    wire [31:0] douta;
    config_memory config_memory_i (
				   .clka(clk),    // input wire clka
				   .ena(1),      // input wire ena
				   .wea(0),      // input wire [0 : 0] wea
				   .addra(addra),  // input wire [3 : 0] addra
				   .dina(0),    // input wire [31 : 0] dina
				   .douta(douta)  // output wire [31 : 0] douta
				   );
    (* keep *) reg [7:0] config_status = 0;
    always @(posedge clk) begin
	if(reset == 1) begin
	    addra <= 0;
	    config_status <= 0;
	end else begin
	    case(config_status)
		0: begin
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		1: begin
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end

		///////////////////////////////////////////////////
      
		2: begin
		    if(douta != 32'h00000000) begin
			myipaddr0 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		3: begin
		    if(douta != 32'h00000000) begin
			mynetmask0 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		4: begin
		    if(douta != 32'h00000000) begin
			mydefaultgateway0 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		5: begin
		    if(douta != 32'h00000000) begin
			mytargetipaddr0 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		6: begin
		    if(douta != 32'h00000000) begin
			mymacaddr0[47:16] <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		7: begin
		    if(douta != 32'h00000000) begin
			mymacaddr0[15:0] <= douta[31:16];
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end

		///////////////////////////////////////////////////

		///////////////////////////////////////////////////
      
		8: begin
		    if(douta != 32'h00000000) begin
			myipaddr1 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		9: begin
		    if(douta != 32'h00000000) begin
			mynetmask1 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		10: begin
		    if(douta != 32'h00000000) begin
			mydefaultgateway1 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		11: begin
		    if(douta != 32'h00000000) begin
			mytargetipaddr1 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		12: begin
		    if(douta != 32'h00000000) begin
			mymacaddr1[47:16] <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		13: begin
		    if(douta != 32'h00000000) begin
			mymacaddr1[15:0] <= douta[31:16];
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end

		///////////////////////////////////////////////////

		///////////////////////////////////////////////////

		14: begin
		    if(douta != 32'h00000000) begin
			myipaddr2 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		15: begin
		    if(douta != 32'h00000000) begin
			mynetmask2 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		16: begin
		    if(douta != 32'h00000000) begin
			mydefaultgateway2 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		17: begin
		    if(douta != 32'h00000000) begin
			mytargetipaddr2 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		18: begin
		    if(douta != 32'h00000000) begin
			mymacaddr2[47:16] <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		19: begin
		    if(douta != 32'h00000000) begin
			mymacaddr2[15:0] <= douta[31:16];
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end

		///////////////////////////////////////////////////

		///////////////////////////////////////////////////

		20: begin
		    if(douta != 32'h00000000) begin
			myipaddr3 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		21: begin
		    if(douta != 32'h00000000) begin
			mynetmask3 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		22: begin
		    if(douta != 32'h00000000) begin
			mydefaultgateway3 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		23: begin
		    if(douta != 32'h00000000) begin
			mytargetipaddr3 <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		24: begin
		    if(douta != 32'h00000000) begin
			mymacaddr3[47:16] <= douta;
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end
		25: begin
		    if(douta != 32'h00000000) begin
			mymacaddr3[15:0] <= douta[31:16];
		    end
		    config_status <= config_status + 1;
		    addra <= addra + 1;
		end

		///////////////////////////////////////////////////

		default: begin
		    // nothing to do
		end
	    endcase // case (config_status)
	end
    end

    ila_config_memory ila_config_memory_i(.clk(clk),
					  .probe0(myipaddr0),
					  .probe1(mynetmask0),
					  .probe2(mydefaultgateway0),
					  .probe3(mytargetipaddr0),
					  .probe4(mymacaddr0),
					  .probe5(addra),
					  .probe6(config_status),
					  .probe7(myipaddr1),
					  .probe8(mynetmask1),
					  .probe9(mydefaultgateway1),
					  .probe10(mytargetipaddr1),
					  .probe11(mymacaddr1)
					  );

endmodule // config_memory_wrapper

`default_nettype wire
