set terminal latex rotate
set output 'picture1-gnuplottex-fig1.tex'
            set key box top left
            set key width 4
            set sample 1000
            set xr [-5:5]
            set yr [-1:1]
            set xlabel '$x$'
            set ylabel '$y$'
            plot sin(x) w l lc 1 t '$\sin(x)$',\
            cos(x) w l lc 2 t '$\cos(x)$',\
            tan(x) w l lc 3 t '$\tan(x)$',\
            tanh(x) w l lc 4 t '$\tanh(x)$'
        
