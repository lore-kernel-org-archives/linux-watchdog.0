Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33207 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754217Ab3A3VNN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Jan 2013 16:13:13 -0500
Date: Wed, 30 Jan 2013 22:13:12 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] improved watchdog driver for STMP3xyz/imx23/imx28
Message-ID: <20130130211312.GJ7867@spo001.leaseweb.com>
References: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de> <20130129162609.GC3323@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130129162609.GC3323@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> On Fri, Jan 04, 2013 at 02:58:46PM +0100, Wolfram Sang wrote:
> > Geez, this should have been sent a year ago but it dropped off somehow.
> > Introduce a new user of the watchdog framework. This is a rewritten driver
> > for STMP and imx23/28: Quoting Patch 2/3 for the motivation of a rewrite:
> > 
> > ===
> > 
> > Replace the existing STMP3xxx driver because it has enough drawbacks
> > that a rewrite is apropriate. The new driver is designed to use the
> > watchdog framework which makes it a lot smaller and avoids open coding
> > the watchdog API again. It also uses now an explicitly exported function
> > from the RTC driver to set up its registers (the old driver silently
> > reused the hopefully(!) already remapped RTC registers). Also, this
> > driver is mach independent, while the old one depends on a mach replaced
> > by another one a year ago. Since the user interface is still the
> > standard watchdog API, users don't need to adapt.
> > 
> > ===
> > 
> > The first patch adds an accessor routine to the RTC-driver which can hopefully
> > go via the watchdog-tree as well (asking for Andrew's ack here). It is needed
> > because the old driver silently assumed its IO area to be already remapped by
> > the RTC driver. The second patch adds the new driver, the third removes the old
> > one. The old driver was broken (= not compilable, no arch for it) anyhow, so
> > there cannot be any regression. Based on 3.8-rc2 and tested on various MX28
> > boards.
> > 
> > Thanks,
> > 
> >    Wolfram
> 
> Ping.
> 
> I rebased and tested the series against v3.8-rc5, added Andrew's ack and
> pushed it out to
> 
> 	git://git.pengutronix.de/git/wsa/linux.git watchdog_mxs
> 
> Would be awesome to have this (simple) driver in 3.9.
> 
> > 
> > 
> > Wolfram Sang (3):
> >   rtc: stmp3xxx: add wdt-accessor function
> >   watchdog: add new driver for STMP3xxx and i.MX23/28
> >   watchdog: remove old STMP3xxx driver
> > 
> >  drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
> >  drivers/watchdog/Kconfig            |   13 +-
> >  drivers/watchdog/Makefile           |    2 +-
> >  drivers/watchdog/stmp3xxx_rtc_wdt.c |  111 ++++++++++++++
> >  drivers/watchdog/stmp3xxx_wdt.c     |  288 -----------------------------------
> >  include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
> >  6 files changed, 198 insertions(+), 295 deletions(-)
> >  create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
> >  delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
> >  create mode 100644 include/linux/stmp3xxx_rtc_wdt.h
> > 
> > -- 
> > 1.7.10.4
> > 
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

Pulled it into linux-watchdog-next.

Kind regards,
Wim.

