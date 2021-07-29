/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pllucian <pllucian@21-school.ru>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/28 13:11:17 by pllucian          #+#    #+#             */
/*   Updated: 2021/07/29 18:29:03 by pllucian         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	send_signal(int pid, char *msg)
{
	static unsigned char	symbol = 0;
	static char				bit_num = 8;
	static char				*str = NULL;

	if (msg)
	{
		str = msg;
		symbol = *str;
	}
	if (!bit_num)
	{
		bit_num = 8;
		symbol = *(++str);
	}
	if (symbol >> --bit_num & 1)
		kill(pid, SIGUSR1);
	else
		kill(pid, SIGUSR2);
}

void	handler(int signum, siginfo_t *siginfo, void *context)
{
	(void)context;
	if (signum == SIGUSR1)
		send_signal(siginfo->si_pid, NULL);
	else if (signum == SIGUSR2)
	{
		ft_putstr_fd("Done!\n", 1);
		exit (0);
	}
}

int	main(int argc, char **argv)
{
	struct sigaction	act;

	if (argc != 3)
	{
		ft_putstr_fd("Error: Invalid arguments!\n", 2);
		return (1);
	}
	ft_memset(&act, 0, sizeof(struct sigaction));
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGUSR1);
	sigaddset(&act.sa_mask, SIGUSR2);
	act.sa_flags = SA_SIGINFO;
	act.sa_sigaction = handler;
	sigaction(SIGUSR1, &act, NULL);
	sigaction(SIGUSR2, &act, NULL);
	if (kill(ft_atoi(argv[1]), 0))
	{
		ft_putstr_fd("Error: Invalid server PID\n", 2);
		return (1);
	}
	send_signal(ft_atoi(argv[1]), argv[2]);
	while (1)
		pause();
	return (0);
}
