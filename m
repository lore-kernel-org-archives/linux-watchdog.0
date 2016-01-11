Return-path: <wimvs@spo001.leaseweb.nl>
Date: Mon, 11 Jan 2016 22:27:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux@roeck-us.net, harald@ccbib.org, festevam@gmail.com,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: stmp3xxx: Remove unused variables
Message-ID: <20160111212707.GB6613@spo001.leaseweb.nl>
References: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabio,

> Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
> halt") introduced the following build warning:
> 
> drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
> drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]
> 
> Remove the unused 'pdata' and 'dev' variables.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
