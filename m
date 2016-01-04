Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:48028 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcADPAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Jan 2016 10:00:22 -0500
From: Harald Geyer <harald@ccbib.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
cc: wim@iguana.be, linux@roeck-us.net, festevam@gmail.com,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: stmp3xxx: Remove unused variables
In-reply-to: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
References: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1485.1451919614.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: 8BIT
Date: Mon, 04 Jan 2016 16:00:14 +0100
Message-Id: <E1aG6cJ-0000Nz-0a@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fabio Estevam writes:
> Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
> halt") introduced the following build warning:
> 
> drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
> drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]
> 
> Remove the unused 'pdata' and 'dev' variables.

Looks like I made an error when splitting the original patch in two and
didn't catch it because I only tested it with the second patch together.
Sorry!
 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Harald Geyer <harald@ccbib.org>

Thanks.

> ---
> Changes since v1:
> - Also remove the 'dev' variable.
> 
>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> index dbe0372..d8b11eb 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -74,9 +74,6 @@ static struct watchdog_device stmp3xxx_wdd = {
>  static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>  			  void *unused)
>  {
> -	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
> -	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
> -
>  	switch (code) {
>  	case SYS_DOWN:	/* keep enabled, system might crash while going down */
>  		break;
> -- 
> 1.9.1
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
