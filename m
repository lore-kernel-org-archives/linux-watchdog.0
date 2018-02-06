Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwright@hpe.com,
	maurice.a.saldivar@hpe.com,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 07/10] watchdog/hpwdt: Select WATCHDOG_CORE
Date: Tue,  6 Feb 2018 15:58:52 -0700
Message-Id: <20180206225855.30582-8-jerry.hoemann@hpe.com>
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Update Kconfig file to show that hpwdt now selects WATCHDOG_CORE.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6a602f70aaa4..4d219c3fa8b4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1108,6 +1108,7 @@ config IT87_WDT
 
 config HP_WATCHDOG
 	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
+	select WATCHDOG_CORE
 	depends on X86 && PCI
 	help
 	  A software monitoring watchdog and NMI sourcing driver. This driver
-- 
2.13.6
