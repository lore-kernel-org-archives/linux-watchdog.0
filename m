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
Subject: [PATCH v2 3/4] watchdog: aspeed: Remove specific reference to AST2400 in Kconfig
Date: Wed, 20 Sep 2017 15:00:19 +0930
Message-Id: <20170920053020.6860-4-andrew@aj.id.au>
In-Reply-To: <20170920053020.6860-1-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

The driver also supports the watchdog in the AST25xx series, and
may work on earlier SoCs as well.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b562d2e03eb9..a1b92ebe74b6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -741,7 +741,7 @@ config RENESAS_RZAWDT
 	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
 
 config ASPEED_WATCHDOG
-	tristate "Aspeed 2400 watchdog support"
+	tristate "Aspeed BMC watchdog support"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
-- 
2.11.0
