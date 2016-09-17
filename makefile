LIBPATH	 = -Lrender/lib
INCLUDES = -Irender/include
LIBS = -lrender -lm -lpng

USE_OPEN_MP = 0

# CC = gcc
# CC_OPTS	 = -std=gnu89 -Wall -O2
CC = clang
CC_OPTS	= -std=gnu89 -Wall -O2

ifeq ($(shell uname), Darwin)
  # for libpng
  LIBPATH += -L/usr/X11/lib
  LIBPATH += -L/usr/local/lib
  INCLUDES += -I/usr/X11/include
  INCLUDES += -I/usr/local/include
endif

# OpenMP enable/disable
ifeq ($(USE_OPEN_MP),1)
	DEF = "$(DEF) -DWITH_OPENMP=1"
	OPEN_MP_FLAG = "-fopenmp"
else
	OPEN_MP_FLAG = ""
endif

render = render/lib/librender.a

####################################################

benchmark: $(render) benchmark.c
	$(CC) $(CC_OPTS) $(OPEN_MP_FLAG) benchmark.c $(LIBPATH) $(INCLUDES) $(LIBS) -o $@	

example: $(render) example.c
	$(CC) $(CC_OPTS) $(OPEN_MP_FLAG) example.c $(LIBPATH) $(INCLUDES) $(LIBS) -o $@

run_demo_gl: $(render)
	(cd demo && make DEF="$(DEF)" run_demo_gl)

$(render):
	(cd render && make DEF="$(DEF)" render)

.PHONY: clean
clean:
	(cd render && make clean) && \
	(cd demo && make clean)   && \
	rm -f ./example ./benchmark;		\
	rm -f *.png		
