Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49685 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbbKCVKx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 16:10:53 -0500
Date: Tue, 3 Nov 2015 13:10:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH 00/13] watchdog: factorize restart handler registration
Message-ID: <20151103211050.GA3985@roeck-us.net>
References: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <5638F812.8010802@roeck-us.net>
 <20151103201009.GA29029@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151103201009.GA29029@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 03, 2015 at 03:10:09PM -0500, Damien Riegel wrote:
> On Tue, Nov 03, 2015 at 10:08:18AM -0800, Guenter Roeck wrote:
> > On 11/03/2015 08:12 AM, Damien Riegel wrote:
> > >Many drivers implements the exact same piece of code to register a
> > >restart handler. It can be nice to factorize this in the watchdog core.
> > >
> > >The first patch adds an optional restart watchdog operation. If a driver
> > >defines this operation, a restart handler is registered. By default, the
> > >restart handler priority is set to 0, but a helper function
> > >watchdog_set_restart_priority is provided to change it.
> > >
> > >The following patches bring this change to the current watchdog drivers
> > >that use watchdog_core.
> > >
> > >This change has been compile-tested on da9063, imx2, lpc18xx, imgpdc.
> > >It has been tested with (not mainlined yet) ts-4800's watchdog driver.
> > >
> > >Damien Riegel (13):
> > >   watchdog: core: add restart handler support
> > >   watchdog: bcm47xx_wdt: use core restart handler
> > >   watchdog: da9063_wdt: use core restart handler
> > >   watchdog: digicolor_wdt: use core restart handler
> > >   watchdog: imgpdc_wdt: use core restart handler
> > >   watchdog: imx2_wdt: use core restart handler
> > >   watchdog: lpc18xx_wdt: use core restart handler
> > >   watchdog: meson_wdt: use core restart handler
> > >   watchdog: moxart_wdt: use core restart handler
> > >   watchdog: mtk_wdt: use core restart handler
> > >   watchdog: qcom-wdt: use core restart handler
> > >   watchdog: s3c2410_wdt: use core restart handler
> > >   watchdog: sunxi_wdt: use core restart handler
> > >
> > 
> > Damien,
> > 
> > "v2" in the subject line as well as a change log would have been appreciated.
> > You are making it (hopefully not intentionally) difficult for maintainers
> > to separate v1 from v2. You might want to keep in mind that maintainers are
> > in general quite busy and might thus be a bit annoyed about such additional
> > (and unnecessary) work.
> 
> Sorry for the inconvenience, I assumed it was correct to send the
> patchset as a v1 since the previous one was a RFC. Do you want me to
> resend this serie as a v2 with a changelog ?
> 
No, that would cause even more confusion.

Thanks,
Guenter
