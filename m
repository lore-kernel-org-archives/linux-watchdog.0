Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35909 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbaBGRnU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 12:43:20 -0500
Date: Fri, 7 Feb 2014 10:43:14 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is
 initially stopped
Message-ID: <20140207174314.GB16263@obsidianresearch.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F43ED0.4050808@roeck-us.net>
 <20140207104044.GA11063@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140207104044.GA11063@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 07, 2014 at 07:40:45AM -0300, Ezequiel Garcia wrote:

> Well, this is related to the discussion about the bootloader not
> reseting the watchdog properly, provoking spurious watchdog triggering.
> 
> Jason Gunthorpe explained [1] that we needed a particular sequence:
> 
>  1. Disable WDT
>  2. Clear bridge
>  3. Enable WDT
> 
> We added the irq handling to satisfy (2), and the watchdog stop for (1).

The issue here is the driver configures two 'machine kill' elements:
the PANIC IRQ and the RstOut setup.

Before configuring either of those the driver needs to ensure that any
old watchdog events are cleared out of the HW. We must not get a
spurious event. 

I agree not disabling an already functional and properly configured
counter from the bootloader is desirable.

So lets break it down a bit..

1) The IRQ:
  It looks like the cause bit latches high on watchdog timer
  expiration but has no side effect unless it is unmasked.

  The new IRQ flow code ensures the bit is cleared during request_irq
  so no old events can trigger the IRQ. Thus it is solved now.

2) The RstOut:
  It is a bit unspecific, but I think this signal latches high when
  any unmasked rst event occurs and stays high until the RstIn pin
  is asserted.

  So we don't need to worry about clearing old events from here

  Alternatively the WDRstOutEn routes the Cause bit into the RstOut
  pin.

3) The timer itself:
  The WDT is just a general timer with an optional hookup to the
  rst control. If it is harmlessly counting but not resetting we need
  to stop that before enabling rst out.

So, how about this for psuedo-code in probe:

if (readl(RSTOUTn) & WDRstOutEn)
{
    /* Watchdog is configured and may be down counting,
       don't touch it */
    request_irq(..);
}
else
{
    /* Watchdog is not configured, fully disable the timer
       and configure for watchdog operation. */
    disable_watchdog();
    request_irq();
    writel(RSTOUTn), .. WDRstOutEn);
}

Jason
