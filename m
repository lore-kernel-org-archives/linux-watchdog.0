Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63946 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1G3IlJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 30 Jul 2011 04:41:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/9] watchdog: WatchDog Timer Driver Core - Add basic framework
Date: Sat, 30 Jul 2011 10:40:47 +0200
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wolfram Sang <w.sang@pengutronix.de>
References: <20110727201537.GA13819@infomag.iguana.be> <1311797800-2706-1-git-send-email-wim@iguana.be> <1311888593.10042.36.camel@Joe-Laptop>
In-Reply-To: <1311888593.10042.36.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201107301040.47664.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 28 July 2011, Joe Perches wrote:
> Perhaps add some logging helpers to the .h?
> 
> #define wdd_emerg(wd, fmt, ...)                                 \
>         pr_emerg("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_crit(wd, fmt, ...)                                  \
>         pr_crit("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_alert(wd, fmt, ...)                                 \
>         pr_alert("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_err(wd, fmt, ...)                                   \
>         pr_err("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_notice(wd, fmt, ...)                                \
>         pr_notice("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_warn(wd, fmt, ...)                                  \
>         pr_warn("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_info(wd, fmt, ...)                                  \
>         pr_info("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)
> #define wdd_dbg(wd, fmt, ...)                                   \
>         pr_debug("%s: " fmt, (wd)->info->identity, ##__VA_ARGS__)

No, please don't. Adding driver-specific debugging macros tends to confuse
more than it helps, IMHO.

> > +     err = misc_register(&watchdog_miscdev);
> > +     if (err != 0) {
> > +             pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
> > +                     watchdog->info->identity, WATCHDOG_MINOR, err);
> 
>                 wdd_err(watchdog, "cannot register watchdog on minor %d, err: %d\n",
>                         WATCHDOG_MINOR, err);

I think changing them could be useful, but I'd rather change them to
dev_err etc and pass the underlying device.

	Arnd
