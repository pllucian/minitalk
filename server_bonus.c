/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pllucian <pllucian@21-school.ru>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/28 13:11:29 by pllucian          #+#    #+#             */
/*   Updated: 2021/07/30 00:18:38 by pllucian         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk_bonus.h"

void	handler(int signum, siginfo_t *siginfo, void *context)
{
	static unsigned char	symbol = 0;
	static char				bit_num = 8;

	(void)context;
	symbol |= (signum == SIGUSR1);
	if (--bit_num)
	{
		symbol <<= 1;
		kill(siginfo->si_pid, SIGUSR1);
	}
	else
	{
		ft_putchar_fd(symbol, 1);
		if (symbol)
			kill(siginfo->si_pid, SIGUSR1);
		else
		{
			ft_putchar_fd('\n', 1);
			kill(siginfo->si_pid, SIGUSR2);
		}
		symbol = 0;
		bit_num = 8;
	}
}

int	main(void)
{
	struct sigaction	act;

	ft_putstr_fd("PID: ", 1);
	ft_putnbr_fd(getpid(), 1);
	ft_putstr_fd("\n", 1);
	ft_memset(&act, 0, sizeof(struct sigaction));
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGUSR1);
	sigaddset(&act.sa_mask, SIGUSR2);
	act.sa_flags = SA_SIGINFO;
	act.sa_sigaction = handler;
	sigaction(SIGUSR1, &act, NULL);
	sigaction(SIGUSR2, &act, NULL);
	while (1)
		pause();
	return (0);
}
