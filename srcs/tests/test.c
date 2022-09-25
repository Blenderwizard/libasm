#include <string.h>
#include <stdio.h>

size_t ft_strlen(const char * string);

int main() {
	printf("%s, has length of %lu\n", "Hello ASM", ft_strlen("Hello ASM"));
	printf("%s, has length of %lu\n", "Hello ASM", strlen("Hello ASM"));
}