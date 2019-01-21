# Efficiency-Analysis-Of-Fractal-Generation
Generated Mandelbrot sets in real time and produce the fractal images and investigated ways for improving the running time and speedup of the program using CUDA. 

**Mandelbrot Set**<br />
The Mandelbrot set is the set of complex numbers c for which the function fc(z) = z<sup>2</sup> + c does not diverge when iterated from z = 0 , i.e for which the function f<sub>c</sub>(0),f<sub>c</sub>(f<sub>c</sub>(0)) etc. remain bounded in absolute value.

**How it works**<br />
To determine whether a value is in or out of the Mandelbrot Set , we loop through the formula Z<sub>n</sub>+1 = Z<sup>2</sup>n + C a certain number of times , these iteration number determines the color of the pixel whether it is black or white.<br /> 
The above equation basically translates to this lim<sub>n->∞</sub>Z<sub>n</sub> ≤2

**Work Flow** <br />
 Assign space for the image and load it into the GPU.<br />  Launch Kernel.<br/>  Assign a grid and block size so that the image is divided across the CUDA cores.<br />  Copy the image back to the host.<br />  Write it into a bmp image<br />

**Challenges in using CUDA**
 The challenge in CUDA programming is choosing the right grid and block size.<br />  A block with many threads will run faster than many blocks with one thread.<br />  This is because of the bottleneck of how many warps can be executed concurrently.<br />  So for best results it is better to use the no of threads per block a multiple of 32.<br />
