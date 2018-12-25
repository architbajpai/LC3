module decode_correct ( clock, reset, enable_decode, dout, E_Control,
npc_in, Mem_Control, W_Control, IR, npc_out);	//psr
input clock, reset, enable_decode;
//input [2:0] psr;
input [15:0] dout;
input [15:0] npc_in;
output reg [1:0] W_Control;
output reg Mem_Control;
output reg [5:0] E_Control;
output reg [15:0] IR;
output reg [15:0] npc_out;

//reg [1:0] W_Control;
//reg M_Control;
//reg [1:0] inst_type;
//reg pc_store;
reg [1:0] pcselect1, alu_control;
reg pcselect2, op2select;
//reg [15:0] IR, npc_out;
wire [3:0] opcode=dout[15:12];

//assign Mem_Control = M_Control;
assign E_Control = {alu_control, pcselect1,pcselect2, op2select};

// always block for IR and npc output
always @(posedge clock)
begin
	if(reset)
	begin
	IR <= 0;
	npc_out <= 0;
	end
	else if (enable_decode)
	begin
	IR <= dout;
	npc_out <= npc_in;
	//npc_out <= npc_in + 1;
	end
end

/*always @(posedge clock)					//CHECK IF NEEDED!!!!!
begin
	if(reset)
	inst_type <= 2'd0;
	else if (enable_decode)
	begin
	case (opcode[1:0])
	2'b00: inst_type <= 2'd1;
	2'b01: inst_type <= 2'd0;
	2'b10: inst_type <= 2'd1;
	2'b11: inst_type <= 2'd2;
	endcase
	end
end*/

always @(posedge clock)
begin
	if(reset)
	begin
	alu_control <= 0;
	op2select <= 0;
	pcselect1 <= 0;
	pcselect2 <= 0;
	end

	else if (enable_decode)
	begin
	case(opcode[1:0])
	2'b00:
		begin
		alu_control <= 2'd0;
		op2select <= 1'b0;
			case (opcode[3:2])
			2'b00:
				begin
				pcselect1 <= 2'd1;
				pcselect2 <= 1'b1;
				end
			2'b11:
				begin
				pcselect1 <= 2'd3;
				pcselect2 <= 1'b0;
				end
			default:
				begin
				pcselect1 <= 2'd0;
				pcselect2 <= 1'b0;
				end
			endcase
		end
	2'b01:
		begin
		pcselect1 <= 2'd0;
		pcselect2 <= 1'b0;
		op2select <= ~dout[5];
		//op2select <= dout[5];
			case (opcode[3:2])
			2'b00: alu_control <= 2'd0;
			2'b01: alu_control <= 2'd1;
			//2'b00: alu_control <= 2'd1;
			//2'b01: alu_control <= 2'd0;
			2'b10: alu_control <= 2'd2;
			default: alu_control<= 2'd0;
			endcase
		end

	2'b10:
	begin
	alu_control<= 2'd0;
	op2select<=1'b0;
		if (opcode[3:2]==2'b01)
		begin
		pcselect1 <=2'd2;
		pcselect2 <=1'd0;
		end
		else
		begin
		pcselect1 <= 2'd1;
		//pcselect1 <= 2'd2;
		pcselect2 <= 1'b1;
		//pcselect2 <= 1'b0;
		end
	end
	2'b11:
	begin
	alu_control<=2'd0;
	op2select <= 1'b0;
		if (opcode[3:2]==2'b01)
		begin
		pcselect1 <=2'd2;
		pcselect2 <=1'b0;
		end
		else
		begin
		pcselect1 <= 2'd1;
		pcselect2 <= 1'b1;
		end
	end
	endcase
end
end

always @(posedge clock)
begin
	if(reset)
	begin
	W_Control <= 2'd0;
	end

	else if (enable_decode)
	begin
	case(opcode[1:0])
	2'b00:
		begin
		W_Control <= 2'd0;
		end
	2'b01:
		begin
		W_Control <= 2'd0;
		//W_Control <= 2'd1; for ALU W_control = 2'b00;
		end
	2'b10:
		begin
		if (opcode[3:2]==2'b11)
		begin
		W_Control<=2'd2;
		//W_Control<=2'd0; for LEA W_Control = 2'b10;
		end
		else
		W_Control<=2'd1;
		end
	2'b11:
		begin
		W_Control<=2'd0;
		end
	default: W_Control<=W_Control;
	endcase
	end
end

always @(posedge clock)
begin
	if (reset)
	begin
	Mem_Control <= 0;
	end
	else if (enable_decode)
	begin
		case(opcode[1:0])
		2'b00:
			begin
			Mem_Control <= 0;
			end
		2'b01:
			begin
			Mem_Control <= 0;
			end
		2'b10:
			begin
			Mem_Control <= (opcode[3:2]==2'b10) ? 1 : 0;
			end
		2'b11:
			begin
			Mem_Control <= (opcode[3:2]==2'b10) ? 1 : 0;
			end
		default: Mem_Control<=Mem_Control;
		endcase
	end
end
endmodule
