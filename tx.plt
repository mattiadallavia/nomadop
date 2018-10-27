# set terminal pdf size 5in,1.5in font 'Times,16'

unset key
unset tics
unset border

set style textbox opaque noborder margins 4,4

set xrange [-5.2:-0.8]
set yrange [-1:1]

set label 1 '' at -1,0 point pt 3
set label 2 '' at -3,0 point pt 3
set label 3 '' at -5,0 point pt 3

set label 4 '{/:Italic p - 1}' at -1,0.8 center
set label 5 '{/:Italic p}' at -3,0.8 center
set label 6 '{/:Italic p + 1}' at -5,0.8 center

set object 1 circle at 2,0 size 4 dt 2 fc rgb 'black'
set object 2 circle at 0,0 size 4 dt 2 fc rgb 'black'

set arrow 1 from -2.8,0 to -1.2,0
set arrow 2 from -3.2,0 to -4.8,0

set label 7 '{/:Italic dati}' at -2,0 center boxed front
set label 8 '{/:Italic ack}' at -4,0 center boxed front

plot NaN