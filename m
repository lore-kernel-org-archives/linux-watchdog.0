Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:42850 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161984Ab3DEQ3U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Apr 2013 12:29:20 -0400
Message-ID: <515EFA43.9000409@digi.com>
Date: Fri, 5 Apr 2013 18:22:27 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: <w.sang@pengutronix.de>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 0/3] improved watchdog driver for STMP3xyz/imx23/imx28
References: <515EF92C.1080609@digi.com>
In-Reply-To: <515EF92C.1080609@digi.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Wolfram,

On 04/05/2013 06:17 PM, Palacios, Hector wrote:
> Geez, this should have been sent a year ago but it dropped off somehow.
> Introduce a new user of the watchdog framework. This is a rewritten driver
> for STMP and imx23/28: Quoting Patch 2/3 for the motivation of a rewrite:
>
> ===
>
> Replace the existing STMP3xxx driver because it has enough drawbacks
> that a rewrite is apropriate. The new driver is designed to use the
> watchdog framework which makes it a lot smaller and avoids open coding
> the watchdog API again. It also uses now an explicitly exported function
> from the RTC driver to set up its registers (the old driver silently
> reused the hopefully(!) already remapped RTC registers). Also, this
> driver is mach independent, while the old one depends on a mach replaced
> by another one a year ago. Since the user interface is still the
> standard watchdog API, users don't need to adapt.
>
> ===
>
> The first patch adds an accessor routine to the RTC-driver which can hopefully
> go via the watchdog-tree as well (asking for Andrew's ack here). It is needed
> because the old driver silently assumed its IO area to be already remapped by
> the RTC driver. The second patch adds the new driver, the third removes the old
> one. The old driver was broken (= not compilable, no arch for it) anyhow, so
> there cannot be any regression. Based on 3.8-rc2 and tested on various MX28
> boards.
>
> Thanks,
>
>      Wolfram
>
>
> Wolfram Sang (3):
>     rtc: stmp3xxx: add wdt-accessor function
>     watchdog: add new driver for STMP3xxx and i.MX23/28
>     watchdog: remove old STMP3xxx driver
>
>    drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
>    drivers/watchdog/Kconfig            |   13 +-
>    drivers/watchdog/Makefile           |    2 +-
>    drivers/watchdog/stmp3xxx_rtc_wdt.c |  111 ++++++++++++++
>    drivers/watchdog/stmp3xxx_wdt.c     |  288 -----------------------------------
>    include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
>    6 files changed, 198 insertions(+), 295 deletions(-)
>    create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
>    delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
>    create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

Thank you.

Reviewed-by: Hector Palacios <hector.palacios@digi.com>
Tested-by: Hector Palacios <hector.palacios@digi.com>

