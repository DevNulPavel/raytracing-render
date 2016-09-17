# CC = gcc
CC = clang

LIBPATH	 = -L../render/lib 
INCLUDES = -I../render/include
LIBS = -lrender -lm -lpng

render = ../render/lib/librender.a

CC_OPTS	 = -Wall
CC_OPTS += -std=gnu89 -O2

USE_OPEN_MP = 1

ifeq ($(shell uname), Darwin)
  OPEN_GL_OPTS = -framework GLUT -framework OpenGL -DDARWIN
  # for libpng
  LIBPATH += -L/usr/X11/lib
  LIBPATH += -L/usr/local/lib
  INCLUDES += -I/usr/X11/include
  INCLUDES += -I/usr/local/include
else
  OPEN_GL_OPTS = -lGL -lglut -DPOSIX
endif

# OpenMP enable/disable
ifeq ($(USE_OPEN_MP),1)
	CC = gcc-5
	DEF += -DWITH_OPENMP=1
	OPEN_MP_FLAG = -fopenmp
else
	OPEN_MP_FLAG = ""
endif

THREADS_NUM = 4

run_demo_gl: demo_gl
	./$< $(THREADS_NUM)

demo_gl: $(render) scene.o scene.h demo_gl.c
	$(CC) $(CC_OPTS) $(OPEN_MP_FLAG) demo_gl.c scene.o $(OPEN_GL_OPTS) $(LIBPATH) $(INCLUDES) $(LIBS) -o $@

scene.o: scene.c
	$(CC) $(INCLUDES) $(CC_OPTS) -c $< -o $@

$(render):
	(cd ../render && make DEF="$(DEF)" render)

.PHONY: clean
clean:
	(cd ../render && make clean) && \
	rm -f *.o;                  	  \
	rm -f ./demo_gl;		 
