Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60295 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaBGCC7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 21:02:59 -0500
Message-ID: <52F43ED0.4050808@roeck-us.net>
Date: Thu, 06 Feb 2014 18:02:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is initially
 stopped
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com> <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/06/2014 09:20 AM, Ezequiel Garcia wrote:
> Having the watchdog initially fully stopped is important to avoid
> any spurious watchdog triggers, in case the registers are not in
> its reset state.
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   drivers/watchdog/orion_wdt.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 6746033..2dbeee9 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -142,6 +142,9 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   	orion_wdt.max_timeout = wdt_max_duration;
>   	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
>
> +	/* Let's make sure the watchdog is fully stopped */
> +	orion_wdt_stop(&orion_wdt);
> +

Actually we just had that in another driver, and I stumbled over it there.

Problem with stopping the watchdog in probe unconditionally is that you can
use it to defeat nowayout: unload the module, then load it again,
and the watchdog is stopped even if nowayout is true.

Is this really what you want ? Or, in other words, what is the problem
you are trying to solve ?

Thanks,
Guenter


>   	watchdog_set_nowayout(&orion_wdt, nowayout);
>   	ret = watchdog_register_device(&orion_wdt);
>   	if (ret)
>

