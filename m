Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50090 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753675AbaA0Rgi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 12:36:38 -0500
Date: Mon, 27 Jan 2014 17:36:24 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 14/20] watchdog: orion: Add support for Armada 370
	and Armada XP SoC
Message-ID: <20140127173624.GT15937@n2100.arm.linux.org.uk>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 27, 2014 at 12:27:14PM -0300, Ezequiel Garcia wrote:
> +static int armada370_wdt_clock_init(struct platform_device *pdev,
> +				    struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup watchdog input clock */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
> +
> +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
> +	return 0;
> +}
> +
> +static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> +				   struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the fixed watchdog clock input */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +			 WDT_AXP_FIXED_ENABLE_BIT,
> +			 WDT_AXP_FIXED_ENABLE_BIT);
> +
> +	dev->clk_rate = clk_get_rate(dev->clk);
> +	return 0;
> +}

Doesn't this result in dev->clk being leaked?  Or at least a difference
in the way dev->clk needs to be cleaned up between these two functions?

I think it would be better in this case to use the standard clk_get() in
the first function and always use clk_put()... until there is a devm_*
version of the of_clk_get* functions.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
