#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

extern "C" {
  #include "bmp.h"
}

__global__ void render(char *img, int width, int height) {
  unsigned int x_dim = blockIdx.x*blockDim.x + threadIdx.x;
  unsigned int y_dim = blockIdx.y*blockDim.y + threadIdx.y;
  int index = 3*width*y_dim + x_dim*3;
  float x_origin = ((float) x_dim/width)*3.25 - 2;
  float y_origin = ((float) y_dim/width)*2.5 - 1.25;

  float x = 0.0;
  float y = 0.0;

  int iteration = 0;
  int max_iteration = 256;
  while(x*x + y*y <= 4 && iteration < max_iteration) {
    float xtemp = x*x - y*y + x_origin;
    y = 2*x*y + y_origin;
    x = xtemp;
    iteration++;
  }

  if(iteration == max_iteration) {
    img[index] = 0;
    img[index + 1] = 0;
    img[index + 2] = 0;
  } else {
    img[index] = iteration;
    img[index + 1] = iteration;
    img[index + 2] = iteration;
  }
}

void runCUDA(int width, int height)
{
  size_t buffer_size = sizeof(char) * width * height * 3;

	char *image;
  cudaMalloc((void **) &image, buffer_size);

  char *host_image = (char *) malloc(buffer_size);

  dim3 blockDim(16, 16, 1);
  dim3 gridDim(width / blockDim.x, height / blockDim.y, 1);
  render<<< gridDim, blockDim, 0 >>>(image, width, height);

  cudaMemcpy(host_image, image, buffer_size, cudaMemcpyDeviceToHost);

  write_bmp("output.bmp", width, height, host_image);

  cudaFree(image);
  free(host_image);
}

int main(int argc, const char * argv[]) {
  runCUDA(1024, 1024);
  return 0;
}
