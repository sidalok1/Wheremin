# File saved with Nlview 7.7.1 2023-07-26 3bc4126617 VDI=43 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new basys3 work:basys3:NOFILE -nosplit
load symbol clocks work:clocks:NOFILE HIERBOX pin clk input.left pin clk_100hz output.right pin clk_1Mhz output.right pin freq output.right pinBus tuning_word input.left [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol display work:display:NOFILE HIERBOX pin din_valid input.left pin disp_clk input.left pinBus anodes output.right [3:0] pinBus din input.left [7:0] pinBus segment output.right [6:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_INV0 work INV pin I0 input pin O output fillcolor 1
load symbol HCSR04 work:HCSR04:NOFILE HIERBOX pin clk input.left pin echo input.left pin trig output.right pinBus dout output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Sine_Generator work:Sine_Generator:NOFILE HIERBOX pin freq input.left pinBus sine output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load port JB1 output -pg 1 -lvl 3 -x 610 -y 220
load port JB2 input -pg 1 -lvl 0 -x 0 -y 220
load port JB3 output -pg 1 -lvl 3 -x 610 -y 40
load port clk input -pg 1 -lvl 0 -x 0 -y 60
load portBus JC output [7:0] -attr @name JC[7:0] -pg 1 -lvl 3 -x 610 -y 100
load portBus an output [3:0] -attr @name an[3:0] -pg 1 -lvl 3 -x 610 -y 310
load portBus seg output [6:0] -attr @name seg[6:0] -pg 1 -lvl 3 -x 610 -y 330
load inst clk_Module clocks work:clocks:NOFILE -autohide -attr @cell(#000000) clocks -pinBusAttr tuning_word @name tuning_word[7:0] -pg 1 -lvl 1 -x 150 -y 50
load inst disp_Module display work:display:NOFILE -autohide -attr @cell(#000000) display -pinBusAttr anodes @name anodes[3:0] -pinBusAttr din @name din[7:0] -pinBusAttr segment @name segment[6:0] -pg 1 -lvl 2 -x 420 -y 300
load inst echo_valid_i RTL_INV0 work -attr @cell(#000000) RTL_INV -pg 1 -lvl 1 -x 150 -y 330
load inst ultrasonic_sensor_Module HCSR04 work:HCSR04:NOFILE -autohide -attr @cell(#000000) HCSR04 -pinBusAttr dout @name dout[7:0] -pg 1 -lvl 2 -x 420 -y 190
load inst virtual_oscillator Sine_Generator work:Sine_Generator:NOFILE -autohide -attr @cell(#000000) Sine_Generator -pinBusAttr sine @name sine[7:0] -pg 1 -lvl 2 -x 420 -y 90
load net JB1 -port JB1 -pin ultrasonic_sensor_Module trig
netloc JB1 1 2 1 NJ 220
load net JB2 -port JB2 -pin echo_valid_i I0 -pin ultrasonic_sensor_Module echo
netloc JB2 1 0 2 20 220 NJ
load net JB3 -port JB3 -pin clk_Module clk_100hz -pin disp_Module disp_clk
netloc JB3 1 1 2 340 40 NJ
load net JC[0] -attr @rip sine[0] -port JC[0] -pin virtual_oscillator sine[0]
load net JC[1] -attr @rip sine[1] -port JC[1] -pin virtual_oscillator sine[1]
load net JC[2] -attr @rip sine[2] -port JC[2] -pin virtual_oscillator sine[2]
load net JC[3] -attr @rip sine[3] -port JC[3] -pin virtual_oscillator sine[3]
load net JC[4] -attr @rip sine[4] -port JC[4] -pin virtual_oscillator sine[4]
load net JC[5] -attr @rip sine[5] -port JC[5] -pin virtual_oscillator sine[5]
load net JC[6] -attr @rip sine[6] -port JC[6] -pin virtual_oscillator sine[6]
load net JC[7] -attr @rip sine[7] -port JC[7] -pin virtual_oscillator sine[7]
load net an[0] -attr @rip anodes[0] -port an[0] -pin disp_Module anodes[0]
load net an[1] -attr @rip anodes[1] -port an[1] -pin disp_Module anodes[1]
load net an[2] -attr @rip anodes[2] -port an[2] -pin disp_Module anodes[2]
load net an[3] -attr @rip anodes[3] -port an[3] -pin disp_Module anodes[3]
load net clk -port clk -pin clk_Module clk
netloc clk 1 0 1 NJ 60
load net clk_bus_0 -pin clk_Module clk_1Mhz -pin ultrasonic_sensor_Module clk
netloc clk_bus_0 1 1 1 300 60n
load net distance[0] -attr @rip dout[0] -pin clk_Module tuning_word[0] -pin disp_Module din[0] -pin ultrasonic_sensor_Module dout[0]
load net distance[1] -attr @rip dout[1] -pin clk_Module tuning_word[1] -pin disp_Module din[1] -pin ultrasonic_sensor_Module dout[1]
load net distance[2] -attr @rip dout[2] -pin clk_Module tuning_word[2] -pin disp_Module din[2] -pin ultrasonic_sensor_Module dout[2]
load net distance[3] -attr @rip dout[3] -pin clk_Module tuning_word[3] -pin disp_Module din[3] -pin ultrasonic_sensor_Module dout[3]
load net distance[4] -attr @rip dout[4] -pin clk_Module tuning_word[4] -pin disp_Module din[4] -pin ultrasonic_sensor_Module dout[4]
load net distance[5] -attr @rip dout[5] -pin clk_Module tuning_word[5] -pin disp_Module din[5] -pin ultrasonic_sensor_Module dout[5]
load net distance[6] -attr @rip dout[6] -pin clk_Module tuning_word[6] -pin disp_Module din[6] -pin ultrasonic_sensor_Module dout[6]
load net distance[7] -attr @rip dout[7] -pin clk_Module tuning_word[7] -pin disp_Module din[7] -pin ultrasonic_sensor_Module dout[7]
load net echo_valid -pin disp_Module din_valid -pin echo_valid_i O
netloc echo_valid 1 1 1 NJ 330
load net freq -pin clk_Module freq -pin virtual_oscillator freq
netloc freq 1 1 1 NJ 100
load net seg[0] -attr @rip segment[0] -pin disp_Module segment[0] -port seg[0]
load net seg[1] -attr @rip segment[1] -pin disp_Module segment[1] -port seg[1]
load net seg[2] -attr @rip segment[2] -pin disp_Module segment[2] -port seg[2]
load net seg[3] -attr @rip segment[3] -pin disp_Module segment[3] -port seg[3]
load net seg[4] -attr @rip segment[4] -pin disp_Module segment[4] -port seg[4]
load net seg[5] -attr @rip segment[5] -pin disp_Module segment[5] -port seg[5]
load net seg[6] -attr @rip segment[6] -pin disp_Module segment[6] -port seg[6]
load netBundle @JC 8 JC[7] JC[6] JC[5] JC[4] JC[3] JC[2] JC[1] JC[0] -autobundled
netbloc @JC 1 2 1 NJ 100
load netBundle @an 4 an[3] an[2] an[1] an[0] -autobundled
netbloc @an 1 2 1 NJ 310
load netBundle @seg 7 seg[6] seg[5] seg[4] seg[3] seg[2] seg[1] seg[0] -autobundled
netbloc @seg 1 2 1 NJ 330
load netBundle @distance 8 distance[7] distance[6] distance[5] distance[4] distance[3] distance[2] distance[1] distance[0] -autobundled
netbloc @distance 1 0 3 20 140 320 140 590
levelinfo -pg 1 0 150 420 610
pagesize -pg 1 -db -bbox -sgen -80 0 710 390
show
fullfit
#
# initialize ictrl to current module basys3 work:basys3:NOFILE
ictrl init topinfo |
