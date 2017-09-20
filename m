Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>,
	wim@iguana.be,
	linux@roeck-us.net,
	joel@jms.id.au,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-aspeed@lists.ozlabs.org,
	ryan_chen@aspeedtech.com
Subject: [PATCH v2 2/4] watchdog: aspeed: Fix 'Apseed' typo in Kconfig
Date: Wed, 20 Sep 2017 15:00:18 +0930
Message-Id: <20170920053020.6860-3-andrew@aj.id.au>
In-Reply-To: <20170920053020.6860-1-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

Apseed sounds like a good name for a web/mobile start-up incubator, but
isn't a reflection of Aspeed themselves.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c722cbfdc7e6..b562d2e03eb9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -746,7 +746,7 @@ config ASPEED_WATCHDOG
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
-	  in Apseed BMC SoCs.
+	  in Aspeed BMC SoCs.
 
 	  This driver is required to reboot the SoC.
 
-- 
2.11.0
