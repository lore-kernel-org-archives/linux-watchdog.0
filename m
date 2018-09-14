Return-Path: <romain.izard.pro@gmail.com>
Return-path: <romain.izard.pro@gmail.com>
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 0/2] Fixes for the SAMA5D2/SAMA5D4 watchdog
Date: Fri, 14 Sep 2018 12:13:37 +0200
Message-Id: <20180914101339.7382-1-romain.izard.pro@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

A previous change of the sama5d4_wdt driver broke the device probing
with the device tree configuration described in existing DTS files,
when no value is set for the "timeout-sec" property.

Moreover, specifying any other value than 16 seconds for "timeout-sec"
leads to a watchdog reset immediately when opening the watchdog device.
Fix this by respecting hardware constraints added in recent versions of
the SAMA5D2 and SAMA5D4 datasheet.

Romain Izard (2):
  watchdog: sama5d4: fix timeout-sec usage
  watchdog: sama5d4: write the mode register in two steps

 drivers/watchdog/sama5d4_wdt.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
2.17.1
