-makelib ies_lib/xilinx_vip -sv \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "D:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_vip_v1_1_5 -sv \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_7 -sv \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system_bd/ip/system_bd_processing_system7_0_0/sim/system_bd_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_18 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_19 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_19 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system_bd/ip/system_bd_axi_protocol_convert_0_0/sim/system_bd_axi_protocol_convert_0_0.v" \
  "../../../bd/system_bd/ip/system_bd_axi_emif_0_0/src/fifo_dsp_zynq/sim/fifo_dsp_zynq.v" \
  "../../../bd/system_bd/ip/system_bd_axi_emif_0_0/src/fifo_zynq_dsp/sim/fifo_zynq_dsp.v" \
  "../../../bd/system_bd/ipshared/b96f/hdl/axi_emif_v1_0_S00_AXI.v" \
  "../../../bd/system_bd/ipshared/b96f/src/zynq_dsp_emif.v" \
  "../../../bd/system_bd/ipshared/b96f/hdl/axi_emif_v1_0.v" \
  "../../../bd/system_bd/ip/system_bd_axi_emif_0_0/sim/system_bd_axi_emif_0_0.v" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_13 \
  "../../../../zynq_sys.srcs/sources_1/bd/system_bd/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system_bd/ip/system_bd_rst_ps7_0_100M_0/sim/system_bd_rst_ps7_0_100M_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system_bd/ip/system_bd_auto_pc_0/sim/system_bd_auto_pc_0.v" \
  "../../../bd/system_bd/sim/system_bd.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

