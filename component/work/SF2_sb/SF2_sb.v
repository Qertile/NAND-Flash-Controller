//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Jul  6 10:22:10 2023
// Version: 2022.1 2022.1.0.10
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// SF2_sb
module SF2_sb(
    // Inputs
    DEVRST_N,
    FAB_RESET_N,
    FIC_0_APB_M_PRDATA,
    FIC_0_APB_M_PREADY,
    FIC_0_APB_M_PSLVERR,
    FIC_0_APB_S_PADDR,
    FIC_0_APB_S_PENABLE,
    FIC_0_APB_S_PSEL,
    FIC_0_APB_S_PWDATA,
    FIC_0_APB_S_PWRITE,
    MSS_INT_F2M,
    // Outputs
    FIC_0_APB_M_PADDR,
    FIC_0_APB_M_PENABLE,
    FIC_0_APB_M_PSEL,
    FIC_0_APB_M_PWDATA,
    FIC_0_APB_M_PWRITE,
    FIC_0_APB_S_PRDATA,
    FIC_0_APB_S_PREADY,
    FIC_0_APB_S_PSLVERR,
    FIC_0_CLK,
    FIC_0_LOCK,
    INIT_DONE,
    MSS_READY,
    POWER_ON_RESET_N
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         DEVRST_N;
input         FAB_RESET_N;
input  [31:0] FIC_0_APB_M_PRDATA;
input         FIC_0_APB_M_PREADY;
input         FIC_0_APB_M_PSLVERR;
input  [31:0] FIC_0_APB_S_PADDR;
input         FIC_0_APB_S_PENABLE;
input         FIC_0_APB_S_PSEL;
input  [31:0] FIC_0_APB_S_PWDATA;
input         FIC_0_APB_S_PWRITE;
input  [15:0] MSS_INT_F2M;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] FIC_0_APB_M_PADDR;
output        FIC_0_APB_M_PENABLE;
output        FIC_0_APB_M_PSEL;
output [31:0] FIC_0_APB_M_PWDATA;
output        FIC_0_APB_M_PWRITE;
output [31:0] FIC_0_APB_S_PRDATA;
output        FIC_0_APB_S_PREADY;
output        FIC_0_APB_S_PSLVERR;
output        FIC_0_CLK;
output        FIC_0_LOCK;
output        INIT_DONE;
output        MSS_READY;
output        POWER_ON_RESET_N;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CORERESETP_0_RESET_N_F2M;
wire          DEVRST_N;
wire          FAB_RESET_N;
wire          FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire          FABOSC_0_RCOSC_25_50MHZ_O2F;
wire   [31:0] FIC_0_AMBA_MASTER_PADDR;
wire          FIC_0_AMBA_MASTER_PENABLE;
wire   [31:0] FIC_0_APB_M_PRDATA;
wire          FIC_0_APB_M_PREADY;
wire          FIC_0_AMBA_MASTER_PSELx;
wire          FIC_0_APB_M_PSLVERR;
wire   [31:0] FIC_0_AMBA_MASTER_PWDATA;
wire          FIC_0_AMBA_MASTER_PWRITE;
wire   [31:0] FIC_0_APB_S_PADDR;
wire          FIC_0_APB_S_PENABLE;
wire   [31:0] FIC_0_AMBA_SLAVE_PRDATA;
wire          FIC_0_AMBA_SLAVE_PREADY;
wire          FIC_0_APB_S_PSEL;
wire          FIC_0_AMBA_SLAVE_PSLVERR;
wire   [31:0] FIC_0_APB_S_PWDATA;
wire          FIC_0_APB_S_PWRITE;
wire          FIC_0_CLK_net_0;
wire          FIC_0_LOCK_net_0;
wire          INIT_DONE_net_0;
wire   [15:0] MSS_INT_F2M;
wire          MSS_READY_net_0;
wire          POWER_ON_RESET_N_net_0;
wire          SF2_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N;
wire          SF2_sb_MSS_TMP_0_MSS_RESET_N_M2F;
wire          POWER_ON_RESET_N_net_1;
wire          INIT_DONE_net_1;
wire          FIC_0_CLK_net_1;
wire          FIC_0_LOCK_net_1;
wire          MSS_READY_net_1;
wire   [31:0] FIC_0_AMBA_SLAVE_PRDATA_net_0;
wire          FIC_0_AMBA_SLAVE_PREADY_net_0;
wire          FIC_0_AMBA_SLAVE_PSLVERR_net_0;
wire   [31:0] FIC_0_AMBA_MASTER_PADDR_net_0;
wire          FIC_0_AMBA_MASTER_PSELx_net_0;
wire          FIC_0_AMBA_MASTER_PENABLE_net_0;
wire          FIC_0_AMBA_MASTER_PWRITE_net_0;
wire   [31:0] FIC_0_AMBA_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [7:2]  PADDR_const_net_0;
wire   [7:0]  PWDATA_const_net_0;
wire   [31:0] SDIF0_PRDATA_const_net_0;
wire   [31:0] SDIF1_PRDATA_const_net_0;
wire   [31:0] SDIF2_PRDATA_const_net_0;
wire   [31:0] SDIF3_PRDATA_const_net_0;
wire   [31:0] FIC_2_APB_M_PRDATA_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                        = 1'b1;
assign GND_net                        = 1'b0;
assign PADDR_const_net_0              = 6'h00;
assign PWDATA_const_net_0             = 8'h00;
assign SDIF0_PRDATA_const_net_0       = 32'h00000000;
assign SDIF1_PRDATA_const_net_0       = 32'h00000000;
assign SDIF2_PRDATA_const_net_0       = 32'h00000000;
assign SDIF3_PRDATA_const_net_0       = 32'h00000000;
assign FIC_2_APB_M_PRDATA_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign POWER_ON_RESET_N_net_1          = POWER_ON_RESET_N_net_0;
assign POWER_ON_RESET_N                = POWER_ON_RESET_N_net_1;
assign INIT_DONE_net_1                 = INIT_DONE_net_0;
assign INIT_DONE                       = INIT_DONE_net_1;
assign FIC_0_CLK_net_1                 = FIC_0_CLK_net_0;
assign FIC_0_CLK                       = FIC_0_CLK_net_1;
assign FIC_0_LOCK_net_1                = FIC_0_LOCK_net_0;
assign FIC_0_LOCK                      = FIC_0_LOCK_net_1;
assign MSS_READY_net_1                 = MSS_READY_net_0;
assign MSS_READY                       = MSS_READY_net_1;
assign FIC_0_AMBA_SLAVE_PRDATA_net_0   = FIC_0_AMBA_SLAVE_PRDATA;
assign FIC_0_APB_S_PRDATA[31:0]        = FIC_0_AMBA_SLAVE_PRDATA_net_0;
assign FIC_0_AMBA_SLAVE_PREADY_net_0   = FIC_0_AMBA_SLAVE_PREADY;
assign FIC_0_APB_S_PREADY              = FIC_0_AMBA_SLAVE_PREADY_net_0;
assign FIC_0_AMBA_SLAVE_PSLVERR_net_0  = FIC_0_AMBA_SLAVE_PSLVERR;
assign FIC_0_APB_S_PSLVERR             = FIC_0_AMBA_SLAVE_PSLVERR_net_0;
assign FIC_0_AMBA_MASTER_PADDR_net_0   = FIC_0_AMBA_MASTER_PADDR;
assign FIC_0_APB_M_PADDR[31:0]         = FIC_0_AMBA_MASTER_PADDR_net_0;
assign FIC_0_AMBA_MASTER_PSELx_net_0   = FIC_0_AMBA_MASTER_PSELx;
assign FIC_0_APB_M_PSEL                = FIC_0_AMBA_MASTER_PSELx_net_0;
assign FIC_0_AMBA_MASTER_PENABLE_net_0 = FIC_0_AMBA_MASTER_PENABLE;
assign FIC_0_APB_M_PENABLE             = FIC_0_AMBA_MASTER_PENABLE_net_0;
assign FIC_0_AMBA_MASTER_PWRITE_net_0  = FIC_0_AMBA_MASTER_PWRITE;
assign FIC_0_APB_M_PWRITE              = FIC_0_AMBA_MASTER_PWRITE_net_0;
assign FIC_0_AMBA_MASTER_PWDATA_net_0  = FIC_0_AMBA_MASTER_PWDATA;
assign FIC_0_APB_M_PWDATA[31:0]        = FIC_0_AMBA_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------SF2_sb_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.201
SF2_sb_CCC_0_FCCC CCC_0(
        // Inputs
        .RCOSC_25_50MHZ ( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        // Outputs
        .GL0            ( FIC_0_CLK_net_0 ),
        .LOCK           ( FIC_0_LOCK_net_0 ) 
        );

//--------CoreResetP   -   Actel:DirectCore:CoreResetP:7.1.100
CoreResetP #( 
        .DDR_WAIT            ( 200 ),
        .DEVICE_090          ( 0 ),
        .DEVICE_VOLTAGE      ( 2 ),
        .ENABLE_SOFT_RESETS  ( 0 ),
        .EXT_RESET_CFG       ( 0 ),
        .FDDR_IN_USE         ( 0 ),
        .MDDR_IN_USE         ( 0 ),
        .SDIF0_IN_USE        ( 0 ),
        .SDIF0_PCIE          ( 0 ),
        .SDIF0_PCIE_HOTRESET ( 1 ),
        .SDIF0_PCIE_L2P2     ( 1 ),
        .SDIF1_IN_USE        ( 0 ),
        .SDIF1_PCIE          ( 0 ),
        .SDIF1_PCIE_HOTRESET ( 1 ),
        .SDIF1_PCIE_L2P2     ( 1 ),
        .SDIF2_IN_USE        ( 0 ),
        .SDIF2_PCIE          ( 0 ),
        .SDIF2_PCIE_HOTRESET ( 1 ),
        .SDIF2_PCIE_L2P2     ( 1 ),
        .SDIF3_IN_USE        ( 0 ),
        .SDIF3_PCIE          ( 0 ),
        .SDIF3_PCIE_HOTRESET ( 1 ),
        .SDIF3_PCIE_L2P2     ( 1 ) )
