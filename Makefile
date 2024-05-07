# Source files
SRC		=	src/main.c \
			src/dda_raycast.c
			#src/texture.c

# Object files definition
OBJS = $(SRC:.c=.o)

# Directories for libraries
GNL_DIR			= libs/gnl/
LIBFT_DIR		= libs/libft/
MLX_DIR			= libs/MLX42/build

# Library files
LIB 			= $(LIBFT) $(GNL)
GNL				= $(GNL_DIR)gnl.a
LIBFT			= $(LIBFT_DIR)libft.a
MLX_LIB			= $(MLX_DIR)/libmlx42.a

# Includes
INCLUDE 		= -I./include/ \
				 -I./libs/ft/ \
				 -I./libs/gnl/ \
				 -I./libs/MLX42/include/MLX42/

# Compiler and delete commands
CC				= cc
RM				= rm -f
CFLAGS			= -Wall -Werror -Wextra -g
GLFW			= -lglfw
#GLFW			=-L/opt/homebrew/lib -lglfw


# Color variables for printing
MG				= \033[0;95m # Magenta
CY				= \033[0;96m # Cyan
R				= \033[0;91m # Red
G				= \033[0;32m # Green
B				= \033[0;94m # Blue
RST				= \033[0;39m # Reset

# Output file name
NAME			= cub3d

# General rule for compiling object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INCLUDE)

# Main target
all: $(NAME)

# Compiling the application
$(NAME): $(LIB) $(MLX_LIB) $(OBJS)
	echo "Linking..."
	$(CC) $(CFLAGS) $(OBJS) $(GLFW) $(MLX_LIB) $(LIB) -o $(NAME)
	echo "$(MG)cub3d ready to play$(RST)"

# Compiling the MLX library
$(MLX_LIB):
	echo "Compiling mlx42..."
	cd lib/MLX42 && cmake -B build
	cmake --build ./libs/MLX42/build -j4
	echo "mlx42 compiled"

# Compiling the libraries
$(LIB):
	echo "Compiling libraries..."
	$(MAKE) -C ./libs/

# Cleaning up object files
clean:
	$(RM) $(OBJS)
	echo "$(MG)Object files cleaned$(RST)"
	$(MAKE) clean -C ./libs/
	echo "$(R)Lib object files removed..."

# Cleaning up all compiled outputs
fclean: clean
	$(RM) $(NAME)
	$(MAKE) fclean -C ./libs/
	echo "$(MG)cub3d program was deleted$(RST)"

# Cleaning up the MLX42 library
clean_mlx:
	echo "Removing MLX42 library..."
	rm -rfd ./libs/MLX42/build/

# Rebuilding everything
re: fclean all

# Phony targets
.PHONY: all clean fclean re clean_mlx
