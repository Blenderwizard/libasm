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
#include <sys/syscall.h>

typedef struct s_list {
	void *data;
	struct s_list *next;
} t_list;

size_t ft_strlen(const char * string);
int ft_strcmp(const char * s1, const char *s2);
char *ft_strcpy(char * s1, const char *s2);
int ft_write(int fildes, const void *buf, size_t nbytes);
int ft_read(int fildes, void *buf, size_t nbytes);
char *ft_strdup(const char *s1);
int ft_atoi_base(const char *s, const char *base);
int ft_list_size(t_list *begin_list);
void ft_list_push_front(t_list **begin_list, void *data);
void ft_list_remove_if(t_list **begin_list, void *data_ref, int(*cmp)(), void (*free_fct)(void *));
void ft_list_sort(t_list **begin_list, int (*cmp)());

void ft_strlen_tests() {
	printf("\"%s\" has length of %lu\n", "Hello ASM", ft_strlen("Hello ASM"));
	printf("\"%s\" has length of %lu\n", "Hello ASM", strlen("Hello ASM"));
}

void ft_strcmp_tests() {
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELLO", ft_strcmp("HELLO", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "WORLD", ft_strcmp("HELLO", "WORLD"));
	printf("\"%s\" is equal to \"%s\", %d\n", "WORLD", "HELLO", ft_strcmp("WOLRD", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELL", "HELLO", ft_strcmp("HELL", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELL", ft_strcmp("HELLO", "HELL"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELLO", strcmp("HELLO", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "WORLD", strcmp("HELLO", "WORLD"));
	printf("\"%s\" is equal to \"%s\", %d\n", "WORLD", "HELLO", strcmp("WOLRD", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELL", "HELLO", strcmp("HELL", "HELLO"));
	printf("\"%s\" is equal to \"%s\", %d\n", "HELLO", "HELL", strcmp("HELLO", "HELL"));
}

void ft_strlcpy_tests() {
	{
		char str1[10] = "HELLO";
		char str2[10] = "WORLD";
		printf("Copying \"%s\" to \"%s\"\n", str2, str1);
		printf("Result: \"%s\"\n", ft_strcpy(str1, str2));
	}
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
		printf("Result: \"%s\"\n", ft_strcpy(str1, str2));
	}
	{
		char str1[10] = "HELLO";
		char str2[10] = "WOR";
		printf("Copying \"%s\" to \"%s\"\n", str2, str1);
		printf("Result: \"%s\"\n", strcpy(str1, str2));
	}
}

void ft_write_tests() {
	char test[30] = "Let's print out this line\n";
	ft_write(1, test, ft_strlen(test));
	write(1, test, strlen(test));
}

void ft_read_tests() {
	{
		char *test = calloc(31, sizeof(char));
		ft_read(1, test, 30);
		test[30] = '\x00';
		ft_write(1, test, ft_strlen(test));
		free(test);
	}
}

void ft_strdup_tests() {
	{
		char * test = ft_strdup("Hello");
		printf("\"%s\"\n", test);
		free(test);
	}
	{
		char * test = ft_strdup(NULL);
		printf("%s\n", test);
	}
}

void ft_atoi_base_tests() {
	{
		printf("\"FF\" from base \"0123456789ABCDEF\" to base10 is %d\n", ft_atoi_base("FF","0123456789ABCDEF"));
		printf("\"100\" from base \"01\" to base10 is %d\n", ft_atoi_base("100","01"));
		printf("\"-100\" from base \"01\" to base10 is %d\n", ft_atoi_base("-100","01"));
		printf("\"--100\" from base \"01\" to base10 is %d\n", ft_atoi_base("--100","01"));
		printf("\"+-100\" from base \"01\" to base10 is %d\n", ft_atoi_base("+-100","01"));
		printf("\"+--100\" from base \"01\" to base10 is %d\n", ft_atoi_base("+--100","01"));
		printf("\"++-100\" from base \"01\" to base10 is %d\n", ft_atoi_base("++-100","01"));
		printf("\" 100\" from base \"01\" to base10 is %d\n", ft_atoi_base(" 100","01"));
		printf("\" \\t\\n100\" from base \"01\" to base10 is %d\n", ft_atoi_base(" \t\n100","01"));
		printf("\" \\t\\n\\r\\v\\f100\" from base \"01\" to base10 is %d\n", ft_atoi_base(" \t\n\r\v\f100","01"));
		printf("\" \\t\\n\\r\\v\\f100\" from base \"01\" to base10 is %d\n", ft_atoi_base(" \t\n\r\v\f+100","01"));
		printf("\" \\t\\n\\r\\v\\f100\" from base \"01\" to base10 is %d\n", ft_atoi_base(" \t\n\r\v\f+-100","01"));
		printf("\"10a0\" from base \"01\" to base10 is %d\n", ft_atoi_base("10a0","01"));
		printf("NULL from base \"01\" to base10 is %d\n", ft_atoi_base(NULL,"01"));
		printf("base \" 01\" is invalid %d\n", ft_atoi_base("01"," 01"));
		printf("base \"0 1\" is invalid %d\n", ft_atoi_base("01","0 1"));
		printf("base \"1 \" is invalid %d\n", ft_atoi_base("01","1 "));
		printf("base \"1\" is invalid %d\n", ft_atoi_base("01","1"));
		printf("base \"+1\" is invalid %d\n", ft_atoi_base("01","+1"));
		printf("base \"0+1\" is invalid %d\n", ft_atoi_base("01","0+1"));
		printf("base \"1-\" is invalid %d\n", ft_atoi_base("01","1-"));
		printf("base \"11\" is invalid %d\n", ft_atoi_base("01","11"));
		printf("base \"011\" is invalid %d\n", ft_atoi_base("01","011"));
		printf("base NULL is invalid %d\n", ft_atoi_base(NULL,NULL));
	}
}

int main() {
	ft_strlen_tests();
	ft_strcmp_tests();
	ft_strcmp_tests();
	ft_write_tests();
	ft_read_tests();
	ft_strdup_tests();
	ft_atoi_base_tests();
	return (0);
}