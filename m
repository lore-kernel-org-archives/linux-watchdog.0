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
Subject: [PATCH 3/7] watchdog: s3c2410: Enable COMPILE_TEST
Date: Fri, 24 Feb 2017 23:07:42 +0200
Message-Id: <20170224210746.12459-3-krzk@kernel.org>
In-Reply-To: <20170224210746.12459-1-krzk@kernel.org>
References: <20170224210746.12459-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Driver can be compile tested on other architectures as well so use it to
increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 338c5bc46f73..82d5f07b5e64 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -333,7 +333,7 @@ config HAVE_S3C2410_WATCHDOG
 
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
-	depends on HAVE_S3C2410_WATCHDOG
+	depends on HAVE_S3C2410_WATCHDOG || COMPILE_TEST
 	select WATCHDOG_CORE
 	select MFD_SYSCON if ARCH_EXYNOS
 	help
-- 
2.9.3
