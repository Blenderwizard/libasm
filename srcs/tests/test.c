/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jrathelo <student.42nice.fr>               +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/09/27 11:15:56 by jrathelo          #+#    #+#             */
/*   Updated: 2022/09/27 13:20:24 by jrathelo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

size_t ft_strlen(const char * string);
int ft_strcmp(const char * s1, const char *s2);
char *ft_strcpy(char * s1, const char *s2);

int main() {
	printf("\"%s\" has length of %lu\n", "Hello ASM", ft_strlen("Hello ASM"));
	printf("\"%s\" has length of %lu\n", "Hello ASM", strlen("Hello ASM"));

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
	return (0);
}