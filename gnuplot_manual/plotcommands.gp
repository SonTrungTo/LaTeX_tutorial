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
set key at 15,-10
plot x with lines, "eg3.dat" with linespoints
set output

#Figure 4
set terminal latex
set output "eg4.tex"
set format y "$%g$"
set format x "$%.2f$"
set title 'This is $\sin(x)$'
set xlabel "$x$"
set ylabel "$\\sin(x)$" #Escape twice in a double quote.
unset key
set xtics -pi,pi/4
plot [-pi:pi][-1:1] sin(x)
set output

#Figure 5, basically the same as Figure 4, except for the
#set xtics command line
set terminal latex
set output "eg5.tex"
set format y "$%g$"
set format x "$%.2f$"
set title 'This is $\sin(x)$'
set xlabel "$x$"
set ylabel "$\\sin(x)$" #Escape twice in a double quote.
unset key
#This begins the change
set xtics ('$-\pi$' -pi,\
'$-\frac{\pi}{2}$' -pi/2, \
"0" 0,\
'$\frac{\pi}{2}$' pi/2, \
'$\pi$' pi)
#End of change
plot [-pi:pi][-1:1] sin(x)
set output

# A reference for all line and point types in LaTeX terminal
set terminal latex
set output 'test.tex'
test
set output
