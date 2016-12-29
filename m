Return-path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: orion: fix spelling mistake: "harcoded" -> "hardcoded"
Date: Thu, 29 Dec 2016 21:49:18 +0000
Message-Id: <20161229214918.28526-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in WARN message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c6b8f4a..39be4dd 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -395,7 +395,7 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
 
 	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
 
-	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
+	WARN(1, FW_BUG "falling back to hardcoded RSTOUT reg %pa\n", &rstout);
 	return devm_ioremap(&pdev->dev, rstout, 0x4);
 }
 
-- 
2.10.2
