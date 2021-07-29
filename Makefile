# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pllucian <pllucian@21-school.ru>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/28 11:35:23 by pllucian          #+#    #+#              #
#    Updated: 2021/07/29 17:07:37 by pllucian         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS_CLIENT = client.c

SRCS_SERVER = server.c

OBJS_CLIENT = $(SRCS_CLIENT:.c=.o)

OBJS_SERVER = $(SRCS_SERVER:.c=.o)

INCL = minitalk.h

NAME_CLIENT = client

NAME_SERVER = server

NAME = minitalk

CC = gcc

RM = rm -f

CFLAGS = -Wall -Wextra -Werror -g

%.o:				%.c $(INCL)
					$(CC) $(CFLAGS) -c $< -o $@ -Ilibft

$(NAME):			$(NAME_CLIENT) $(NAME_SERVER)

$(NAME_CLIENT):		$(OBJS_CLIENT) $(INCL)
					make bonus -C ./libft
					$(CC) -o $(NAME_CLIENT) $(OBJS_CLIENT) -Llibft -lft

$(NAME_SERVER):		$(OBJS_SERVER) $(INCL)
					make bonus -C ./libft
					$(CC) -o $(NAME_SERVER) $(OBJS_SERVER) -Llibft -lft

all:				$(NAME)

clean:
					make clean -C ./libft
					$(RM) $(OBJS_CLIENT) $(OBJS_SERVER)

fclean:				clean
					make fclean -C ./libft
					$(RM) $(NAME_CLIENT) $(NAME_SERVER)

re:					fclean all

.PHONY:				all clean fclean re
