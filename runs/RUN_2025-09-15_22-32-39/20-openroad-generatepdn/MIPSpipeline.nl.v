module MIPSpipeline (clk,
    reset,
    current_pc,
    VGND,
    VPWR);
 input clk;
 input reset;
 output [31:0] current_pc;
 inout VGND;
 inout VPWR;

 wire \PC4[10] ;
 wire \PC4[11] ;
 wire \PC4[12] ;
 wire \PC4[13] ;
 wire \PC4[14] ;
 wire \PC4[15] ;
 wire \PC4[16] ;
 wire \PC4[17] ;
 wire \PC4[18] ;
 wire \PC4[19] ;
 wire \PC4[20] ;
 wire \PC4[21] ;
 wire \PC4[22] ;
 wire \PC4[23] ;
 wire \PC4[24] ;
 wire \PC4[25] ;
 wire \PC4[26] ;
 wire \PC4[27] ;
 wire \PC4[28] ;
 wire \PC4[29] ;
 wire \PC4[2] ;
 wire \PC4[30] ;
 wire \PC4[31] ;
 wire \PC4[3] ;
 wire \PC4[4] ;
 wire \PC4[5] ;
 wire \PC4[6] ;
 wire \PC4[7] ;
 wire \PC4[8] ;
 wire \PC4[9] ;
 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;

 sky130_fd_sc_hd__inv_2 _066_ (.A(current_pc[2]),
    .Y(\PC4[2] ));
 sky130_fd_sc_hd__inv_2 _067_ (.A(reset),
    .Y(_000_));
 sky130_fd_sc_hd__nand2_2 _068_ (.A(current_pc[2]),
    .B(current_pc[3]),
    .Y(_062_));
 sky130_fd_sc_hd__or2_2 _069_ (.A(current_pc[2]),
    .B(current_pc[3]),
    .X(_063_));
 sky130_fd_sc_hd__and2_2 _070_ (.A(_062_),
    .B(_063_),
    .X(\PC4[3] ));
 sky130_fd_sc_hd__xnor2_2 _071_ (.A(current_pc[4]),
    .B(_062_),
    .Y(\PC4[4] ));
 sky130_fd_sc_hd__and4_2 _072_ (.A(current_pc[2]),
    .B(current_pc[3]),
    .C(current_pc[4]),
    .D(current_pc[5]),
    .X(_064_));
 sky130_fd_sc_hd__a31o_2 _073_ (.A1(current_pc[2]),
    .A2(current_pc[3]),
    .A3(current_pc[4]),
    .B1(current_pc[5]),
    .X(_065_));
 sky130_fd_sc_hd__and2b_2 _074_ (.A_N(_064_),
    .B(_065_),
    .X(\PC4[5] ));
 sky130_fd_sc_hd__xor2_2 _075_ (.A(current_pc[6]),
    .B(_064_),
    .X(\PC4[6] ));
 sky130_fd_sc_hd__nand3_2 _076_ (.A(current_pc[6]),
    .B(current_pc[7]),
    .C(_064_),
    .Y(_030_));
 sky130_fd_sc_hd__a21o_2 _077_ (.A1(current_pc[6]),
    .A2(_064_),
    .B1(current_pc[7]),
    .X(_031_));
 sky130_fd_sc_hd__and2_2 _078_ (.A(_030_),
    .B(_031_),
    .X(\PC4[7] ));
 sky130_fd_sc_hd__xnor2_2 _079_ (.A(current_pc[8]),
    .B(_030_),
    .Y(\PC4[8] ));
 sky130_fd_sc_hd__and4_2 _080_ (.A(current_pc[6]),
    .B(current_pc[7]),
    .C(current_pc[8]),
    .D(current_pc[9]),
    .X(_032_));
 sky130_fd_sc_hd__and2_2 _081_ (.A(_064_),
    .B(_032_),
    .X(_033_));
 sky130_fd_sc_hd__a41o_2 _082_ (.A1(current_pc[6]),
    .A2(current_pc[7]),
    .A3(current_pc[8]),
    .A4(_064_),
    .B1(current_pc[9]),
    .X(_034_));
 sky130_fd_sc_hd__and2b_2 _083_ (.A_N(_033_),
    .B(_034_),
    .X(\PC4[9] ));
 sky130_fd_sc_hd__xor2_2 _084_ (.A(current_pc[10]),
    .B(_033_),
    .X(\PC4[10] ));
 sky130_fd_sc_hd__and3_2 _085_ (.A(current_pc[10]),
    .B(current_pc[11]),
    .C(_033_),
    .X(_035_));
 sky130_fd_sc_hd__a31o_2 _086_ (.A1(current_pc[10]),
    .A2(_064_),
    .A3(_032_),
    .B1(current_pc[11]),
    .X(_036_));
 sky130_fd_sc_hd__and2b_2 _087_ (.A_N(_035_),
    .B(_036_),
    .X(\PC4[11] ));
 sky130_fd_sc_hd__and2_2 _088_ (.A(current_pc[12]),
    .B(_035_),
    .X(_037_));
 sky130_fd_sc_hd__xor2_2 _089_ (.A(current_pc[12]),
    .B(_035_),
    .X(\PC4[12] ));
 sky130_fd_sc_hd__and4_2 _090_ (.A(current_pc[10]),
    .B(current_pc[11]),
    .C(current_pc[12]),
    .D(current_pc[13]),
    .X(_038_));
 sky130_fd_sc_hd__and3_2 _091_ (.A(_064_),
    .B(_032_),
    .C(_038_),
    .X(_039_));
 sky130_fd_sc_hd__xor2_2 _092_ (.A(current_pc[13]),
    .B(_037_),
    .X(\PC4[13] ));
 sky130_fd_sc_hd__nand2_2 _093_ (.A(current_pc[14]),
    .B(_039_),
    .Y(_040_));
 sky130_fd_sc_hd__xor2_2 _094_ (.A(current_pc[14]),
    .B(_039_),
    .X(\PC4[14] ));
 sky130_fd_sc_hd__and3_2 _095_ (.A(current_pc[14]),
    .B(current_pc[15]),
    .C(_039_),
    .X(_041_));
 sky130_fd_sc_hd__xnor2_2 _096_ (.A(current_pc[15]),
    .B(_040_),
    .Y(\PC4[15] ));
 sky130_fd_sc_hd__and2_2 _097_ (.A(current_pc[16]),
    .B(_041_),
    .X(_042_));
 sky130_fd_sc_hd__xor2_2 _098_ (.A(current_pc[16]),
    .B(_041_),
    .X(\PC4[16] ));
 sky130_fd_sc_hd__and4_2 _099_ (.A(current_pc[14]),
    .B(current_pc[15]),
    .C(current_pc[16]),
    .D(current_pc[17]),
    .X(_043_));
 sky130_fd_sc_hd__and4_2 _100_ (.A(_064_),
    .B(_032_),
    .C(_038_),
    .D(_043_),
    .X(_044_));
 sky130_fd_sc_hd__o21ba_2 _101_ (.A1(current_pc[17]),
    .A2(_042_),
    .B1_N(_044_),
    .X(\PC4[17] ));
 sky130_fd_sc_hd__xor2_2 _102_ (.A(current_pc[18]),
    .B(_044_),
    .X(\PC4[18] ));
 sky130_fd_sc_hd__a21oi_2 _103_ (.A1(current_pc[18]),
    .A2(_044_),
    .B1(current_pc[19]),
    .Y(_045_));
 sky130_fd_sc_hd__and3_2 _104_ (.A(current_pc[18]),
    .B(current_pc[19]),
    .C(_044_),
    .X(_046_));
 sky130_fd_sc_hd__nor2_2 _105_ (.A(_045_),
    .B(_046_),
    .Y(\PC4[19] ));
 sky130_fd_sc_hd__nor2_2 _106_ (.A(current_pc[20]),
    .B(_046_),
    .Y(_047_));
 sky130_fd_sc_hd__and2_2 _107_ (.A(current_pc[20]),
    .B(_046_),
    .X(_048_));
 sky130_fd_sc_hd__nor2_2 _108_ (.A(_047_),
    .B(_048_),
    .Y(\PC4[20] ));
 sky130_fd_sc_hd__and4_2 _109_ (.A(current_pc[18]),
    .B(current_pc[19]),
    .C(current_pc[20]),
    .D(current_pc[21]),
    .X(_049_));
 sky130_fd_sc_hd__and2_2 _110_ (.A(_044_),
    .B(_049_),
    .X(_050_));
 sky130_fd_sc_hd__o21ba_2 _111_ (.A1(current_pc[21]),
    .A2(_048_),
    .B1_N(_050_),
    .X(\PC4[21] ));
 sky130_fd_sc_hd__xor2_2 _112_ (.A(current_pc[22]),
    .B(_050_),
    .X(\PC4[22] ));
 sky130_fd_sc_hd__a21oi_2 _113_ (.A1(current_pc[22]),
    .A2(_050_),
    .B1(current_pc[23]),
    .Y(_051_));
 sky130_fd_sc_hd__and3_2 _114_ (.A(current_pc[22]),
    .B(current_pc[23]),
    .C(_050_),
    .X(_052_));
 sky130_fd_sc_hd__nor2_2 _115_ (.A(_051_),
    .B(_052_),
    .Y(\PC4[23] ));
 sky130_fd_sc_hd__and3_2 _116_ (.A(current_pc[22]),
    .B(current_pc[23]),
    .C(current_pc[24]),
    .X(_053_));
 sky130_fd_sc_hd__o2bb2a_2 _117_ (.A1_N(_050_),
    .A2_N(_053_),
    .B1(_052_),
    .B2(current_pc[24]),
    .X(\PC4[24] ));
 sky130_fd_sc_hd__a21oi_2 _118_ (.A1(_050_),
    .A2(_053_),
    .B1(current_pc[25]),
    .Y(_054_));
 sky130_fd_sc_hd__and4_2 _119_ (.A(current_pc[25]),
    .B(_044_),
    .C(_049_),
    .D(_053_),
    .X(_055_));
 sky130_fd_sc_hd__nor2_2 _120_ (.A(_054_),
    .B(_055_),
    .Y(\PC4[25] ));
 sky130_fd_sc_hd__xor2_2 _121_ (.A(current_pc[26]),
    .B(_055_),
    .X(\PC4[26] ));
 sky130_fd_sc_hd__a21oi_2 _122_ (.A1(current_pc[26]),
    .A2(_055_),
    .B1(current_pc[27]),
    .Y(_056_));
 sky130_fd_sc_hd__and3_2 _123_ (.A(current_pc[26]),
    .B(current_pc[27]),
    .C(_055_),
    .X(_057_));
 sky130_fd_sc_hd__nor2_2 _124_ (.A(_056_),
    .B(_057_),
    .Y(\PC4[27] ));
 sky130_fd_sc_hd__and3_2 _125_ (.A(current_pc[26]),
    .B(current_pc[27]),
    .C(current_pc[28]),
    .X(_058_));
 sky130_fd_sc_hd__xor2_2 _126_ (.A(current_pc[28]),
    .B(_057_),
    .X(\PC4[28] ));
 sky130_fd_sc_hd__a21oi_2 _127_ (.A1(_055_),
    .A2(_058_),
    .B1(current_pc[29]),
    .Y(_059_));
 sky130_fd_sc_hd__and3_2 _128_ (.A(current_pc[29]),
    .B(_055_),
    .C(_058_),
    .X(_060_));
 sky130_fd_sc_hd__nor2_2 _129_ (.A(_059_),
    .B(_060_),
    .Y(\PC4[29] ));
 sky130_fd_sc_hd__and4_2 _130_ (.A(current_pc[29]),
    .B(current_pc[30]),
    .C(_055_),
    .D(_058_),
    .X(_061_));
 sky130_fd_sc_hd__xor2_2 _131_ (.A(current_pc[30]),
    .B(_060_),
    .X(\PC4[30] ));
 sky130_fd_sc_hd__xor2_2 _132_ (.A(current_pc[31]),
    .B(_061_),
    .X(\PC4[31] ));
 sky130_fd_sc_hd__inv_2 _133_ (.A(reset),
    .Y(_001_));
 sky130_fd_sc_hd__inv_2 _134_ (.A(reset),
    .Y(_002_));
 sky130_fd_sc_hd__inv_2 _135_ (.A(reset),
    .Y(_003_));
 sky130_fd_sc_hd__inv_2 _136_ (.A(reset),
    .Y(_004_));
 sky130_fd_sc_hd__inv_2 _137_ (.A(reset),
    .Y(_005_));
 sky130_fd_sc_hd__inv_2 _138_ (.A(reset),
    .Y(_006_));
 sky130_fd_sc_hd__inv_2 _139_ (.A(reset),
    .Y(_007_));
 sky130_fd_sc_hd__inv_2 _140_ (.A(reset),
    .Y(_008_));
 sky130_fd_sc_hd__inv_2 _141_ (.A(reset),
    .Y(_009_));
 sky130_fd_sc_hd__inv_2 _142_ (.A(reset),
    .Y(_010_));
 sky130_fd_sc_hd__inv_2 _143_ (.A(reset),
    .Y(_011_));
 sky130_fd_sc_hd__inv_2 _144_ (.A(reset),
    .Y(_012_));
 sky130_fd_sc_hd__inv_2 _145_ (.A(reset),
    .Y(_013_));
 sky130_fd_sc_hd__inv_2 _146_ (.A(reset),
    .Y(_014_));
 sky130_fd_sc_hd__inv_2 _147_ (.A(reset),
    .Y(_015_));
 sky130_fd_sc_hd__inv_2 _148_ (.A(reset),
    .Y(_016_));
 sky130_fd_sc_hd__inv_2 _149_ (.A(reset),
    .Y(_017_));
 sky130_fd_sc_hd__inv_2 _150_ (.A(reset),
    .Y(_018_));
 sky130_fd_sc_hd__inv_2 _151_ (.A(reset),
    .Y(_019_));
 sky130_fd_sc_hd__inv_2 _152_ (.A(reset),
    .Y(_020_));
 sky130_fd_sc_hd__inv_2 _153_ (.A(reset),
    .Y(_021_));
 sky130_fd_sc_hd__inv_2 _154_ (.A(reset),
    .Y(_022_));
 sky130_fd_sc_hd__inv_2 _155_ (.A(reset),
    .Y(_023_));
 sky130_fd_sc_hd__inv_2 _156_ (.A(reset),
    .Y(_024_));
 sky130_fd_sc_hd__inv_2 _157_ (.A(reset),
    .Y(_025_));
 sky130_fd_sc_hd__inv_2 _158_ (.A(reset),
    .Y(_026_));
 sky130_fd_sc_hd__inv_2 _159_ (.A(reset),
    .Y(_027_));
 sky130_fd_sc_hd__inv_2 _160_ (.A(reset),
    .Y(_028_));
 sky130_fd_sc_hd__inv_2 _161_ (.A(reset),
    .Y(_029_));
 sky130_fd_sc_hd__dfrtp_2 _162_ (.CLK(clk),
    .D(\PC4[2] ),
    .RESET_B(_000_),
    .Q(current_pc[2]));
 sky130_fd_sc_hd__dfrtp_2 _163_ (.CLK(clk),
    .D(\PC4[3] ),
    .RESET_B(_001_),
    .Q(current_pc[3]));
 sky130_fd_sc_hd__dfrtp_2 _164_ (.CLK(clk),
    .D(\PC4[4] ),
    .RESET_B(_002_),
    .Q(current_pc[4]));
 sky130_fd_sc_hd__dfrtp_2 _165_ (.CLK(clk),
    .D(\PC4[5] ),
    .RESET_B(_003_),
    .Q(current_pc[5]));
 sky130_fd_sc_hd__dfrtp_2 _166_ (.CLK(clk),
    .D(\PC4[6] ),
    .RESET_B(_004_),
    .Q(current_pc[6]));
 sky130_fd_sc_hd__dfrtp_2 _167_ (.CLK(clk),
    .D(\PC4[7] ),
    .RESET_B(_005_),
    .Q(current_pc[7]));
 sky130_fd_sc_hd__dfrtp_2 _168_ (.CLK(clk),
    .D(\PC4[8] ),
    .RESET_B(_006_),
    .Q(current_pc[8]));
 sky130_fd_sc_hd__dfrtp_2 _169_ (.CLK(clk),
    .D(\PC4[9] ),
    .RESET_B(_007_),
    .Q(current_pc[9]));
 sky130_fd_sc_hd__dfrtp_2 _170_ (.CLK(clk),
    .D(\PC4[10] ),
    .RESET_B(_008_),
    .Q(current_pc[10]));
 sky130_fd_sc_hd__dfrtp_2 _171_ (.CLK(clk),
    .D(\PC4[11] ),
    .RESET_B(_009_),
    .Q(current_pc[11]));
 sky130_fd_sc_hd__dfrtp_2 _172_ (.CLK(clk),
    .D(\PC4[12] ),
    .RESET_B(_010_),
    .Q(current_pc[12]));
 sky130_fd_sc_hd__dfrtp_2 _173_ (.CLK(clk),
    .D(\PC4[13] ),
    .RESET_B(_011_),
    .Q(current_pc[13]));
 sky130_fd_sc_hd__dfrtp_2 _174_ (.CLK(clk),
    .D(\PC4[14] ),
    .RESET_B(_012_),
    .Q(current_pc[14]));
 sky130_fd_sc_hd__dfrtp_2 _175_ (.CLK(clk),
    .D(\PC4[15] ),
    .RESET_B(_013_),
    .Q(current_pc[15]));
 sky130_fd_sc_hd__dfrtp_2 _176_ (.CLK(clk),
    .D(\PC4[16] ),
    .RESET_B(_014_),
    .Q(current_pc[16]));
 sky130_fd_sc_hd__dfrtp_2 _177_ (.CLK(clk),
    .D(\PC4[17] ),
    .RESET_B(_015_),
    .Q(current_pc[17]));
 sky130_fd_sc_hd__dfrtp_2 _178_ (.CLK(clk),
    .D(\PC4[18] ),
    .RESET_B(_016_),
    .Q(current_pc[18]));
 sky130_fd_sc_hd__dfrtp_2 _179_ (.CLK(clk),
    .D(\PC4[19] ),
    .RESET_B(_017_),
    .Q(current_pc[19]));
 sky130_fd_sc_hd__dfrtp_2 _180_ (.CLK(clk),
    .D(\PC4[20] ),
    .RESET_B(_018_),
    .Q(current_pc[20]));
 sky130_fd_sc_hd__dfrtp_2 _181_ (.CLK(clk),
    .D(\PC4[21] ),
    .RESET_B(_019_),
    .Q(current_pc[21]));
 sky130_fd_sc_hd__dfrtp_2 _182_ (.CLK(clk),
    .D(\PC4[22] ),
    .RESET_B(_020_),
    .Q(current_pc[22]));
 sky130_fd_sc_hd__dfrtp_2 _183_ (.CLK(clk),
    .D(\PC4[23] ),
    .RESET_B(_021_),
    .Q(current_pc[23]));
 sky130_fd_sc_hd__dfrtp_2 _184_ (.CLK(clk),
    .D(\PC4[24] ),
    .RESET_B(_022_),
    .Q(current_pc[24]));
 sky130_fd_sc_hd__dfrtp_2 _185_ (.CLK(clk),
    .D(\PC4[25] ),
    .RESET_B(_023_),
    .Q(current_pc[25]));
 sky130_fd_sc_hd__dfrtp_2 _186_ (.CLK(clk),
    .D(\PC4[26] ),
    .RESET_B(_024_),
    .Q(current_pc[26]));
 sky130_fd_sc_hd__dfrtp_2 _187_ (.CLK(clk),
    .D(\PC4[27] ),
    .RESET_B(_025_),
    .Q(current_pc[27]));
 sky130_fd_sc_hd__dfrtp_2 _188_ (.CLK(clk),
    .D(\PC4[28] ),
    .RESET_B(_026_),
    .Q(current_pc[28]));
 sky130_fd_sc_hd__dfrtp_2 _189_ (.CLK(clk),
    .D(\PC4[29] ),
    .RESET_B(_027_),
    .Q(current_pc[29]));
 sky130_fd_sc_hd__dfrtp_2 _190_ (.CLK(clk),
    .D(\PC4[30] ),
    .RESET_B(_028_),
    .Q(current_pc[30]));
 sky130_fd_sc_hd__dfrtp_2 _191_ (.CLK(clk),
    .D(\PC4[31] ),
    .RESET_B(_029_),
    .Q(current_pc[31]));
 sky130_fd_sc_hd__conb_1 _192_ (.LO(current_pc[0]));
 sky130_fd_sc_hd__conb_1 _193_ (.LO(current_pc[1]));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_83 ();
endmodule
