onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RegisterFile_tb/TB/STATES
add wave -noupdate /RegisterFile_tb/RF/clk
add wave -noupdate /RegisterFile_tb/RF/reset
add wave -noupdate /RegisterFile_tb/RF/Reg_Write_i
add wave -noupdate -radix unsigned /RegisterFile_tb/RF/Write_Register_i
add wave -noupdate -radix unsigned /RegisterFile_tb/RF/Read_Register_1_i
add wave -noupdate -radix unsigned /RegisterFile_tb/RF/Read_Register_2_i
add wave -noupdate -radix hexadecimal /RegisterFile_tb/RF/Write_Data_i
add wave -noupdate -radix hexadecimal /RegisterFile_tb/RF/Read_Data_1_o
add wave -noupdate -radix hexadecimal /RegisterFile_tb/RF/Read_Data_2_o
add wave -noupdate /RegisterFile_tb/TB/i
add wave -noupdate /RegisterFile_tb/TB/j
add wave -noupdate -radix hexadecimal /RegisterFile_tb/TB/testArr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {292300 ps} {322500 ps}
