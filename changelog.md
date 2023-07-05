# NFC NAND Flash Controller
The NAND flash controller for Micron MT29F8G08ABACAWP by verilog.

-----------------------------------
## Unreleased v0.0.4 (2023.07.##)
### New
### Changed
### Removed
### Deprecated
### Fixed
### Known Issues
### Notes
### Reference

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