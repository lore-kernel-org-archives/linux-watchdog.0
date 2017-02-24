Return-path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/7] watchdog: s3c2410: Select MFD_SYSCON on all Exynos platforms
Date: Fri, 24 Feb 2017 23:07:41 +0200
Message-Id: <20170224210746.12459-2-krzk@kernel.org>
In-Reply-To: <20170224210746.12459-1-krzk@kernel.org>
References: <20170224210746.12459-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Syscon is used not only on Exynos5 SoCs but also on Exynos3250,
Exynos4412 and ARMv8 versions (Exynos5433, Exynos7).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index acb00b53a520..338c5bc46f73 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -335,7 +335,7 @@ config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
 	depends on HAVE_S3C2410_WATCHDOG
 	select WATCHDOG_CORE
-	select MFD_SYSCON if ARCH_EXYNOS5
+	select MFD_SYSCON if ARCH_EXYNOS
 	help
 	  Watchdog timer block in the Samsung SoCs. This will reboot
 	  the system when the timer expires with the watchdog enabled.
-- 
2.9.3
