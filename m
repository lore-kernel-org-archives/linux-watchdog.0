Return-path: <Matt.Redfearn@imgtec.com>
From: Matt Redfearn <matt.redfearn@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Matt Redfearn <matt.redfearn@imgtec.com>, <linux-kernel@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: rt2880_wdt: Remove assignment of dev pointer
Date: Mon, 12 Sep 2016 10:35:12 +0100
Message-ID: <1473672913-10484-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
struct watchdog_device") removed the dev pointer from struct
watchdog_device, but this driver was still assigning it, leading to a
compilation error:

drivers/watchdog/rt2880_wdt.c: In function ‘rt288x_wdt_probe’:
drivers/watchdog/rt2880_wdt.c:161:16: error: ‘struct watchdog_device’
has no member named ‘dev’
  rt288x_wdt_dev.dev = &pdev->dev;
                ^
scripts/Makefile.build:289: recipe for target
'drivers/watchdog/rt2880_wdt.o' failed

Fix this by removing the assignment.

Fixes: 0254e953537c
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 drivers/watchdog/rt2880_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 1967919ae743..14b4fd428fff 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -158,7 +158,6 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 
 	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
 
-	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
 	rt288x_wdt_dev.parent = &pdev->dev;
-- 
2.7.4
