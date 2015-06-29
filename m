Return-path: <wimvs@spo001.leaseweb.nl>
Date: Mon, 29 Jun 2015 11:48:16 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lars Poeschel <poeschel@lemonage.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [next:master 13253/13461] drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared
Message-ID: <20150629094816.GA12255@spo001.leaseweb.nl>
References: <201506291320.FgKUqYd7%fengguang.wu@intel.com> <5590FF57.9050401@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5590FF57.9050401@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

we will fix the commit.

Kind regards,
Wim.

> On 06/28/2015 10:18 PM, kbuild test robot wrote:
> >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> >master
> >head:   e3984319760987beee59b1d017416671ebb89b4c
> >commit: 387ee4d26e5f530e8a6a850cc0a817fad6324686 [13253/13461] watchdog: 
> >omap_wdt: early_enable module parameter
> >config: arm-omap2plus_defconfig (attached as .config)
> >reproduce:
> >   wget 
> >   https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >   chmod +x ~/bin/make.cross
> >   git checkout 387ee4d26e5f530e8a6a850cc0a817fad6324686
> >   # save the attached .config to linux build tree
> >   make.cross ARCH=arm
> >
> >All error/warnings (new ones prefixed by >>):
> >
> >    drivers/watchdog/omap_wdt.c: In function 'omap_wdt_probe':
> >>>drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared (first 
> >>>use in this function)
> >       omap_wdt_start(omap_wdt);
> >                      ^
> >    drivers/watchdog/omap_wdt.c:288:18: note: each undeclared identifier 
> >    is reported only once for each function it appears in
> >
> >vim +/omap_wdt +288 drivers/watchdog/omap_wdt.c
> >
> >    282			readl_relaxed(wdev->base + 
> >    OMAP_WATCHDOG_REV) & 0xFF,
> >    283			wdev->wdog.timeout);
> >    284	
> >    285		pm_runtime_put_sync(wdev->dev);
> >    286	
> >    287		if (early_enable)
> >  > 288			omap_wdt_start(omap_wdt);
> >    289	
> >    290		return 0;
> >    291	}
> >
> 
> Commit 'watchdog: omap_wdt: early_enable module parameter' interfers with
> 'watchdog: omap: put struct watchdog_device into driver data'. Wonder why
> my test build didn't catch this ... ah, I didn't push that commit into my
> test repository. Oh well :-(.
> 
> Wim, do you want to fix it up in the commit, or should Lars send a patch
> to fix it on top of -next ? Should be something like
> 
> -			omap_wdt_start(omap_wdt);
> +			omap_wdt_start(&wdev->wdog);
> 
> Thanks,
> Guenter
> 
