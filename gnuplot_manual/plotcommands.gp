#Figure 1
set terminal latex
set output "eg1.tex"
plot [-3.14:3.14] cos(x)
set output

#Figure 2
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

#Figure 3
set terminal latex
set output "eg3.tex"
set format xy "$%g$"
set title "This is another plot"
set xlabel "$x$"
set ylabel "$y$"
set key at 5,10
plot x with linespoints, x+1 with points
