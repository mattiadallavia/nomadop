# ./routst 2 2 1 20 100 10 1000 1000 --w "20 20 1" --b "50 50 1" --r "6 6 1" --s 1 --c > d2.dat
# ./st 2 --a 7 --m --st < d2.dat > d2_tf.aggr.dat
# ./st 2 --a 8 --m --st < d2.dat > d2_tx.aggr.dat
# ./st 2 --a 9 --m --st < d2.dat > d2_retx.aggr.dat
# ./st 2 --a 11 --m --st < d2.dat > d2_coll.aggr.dat
# set terminal pdf size 12cm,10.5cm font 'Times,14'

d = 2

r(x) = m*x+q
fit r(x) 'd2_tx.aggr.dat' via m,q
print sprintf('r(x) = %f * x + %f', m,q)

unset key
set ylabel offset 1.5,0
set link x2 via x/(d**2) inverse x*(d**2)

set multiplot layout 2,2

# tf
set lmargin 10
set bmargin 0.5
set xtics format ''
set x2tics format '%.0f'
set x2label 'q' offset 0,-0.2
set yrange [0:1400]
set ylabel 'tf (±3{/Symbol s})'

plot 'd2_tf.aggr.dat' with lines lc 'black', \
     'd2_tf.aggr.dat' using 1:($2+3*$3) with lines lc 'black' dt 3

# tx
set lmargin 7
set yrange [0:500]
set ylabel 'tx  (±3{/Symbol s})'

plot 'd2_tx.aggr.dat' with lines lc 'black', \
     'd2_tx.aggr.dat' using 1:($2+3*$3) with lines lc 'black' dt 3, \
     'd2_tx.aggr.dat' using 1:($2-3*$3) with lines lc 'black' dt 3

# coll
set lmargin 10
set bmargin 3
set x2tics format ''
set xtics format '%.0f' rotate
unset x2label
set xlabel 'n' offset 0,0.5
set yrange [0:80]
set ylabel 'coll.  (±3{/Symbol s})'

plot 'd2_coll.aggr.dat' with lines lc 'black', \
     'd2_coll.aggr.dat' using 1:($2+3*$3) with lines lc 'black' dt 3

# retx
set lmargin 7
set yrange [0:50]
set ylabel 'retx  (±3{/Symbol s})'

plot 'd2_retx.aggr.dat' with lines lc 'black', \
     'd2_retx.aggr.dat' using 1:($2+3*$3) with lines lc 'black' dt 3, \
     'd2_retx.aggr.dat' using 1:($2-3*$3) with lines lc 'black' dt 3

unset xlabel
unset multiplot