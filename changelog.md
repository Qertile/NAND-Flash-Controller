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
## Unreleased v0.1.5 (2023.07.##)
### New
1. add prefix `F_` for flash variables
2. add prefix `C_` for controller variables
3. create input `F_nRB`
### Changed
### Removed
### Deprecated
### Fixed
### Known Issues
### Notes
### Reference

-----------------------------------
## NFC v0.1.4 (2023.07.18)
### New
- create FIFO.v
- create control and status registers


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