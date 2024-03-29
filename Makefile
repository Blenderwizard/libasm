# Colors
_BLACK			= \033[0;30m
_RED 			= \033[0;31m
_GREEN			= \033[0;32m
_BROWN			= \033[0;33m
_BLUE			= \033[0;34m
_PURPLE			= \033[0;35m
_CYAN			= \033[0;36m
_LIGHT_GRAY		= \033[0;37m
_DARK_GRAY		= \033[1;30m
_LIGHT_RED		= \033[1;31m
_LIGHT_GREEN	= \033[1;32m
_YELLOW			= \033[1;33m
_LIGHT_BLUE		= \033[1;34m
_LIGHT_PURPLE	= \033[1;35m
_LIGHT_CYAN		= \033[1;36m
_WHITE			= \033[1;37m
_NC 			= \033[0m

# Inverted, i.e. colored backgrounds
_IGREY			= \x1b[40m
_IRED			= \x1b[41m
_IGREEN			= \x1b[42m
_IYELLOW		= \x1b[43m
_IBLUE			= \x1b[44m
_IPURPLE		= \x1b[45
_ICYAN			= \x1b[46m
_IWHITE			= \x1b[47m

# Color reset
_COLOR_RESET	= \033[0m

# Folders
SRC_DIR = srcs
OUTS = objs

# Source Files
SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
SRC_PLUS_PATH = $(addprefix $(SRC_DIR)/, $(SRC))

TEST_SRC = tests/test.c
TEST_SRC_PLUS_PATH = $(addprefix $(SRC_DIR)/, $(TEST_SRC))

# Output Files
OUT = $(subst $(SRC_DIR)/, $(OUTS)/, $(patsubst %.s, %.o, $(SRC_PLUS_PATH)))
TEST_OUT = $(subst $(SRC_DIR)/, $(OUTS)/, $(patsubst %.c, %.o, $(TEST_SRC_PLUS_PATH)))

NAME = libasm.a

CC = nasm

UNAME_S = $(shell uname -s)
ifeq ($(UNAME_S),Linux)
 ASMFLAGS = -f elf64 -D LINUX -g -F dwarf
endif
ifeq ($(UNAME_S),Darwin)
 ASMFLAGS = -f macho64 -D MACOS -g
endif

TESTS = tester

all :
	@echo "$(_YELLOW)Begin Compiling $(NAME)$(_COLOR_RESET)"
	@make $(NAME)
	@echo "$(_YELLOW)Begin Compiling $(TESTS)$(_COLOR_RESET)"
	@make $(TESTS)

$(NAME): $(OUT)
	@echo "$(_PURPLE)Linking $(NAME)$(_COLOR_RESET)"
	@ar rcs $(NAME) $(OUT)
	@echo "$(_GREEN)DONE$(_COLOR_RESET)"

$(TESTS): $(NAME) $(TEST_OUT)
	@echo "$(_PURPLE)Linking $(TESTS)$(_COLOR_RESET)"
	@gcc $(TEST_OUT) -o $(TESTS) -L. -lasm -Wall -Wextra -Werror -g -z noexecstack -pie
	@echo "$(_GREEN)DONE$(_COLOR_RESET)"

$(OUT): $(OUTS)/%.o : $(SRC_DIR)/%.s
	@echo "$(_CYAN)Compiling $(basename $(notdir $*.o)) $(_COLOR_RESET)"
	@mkdir -p $(@D)
	@$(CC) $(ASMFLAGS) -o $@ $<

$(TEST_OUT): $(OUTS)/%.o : $(SRC_DIR)/%.c
	@echo "$(_CYAN)Compiling $(basename $(notdir $*.o)) $(_COLOR_RESET)"
	@mkdir -p $(@D)
	@gcc -Wall -Werror -Wextra -g -c $< -o $@

re: fclean
	@make all

fclean: clean
	@echo "$(_RED)Cleaning output files$(_COLOR_RESET)"
	@rm -rf $(NAME)
	@rm -rf $(TESTS)

clean:
	@echo "$(_RED)Cleaning object files$(_COLOR_RESET)"
	@rm -rf objs

.PHONY: clean fclean re all
