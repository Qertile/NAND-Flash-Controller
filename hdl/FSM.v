`include "inc.v"
module fsm (
    /* APB Inputs */
    PCLK,
    PRESETN,

    /* Controller Inputs */
    C_Cmd,
    C_Addr,
    C_Length,
    C_Status,
    
    /* Controller Outputs */
    F_nCE, 
    F_CLE, 
    F_ALE, 
    F_nWE, 
    F_nRE, 
    F_nWP,
    F_nRB,
    F_DIO
);

/* APB Inputs */
input       PCLK;
input       PRESETN;

/* Controller Inputs */
input       C_Cmd;
input       C_Addr;
input       C_Length;
input       C_Status;
input       F_nRB; 

/* Controller output */
output       F_nCE; 
output       F_CLE; 
output       F_ALE; 
output       F_nWE; 
output       F_nRE; 
output       F_nWP;
output       F_DIO;


/* Control registers and Status register  */
wire    [7:0]   C_Cmd;
wire    [7:0]   C_Addr;
wire    [7:0]   C_Length;
wire    [7:0]   C_Status;

/* Controller output */
reg F_nCE;
reg F_CLE;
reg F_ALE;
reg F_nWE;
reg F_nRE;
reg F_nWP;
reg [7:0] F_DIO;


/* Internal signals and array */
reg [2:0]   i_state;
reg [2:0]   i_next_state;
reg [7:0]   i_cmd  [1:0];
reg [7:0]   i_addr [4:0];
reg         icmd_ptr;
reg [2:0]   iaddr_ptr ;


/* Custom define states for state machine */
parameter   STATE_RSET  = 3'b111;
parameter   STATE_IDLE  = 3'b000;
parameter   STATE_READ  = 3'b001;
parameter   STATE_WRIT  = 3'b010;
parameter   STATE_ERAS  = 3'b011;
parameter   STATE_RX    = 3'b100;



always @(posedge PCLK or negedge PRESETN) begin
    if (!PRESETN) begin
        /* reset NAND flash */
        i_state <= STATE_RSET;
        /* reset command buffer */
        icmd_ptr <= 0;
        iaddr_ptr <= 0;
    end 
    else begin
        i_state <= STATE_IDLE;
    end
    if(C_Cmd)begin
        i_cmd[icmd_ptr] <= C_Cmd;
        icmd_ptr = ~icmd_ptr;
    end
    if(C_Addr)begin
        i_addr[iaddr_ptr] <= C_Addr;
        iaddr_ptr = iaddr_ptr+1;
        if (iaddr_ptr == 3'd5) begin
            iaddr_ptr <= 0;
        end
    end
end

integer i;
always @(*) begin
    case (i_state)
    STATE_RSET: begin
        if (!PRESETN) begin
            command_cycle(8'hFF);
            i_next_state <= STATE_IDLE;
        end 
        else begin
            i_next_state <= STATE_IDLE;
        end
    end
    STATE_IDLE: begin
        idle_cycle();
        i_next_state <= STATE_IDLE;
    end
    STATE_READ: begin
        if (i_cmd[0] == 8'h00 && i_cmd[1] == 8'h30) begin
            command_cycle (i_cmd[0]);
            for (i = 0; i<5; i=1+1) begin
                address_cycle (i_addr[i]);
            end
            command_cycle (i_cmd[1]);
                
            # (`T_R + `T_RR) // # 25
            
            for (i = 0; i<C_Length; i=1+1) begin
                dataout_cycle();
            end
            i_next_state <= STATE_IDLE;
        end 
        else begin
            i_next_state <= STATE_IDLE;
        end
    end
    STATE_WRIT: begin
        if (i_cmd[0] == 8'h80 && i_cmd[1] == 8'h10) begin
            command_cycle (i_cmd[0]);
            for (i = 0; i<5; i=1+1) begin
                address_cycle (i_addr[i]);
            end

            # (`T_ADL) // # 70
            
            for (i = 0; i<C_Length; i=1+1) begin
                datain_cycle();
            end

            command_cycle (i_cmd[i]);
            i_next_state <= STATE_IDLE;
        end 
        else begin
            i_next_state <= STATE_IDLE;
        end
    end
    STATE_RSET: begin
        if (i_cmd[0] == 8'h60 && i_cmd[1] == 8'hD0) begin
            command_cycle(i_cmd[0]);
         
            for (i = 0; i<3; i=1+1) begin
                address_cycle (i_addr[i]);
            end
        
            command_cycle(i_cmd[1]);
        end
    end
    default: begin
        idle_cycle();
        i_next_state <= STATE_IDLE;
    end
    endcase
end

/* ----- Tasks of cycles ----- */

task command_cycle;
    input [7:0] cmd;
    begin: command_cycle

        F_CLE = (`HIGH);
        F_nCE = (`LOW);
        F_nWE = (`LOW);
        F_ALE = (`LOW);
        // buff <= cmd;
        
        # (`T_CS) // # 15
        F_nWE = ~F_nWE;

        # (`T_CH) // # 5
        F_nCE = ~F_nCE; 
        F_CLE = ~F_CLE;
        F_ALE = ~F_ALE;
    end
endtask


task address_cycle;
    input [7:0] addr;
    begin: address_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_nWE = (`LOW);
        F_ALE = (`HIGH);
        // buff <= addr;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
    end
endtask

task datain_cycle;
    input [7:0] data;
    begin: datain_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_ALE = (`LOW);
        F_nWE = (`LOW);
        // buff <= data;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
    end
endtask

task dataout_cycle;
    if (F_nRB) begin
        
        begin: dataout_cycle

            F_nCE = (`LOW);
            F_nRE = (`LOW);
            // buff <= data;
            
            # (`T_RP) // # 10
            F_nRE = ~F_nRE;

            # (`T_REH); // # 7
        end
    end
endtask

task idle_cycle;        
    begin: idle_cycle

        F_nCE = (`HIGH);
    end
endtask
endmodule