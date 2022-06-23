#!/bin/bash

ghdl -a BancoRegistradores.vhd
ghdl -a MaquinaEstados.vhd
ghdl -a mux2x1.vhd
ghdl -a PC.vhd
ghdl -a Processador_tb.vhd
ghdl -a Processador.vhd
ghdl -a reg1bit.vhd
ghdl -a reg16bits.vhd
ghdl -a ROM.vhd
ghdl -a UC.vhd
ghdl -a ULA_tb.vhd
ghdl -a ULA.vhd
ghdl -a ram.vhd

ghdl -r Processador_tb --wave=Processador_tb.ghw
gtkwave Processador_tb.ghw 