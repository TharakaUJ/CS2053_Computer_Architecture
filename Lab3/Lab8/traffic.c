#include "ripes_system.h"
unsigned *led_base = LED_MATRIX_0_BASE;
unsigned *switch_base = SWITCHES_0_BASE;
void main()
{
    unsigned state = 0;
    unsigned count = 1;
    while (1)
    {
        count++;
        if (switch_base[0] == 1)
        {
            if (count % 10 == 0)
            { // State Change
                if (state == 2)
                {
                    state = 0;
                }
                else
                {
                    state++;
                }
            }
            if (state == 0)
            { // Go State
                led_base[0] = 0 << 8;
                led_base[1] = 0 << 8;
                led_base[2] = 255 << 8;
            }
            else if (state == 1)
            { // Get Ready State
                led_base[0] = 0;
                led_base[1] = 255 << 16 | 255 << 8;
                led_base[2] = 0 << 8;
            }
            else
            { // Stop State
                led_base[0] = 255 << 16;
                led_base[1] = 0;
                led_base[2] = 0 << 16;
            }
            count++; // Increment Count
        }
        else
        { // Switch 0 is not toggled
            led_base[0] = 0;
            led_base[1] = 0;
            led_base[2] = 0 << 8;
        }
    }
}