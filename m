Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:44687 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067Ab2CGLR3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 06:17:29 -0500
Date: Wed, 7 Mar 2012 16:47:12 +0530
From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
To: Viresh KUMAR <viresh.kumar@st.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
Message-ID: <20120307111711.GA31348@bnru02>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 07, 2012 at 11:27:55 +0100, Viresh KUMAR wrote:
> This patch adds in clk framework support for wdt driver. If clk_get fails for
> some platform, then we continue without clk_* API's.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/watchdog/mpcore_wdt.c |   71 ++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index ebd964a..9747193 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
> @@ -17,6 +17,7 @@
>   *
>   * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
>   */

[..]

> @@ -350,6 +368,28 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	wdt->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(wdt->clk)) {
> +		dev_warn(&pdev->dev, "Clock not found\n");
> +		wdt->clk = NULL;
> +	}
> +
> +	if (wdt->clk) {
> +		ret = clk_enable(wdt->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Clock enable failed\n");
> +			goto err_put_clk;
> +		}
> +	}
> +
> +	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
> +			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
> +

I see that patch 12/15 does this, why are you doing it here again in clock patch?

> +	mpcore_wdt_stop(wdt);
> +
> +	if (wdt->clk)
> +		clk_disable(wdt->clk);
> +
>  	/*
>  	 * Check that the margin value is within it's range;
>  	 * if not reset to the default
> @@ -368,25 +408,32 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
>  		dev_printk(KERN_ERR, wdt->dev,
>  			"cannot register miscdev on minor=%d (err=%d)\n",
>  							WATCHDOG_MINOR, ret);
> -		return ret;
> +		goto err_put_clk;
>  	}
>  
> -	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
> -			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
> -

oh, you delete this stuff here again.

something messy in patch creation?

Srinidhi
