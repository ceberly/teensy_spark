// https://github.com/PaulStoffregen/cores/blob/master/teensy3/kinetis.h
void main(void) {
  // disable watchdog
  volatile unsigned short *watchdog_unlock =
      (volatile unsigned short *)0x4005200E;
  volatile unsigned short *watchdog_stctrlh =
      (volatile unsigned short *)0x40052000;
  *watchdog_unlock = 0xC520;
  *watchdog_unlock = 0xD928;
  __asm__ volatile("nop");
  __asm__ volatile("nop");

  unsigned short c = *watchdog_stctrlh;
  *watchdog_stctrlh = c & ~(0x00000001);

  // enable SIM port clock
  volatile unsigned int *sim_scgc5 = (volatile unsigned int *)0x40048038;
  unsigned int scgc = *sim_scgc5;

  *sim_scgc5 = scgc | (unsigned int)0x00000800;

  // turn on GPIO
  volatile unsigned int *pcr5 = (volatile unsigned int *)0x4004B014;
  unsigned int pcr = *pcr5;
  unsigned int mode = 1 & 0x00000007;
  mode <<= 8;

  pcr &= 0xFFFFF8FF;
  pcr |= mode;

  *pcr5 = pcr;

  // turn on led
  struct gpioband {
    volatile unsigned int pdor[32];
    volatile unsigned int psor[32];
    volatile unsigned int pcor[32];
    volatile unsigned int ptor[32];
    volatile unsigned int pdir[32];
    volatile unsigned int pddr[32];
  };

  volatile struct gpioband *gpioc = (volatile struct gpioband *)0x43FE1000;

  gpioc->pddr[5] = 1;

  while (1) {
    gpioc->psor[5] = 1;
    // delay
    for (volatile unsigned int i = 0; i < 500000; i++) {
      __asm__ volatile("yield");
    }

    gpioc->pcor[5] = 1;

    for (volatile unsigned int i = 0; i < 500000; i++) {
      __asm__ volatile("yield");
    }
  };
}

extern void _stack_top(void);

__attribute__((section(".vectors"))) void (*_VECTORS[2])(void) = {_stack_top,
                                                                  main};

unsigned char _FLASHCONFIG[16] __attribute__((section(".flashconfig"))) = {
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xDE, 0xF9, 0xFF, 0xFF};
