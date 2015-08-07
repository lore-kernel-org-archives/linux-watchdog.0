Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56375 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbbHGNkJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 09:40:09 -0400
Message-ID: <55C4B534.5050602@roeck-us.net>
Date: Fri, 07 Aug 2015 06:40:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, support.opensource@diasemi.com,
	kernel@pengutronix.de
Subject: Re: [PATCH 2/2] watchdog: da9063: Disable and wait before changing
 timeout
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de> <1438879019-12978-2-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1438879019-12978-2-git-send-email-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/06/2015 09:36 AM, Philipp Zabel wrote:
> The DA9063 watchdog occasionally enters error condition and resets the
> system if the timeout is changed quickly after the timer was enabled.
>
> The method of disabling and waiting for > 150 µs before setting the
> new timeout is taken from the DA9052 driver.
>
Using sleep concerns me a bit, since during that time the watchdog
is disabled. Bad enough that we have to do this to start with,
but using usleep adds more risk to an already bad situation.

How about udelay() instead ?

Thanks,
Guenter

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/watchdog/da9063_wdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index b2e9201..87e14d8 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -67,6 +67,11 @@ static int _da9063_wdt_set_timeout(struct da9063_watchdog *wdt,
>   	mutex_lock(&wdt->mutex);
>
>   	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> +
> +	usleep_range(150, 300);
> +
> +	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>   				 DA9063_TWDSCALE_MASK, regval);
>
>   	wdt->defer_ping = false;
>

