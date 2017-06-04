set terminal latex
set output 'example2-gnuplottex-fig2.tex'
    set grid
    set title 'gnuplottex test $e^x$'
    set ylabel '$y$'
    set xlabel '$x$'
    plot exp(x) with linespoints
