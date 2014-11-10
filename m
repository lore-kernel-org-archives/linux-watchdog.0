Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44082 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbaKJPCd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Nov 2014 10:02:33 -0500
Message-ID: <5460D37D.40604@free-electrons.com>
Date: Mon, 10 Nov 2014 16:02:21 +0100
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 2/3] watchdog: orion: Use the reference clock on Armada
 375 SoC
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com> <1415107293-19258-3-git-send-email-ezequiel.garcia@free-electrons.com> <5460CEB0.7080009@free-electrons.com> <5460CFEF.1090400@free-electrons.com>
In-Reply-To: <5460CFEF.1090400@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/11/2014 15:47, Ezequiel Garcia wrote:
> On 11/10/2014 11:41 AM, Gregory CLEMENT wrote:
>> Hi Ezequiel,
>>
>> [...]
>>
>>> +static int armada375_wdt_clock_init(struct platform_device *pdev,
>>> +				    struct orion_watchdog *dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
>>> +	if (!IS_ERR(dev->clk)) {
>>> +		ret = clk_prepare_enable(dev->clk);
>>> +		if (ret) {
>>> +			clk_put(dev->clk);
>>> +			return ret;
>>> +		}
>>> +
>>> +		atomic_io_modify(dev->reg + TIMER_CTRL,
>>> +				WDT_AXP_FIXED_ENABLE_BIT,
>>> +				WDT_AXP_FIXED_ENABLE_BIT);
>>> +		dev->clk_rate = clk_get_rate(dev->clk);
>>> +
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* Mandatory fallback for proper devicetree backward compatibility */
>>> +	dev->clk = clk_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(dev->clk))
>>> +		return PTR_ERR(dev->clk);
>>> +
>>> +	ret = clk_prepare_enable(dev->clk);
>>> +	if (ret) {
>>> +		clk_put(dev->clk);
>>> +		return ret;
>>> +	}
>>> +
>>> +	atomic_io_modify(dev->reg + TIMER_CTRL,
>>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
>>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
>>> +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
>>> +
>>> +	return 0;
>>> +}
>>
>> Shouldn't be possible to do the following:
>>
>> static int armada375_wdt_clock_init(struct platform_device *pdev,
>> 				    struct orion_watchdog *dev)
>> {
>> 	if (armadaxp_wdt_clock_init(pdev, dev)) {
>> 		/* Mandatory fallback for proper devicetree backward compatibility */
>> 		return armadaxp_wdt_clock_init(pdev, dev));
> 
> I guess you meant armada370_wdt_clock_init for the fallback?

yes wrong copy and paste

> 
>> 	}
>> 	return 0;
>> }
>>
>> Actually reusing the armadaxp_wdt_clock_init() function  was also suggested by Thomas
>> on your first version but I didn't find your answer about it.
>>
> 
> I replied here to the same objection on the clocksource driver:
> http://www.spinics.net/lists/linux-watchdog/msg05318.html

Thanks i didn't managed to find it.

> 
> I found that it's a fragile practice, just to save a few lines of code.

The purpose was not to save a few line of code but to make the code more
maintainable. If we need to fix something in the one of the aramda370 and
xp function then we also need to do the same in this function.

> Someone can go and change the 370/xp clock init, in some way that's
> incompatible with 375.
> 
> I guess I'm being paranoid, but it's a way to keep the code robust and
> we are only duplicating a few lines.

I see your point and I don't have a strong opinion on my suggestion so:


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