CORERESETP_0(
        // Inputs
        .RESET_N_M2F                    ( SF2_sb_MSS_TMP_0_MSS_RESET_N_M2F ),
        .FIC_2_APB_M_PRESET_N           ( SF2_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N ),
        .POWER_ON_RESET_N               ( POWER_ON_RESET_N_net_0 ),
        .FAB_RESET_N                    ( FAB_RESET_N ),
        .RCOSC_25_50MHZ                 ( FABOSC_0_RCOSC_25_50MHZ_O2F ),
        .CLK_BASE                       ( FIC_0_CLK_net_0 ),
        .CLK_LTSSM                      ( GND_net ), // tied to 1'b0 from definition
        .FPLL_LOCK                      ( VCC_net ), // tied to 1'b1 from definition
        .SDIF0_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .CONFIG1_DONE                   ( VCC_net ),
        .CONFIG2_DONE                   ( VCC_net ),
        .SDIF0_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF0_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF0_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF0_PRDATA                   ( SDIF0_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF1_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF1_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_PRDATA                   ( SDIF1_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF2_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF2_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_PRDATA                   ( SDIF2_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF3_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF3_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_PRDATA                   ( SDIF3_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SOFT_EXT_RESET_OUT             ( GND_net ), // tied to 1'b0 from definition
        .SOFT_RESET_F2M                 ( GND_net ), // tied to 1'b0 from definition
        .SOFT_M3_RESET                  ( GND_net ), // tied to 1'b0 from definition
        .SOFT_MDDR_DDR_AXI_S_CORE_RESET ( GND_net ), // tied to 1'b0 from definition
        .SOFT_FDDR_CORE_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_0_CORE_RESET        ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_1_CORE_RESET        ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF1_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF1_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF2_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF2_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF3_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF3_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .MSS_HPMS_READY                 ( MSS_READY_net_0 ),
        .DDR_READY                      (  ),
        .SDIF_READY                     (  ),
        .RESET_N_F2M                    ( CORERESETP_0_RESET_N_F2M ),
        .M3_RESET_N                     (  ),
        .EXT_RESET_OUT                  (  ),
        .MDDR_DDR_AXI_S_CORE_RESET_N    (  ),
        .FDDR_CORE_RESET_N              (  ),
        .SDIF0_CORE_RESET_N             (  ),
        .SDIF0_0_CORE_RESET_N           (  ),
        .SDIF0_1_CORE_RESET_N           (  ),
        .SDIF0_PHY_RESET_N              (  ),
        .SDIF1_CORE_RESET_N             (  ),
        .SDIF1_PHY_RESET_N              (  ),
        .SDIF2_CORE_RESET_N             (  ),
        .SDIF2_PHY_RESET_N              (  ),
        .SDIF3_CORE_RESET_N             (  ),
        .SDIF3_PHY_RESET_N              (  ),
        .SDIF_RELEASED                  (  ),
        .INIT_DONE                      ( INIT_DONE_net_0 ) 
        );

//--------SF2_sb_FABOSC_0_OSC   -   Actel:SgCore:OSC:2.0.101
SF2_sb_FABOSC_0_OSC FABOSC_0(
        // Inputs
        .XTL                ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .RCOSC_25_50MHZ_CCC ( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        .RCOSC_25_50MHZ_O2F ( FABOSC_0_RCOSC_25_50MHZ_O2F ),
        .RCOSC_1MHZ_CCC     (  ),
        .RCOSC_1MHZ_O2F     (  ),
        .XTLOSC_CCC         (  ),
        .XTLOSC_O2F         (  ) 
        );

//--------SF2_sb_MSS
SF2_sb_MSS SF2_sb_MSS_0(
        // Inputs
        .MCCC_CLK_BASE          ( FIC_0_CLK_net_0 ),
        .MCCC_CLK_BASE_PLL_LOCK ( FIC_0_LOCK_net_0 ),
        .MSS_RESET_N_F2M        ( CORERESETP_0_RESET_N_F2M ),
        .FIC_0_APB_S_PSEL       ( FIC_0_APB_S_PSEL ),
        .FIC_0_APB_S_PWRITE     ( FIC_0_APB_S_PWRITE ),
        .FIC_0_APB_S_PENABLE    ( FIC_0_APB_S_PENABLE ),
        .FIC_0_APB_M_PREADY     ( FIC_0_APB_M_PREADY ),
        .FIC_0_APB_M_PSLVERR    ( FIC_0_APB_M_PSLVERR ),
        .FIC_2_APB_M_PREADY     ( VCC_net ), // tied to 1'b1 from definition
        .FIC_2_APB_M_PSLVERR    ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_APB_S_PADDR      ( FIC_0_APB_S_PADDR ),
        .FIC_0_APB_S_PWDATA     ( FIC_0_APB_S_PWDATA ),
        .FIC_0_APB_M_PRDATA     ( FIC_0_APB_M_PRDATA ),
        .FIC_2_APB_M_PRDATA     ( FIC_2_APB_M_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .MSS_INT_F2M            ( MSS_INT_F2M ),
        // Outputs
        .MSS_RESET_N_M2F        ( SF2_sb_MSS_TMP_0_MSS_RESET_N_M2F ),
        .FIC_0_APB_S_PREADY     ( FIC_0_AMBA_SLAVE_PREADY ),
        .FIC_0_APB_S_PSLVERR    ( FIC_0_AMBA_SLAVE_PSLVERR ),
        .FIC_0_APB_M_PSEL       ( FIC_0_AMBA_MASTER_PSELx ),
        .FIC_0_APB_M_PWRITE     ( FIC_0_AMBA_MASTER_PWRITE ),
        .FIC_0_APB_M_PENABLE    ( FIC_0_AMBA_MASTER_PENABLE ),
        .FIC_2_APB_M_PRESET_N   ( SF2_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N ),
        .FIC_2_APB_M_PCLK       (  ),
        .FIC_2_APB_M_PWRITE     (  ),
        .FIC_2_APB_M_PENABLE    (  ),
        .FIC_2_APB_M_PSEL       (  ),
        .FIC_0_APB_S_PRDATA     ( FIC_0_AMBA_SLAVE_PRDATA ),
        .FIC_0_APB_M_PADDR      ( FIC_0_AMBA_MASTER_PADDR ),
        .FIC_0_APB_M_PWDATA     ( FIC_0_AMBA_MASTER_PWDATA ),
        .FIC_2_APB_M_PADDR      (  ),
        .FIC_2_APB_M_PWDATA     (  ) 
        );

//--------SYSRESET
SYSRESET SYSRESET_POR(
        // Inputs
        .DEVRST_N         ( DEVRST_N ),
        // Outputs
        .POWER_ON_RESET_N ( POWER_ON_RESET_N_net_0 ) 
        );


endmodule
