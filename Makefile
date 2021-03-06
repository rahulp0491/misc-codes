EXEC_NAME = run.out
CC = g++
DEBUG = -g
OBJECT = -o
CFLAGS = -c $(DEBUG)
LFLAGS = $(DEBUG)

ALGOS_DIR = algos
NT_DIR = $(ALGOS_DIR)/number-theory
SM_DIR = $(ALGOS_DIR)/string-matching
GT_DIR = $(ALGOS_DIR)/graph

NT_OBJS = $(NT_DIR)/nt_common.o
SM_OBJS = $(SM_DIR)/string_matcher.o
GT_OBJS = $(GT_DIR)/traversal.o
GT_APP_OBJS = $(GT_DIR)/applications.o
GT_COMMON_OBJS = $(GT_DIR)/graph_common.o

OBJS = $(NT_OBJS) $(SM_OBJS) $(GT_OBJS) $(GT_APP_OBJS) $(GT_COMMON_OBJS)

NT_DEPS = $(NT_DIR)/nt_common.cpp $(NT_DIR)/nt_common.h
SM_DEPS = $(SM_DIR)/string_matcher.cpp $(SM_DIR)/sm_common.h $(NT_DIR)/nt_common.h
GT_COMMON_DEPS = $(GT_DIR)/graph_common.cpp $(GT_DIR)/graph_common.h
GT_DEPS = $(GT_DIR)/traversal.cpp $(GT_COMMON_DEPS)
GT_APP_DEPS = $(GT_DIR)/applications.cpp $(GT_COMMON_DEPS)

NT_MAIN = $(NT_DIR)/nt_common.cpp
SM_MAIN = $(SM_DIR)/string_matcher.cpp
GT_MAIN = $(GT_DIR)/traversal.cpp
GT_APP_MAIN = $(GT_DIR)/applications.cpp
GT_COMMON_MAIN = $(GT_DIR)/graph_common.cpp

STRING_MATCHER = string_matcher
GRAPH_TRAVERSAL = graph_traversal
GRAPH_APP = graph_app

$(STRING_MATCHER) : $(SM_OBJS) $(NT_OBJS)
	$(CC) $(LFLAGS) $(SM_OBJS) $(NT_OBJS) $(OBJECT) $(EXEC_NAME)

$(GRAPH_TRAVERSAL) : $(GT_OBJS) $(GT_COMMON_OBJS)
	$(CC) $(LFLAGS) $(GT_OBJS) $(GT_COMMON_OBJS) $(OBJECT) $(EXEC_NAME)

$(GRAPH_APP) : $(GT_APP_OBJS) $(GT_COMMON_OBJS)
	$(CC) $(LFLAGS) $(GT_APP_OBJS) $(GT_COMMON_OBJS) $(OBJECT) $(EXEC_NAME)

$(NT_OBJS) : $(NT_DEPS)
	$(CC) $(CFLAGS) $(NT_MAIN) $(OBJECT) $(NT_OBJS)

$(SM_OBJS) : $(SM_DEPS)
	$(CC) $(CFLAGS) $(SM_MAIN) $(OBJECT) $(SM_OBJS)

$(GT_OBJS) : $(GT_DEPS)
	$(CC) $(CFLAGS) $(GT_MAIN) $(OBJECT) $(GT_OBJS)

$(GT_APP_OBJS): $(GT_APP_DEPS)
	$(CC) $(CFLAGS) $(GT_APP_MAIN) $(OBJECT) $(GT_APP_OBJS)

$(GT_COMMON_OBJS): $(GT_COMMON_DEPS)
	$(CC) $(CFLAGS) $(GT_COMMON_MAIN) $(OBJECT) $(GT_COMMON_OBJS)

clean:
	if [ -f $(EXEC_NAME) ]; \
	then \
		rm $(EXEC_NAME); \
	fi; \
	\
	for o in $(OBJS); \
	do \
		if [ -f $$o ]; \
		then \
			rm $$o; \
		fi; \
	done;

