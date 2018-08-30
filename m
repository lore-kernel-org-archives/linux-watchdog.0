Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
Date: Thu, 30 Aug 2018 20:50:04 +0200
From: Marek Behun <marek.behun@nic.cz>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830205004.6fe9858f@nic.cz>
In-Reply-To: <20180830204223.391d6066@nic.cz>
References: <20180830142243.12153-1-marek.behun@nic.cz>
	<20180830162853.GA27086@roeck-us.net>
	<20180830204223.391d6066@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

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

What do you think of this solution?

u64 val;
u32 low1, low2;

low1 = readl(dev->reg + CNTR_COUNT_LOW);
val = readl(dev->reg + CNTR_COUNT_HIGH);
low2 = readl(dev->reg + CNTR_COUNT_LOW);

/*
 * If low jumped in this short time more than 2^31, a wrap probably
 * occured. Read high again.
 */
if (low2 - low1 > 0x80000000)
	val = readl(dev->reg + CNTR_COUNT_HIGH);
val = (val << 32) | low2;
