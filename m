Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:37104 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756570AbcAZJJu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 04:09:50 -0500
Message-ID: <1453799387.17181.76.camel@tiscali.nl>
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
From: Paul Bolle <pebolle@tiscali.nl>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 26 Jan 2016 10:09:47 +0100
In-Reply-To: <20160125190942.GA6824@sophia>
References: <20160125190942.GA6824@sophia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On ma, 2016-01-25 at 14:09 -0500, William Breathitt Gray wrote:
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

> +config EBC_C386_WDT
> +	tristate "WinSystems EBC-C384 Watchdog Timer"
> +	depends on X86
> +	select WATCHDOG_CORE
> +	help
> +	  Enables watchdog timer support for the watchdog timer on the
> +	  WinSystems EBC-C384 motherboard. The timeout may be configured via
> +	  the timeout module parameter.

It's utterly trivial, but I couldn't help noticing that this supports
the "EBC-C384" motherboard but the Kconfig symbol is EBC_C386_WDT (note
the 6). Any particular reason?


Thanks,


Paul Bolle
