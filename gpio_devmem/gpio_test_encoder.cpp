#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>

#define PAGE_SIZE 4096

// EMIO GPIO Memory Addresses (Verify these for Zynq 7020 and design-specific mappings)
#define EMIO_DATA_L 0xE000A048  // Lower 32 bits of EMIO data
#define EMIO_DATA_H 0xE000A04C  // Upper 32 bits of EMIO data

#define EMIO_DATA_RO_L 0xE000A068 // Lower 32 bits of EMIO input data (read-only)
#define EMIO_DATA_RO_H 0xE000A06C // Upper 32 bits of EMIO input data (read-only)

#define EMIO_DIRM_L 0xE000A284   // Lower 32 bits direction mode register
#define EMIO_DIRM_H 0xE000A288   // Upper 32 bits direction mode register

#define EMIO_OEN_L 0xE000A288    // Lower 32 bits output enable register
#define EMIO_OEN_H 0xE000A28C    // Upper 32 bits output enable register

void delay_ms(int ms) {
    usleep(ms * 1000); // Microsecond to millisecond conversion
}

void blink_led(volatile unsigned int *gpio_ptr, int offset, int duration_ms) {
    *(gpio_ptr + offset) = 0x000000C0; // Turn LED on
    delay_ms(duration_ms);
    *(gpio_ptr + offset) = 0x00000000; // Turn LED off
    delay_ms(duration_ms);
}

int main() {
    int fd;
    void *ptr;

    // Open /dev/mem
    fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("Error opening /dev/mem");
        return -1;
    }

    // Memory map GPIO base
    ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, EMIO_DATA_L & ~(PAGE_SIZE - 1));
    if (ptr == MAP_FAILED) {
        perror("mmap failed");
        close(fd);
        return -1;
    }

    // GPIO configuration for EMIO
    volatile unsigned int *gpio_dirm = (unsigned int *)(ptr + (EMIO_DIRM_L & (PAGE_SIZE - 1)));
   // volatile unsigned int *gpio_oen = (unsigned int *)(ptr + (EMIO_OEN_L & (PAGE_SIZE - 1)));
   // volatile unsigned int *gpio_data = (unsigned int *)(ptr + (EMIO_DATA_L & (PAGE_SIZE - 1)));

    *gpio_dirm = 0x00000000; // Configure all EMIO lower 32 pins as output
   // *gpio_oen  = 0x00000000;  // Enable output for EMIO lower 32 pins

    // Blink LEDs on EMIO pins
    for (int i = 0; i < 5; i++) {
       // blink_led(gpio_data, 0, 200); // Blink with 500ms delay
    }

    // Infinite loop for button polling using EMIO pins
    volatile unsigned int *gpio_input = (unsigned int *)(ptr + (EMIO_DATA_RO_L & (PAGE_SIZE - 1)));
    while (1) {

        //if (!(*gpio_input & 0x00000100)) { // Check button press (EMIO input pin 0)
	if (!(*gpio_input & (0x01 << 6))) { // Check button press (EMIO input pin 0)
            //blink_led(gpio_data, 0, 200);
           perror("Key 1111      clk .....");
	//delay_ms(200);
        }
        if (!(*gpio_input & (0x01 << 7))) { // Check button press (EMIO input pin 0)
            //blink_led(gpio_data, 0, 200);
           perror("Key 2222           DT  .....");
	//delay_ms(200);
        }
        if (!(*gpio_input & (0x01 << 8))) { // Check button press (EMIO input pin 0)
            //blink_led(gpio_data, 0, 200);
           perror("Key 3333       SW       ................");
	//delay_ms(200);
        }
    }

    // Cleanup
    munmap(ptr, PAGE_SIZE);
    close(fd);
    return 0;
}

