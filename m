Return-path: <abrestic@google.com>
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 3/4] watchdog: imgpdc: Set timeout before starting watchdog
Date: Tue, 31 Mar 2015 11:49:10 -0700
Message-Id: <1427827751-19705-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

Set up the watchdog for the specified timeout before attempting to start it.

Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/watchdog/imgpdc_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index f3f65ac..aef3596 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -106,6 +106,8 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	unsigned int val;
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
 
+	pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
+
 	val = readl(wdt->base + PDC_WDT_CONFIG);
 	val |= PDC_WDT_CONFIG_ENABLE;
 	writel(val, wdt->base + PDC_WDT_CONFIG);
-- 
2.2.0.rc0.207.ga3a616c
