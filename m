Return-path: <abrestic@google.com>
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 1/4] watchdog: imgpdc: Fix NULL pointer dereference on probe
Date: Tue, 31 Mar 2015 11:49:08 -0700
Message-Id: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

pdc_wdt_probe() called pdc_wdt_stop() before watchdog_set_drvdata(),
resulting in the following NULL pointer dereference:

  CPU 0 Unable to handle kernel paging request at virtual address 0000008c, epc == 8082a2b8, ra == 8082a914
  Oops[#1]:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc5+ #102
  task: 8f8c0000 ti: 8f89e000 task.ti: 8f89e000
  $ 0   : 00000000 8082a914 00000000 dc8ba200
  $ 4   : 8faf9418 80ac0000 8f9cdc10 00008012
  $ 8   : 00000000 806e2350 00000001 8f001880
  $12   : 8f89fd14 00000000 00000000 65646f4d
  $16   : 8faf9418 8f9cdc10 8f001880 8f9cdc00
  $20   : 00000000 80c20000 00000000 80bc0000
  $24   : 00000002 00000000
  $28   : 8f89e000 8f89fd00 00000000 8082a914
  Hi    : 0000006b
  Lo    : 00008013
  epc   : 8082a2b8 pdc_wdt_stop+0x1c/0x44
      Not tainted
  ra    : 8082a914 pdc_wdt_probe+0x404/0x550
  Status: 11000403	KERNEL EXL IE
  Cause : 00800008
  BadVA : 0000008c
  PrId  : 0001a120 (MIPS interAptiv (multi))

Fix it by moving the call to pdc_wdt_stop() after we've set drvdata.

Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/watchdog/imgpdc_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index c8def68..c4151cd 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -199,8 +199,6 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 			 "Initial timeout out of range! setting max timeout\n");
 	}
 
-	pdc_wdt_stop(&pdc_wdt->wdt_dev);
-
 	/* Find what caused the last reset */
 	val = readl(pdc_wdt->base + PDC_WDT_TICKLE1);
 	val = (val & PDC_WDT_TICKLE_STATUS_MASK) >> PDC_WDT_TICKLE_STATUS_SHIFT;
@@ -234,6 +232,8 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdc_wdt);
 	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+
 	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
 	if (ret)
 		goto disable_wdt_clk;
-- 
2.2.0.rc0.207.ga3a616c
