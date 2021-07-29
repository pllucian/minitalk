# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pllucian <pllucian@21-school.ru>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/28 11:35:23 by pllucian          #+#    #+#              #
#    Updated: 2021/08/06 01:19:52 by pllucian         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS_CLIENT = client.c

SRCS_SERVER = server.c

SRCS_CLIENT_BONUS = client_bonus.c

SRCS_SERVER_BONUS = server_bonus.c

OBJS_CLIENT = $(SRCS_CLIENT:.c=.o)

OBJS_SERVER = $(SRCS_SERVER:.c=.o)

OBJS_CLIENT_BONUS = $(SRCS_CLIENT_BONUS:.c=.o)

OBJS_SERVER_BONUS = $(SRCS_SERVER_BONUS:.c=.o)

INCL = minitalk.h

INCL_BONUS = minitalk_bonus.h

NAME_CLIENT = client

NAME_SERVER = server

NAME_CLIENT_BONUS = client_bonus

NAME_SERVER_BONUS = server_bonus

NAME = minitalk

CC = gcc

RM = rm -f

CFLAGS = -Wall -Wextra -Werror

%.o:					%.c
						$(CC) $(CFLAGS) -c $< -o $@ -Ilibft

$(NAME):				$(NAME_CLIENT) $(NAME_SERVER)

$(NAME_CLIENT):			$(OBJS_CLIENT) $(INCL)
						make bonus -C ./libft
						$(CC) -o $@ $< -Llibft -lft

$(NAME_SERVER):			$(OBJS_SERVER) $(INCL)
						make bonus -C ./libft
						$(CC) -o $@ $< -Llibft -lft
					
bonus:					$(NAME_CLIENT_BONUS) $(NAME_SERVER_BONUS)

$(NAME_CLIENT_BONUS):	$(OBJS_CLIENT_BONUS) $(INCL_BONUS)
						make bonus -C ./libft
						$(CC) -o $@ $< -Llibft -lft

$(NAME_SERVER_BONUS):	$(OBJS_SERVER_BONUS) $(INCL_BONUS)
						make bonus -C ./libft
						$(CC) -o $@ $< -Llibft -lft

all:					$(NAME)

clean:
						make clean -C ./libft
						$(RM) $(OBJS_CLIENT) $(OBJS_SERVER) $(OBJS_CLIENT_BONUS) $(OBJS_SERVER_BONUS)

fclean:					clean
						make fclean -C ./libft
						$(RM) $(NAME_CLIENT) $(NAME_SERVER) $(NAME_CLIENT_BONUS) $(NAME_SERVER_BONUS)

re:						fclean all

.PHONY:					bonus all clean fclean re
