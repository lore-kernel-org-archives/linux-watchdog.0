Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35270 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeH3XL3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 19:11:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9-v6so4265448plr.2
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Aug 2018 12:07:51 -0700 (PDT)
Date: Thu, 30 Aug 2018 12:07:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek Behun <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830190748.GA6752@roeck-us.net>
References: <20180830142243.12153-1-marek.behun@nic.cz>
 <20180830162853.GA27086@roeck-us.net>
 <20180830204223.391d6066@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830204223.391d6066@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 30, 2018 at 08:42:23PM +0200, Marek Behun wrote:
> On Thu, 30 Aug 2018 09:28:53 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > >  .../bindings/watchdog/armada-37xx-wdt.txt          |  23 ++  
> > 
> > Deviceptree properties need to be in a separate patch and have to be
> > approved by devicetree maintainers.
> 
> OK :) I will divide the patch. Should I add devicetree maintainers to
> Cc? Who is then responsible for applying the devicetree property, them
> or you?
> 
I (or rather Wim) will appy it, it just needs a Reviewed-by: from a DT
maintainer.

> > > +config ARMADA_37XX_WATCHDOG
> > > +	tristate "Armada 37xx watchdog"
> > > +	depends on ARCH_MVEBU || COMPILE_TEST  
> > 
> > Did you test this with a couple of architectures ?
> 
> This watchdog si specific to Armada 3720, which currently means
> EspressoBin and Turris Mox. I don't think another vendor would create a
> SOC with same structure for watchdog as this. I also don't have access
> to other boards. This works on EspressoBin and Turris Mox.
> 
I should have said "build test". Did you test-build the driver with other
architectures ?

> > > +static unsigned int timeout = WATCHDOG_TIMEOUT;  
> > 
> > This defeats the purpose of using watchdog_init_timeout() to get a
> > value from devicetree. That value will never be used.
> 
> I shall rewrite this in the next version.
> 
> > > +static u64 get_counter_value(struct armada_37xx_watchdog *dev)
> > > +{
> > > +	u64 val;
> > > +
> > > +	val = readl(dev->reg + CNTR_COUNT_HIGH);
> > > +	val = (val << 32) | readl(dev->reg + CNTR_COUNT_LOW);  
> > 
> > Is this guaranteed to be consistent ? What happens if there is a
> > 32-bit wrap between those two operations ?
> 
> hmmm. The address is not divisible by 8, so I can't use readq :( what
> do you propose?
> 

Re-read high after reading low ?

> > > +static int armada_37xx_wdt_ping(struct watchdog_device *wdt)
> > > +{
> > > +	struct armada_37xx_watchdog *dev =
> > > watchdog_get_drvdata(wdt); +
> > > +	armada_37xx_wdt_counter_disable(dev);
> > > +	set_counter_value(dev);
> > > +	armada_37xx_wdt_counter_enable(dev);
> > > +  
> > 
> > Is it really necessary to stop the watchdog for each ping ? That
> > leaves the system in a vulnerable state. Or does CNTR_CTRL_ENABLE
> > only enable writing into the counter register ?
> 
> Well, it probably is possible to do this without stopping the watchdog,
> but two counters would need to be used for this. A trigger can be set
> to counter 1 to start counting from initial value when counter 2 ended.
> I will have to try if it works, though.
> 
> > > +static int armada_37xx_wdt_start(struct watchdog_device *wdt)
> > > +{
> > > +	struct armada_37xx_watchdog *dev =
> > > watchdog_get_drvdata(wdt);
> > > +	u32 reg;
> > > +
> > > +	reg = readl(dev->reg + CNTR_CTRL);
> > > +
> > > +	if (reg & CNTR_CTRL_ACTIVE)
> > > +		return -EBUSY;  
> > 
> > This is highly unusual. What problem are you solving here ?
> 
> Hmm, you are right, this should not happen if the rest of this driver
> works well so that code is redundant.
> 
> > > +	ret = clk_prepare_enable(dev->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev->clk_rate = clk_get_rate(dev->clk);  
> > 
> > Some clock drivers can return 0 here, which would result in a
> > division by 0 later. It is prudent to check the return value.
> 
> Yes, I shall do that.
> 
> > > +
> > > +	/*
> > > +	 * Since the timeout in seconds is given as 32 bit
> > > unsigned int, and
> > > +	 * the counters hold 64 bit values, even after
> > > multiplication by clock
> > > +	 * rate the counter can hold timeout of UINT_MAX seconds.
> > > +	 */
> > > +	dev->wdt.min_timeout = 0;  
> > 
> > That value is set to 1 above, which makes more sense. What is the
> > point of setting it to 0 here, and what is the impact of setting the
> > actual timeout to 0 ? Are you sure that doesn't result in an
> > immediate reboot ?
> 
> Yes, setting it to 0 does immediate reset. The = 1 line is redundant,
> sorry.

This does not make sense. If you want to implement a reset function,
do it. Don't mis-use the watchdog API for it.

> 
> > > +	armada_37xx_wdt_set_timeout(&dev->wdt, dev->wdt.timeout);
> > > +
> > > +	if (armada_37xx_wdt_is_running(dev))
> > > +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
> > > +	else
> > > +		armada_37xx_wdt_stop(&dev->wdt);  
> > 
> > Why stop it if it isn't running ?
> 
> There are 4 counters and every one of them can be set to be a watchdog
> counter. This driver, as described in the commit message, works with
> counter ID 1. The armada_37xx_wdt_stop unsets all 4 counters from
> being watchdog counters, so that if something, for example u-boot, set
> another counter as watchdog counter, the system would not reboot.
> 
> If you think this shouldn't be done I shall take it away, and rewrite
> armada_37xx_wdt_stop to only touch counter ID 1.
> 

If anything, the counter to be used should be specified in devicetree
instead of being fixed. You should not touch any other counters.

Guenter
