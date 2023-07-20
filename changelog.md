# NFC NAND Flash Controller
The NAND flash controller for Micron MT29F8G08ABACAWP by verilog.


## TO-DO
- [ ] command
  - [ ] from master
  - [ ] to slave
- [ ] addr
  - [ ] location
- [ ] FIFO 
  - [ ] TX FIFO 
  - [ ] RX FIFO 
- [ ] Register Map
  - [ ] control register
    - [ ] internal command
  - [ ] status register
- [ ] busy hand shake
- [ ] interrupt
- [ ] FSM

-----------------------------------
## Unreleased v0.1.9 (2023.07.##)
### New
### Changed
1. rename datain_cycle to rddata_cycle
2. rename dataout_cycle to wrdata_cycle
### Removed
### Deprecated
### Fixed
### Known Issues
### Notes
### Reference

-----------------------------------
## NFC v0.1.8 (2023.07.20)
### New
1. implement `STATE_READ`
2. implement `STATE_WRIT`
3. implement `STATE_RSET`
### Notes
1. need connect data in and out in state machine


-----------------------------------
## NFC v0.1.7 (2023.07.19)
### New
1. create array `i_cmd` and `i_addr`
2. create reg `icmd_ptr` and `iaddr_ptr`
3. implement moving cmd and addr from port into array


-----------------------------------
## NFC v0.1.6 (2023.07.19)
### New
1. create task `idle_cycle`
2. implement `STATE_RST` and `STATE_IDLE`
### Changed
1. rename `STATE_REST` to `STATE_RSET`
2. rename `reset_cycle` to `idle_cycle`
3. add a prefix `i_` to `state` and `next_state`


-----------------------------------
## Unreleased v0.1.5 (2023.07.19)
### New
1. create FSM.v
2. create `dataout_cycle`
### Changed
1. rename `data_cycle` to `datain_cycle`


-----------------------------------
## NFC v0.1.4 (2023.07.18)
### New
1. create FIFO.v
2.  create control and status registers
3. add prefix `F_` for flash variables
4. add prefix `C_` for controller variables
5. create input `F_nRB`


-----------------------------------
## NFC v0.1.3 (2023.07.10)
### New
- create to-do list and psuedo code
### Changed
- rename IO to FLASH_IO


-----------------------------------
## NFC v0.1.2 (2023.07.10)
### New
- create wire `wr_enable` and `rd_enable`

-----------------------------------
## NFC v0.1.1 (2023.07.07)
### New
1. connect PCLK to FIC_0_CLK
### Changed
1. rename PREADY to PREADY_S0
2. rename PSLVERR to PSLVERR_S0


-----------------------------------
## NFC v0.1.0 (2023.07.06)
### New
1. using APB bus to connect controller and SF2
2. create new instance NAND_controller_0
   

-----------------------------------
## NFC v0.0.3 (2023.07.05)
### New
1. create an always block to deal with type and IOH from host
2. create host simulator in testbench
### Changed
1. rename RST to nRST, TYPE to MODE


-----------------------------------
## NFC v0.0.2 (2023.06.13)
### New
1. create task `address_cycle`
2. create task `data_cycle`
3. create input `TYPE`


-----------------------------------
## NFC v0.0.1 (2023.06.13)
### New
1. create module MT29F8G08ABACAWP
2. create task `command_cycle`
3. create test bench