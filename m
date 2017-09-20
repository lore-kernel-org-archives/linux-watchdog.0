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
Subject: [PATCH v2 4/4] watchdog: aspeed: Move init to arch_initcall
Date: Wed, 20 Sep 2017 15:00:20 +0930
Message-Id: <20170920053020.6860-5-andrew@aj.id.au>
In-Reply-To: <20170920053020.6860-1-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

Probing at device_initcall time lead to perverse cases where the
watchdog was probed after, say, I2C devices, which then leaves a
potentially running watchdog at the mercy of I2C device behaviour and
bus conditions.

Load the watchdog driver early to ensure that the kernel is patting it
well before initialising peripherals.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/watchdog/aspeed_wdt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 6c6dd3f4c48d..ca5b91e2eb92 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -316,7 +316,18 @@ static struct platform_driver aspeed_watchdog_driver = {
 		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
 	},
 };
-module_platform_driver(aspeed_watchdog_driver);
+
+static int __init aspeed_wdt_init(void)
+{
+	return platform_driver_register(&aspeed_watchdog_driver);
+}
+arch_initcall(aspeed_wdt_init);
+
+static void __exit aspeed_wdt_exit(void)
+{
+	platform_driver_unregister(&aspeed_watchdog_driver);
+}
+module_exit(aspeed_wdt_exit);
 
 MODULE_DESCRIPTION("Aspeed Watchdog Driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0
