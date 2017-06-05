set terminal latex
set output "eg1.tex"
plot [-3.14:3.14] cos(x)
set output

set terminal latex
set output "eg2.tex"
set size 5/5., 4/3.
set format xy "$%g$"
set title "This is an embellished plot"
set xlabel 'This is the $x$ axis'
set ylabel 'This is\\ the\\ $y$ axis'
set key at 4,0.8
plot [0:6.28] [0:1] sin(x), cos(x) with linespoints
set output
