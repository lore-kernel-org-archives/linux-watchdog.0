Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42499 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbaJHP6i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Oct 2014 11:58:38 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XbtdO-0018S7-3R
	for linux-watchdog@vger.kernel.org; Wed, 08 Oct 2014 15:58:38 +0000
Date: Wed, 8 Oct 2014 08:57:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, wim@iguana.be, linux-watchdog@vger.kernel.org,
	David Paris <david.paris@st.com>
Subject: Re: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
Message-ID: <20141008155756.GA17676@roeck-us.net>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
 <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 08, 2014 at 10:33:30AM +0100, Lee Jones wrote:
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/watchdog/Kconfig  |  16 +++
>  drivers/watchdog/Makefile |   1 +
>  drivers/watchdog/st_wdt.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/watchdog/st_wdt.c
> 

Unfortunately (built with W=1):

drivers/watchdog/st_wdt.c: In function 'st_wdog_load_timer':
drivers/watchdog/st_wdt.c:114:14: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]
drivers/watchdog/st_wdt.c: In function 'st_wdog_remove':
drivers/watchdog/st_wdt.c:273:24: error: 'clk' undeclared (first use in this
function)

and checkpatch complains a bit: 

WARNING: please, no space before tabs
#303: FILE: drivers/watchdog/st_wdt.c:236:
+^Ist_wdog->dev ^I^I= &pdev->dev;$

WARNING: please, no space before tabs
#304: FILE: drivers/watchdog/st_wdt.c:237:
+^Ist_wdog->base ^I^I= base;$

WARNING: please, no space before tabs
#306: FILE: drivers/watchdog/st_wdt.c:239:
+^Ist_wdog->warm_reset ^I= of_property_read_bool(np, "st,warm_reset");$

Guenter
