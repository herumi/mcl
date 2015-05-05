include ../common.mk

TARGET=$(TEST_FILE)
LIBS=

SRC=$(wildcard *.cpp)

all: $(TARGET)

test: $(TARGET)
	@$(SAMPLE_TEST)

$(OBJDIR):
	@$(MKDIR) $(OBJDIR)

clean:
	$(CLEAN)

$(LIBS):
	$(MAKE) -C ../src

-include $(DEPEND_FILE)

