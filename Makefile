CC 			= gcc
CFLAGS 		= -Wall -g -std=gnu11
LFLAGS 		= -lX11 -lgomp -lm
XFLAG 		= -D SHOW_X
BFLAG 		= -D BENCHMARK
NVCC 		= nvcc
CUDA_FLAGS 	= -gencode=arch=compute_75,code=sm_75 -g

all : mandelbrot XBenchmark benchmark fractal fractalmp mandelbrot_shapeschecking benchmark_shapeschecking 

mandelbrot : mandelbrot.cu
	$(NVCC) $(CUDA_FLAGS) $(XFLAG) mandelbrot.cu -o mandelbrot $(LFLAGS)

benchmark : mandelbrot.cu
	$(NVCC) $(CUDA_FLAGS) $(BFLAG) mandelbrot.cu -o benchmark $(LFLAGS)

XBenchmark : mandelbrot.cu
	$(NVCC) $(CUDA_FLAGS) $(BFLAG) $(XFLAG) mandelbrot.cu -o XBenchmark $(LFLAGS)

mandelbrot_shapeschecking : mandelbrot_shapeschecking.cu
	$(NVCC) $(CUDA_FLAGS) $(XFLAG) mandelbrot_shapeschecking.cu -o mandelbrot_shapeschecking $(LFLAGS)

benchmark_shapeschecking : mandelbrot_shapeschecking.cu
	$(NVCC) $(CUDA_FLAGS) $(BFLAG) mandelbrot_shapeschecking.cu -o benchmark_shapeschecking $(LFLAGS)

fractal: fractal.c gfx.c
	gcc fractal.c gfx.c -g -Wall --std=c99 -lX11 -lm -lgomp -o fractal

fractalmp: fractal_mp.c gfx.c
	gcc fractal_mp.c gfx.c -g -Wall --std=c99 -lX11 -lm -lgomp -fopenmp -o fractalmp

clean :
	rm -rf *.o mandelbrot XBenchmark benchmark fractal fractalmp mandelbrot_shapeschecking benchmark_shapeschecking		
