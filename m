Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:59193 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756188AbbBCTCn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 14:02:43 -0500
Date: Tue, 3 Feb 2015 20:02:33 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Doug Anderson <dianders@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: dw_wdt: Try to get a 30 second watchdog by default
Message-ID: <20150203190232.GE2875@spo001.leaseweb.nl>
References: <1422397517-20426-1-git-send-email-dianders@chromium.org> <1422397517-20426-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422397517-20426-2-git-send-email-dianders@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Doug,

> The dw_wdt_set_top() function takes in a value in seconds.  In
> dw_wdt_open() we were calling it with a value that's supposed to
> represent the maximum value programmed into the "top" register with a
> comment saying that we were trying to set the watchdog to its maximum
> value.  Instead we ended up setting the watchdog to ~15 seconds.
> 
> Let's fix this.  However, setting things to the "max" gives me an 86
> second watchdog in the system I'm looking at.  86 seconds feels a
> little too long.  We'll explicitly choose 30 seconds as a more
> reasonable value.
> 
> NOTE: Ideally this driver should be transitioned to be a real watchdog
> driver.  Then we could use "watchdog_init_timeout" and let the timeout
> be specified in a number of ways (device tree, module parameter, etc).
> This patch should be considered a bit of a stopgap solution.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This one has also been added to linux-watchdog-next.

Kind regards,
Wim.

