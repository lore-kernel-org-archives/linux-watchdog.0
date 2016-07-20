Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40975 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcGTXr5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 Jul 2016 19:47:57 -0400
Date: Wed, 20 Jul 2016 16:47:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when
 appropriate
Message-ID: <20160720234732.GB23213@roeck-us.net>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468570524-18222-3-git-send-email-rasmus.villemoes@prevas.dk>
 <5788E935.6080608@roeck-us.net>
 <578FEF33.9020801@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578FEF33.9020801@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 20, 2016 at 11:37:55PM +0200, Rasmus Villemoes wrote:
> On 2016-07-15 15:46, Guenter Roeck wrote:
> >On 07/15/2016 01:15 AM, Rasmus Villemoes wrote:
> >>
> >>+static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
> >>+{
> >>+    uint32_t cur;
> >>+
> >>+    cur = readl(wdt->base + PM_RSTC);
> >>+
> >>+    return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
> >>+}
> >>+
> >>  static int bcm2835_wdt_start(struct watchdog_device *wdog)
> >>  {
> >>      struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
> >>@@ -70,6 +79,7 @@ static int bcm2835_wdt_start(struct watchdog_device
> >>*wdog)
> >>            PM_RSTC_WRCFG_FULL_RESET, wdt->base + PM_RSTC);
> >>
> >>      spin_unlock_irqrestore(&wdt->lock, flags);
> >>+    set_bit(WDOG_HW_RUNNING, &wdog->status);
> >>
> >You don't need to set this bit here unless the watchdog can not be stopped.
> >
> >>      return 0;
> >>  }
> >>@@ -79,6 +89,7 @@ static int bcm2835_wdt_stop(struct watchdog_device
> >>*wdog)
> >>      struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
> >>
> >>      writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
> >>+    clear_bit(WDOG_HW_RUNNING, &wdog->status);
> >
> >... and since you clear the bit, it can be stopped. Both setting and
> >resetting the bit
> >is therefore not necessary.
> 
> Well, if the bit isn't cleared here, but it was set during probe(), the
> framework will (re)start this watchdog (and keep it fed) since there's no
> separate ping method. I suppose that's reasonable semantics if the watchdog
> was running at boot (and I like how that ends up interacting with my
> open_deadline proposal), but probably a little too subtle. This would also
> change if the ->start method was broken up into separate ping and start
> methods, which it seems that it could be.
> 
> If we do clear the bit here, I think it's neater to set it in start as well,
> even if that doesn't really have any effect.
> 

The problem is different. The core should clear the bit on close if there is a
stop function, and if calling the stop function does not return an error.

Guenter
