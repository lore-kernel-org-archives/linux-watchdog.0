Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39713 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbcISWgy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 18:36:54 -0400
Date: Mon, 19 Sep 2016 23:36:16 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
Message-ID: <20160919223616.GN1041@n2100.armlinux.org.uk>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
 <20160919200816.GC29242@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160919200816.GC29242@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 19, 2016 at 01:08:16PM -0700, Guenter Roeck wrote:
> On Mon, Sep 19, 2016 at 09:12:14PM +0200, Robert Jarzmik wrote:
> > The OS timer rate used for the watchdog can now be fetched from the
> > standard clock API. This will remove the last user of
> > get_clock_tick_rate() in both pxa and sa11x0 architectures.
> > 
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Did you test this ? Potential problem, if built into the kernel, could be that
> the clocks might not be ready by the time the driver is instantiated. Unless
> this is converted to a platform driver, it won't be able to handle a
> -EPROBE_DEFER from the clock subsystem.

Really not a problem at all.  The OSTIMER0 is required for the system
tick, and if that's not present, the kernel will be without any kind
of time keeping, so a missing watchdog driver is the least of the
problems.

Therefore, both PXA and SA11x0 register their clocks really early to
ensure that OSTIMER0 is available by the time_init() stage, which is
way before driver probe time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
