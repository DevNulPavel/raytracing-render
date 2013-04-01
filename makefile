clean:
	rm -f *.o

color.o: color.c color.h
	gcc -c color.c -I. -o color.o

canvas.o: canvas.c canvas.h color.h
	gcc -c canvas.c -I. -o canvas.o

geometry3d.o: geometry3d.c geometry3d.h color.h
	gcc -c geometry3d.c -I. -o geometry3d.o

test: test.c color.o geometry3d.o
	gcc test.c color.o geometry3d.o -I. -o test
