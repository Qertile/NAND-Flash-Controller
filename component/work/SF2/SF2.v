//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Jul  8 18:59:08 2023
// Version: 2022.1 2022.1.0.10
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// SF2
module SF2(
    // Inputs
    DEVRST_N
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CoreAPB3_C0_0_APBmslave0_PENABLE;
wire          CoreAPB3_C0_0_APBmslave0_PREADY;
wire          CoreAPB3_C0_0_APBmslave0_PSELx;
wire          CoreAPB3_C0_0_APBmslave0_PSLVERR;
wire          CoreAPB3_C0_0_APBmslave0_PWRITE;
wire          DEVRST_N;
wire   [31:0] SF2_sb_0_FIC_0_AMBA_MASTER_PADDR;
wire          SF2_sb_0_FIC_0_AMBA_MASTER_PENABLE;
wire   [31:0] SF2_sb_0_FIC_0_AMBA_MASTER_PRDATA;
wire          SF2_sb_0_FIC_0_AMBA_MASTER_PREADY;
wire          SF2_sb_0_FIC_0_AMBA_MASTER_PSELx;
wire          SF2_sb_0_FIC_0_AMBA_MASTER_PSLVERR;
wire   [31:0] SF2_sb_0_FIC_0_AMBA_MASTER_PWDATA;
wire          SF2_sb_0_FIC_0_AMBA_MASTER_PWRITE;
wire          SF2_sb_0_FIC_0_CLK;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire   [15:0] MSS_INT_F2M_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] CoreAPB3_C0_0_APBmslave0_PADDR;
wire   [4:0]  CoreAPB3_C0_0_APBmslave0_PADDR_0;
wire   [4:0]  CoreAPB3_C0_0_APBmslave0_PADDR_0_4to0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave0_PRDATA;
wire   [31:0] CoreAPB3_C0_0_APBmslave0_PRDATA_0;
wire   [31:8] CoreAPB3_C0_0_APBmslave0_PRDATA_0_31to8;
wire   [7:0]  CoreAPB3_C0_0_APBmslave0_PRDATA_0_7to0;
wire   [31:0] CoreAPB3_C0_0_APBmslave0_PWDATA;
wire   [7:0]  CoreAPB3_C0_0_APBmslave0_PWDATA_0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave0_PWDATA_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                 = 1'b1;
assign MSS_INT_F2M_const_net_0 = 16'h0000;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign CoreAPB3_C0_0_APBmslave0_PADDR_0 = { CoreAPB3_C0_0_APBmslave0_PADDR_0_4to0 };
assign CoreAPB3_C0_0_APBmslave0_PADDR_0_4to0 = CoreAPB3_C0_0_APBmslave0_PADDR[4:0];

assign CoreAPB3_C0_0_APBmslave0_PRDATA_0 = { CoreAPB3_C0_0_APBmslave0_PRDATA_0_31to8, CoreAPB3_C0_0_APBmslave0_PRDATA_0_7to0 };
assign CoreAPB3_C0_0_APBmslave0_PRDATA_0_31to8 = 24'h0;
assign CoreAPB3_C0_0_APBmslave0_PRDATA_0_7to0 = CoreAPB3_C0_0_APBmslave0_PRDATA[7:0];

