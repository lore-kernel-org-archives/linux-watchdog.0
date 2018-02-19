Return-Path: <radu.rendec@gmail.com>
Return-path: <radu.rendec@gmail.com>
From: Radu Rendec <radu.rendec@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/1] xen_wdt: fix build failure
Date: Mon, 19 Feb 2018 14:38:50 +0000
Message-Id: <20180219143851.13983-1-radu.rendec@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

I just saw Matteo Croce's email/patch on the i6300esb build failure and
I realized that xen_wdt has the exact same problem. I forgot to add a
dependency on CONFIG_WATCHDOG_CORE for both drivers when I ported them
to use the watchdog core.

This patch is the xen_wdt equivalent of Matteo Croce's patch for
i6300esb.

Thanks!

Radu Rendec (1):
  watchdog: xen_wdt: fix potential build failure

 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.13.6
