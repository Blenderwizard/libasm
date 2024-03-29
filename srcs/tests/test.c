/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jrathelo <student.42nice.fr>               +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/09/27 11:15:56 by jrathelo          #+#    #+#             */
/*   Updated: 2022/09/27 18:59:22 by jrathelo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/syscall.h>


size_t ft_strlen(const char * string);
int ft_strcmp(const char * s1, const char *s2);
char *ft_strcpy(char * s1, const char *s2);
int ft_write(int fildes, const void *buf, size_t nbytes);
int ft_read(int fildes, void *buf, size_t nbytes);
char *ft_strdup(const char *s1);

void ft_strlen_tests() {
    printf("----- Starting ft_strlen tests -----\n");
    printf("\"%s\" has length of %lu\n", "Hello ASM", ft_strlen("Hello ASM"));
    printf("----- Starting strlen tests -----\n");
	printf("\"%s\" has length of %lu\n", "Hello ASM", strlen("Hello ASM"));
}

void ft_strcmp_tests() {
  	printf("----- Starting ft_strcmp tests -----\n");
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELLO", ft_strcmp("HELLO", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "WORLD", ft_strcmp("HELLO", "WORLD"));
	printf("\"%s\" is equal to \"%s\", %d\n", "WORLD", "HELLO", ft_strcmp("WOLRD", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELL", "HELLO", ft_strcmp("HELL", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELL", ft_strcmp("HELLO", "HELL"));
	printf("----- Starting strcmp tests -----\n");
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELLO", strcmp("HELLO", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "WORLD", strcmp("HELLO", "WORLD"));
	printf("\"%s\" is equal to \"%s\", %d\n", "WORLD", "HELLO", strcmp("WOLRD", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELL", "HELLO", strcmp("HELL", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELL", strcmp("HELLO", "HELL"));
}

void ft_strlcpy_tests() {
  printf("----- Starting ft_strcpy tests -----\n");
	{
		char str1[10] = "HELLO";
		char str2[10] = "WORLD";
		printf("Copying \"%s\" to \"%s\"\n", str2, str1);
		printf("Result: \"%s\"\n", ft_strcpy(str1, str2));
    }
    {
          char str1[10] = "HELLO";
          char str2[10] = "WOR";
          printf("Copying \"%s\" to \"%s\"\n", str2, str1);
          printf("Result: \"%s\"\n", ft_strcpy(str1, str2));
    }
    printf("----- Starting strcpy tests -----\n");
	{
		char str1[10] = "HELLO";
		char str2[10] = "WORLD";
		printf("Copying \"%s\" to \"%s\"\n", str2, str1);
		printf("Result: \"%s\"\n", strcpy(str1, str2));
	}
	{
		char str1[10] = "HELLO";
		char str2[10] = "WOR";
		printf("Copying \"%s\" to \"%s\"\n", str2, str1);
		printf("Result: \"%s\"\n", strcpy(str1, str2));
	}
}

void ft_write_tests() {
    printf("----- Starting ft_write tests -----\n");
	char test[30] = "Let's print out this line\n";
    ft_write(1, test, ft_strlen(test));
    printf("----- Starting write tests -----\n");
	write(1, test, strlen(test));
}

void ft_read_tests() {
	{
        printf("----- Starting ft_read tests -----\n");
		char *test = calloc(31, sizeof(char));
		ft_read(1, test, 30);
		test[30] = '\x00';
		ft_write(1, test, ft_strlen(test));
		free(test);
	}
    {
        ft_read(-1, NULL, 0);
        printf("errno: %d, expected:", errno);
        read(-1, NULL, 0);
        printf(" %d\n", errno);
    }
}

void ft_strdup_tests() {
    printf("----- Starting ft_strdup tests -----\n");
	{
        char * test = ft_strdup("Hello");
		printf("\"%s\"\n", test);
		free(test);
	}
	{
		char * test = ft_strdup(NULL);
		printf("%p\n", test);
	}
}


int main() {
	ft_strlen_tests();
	ft_strcmp_tests();
	ft_strlcpy_tests();
	ft_write_tests();
	ft_read_tests();
	ft_strdup_tests();
	return (0);
}