assign CoreAPB3_C0_0_APBmslave0_PWDATA_0 = { CoreAPB3_C0_0_APBmslave0_PWDATA_0_7to0 };
assign CoreAPB3_C0_0_APBmslave0_PWDATA_0_7to0 = CoreAPB3_C0_0_APBmslave0_PWDATA[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAPB3_C0
CoreAPB3_C0 CoreAPB3_C0_0(
        // Inputs
        .PSEL      ( SF2_sb_0_FIC_0_AMBA_MASTER_PSELx ),
        .PENABLE   ( SF2_sb_0_FIC_0_AMBA_MASTER_PENABLE ),
        .PWRITE    ( SF2_sb_0_FIC_0_AMBA_MASTER_PWRITE ),
        .PREADYS0  ( CoreAPB3_C0_0_APBmslave0_PREADY ),
        .PSLVERRS0 ( CoreAPB3_C0_0_APBmslave0_PSLVERR ),
        .PADDR     ( SF2_sb_0_FIC_0_AMBA_MASTER_PADDR ),
        .PWDATA    ( SF2_sb_0_FIC_0_AMBA_MASTER_PWDATA ),
        .PRDATAS0  ( CoreAPB3_C0_0_APBmslave0_PRDATA_0 ),
        // Outputs
        .PREADY    ( SF2_sb_0_FIC_0_AMBA_MASTER_PREADY ),
        .PSLVERR   ( SF2_sb_0_FIC_0_AMBA_MASTER_PSLVERR ),
        .PSELS0    ( CoreAPB3_C0_0_APBmslave0_PSELx ),
        .PENABLES  ( CoreAPB3_C0_0_APBmslave0_PENABLE ),
        .PWRITES   ( CoreAPB3_C0_0_APBmslave0_PWRITE ),
        .PRDATA    ( SF2_sb_0_FIC_0_AMBA_MASTER_PRDATA ),
        .PADDRS    ( CoreAPB3_C0_0_APBmslave0_PADDR ),
        .PWDATAS   ( CoreAPB3_C0_0_APBmslave0_PWDATA ) 
        );

//--------NAND_controller
NAND_controller NAND_controller_0(
        // Inputs
        .PCLK       ( SF2_sb_0_FIC_0_CLK ),
        .PENABLE    ( CoreAPB3_C0_0_APBmslave0_PENABLE ),
        .PRESETN    ( VCC_net ),
        .PSEL       ( CoreAPB3_C0_0_APBmslave0_PSELx ),
        .PWRITE     ( CoreAPB3_C0_0_APBmslave0_PWRITE ),
        .PADDR      ( CoreAPB3_C0_0_APBmslave0_PADDR_0 ),
        .PWDATA     ( CoreAPB3_C0_0_APBmslave0_PWDATA_0 ),
        // Outputs
        .PREADY_S0  ( CoreAPB3_C0_0_APBmslave0_PREADY ),
        .PSLVERR_S0 ( CoreAPB3_C0_0_APBmslave0_PSLVERR ),
        .nCE        (  ),
        .CLE        (  ),
        .ALE        (  ),
        .nWE        (  ),
        .nRE        (  ),
        .nWP        (  ),
        .PRDATA     ( CoreAPB3_C0_0_APBmslave0_PRDATA ),
        .IO         (  ) 
        );

//--------SF2_sb
SF2_sb SF2_sb_0(
        // Inputs
        .FAB_RESET_N         ( VCC_net ), // tied to 1'b1 from definition
        .DEVRST_N            ( DEVRST_N ),
        .FIC_0_APB_M_PREADY  ( SF2_sb_0_FIC_0_AMBA_MASTER_PREADY ),
        .FIC_0_APB_M_PSLVERR ( SF2_sb_0_FIC_0_AMBA_MASTER_PSLVERR ),
        .MSS_INT_F2M         ( MSS_INT_F2M_const_net_0 ),
        .FIC_0_APB_M_PRDATA  ( SF2_sb_0_FIC_0_AMBA_MASTER_PRDATA ),
        // Outputs
        .POWER_ON_RESET_N    (  ),
        .INIT_DONE           (  ),
        .FIC_0_CLK           ( SF2_sb_0_FIC_0_CLK ),
        .FIC_0_LOCK          (  ),
        .MSS_READY           (  ),
        .FIC_0_APB_M_PSEL    ( SF2_sb_0_FIC_0_AMBA_MASTER_PSELx ),
        .FIC_0_APB_M_PENABLE ( SF2_sb_0_FIC_0_AMBA_MASTER_PENABLE ),
        .FIC_0_APB_M_PWRITE  ( SF2_sb_0_FIC_0_AMBA_MASTER_PWRITE ),
        .FIC_0_APB_M_PADDR   ( SF2_sb_0_FIC_0_AMBA_MASTER_PADDR ),
        .FIC_0_APB_M_PWDATA  ( SF2_sb_0_FIC_0_AMBA_MASTER_PWDATA ) 
        );


endmodule
