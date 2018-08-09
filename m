Return-Path: <paul@crapouillou.net>
Return-path: <paul@crapouillou.net>
From: Paul Cercueil <paul@crapouillou.net>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Malaterre <malat@debian.org>,
	Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 07/24] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date: Thu,  9 Aug 2018 23:43:57 +0200
Message-Id: <20180809214414.20905-8-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
List-ID: <linux-watchdog@vger.kernel.org>

Add myself as maintainer for the ingenic-timer and ingenic-ost drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change

 v3: No change

 v4: No change

 v5: Update with new files

 v6: No change

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cebd5bba8a8..cf5fbc777bb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7074,6 +7074,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/jz4780_*
 
+INGENIC TCU driver
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clocksource/ingenic-ost.c
+F:	drivers/clocksource/ingenic-timer.c
+F:	drivers/clocksource/ingenic-timer.h
+F:	include/linux/mfd/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0
