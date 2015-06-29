Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59309 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbbF2ISg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Jun 2015 04:18:36 -0400
Message-ID: <5590FF57.9050401@roeck-us.net>
Date: Mon, 29 Jun 2015 01:18:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lars Poeschel <poeschel@lemonage.de>
CC: Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [next:master 13253/13461] drivers/watchdog/omap_wdt.c:288:18:
 error: 'omap_wdt' undeclared
References: <201506291320.FgKUqYd7%fengguang.wu@intel.com>
In-Reply-To: <201506291320.FgKUqYd7%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/28/2015 10:18 PM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   e3984319760987beee59b1d017416671ebb89b4c
> commit: 387ee4d26e5f530e8a6a850cc0a817fad6324686 [13253/13461] watchdog: omap_wdt: early_enable module parameter
> config: arm-omap2plus_defconfig (attached as .config)
> reproduce:
>    wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>    chmod +x ~/bin/make.cross
>    git checkout 387ee4d26e5f530e8a6a850cc0a817fad6324686
>    # save the attached .config to linux build tree
>    make.cross ARCH=arm
>
> All error/warnings (new ones prefixed by >>):
>
>     drivers/watchdog/omap_wdt.c: In function 'omap_wdt_probe':
>>> drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared (first use in this function)
>        omap_wdt_start(omap_wdt);
>                       ^
>     drivers/watchdog/omap_wdt.c:288:18: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/omap_wdt +288 drivers/watchdog/omap_wdt.c
>
>     282			readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
>     283			wdev->wdog.timeout);
>     284	
>     285		pm_runtime_put_sync(wdev->dev);
>     286	
>     287		if (early_enable)
>   > 288			omap_wdt_start(omap_wdt);
>     289	
>     290		return 0;
>     291	}
>

Commit 'watchdog: omap_wdt: early_enable module parameter' interfers with
'watchdog: omap: put struct watchdog_device into driver data'. Wonder why
my test build didn't catch this ... ah, I didn't push that commit into my
test repository. Oh well :-(.

Wim, do you want to fix it up in the commit, or should Lars send a patch
to fix it on top of -next ? Should be something like

-			omap_wdt_start(omap_wdt);
+			omap_wdt_start(&wdev->wdog);

Thanks,
Guenter

