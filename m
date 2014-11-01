Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18664 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaKAXHn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Nov 2014 19:07:43 -0400
Date: Sat, 1 Nov 2014 19:07:25 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 2/4] watchdog: orion: Use the reference clock on
 Armada 375 SoC
Message-ID: <20141101230725.GI3698@titan.lakedaemon.net>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141031135002.17526d50@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141031135002.17526d50@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Ezequiel, Wim,

On Fri, Oct 31, 2014 at 01:50:02PM +0100, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> It's really nitpicking, but I find the usage of empty newlines rather
> unfortunate in the below function.

oops, I thought this was against patch #3.  Ezequiel, please feel free
to add my Ack once these changes are made.

thx,

Jason.

> On Sat, 25 Oct 2014 11:48:40 -0300, Ezequiel Garcia wrote:
> 
> > +static int armada375_wdt_clock_init(struct platform_device *pdev,
> > +				    struct orion_watchdog *dev)
> > +{
> > +	int ret;
> > +
> > +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
> > +	if (!IS_ERR(dev->clk)) {
> > +
> 
> This empty new line seems not needed.
> 
> > +		ret = clk_prepare_enable(dev->clk);
> > +		if (ret) {
> > +			clk_put(dev->clk);
> > +			return ret;
> > +		}
> > +
> > +		atomic_io_modify(dev->reg + TIMER_CTRL,
> > +				WDT_AXP_FIXED_ENABLE_BIT,
> > +				WDT_AXP_FIXED_ENABLE_BIT);
> > +		dev->clk_rate = clk_get_rate(dev->clk);
> > +		return 0;
> 
> But one empty new line before the return would be good.
> 
> > +	}
> > +
> > +	/* Mandatory fallback for proper devicetree backward compatibility */
> > +	dev->clk = clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(dev->clk))
> > +		return PTR_ERR(dev->clk);
> 
> An empty newline would be good here as well.
> 
> > +	ret = clk_prepare_enable(dev->clk);
> > +	if (ret) {
> > +		clk_put(dev->clk);
> > +		return ret;
> > +	}
> > +
> > +	atomic_io_modify(dev->reg + TIMER_CTRL,
> > +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
> > +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
> > +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
> 
> And here.
> 
> With this fixed:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
