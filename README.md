# Efficiency-Analysis-Of-Fractal-Generation
Generated Mandelbrot sets in real time and produce the fractal images and investigated ways for improving the running time and speedup of the program using CUDA. 

**Mandelbrot Set**
The Mandelbrot set is the set of complex numbers c for which the function fc(z) = z2 + c does not diverge when iterated from z = 0 , i.e for which the function fc(0),fc(fc(0)) etc. remain bounded in absolute value.

**How it works**
To determine whether a value is in or out of the Mandelbrot Set , we loop through the formula Zn+1 = Z2n + C a certain number of times , these iteration number determines the color of the pixel whether it is black or white. 
The above equation basically translates to this lim<sub>n</sub>->∞Zn ≤2
