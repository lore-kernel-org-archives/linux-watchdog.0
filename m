Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:59186 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S966294AbbBCTCL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 14:02:11 -0500
Date: Tue, 3 Feb 2015 20:01:53 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Doug Anderson <dianders@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: dw_wdt: pat the watchdog before enabling it
Message-ID: <20150203190153.GD2875@spo001.leaseweb.nl>
References: <1422397517-20426-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422397517-20426-1-git-send-email-dianders@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Doug,

> On some dw_wdt implementations the "top" register may be initted to 0
> at bootup.  In such a case, each "pat" of the watchdog will reset the
> timer to 0xffff.  That's pretty short.
> 
> The input clock of the wdt can be any of a wide range of values.  On
> an rk3288 system, I've seen the wdt clock be 24.75 MHz.  That means
> each tick is ~40ns and we'll count to 0xffff in ~2.6ms.
> 
> Because of the above two facts, it's a really good idea to pat the
> watchdog after initting the "top" register properly and before
> enabling the watchdog.  If you don't then there's no way we'll get the
> next heartbeat in time.
> 
> Jisheng Zhang fixed this problem on some dw_wdt versions by using the
> TOP_INIT feature.  However, the dw_wdt on rk3288 doesn't have TOP_INIT
> so it's a good idea to also pat the watchdog manually.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

