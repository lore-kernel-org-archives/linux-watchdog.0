Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49680 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbbKCSIU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 13:08:20 -0500
Subject: Re: [PATCH 00/13] watchdog: factorize restart handler registration
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5638F812.8010802@roeck-us.net>
Date: Tue, 3 Nov 2015 10:08:18 -0800
MIME-Version: 1.0
In-Reply-To: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/03/2015 08:12 AM, Damien Riegel wrote:
> Many drivers implements the exact same piece of code to register a
> restart handler. It can be nice to factorize this in the watchdog core.
>
> The first patch adds an optional restart watchdog operation. If a driver
> defines this operation, a restart handler is registered. By default, the
> restart handler priority is set to 0, but a helper function
> watchdog_set_restart_priority is provided to change it.
>
> The following patches bring this change to the current watchdog drivers
> that use watchdog_core.
>
> This change has been compile-tested on da9063, imx2, lpc18xx, imgpdc.
> It has been tested with (not mainlined yet) ts-4800's watchdog driver.
>
> Damien Riegel (13):
>    watchdog: core: add restart handler support
>    watchdog: bcm47xx_wdt: use core restart handler
>    watchdog: da9063_wdt: use core restart handler
>    watchdog: digicolor_wdt: use core restart handler
>    watchdog: imgpdc_wdt: use core restart handler
>    watchdog: imx2_wdt: use core restart handler
>    watchdog: lpc18xx_wdt: use core restart handler
>    watchdog: meson_wdt: use core restart handler
>    watchdog: moxart_wdt: use core restart handler
>    watchdog: mtk_wdt: use core restart handler
>    watchdog: qcom-wdt: use core restart handler
>    watchdog: s3c2410_wdt: use core restart handler
>    watchdog: sunxi_wdt: use core restart handler
>

Damien,

"v2" in the subject line as well as a change log would have been appreciated.
You are making it (hopefully not intentionally) difficult for maintainers
to separate v1 from v2. You might want to keep in mind that maintainers are
in general quite busy and might thus be a bit annoyed about such additional
(and unnecessary) work.

Thanks,
Guenter

>   Documentation/watchdog/watchdog-kernel-api.txt | 19 +++++++
>   drivers/watchdog/bcm47xx_wdt.c                 | 21 +++-----
>   drivers/watchdog/da9063_wdt.c                  | 23 +++------
>   drivers/watchdog/digicolor_wdt.c               | 18 ++-----
>   drivers/watchdog/imgpdc_wdt.c                  | 34 +++++--------
>   drivers/watchdog/imx2_wdt.c                    | 23 +++------
>   drivers/watchdog/lpc18xx_wdt.c                 | 68 +++++++++++---------------
>   drivers/watchdog/meson_wdt.c                   | 23 ++-------
>   drivers/watchdog/moxart_wdt.c                  | 23 +++------
>   drivers/watchdog/mtk_wdt.c                     | 22 ++-------
>   drivers/watchdog/qcom-wdt.c                    | 63 ++++++++++--------------
>   drivers/watchdog/s3c2410_wdt.c                 | 60 ++++++++++-------------
>   drivers/watchdog/sunxi_wdt.c                   | 23 ++-------
>   drivers/watchdog/watchdog_core.c               | 48 ++++++++++++++++++
>   include/linux/bcm47xx_wdt.h                    |  1 -
>   include/linux/watchdog.h                       |  6 +++
>   16 files changed, 210 insertions(+), 265 deletions(-)
>

