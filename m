Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36576 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3XQG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 19:16:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so4325681pfo.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Aug 2018 12:12:27 -0700 (PDT)
Date: Thu, 30 Aug 2018 12:12:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek Behun <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830191226.GB6752@roeck-us.net>
References: <20180830142243.12153-1-marek.behun@nic.cz>
 <20180830162853.GA27086@roeck-us.net>
 <20180830204223.391d6066@nic.cz>
 <20180830205004.6fe9858f@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830205004.6fe9858f@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 30, 2018 at 08:50:04PM +0200, Marek Behun wrote:
> > > > +static u64 get_counter_value(struct armada_37xx_watchdog *dev)
> > > > +{
> > > > +	u64 val;
> > > > +
> > > > +	val = readl(dev->reg + CNTR_COUNT_HIGH);
> > > > +	val = (val << 32) | readl(dev->reg + CNTR_COUNT_LOW);    
> > > 
> > > Is this guaranteed to be consistent ? What happens if there is a
> > > 32-bit wrap between those two operations ?  
> > 
> > hmmm. The address is not divisible by 8, so I can't use readq :( what
> > do you propose?
> 
> What do you think of this solution?
> 
> u64 val;
> u32 low1, low2;
> 
> low1 = readl(dev->reg + CNTR_COUNT_LOW);
> val = readl(dev->reg + CNTR_COUNT_HIGH);
> low2 = readl(dev->reg + CNTR_COUNT_LOW);
> 
> /*
>  * If low jumped in this short time more than 2^31, a wrap probably
>  * occured. Read high again.
>  */
> if (low2 - low1 > 0x80000000)
> 	val = readl(dev->reg + CNTR_COUNT_HIGH);
> val = (val << 32) | low2;

Yes, that is one option. The other would be to read high again
all the time and repeat reading low if high changed on the second
read of high.

	high1 = readl(dev->reg + CNTR_COUNT_HIGH);
	low = readl(dev->reg + CNTR_COUNT_LOW);
	high2 = readl(dev->reg + CNTR_COUNT_HIGH);
	if (high2 != high1)
		low = readl(dev->reg + CNTR_COUNT_LOW);
	val = (high2 << 32) | low;

There is no ambiguity in this case: We _know_ that
a wrap occurred if high1 and high2 are different.

Guenter
