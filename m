Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57436 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2CGLSy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 06:18:54 -0500
Date: Wed, 7 Mar 2012 11:18:33 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Viresh Kumar <viresh.kumar@st.com>
Cc: wim@iguana.be, linus.walleij@stericsson.com,
	srinidhi.kasagar@stericsson.com, spear-devel@list.st.com,
	viresh.linux@gmail.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
Message-ID: <20120307111833.GQ17370@n2100.arm.linux.org.uk>
References: <cover.1331115751.git.viresh.kumar@st.com> <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 07, 2012 at 03:57:55PM +0530, Viresh Kumar wrote:
> @@ -156,10 +159,22 @@ static int mpcore_wdt_open(struct inode *inode, struct file *file)
>  
>  	file->private_data = wdt;
>  
> +	if (wdt->clk) {

	if (!IS_ERR(wdt->clk)) {

> +		ret = clk_enable(wdt->clk);

What about preparing the clock?

> +		if (ret) {
> +			dev_err(wdt->dev, "clock enable fail");
> +			goto err;
> +		}
> +	}
> +
>  	/* Activate timer */
>  	mpcore_wdt_start(wdt);
>  
>  	return nonseekable_open(inode, file);
> +
> +err:
> +	clear_bit(0, &wdt->timer_alive);
> +	return ret;
>  }
>  
>  static int mpcore_wdt_release(struct inode *inode, struct file *file)
> @@ -169,9 +184,12 @@ static int mpcore_wdt_release(struct inode *inode, struct file *file)
>  	/*
>  	 * Shut off the timer. Lock it in if it's a module and we set nowayout
>  	 */
> -	if (wdt->expect_close == 42)
> +	if (wdt->expect_close == 42) {
>  		mpcore_wdt_stop(wdt);
> -	else {
> +
> +		if (wdt->clk)

		if (!IS_ERR(wdt->clk))

> +			clk_disable(wdt->clk);

What about unpreparing the clock?

> +	} else {
>  		dev_printk(KERN_CRIT, wdt->dev,
>  				"unexpected close, not stopping watchdog!\n");
>  		mpcore_wdt_keepalive(wdt);
> @@ -350,6 +368,28 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	wdt->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(wdt->clk)) {
> +		dev_warn(&pdev->dev, "Clock not found\n");
> +		wdt->clk = NULL;

Remove this line.

> +	}
> +
> +	if (wdt->clk) {

	if (!IS_ERR(wdt->clk)) {

> +		ret = clk_enable(wdt->clk);

What about preparing the clock?

> +		if (ret) {
> +			dev_err(&pdev->dev, "Clock enable failed\n");
> +			goto err_put_clk;
> +		}
> +	}
> +
> +	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
> +			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
> +
> +	mpcore_wdt_stop(wdt);
> +
> +	if (wdt->clk)
> +		clk_disable(wdt->clk);

Same two comments...

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
> -	mpcore_wdt_stop(wdt);
>  	platform_set_drvdata(pdev, wdt);
>  	mpcore_wdt_pdev = pdev;
>  
>  	return 0;
> +
> +err_put_clk:
> +	if (wdt->clk)
> +		clk_put(wdt->clk);
> +
> +	return ret;
>  }
>  
>  static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
>  {
> +	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
> +
>  	platform_set_drvdata(pdev, NULL);
>  
>  	misc_deregister(&mpcore_wdt_miscdev);
>  
> +	if (wdt->clk)
> +		clk_put(wdt->clk);

Same comments.

> +
>  	mpcore_wdt_pdev = NULL;
>  
>  	return 0;
> @@ -399,6 +446,9 @@ static int mpcore_wdt_suspend(struct device *dev)
>  
>  	if (test_bit(0, &wdt->timer_alive))
>  		mpcore_wdt_stop(wdt);		/* Turn the WDT off */
> +
> +	if (wdt->clk)
> +		clk_disable(wdt->clk);

Same comments...  And what if the watchdog is not open?  Doesn't this
disable an already disabled clock?

>  	return 0;
>  }
>  
> @@ -407,8 +457,13 @@ static int mpcore_wdt_resume(struct device *dev)
>  	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
>  
>  	/* re-activate timer */
> -	if (test_bit(0, &wdt->timer_alive))
> +	if (test_bit(0, &wdt->timer_alive)) {
> +		if (wdt->clk)
> +			clk_enable(wdt->clk);

Same two comments.

> +
>  		mpcore_wdt_start(wdt);
> +	}
> +
>  	return 0;
>  }
>  #endif
> -- 
> 1.7.8.110.g4cb5d
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
