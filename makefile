CC = g++

# Set up the path to the CQMesh header files
INC1 = ./src/common
INC2 = ./src/hedge
INC3 = ./src/bmesh
INC4 = ./src/interface
INC5 = ./src/quad

# Set up the path to the BOOST header files (these files are used by CGAL)
INC6 = /usr/local/include

INC_FLAGS = -I$(INC1) -I$(INC2) -I$(INC3) -I$(INC4) -I$(INC5) -I$(INC6)

# Set up the compiler options ('pedantic' and 'ansi' has been removed
# due to compiler problems with the 3.5.1 CGAL version)
CFLAGS = -g -c -Wall -frounding-math

# Set up the path to the CGAL header and library files
CGAL_INCLUDE = -I/usr/local/include
CGAL_LIB     = -L/usr/local/lib

# Set up the path to the GMP header and library files
GMP_INCLUDE = -I/usr/local/include
GMP_LIB     = -I/usr/local/lib

# Set up the path to the BOOST and CGAL library files
LIB_FLAGS = -L/usr/local/lib $(CGAL_LIB)

# Set up the lib options
LDFLAGS = -g 

LIBS = -lCGAL -lgmp -lgmpxx -lm

OBJ = vertex2.o halfedge2.o edge2.o face2.o boundary2.o bbox2.o complex2.o \
      dualgraph.o regiongraph.o sptree.o edgekey.o polygon2.o tri2.o quad2.o \
      iomesh2.o mesh2.o compquad.o gencontrol.o cqm.o

cqm: $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) -o cqm $(LIB_FLAGS) $(LIBS);
	mv cqm ./bin/cqm

vertex2.o: $(INC1)/typedefs.h $(INC2)/vertex2attrib.h \
           $(INC2)/vertex2.h $(INC2)/vertex2.cc
	$(CC) $(CFLAGS) $(INC2)/vertex2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

halfedge2.o: $(INC2)/vertex2.h \
             $(INC2)/halfedge2.h $(INC2)/halfedge2.cc
	$(CC) $(CFLAGS) $(INC2)/halfedge2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

edge2.o: $(INC2)/vertex2.h $(INC2)/halfedge2.h $(INC2)/edge2attrib.h \
	 $(INC2)/edge2.h $(INC2)/edge2.cc
	$(CC) $(CFLAGS) $(INC2)/edge2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

face2.o: $(INC2)/halfedge2.h $(INC2)/edge2.h $(INC2)/face2attrib.h \
	 $(INC2)/face2.h $(INC2)/face2.cc
	$(CC) $(CFLAGS) $(INC2)/face2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

boundary2.o: $(INC2)/edge2.h $(INC2)/face2.h \
             $(INC2)/boundary2.h $(INC2)/boundary2.cc
	$(CC) $(CFLAGS) $(INC2)/boundary2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

bbox2.o: $(INC1)/typedefs.h $(INC1)/bbox2.h $(INC1)/bbox2.cc
	$(CC) $(CFLAGS) $(INC1)/bbox2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

complex2.o: $(INC1)/typedefs.h $(INC1)/bbox2.h $(INC2)/vertex2.h $(INC2)/halfedge2.h \
	    $(INC2)/edge2.h $(INC2)/face2.h $(INC2)/boundary2.h $(INC2)/dualgraph.h \
            $(INC2)/complex2.h $(INC2)/complex2.cc
	$(CC) $(CFLAGS) $(INC2)/complex2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

dualgraph.o: $(INC1)/typedefs.h  $(INC2)/edge2.h  $(INC2)/face2.h $(INC2)/dgvattrib.h \
             $(INC2)/dualgraph.h $(INC2)/dualgraph.cc
	$(CC) $(CFLAGS) $(INC2)/dualgraph.cc $(INC_FLAGS) $(CGAL_INCLUDE)

