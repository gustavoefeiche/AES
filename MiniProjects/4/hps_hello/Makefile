TARGET = hps_gpio

ALT_DEVICE_FAMILY ?= soc_cv_av

HWLIBS_ROOT = $(SOCEDS_HWLIB)

CFLAGS = -g -Wall -Werror -I$(HWLIBS_ROOT)include -I$(HWLIBS_ROOT)include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)
LDFLAGS = -g -Wall -Werror

CROSS_COMPILE = arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
ARCH = arm

.PHONY: build
build: $(TARGET)

$(TARGET): main.o
	$(LD) $(LDFLAGS)   $^ -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

deploy: $(TARGET)
	scp hps_gpio root@$(IP):/root/

run: deploy
	ssh root@$(IP) '/root/hps_gpio'

kill:
	ssh root@$(IP) 'killall hps_gpio'

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~
