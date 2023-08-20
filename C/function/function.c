#include "function.h"

void decimalToBinary(int num)
{
    if (num == 0)
    {
        printf("The binary number is--> 0 \n");
        return;
    }
    else if (num < 0)
    {
        printf("Error! Enter a positive decimal number! \n");
        return;
    }
    else
    {
        int binary[32];  // We use an array to store binary bits
        int i = 0;
        while (num > 0)
        {
            binary[i] = num % 2;
            num /= 2;
            i++;
        }

        printf("The binary number is--> ");
        for (int j = i - 1; j >= 0; j--)
        {
            printf("%d", binary[j]);
        }
    }
}