regiongraph.o: $(INC1)/typedefs.h $(INC2)/dgvattrib.h $(INC2)/dualgraph.h \
             $(INC2)/halfedge2.h $(INC2)/edge2.h $(INC2)/face2.h \
             $(INC5)/regiongraph.h $(INC5)/regiongraph.cc
	$(CC) $(CFLAGS) $(INC5)/regiongraph.cc $(INC_FLAGS) $(CGAL_INCLUDE)

sptree.o: $(INC1)/typedefs.h $(INC3)/polygon2.h $(INC2)/halfedge2.h $(INC2)/dualgraph.h \
	  $(INC5)/sptree.h $(INC5)/sptree.cc
	$(CC) $(CFLAGS) $(INC5)/sptree.cc $(INC_FLAGS) $(CGAL_INCLUDE)

edgekey.o: $(INC3)/edgekey.h $(INC3)/edgekey.cc
	$(CC) $(CFLAGS) $(INC3)/edgekey.cc $(INC_FLAGS)

polygon2.o: $(INC1)/typedefs.h $(INC1)/err.h \
            $(INC3)/polygon2.h $(INC3)/polygon2.cc
	$(CC) $(CFLAGS) $(INC3)/polygon2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

tri2.o: $(INC1)/typedefs.h $(INC3)/polygon2.h \
        $(INC3)/tri2.h $(INC3)/tri2.cc
	$(CC) $(CFLAGS) $(INC3)/tri2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

quad2.o: $(INC1)/typedefs.h $(INC3)/polygon2.h \
         $(INC3)/quad2.h $(INC3)/quad2.cc
	$(CC) $(CFLAGS) $(INC3)/quad2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

iomesh2.o: $(INC1)/typedefs.h $(INC1)/err.h $(INC3)/edgekey.h $(INC3)/tri2.h \
           $(INC3)/quad2.h \
           $(INC3)/iomesh2.h $(INC3)/iomesh2.cc
	$(CC) $(CFLAGS) $(INC3)/iomesh2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

mesh2.o: $(INC1)/typedefs.h $(INC1)/err.h $(INC3)/edgekey.h $(INC3)/tri2.h \
         $(INC3)/iomesh2.h $(INC2)/vertex2.h $(INC2)/halfedge2.h $(INC2)/edge2.h \
         $(INC2)/face2.h $(INC2)/boundary2.h $(INC2)/complex2.h \
	 $(INC3)/mesh2.h $(INC3)/mesh2.cc
	$(CC) $(CFLAGS) $(INC3)/mesh2.cc $(INC_FLAGS) $(CGAL_INCLUDE)

compquad.o: $(INC1)/typedefs.h $(INC1)/err.h $(INC2)/vertex2.h $(INC2)/halfedge2.h \
            $(INC2)/edge2.h $(INC2)/face2.h $(INC2)/complex2.h $(INC5)/regiongraph.h \
            $(INC5)/sptree.h $(INC3)/polygon2.h $(INC3)/quad2.h \
            $(INC5)/compquad.h $(INC5)/compquad.cc
	$(CC) $(CFLAGS) $(INC5)/compquad.cc $(INC_FLAGS) $(CGAL_INCLUDE) $(GMP_INCLUDE)

gencontrol.o: $(INC1)/typedefs.h $(INC1)/err.h $(INC3)/edgekey.h $(INC2)/vertex2.h \
              $(INC2)/halfedge2.h $(INC2)/edge2.h $(INC2)/complex2.h $(INC3)/mesh2.h \
              $(INC3)/tri2.h $(INC3)/quad2.h $(INC5)/compquad.h $(INC3)/iomesh2.h \
	      $(INC5)/gencontrol.h $(INC5)/gencontrol.cc
	$(CC) $(CFLAGS) $(INC5)/gencontrol.cc $(INC_FLAGS) $(CGAL_INCLUDE)

cqm.o: $(INC1)/err.h $(INC5)/gencontrol.h \
       $(INC4)/cqm.h $(INC4)/cqm.cc 
	$(CC) $(CFLAGS) $(INC4)/cqm.cc $(INC_FLAGS) $(CGAL_INCLUDE)

clean:
	rm *.o *~
