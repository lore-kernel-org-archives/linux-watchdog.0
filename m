Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60309 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdHNOo7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:44:59 -0400
Date: Mon, 14 Aug 2017 07:44:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Wim Van Sebroeck <wim@iguana.be>, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] watchdog: constify watchdog_ops and watchdog_info
 structures
Message-ID: <20170814144454.GA14491@roeck-us.net>
References: <1501795291-21372-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501795291-21372-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 03, 2017 at 11:21:31PM +0200, Julia Lawall wrote:
> These watchdog_ops and watchdog_info structures are only stored
> in the ops and info fields of a watchdog_device structure,
> respectively, which are const.  Thus make the watchdog_ops and
> watchdog_info structures const as well.
> 
> Done with the help of Coccinelle.  The rules for the watchdog_ops case are
> as follows:
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
>  drivers/watchdog/coh901327_wdt.c |    2 +-
>  drivers/watchdog/diag288_wdt.c   |    2 +-
>  drivers/watchdog/it87_wdt.c      |    2 +-
>  drivers/watchdog/mt7621_wdt.c    |    2 +-
>  drivers/watchdog/rt2880_wdt.c    |    2 +-
>  drivers/watchdog/stm32_iwdg.c    |    2 +-
>  drivers/watchdog/ts72xx_wdt.c    |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 6f59108..806a04a 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -213,7 +213,7 @@ static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
>  	.set_timeout = wdt_set_timeout,
>  };
>  
> -static struct watchdog_info wdt_info = {
> +static const struct watchdog_info wdt_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  	.firmware_version = 0,
>  	.identity = "z Watchdog",
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index dd1e7ea..e96faea 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
> @@ -253,7 +253,7 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
>  	.identity = WATCHDOG_NAME,
>  };
>  
> -static struct watchdog_ops wdt_ops = {
> +static const struct watchdog_ops wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = wdt_start,
>  	.stop = wdt_stop,
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 48a0606..878835c 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -105,7 +105,7 @@ static int mt7621_wdt_bootcause(void)
>  	return 0;
>  }
>  
> -static struct watchdog_info mt7621_wdt_info = {
> +static const struct watchdog_info mt7621_wdt_info = {
>  	.identity = "Mediatek Watchdog",
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  };
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 05524ba..1727aa3 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -119,7 +119,7 @@ static int rt288x_wdt_bootcause(void)
>  	return 0;
>  }
>  
> -static struct watchdog_info rt288x_wdt_info = {
> +static const struct watchdog_info rt288x_wdt_info = {
>  	.identity = "Ralink Watchdog",
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  };
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 17c25da..811e43c 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -112,7 +112,7 @@ static int ts72xx_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
>  	.identity		= "TS-72XX WDT",
>  };
>  
> -static struct watchdog_ops ts72xx_wdt_ops = {
> +static const struct watchdog_ops ts72xx_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= ts72xx_wdt_start,
>  	.stop		= ts72xx_wdt_stop,
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index 6c501b7..be64a86 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -140,7 +140,7 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>  	.identity	= "STM32 Independent Watchdog",
>  };
>  
> -static struct watchdog_ops stm32_iwdg_ops = {
> +static const struct watchdog_ops stm32_iwdg_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= stm32_iwdg_start,
>  	.ping		= stm32_iwdg_ping,
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 38dd60f0..4410337 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -218,7 +218,7 @@ static irqreturn_t coh901327_interrupt(int irq, void *data)
>  	.identity = DRV_NAME,
>  };
>  
> -static struct watchdog_ops coh901327_ops = {
> +static const struct watchdog_ops coh901327_ops = {
>  	.owner = THIS_MODULE,
>  	.start = coh901327_start,
>  	.stop = coh901327_stop,
> 
