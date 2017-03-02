Return-path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Wenyou.Yang@microchip.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/4] watchdog: sama5d4: fix issues
Date: Thu,  2 Mar 2017 18:31:10 +0100
Message-Id: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

This is a rework of how the watchdog is getting programmed. Currently,
there are multiple issue that have the same symptoms: the watchdog is
unexpectidly resetting the SoCs when configuring it.

The first issue was how WDDIS was handled. To sum it up, the watchdog
has to be configured when removing WDDIS instead of first removing it
then configuring it. It is solved by only configuring the IP when
enabling the watchdog.
Note that there were no issue updating the timeout with the watchdog
running.

The second issue is how the write are synchronized inside the IP. The
datasheet state that iit is necessary to wait 3 slow clock periods
between a write to CR and subsequents writes to CR and MR. This was not
done in the driver. Also, it apears it is necessary to wait the same
amount of time between a write to MR and a write to CR or MR.

Finally, a simplification of the probe is done and a comment is added in
the resume function to explain why the reset may be delayed after a
suspend/resume cycle (but it will still happen).

Before the series, the watchdog would reset the SoC after a few
configurations. Now, I've lett a test progam run that managed to do more
than 1 000 000 configurations with the watchdog enabled and the same
while disabled.

Alexandre Belloni (4):
  watchdog: sama5d4: fix WDDIS handling
  watchdog: sama5d4: fix race condition
  watchodg: sama5d4: simplify probe
  watchdog: sama5d4: Add comment explaining what happens on resume

 drivers/watchdog/sama5d4_wdt.c | 96 ++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 28 deletions(-)

-- 
2.11.0
