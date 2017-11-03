Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/2] xen_wdt: use the watchdog subsystem
Date: Fri,  3 Nov 2017 15:31:51 +0000
Message-Id: <20171103153153.9992-1-rrendec@arista.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

I just figured out we have a similar use case (of two watchdogs at the
same time) that involves the xen_wdt driver. I thought "same problem,
same fix", so I decided to port xen_wdt to use the watchdog subsystem.

This patch series contains similar changes to what I have recently done
for i6300esb. The changes are simpler though, because the Xen hypervisor
cannot expose multiple watchdogs to the guest, and so the driver doesn't
need to allocate watchdog structures dynamically.

I tried to avoid all the problems I had with the i6300esb patches and
hopefully these new patches don't have as many issues (or none at all).

Thanks,
Radu

Radu Rendec (2):
  watchdog: xen_wdt: use the watchdog subsystem
  watchdog: xen_wdt: remove info message and version number

 drivers/watchdog/xen_wdt.c | 208 +++++++++------------------------------------
 1 file changed, 38 insertions(+), 170 deletions(-)

-- 
2.13.6
