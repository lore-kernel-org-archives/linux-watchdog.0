Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948232D617
	for <linux-watchdog@vger.kernel.org>; Sun, 17 May 2026 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778993934; cv=none; b=tRbryXIiashEL6WmtzaDTNiEeYl8vMRoGAVo8K7PDZPGGIA6LPr1CWrZg6UutPw9KXjpCMMci0hUhe//7d7dJylLwNV7uLFFNUAhcdq1fAENGagP7N2ldTOadHcJn08q4rLx/hX9OffuNk0tBfjj4k09u5k2m8pMqKCGL1gGGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778993934; c=relaxed/simple;
	bh=3Y/ExQHmpM874sXJzRTs7GT3T+TDmiYeO3BxiHRitrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYI1gqYIkVT4NnWUysYpPORVHpJVahnK8pOWJAjByTu2sXnhY3vMs7JuHi3d+9ofuwv/wbWgBgXKwPRzsebDeiStM1jexS0D3BfWeVYeAqFhgc0NGnZE3x1me2VsZK8Exi5/OrJMDxIVa9gEc1PhgX6XCQV6on7UT2GEQ83PySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og1+yK8Z; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og1+yK8Z"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso533003eec.1
        for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778993932; x=1779598732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68fzEAsJ3Cm+QlWLkcdWbs0tKgQSxg21Abj5S1Q5CD4=;
        b=Og1+yK8ZkxOWWF00ctxFNMpCThS3KEBKsNV22iCVuBZH02Sb8R2Zqyxi4Bj8L0s8OJ
         5sXkJ6gRYfYYet/ljJcmY9839/Sosi0FIjW7ZTlnef62wofdAxeuVXQqwh7x9QQL3bgJ
         /T6axN5SRWh9pkylTJeN+TI+uqzd+iyx4pPFmPv0lleSTzZIFrFJeRE7GQDm44P+OZX0
         kjkI1OXkLVB1pySGNw6WfSy7f6/Yc1FLM+aEbTU75svEqGtQFNCY21KjVW56djqpn+ep
         Et2J9pQbQGMD/zYw2AO/1cjeTahyQ1oEkBDhdpUCglGxXMilFKlitH52qtXPRHYxH9+O
         W/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778993932; x=1779598732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68fzEAsJ3Cm+QlWLkcdWbs0tKgQSxg21Abj5S1Q5CD4=;
        b=SlU9XhtSHL2kT30YsNdbZQ1n7VOijh38EVlhLOB+Axvs/qU3FHcsZzSiwwbqFHrD4K
         sAdtoNROcoXgOxvIjyVD11qgSReah16LdwJSXkEeBjRFh00DcBySRU6xmrrasuG5EOmK
         riMG6Op91+JkQjAWgbWFj55ISXN0FM5TxxfNcx0ab/QlTo9pJuN1kaCO/3zM9Igi1nrv
         OTyBi8AXxAadVSjO2Ye/N6BUAI3xgNwthp41MBlFwI7j26x168j8QLNrUjI5eCPAgZ/R
         d4lCazclmImX7MDp2sFzPAOcLUqOHTzt0jHIwNhpP4MEKxHVaCC9W2b7pAOdlBnS4jpA
         KINw==
X-Forwarded-Encrypted: i=1; AFNElJ9ADgPTBlToRiFEqet9DWCsVXxCgo8CFFDPJX47e8FR9m12FGIGkWKQRegual2bHt6kBfr8RKCKKLcaADKmPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2l1Z03HonUMf8jmcCZaImid3Tvix+c6d616T9lTSysNFZmmtY
	kh10KRD0IQ5gRwH+x5sf8kHYJ0Zg3nLjxXbstw/z/pFHqW4NlZiYptxndqJOgJnOPdE=
X-Gm-Gg: Acq92OGoYaoG5/j/JplykN3lyJ5uB/FhL8vWAFovPnMKxbeJ9HZUxe61aZHHjhouE/c
	/CsWrk9A1SNWtnWzNDQOfTp3oRQfzYQpm6N791Gh7QaMlZndQe7q1o50yWcgT4WYRqm5bUYtezM
	jCeS21z/gegWfskBPGDAGFYwjuLBRJvcFl3E31tKlVRlcyPY2kr6+vAFM18brH0UMAINF+82iln
	twI1TQ5aX9uJ5eNfFbPs1uZEniETx41mOWgcgvwuzDntQ9X6jlvfx90IXAGqSSKBGXwsG8lNlpb
	kzySdQLCw3yol4WOwIqTvFBRCJyHinbirbkytqjihq5Hb2BXr0wTiiIIfkcl+pyNPVKOwR5ckoB
	LWsXaA8bxPfCNyKsAsJR82h+KN09GcdaH/MDA2K3Tp4Wfan/vjuN3EygZ8rodGfQPmhbtQJxeIf
	3lf4IL1ecqeaYtMRomQ0bqU6R3nrF0Orp+qiO7MbB/6i85DD010yZ+Jyn7R7sakbsfI90/GlcLt
	KrdQFobRGaabaBgNGBtcmWMNf7HiOT2hVG9OSlci4bvnT7FzgLyJLehAbmGmhGSiV4ADsKDJ6a3
	ZAfP32pPa3ibck1SqMXg5XRP8krb
X-Received: by 2002:a05:7300:a888:b0:2f0:ee2:f6c6 with SMTP id 5a478bee46e88-30262b43a2bmr5609138eec.19.1778993931514;
        Sat, 16 May 2026 21:58:51 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e6a9sm10931848eec.2.2026.05.16.21.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 21:58:51 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ARM: Move Footbridge-specific header into mach-footbridge
Date: Sat, 16 May 2026 21:57:39 -0700
Message-ID: <20260517045804.345657-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/arm/include/asm/hardware/dec21285.h is specific to the DC21285
Footbridge chip and should not be in the global ARM include directory.
Move it into mach-footbridge where it belongs. It was included twice in
arch/arm/mach-footbridge/common.c; remove one of the includes.
Also remove the file path from the header (it is bad style and would
become outdated) and add missing include guards.

Tested by compiling footbridge_defconfig and netwinder_defconfig,
modified to additionally enable CONFIG_MTD_DC21285 and
CONFIG_DEBUG_FOOTBRIDGE_COM1 or CONFIG_DEBUG_DC21285_PORT, respectively
(these are the only Footbridge-related options not enabled by the
defconfigs).

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
This patch depends on my previous patch "ARM: clean up machine-specific
PCI code and move it into mach-footbridge" because it touches the same
area of arch/arm/mach-footbridge/dc21285.c.

 MAINTAINERS                                               | 1 -
 arch/arm/include/debug/dc21285.S                          | 2 +-
 arch/arm/mach-footbridge/common.c                         | 3 +--
 arch/arm/mach-footbridge/dc21285-timer.c                  | 2 +-
 arch/arm/mach-footbridge/dc21285.c                        | 2 +-
 arch/arm/mach-footbridge/dma-isa.c                        | 2 +-
 arch/arm/mach-footbridge/ebsa285.c                        | 2 +-
 .../hardware => mach-footbridge/include/mach}/dec21285.h  | 8 +++++---
 arch/arm/mach-footbridge/isa-irq.c                        | 2 +-
 arch/arm/mach-footbridge/isa.c                            | 2 +-
 arch/arm/mach-footbridge/netwinder-hw.c                   | 2 +-
 drivers/char/nwflash.c                                    | 2 +-
 drivers/mtd/maps/dc21285.c                                | 2 +-
 drivers/tty/serial/21285.c                                | 2 +-
 drivers/watchdog/wdt285.c                                 | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)
 rename arch/arm/{include/asm/hardware => mach-footbridge/include/mach}/dec21285.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..37ecfe4bc4e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2811,7 +2811,6 @@ M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/dec21285.h
 F:	arch/arm/mach-footbridge/
 
 ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
diff --git a/arch/arm/include/debug/dc21285.S b/arch/arm/include/debug/dc21285.S
index 4ec0e5e31704..c0eb58ba7d7e 100644
--- a/arch/arm/include/debug/dc21285.S
+++ b/arch/arm/include/debug/dc21285.S
@@ -7,7 +7,7 @@
  *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
 */
 
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 #include <mach/hardware.h>
 	/* For EBSA285 debugging */
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 85c598708c10..d3076bf03875 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -20,7 +20,6 @@
 #include <asm/mach-types.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
-#include <asm/hardware/dec21285.h>
 
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
@@ -30,7 +29,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 static int dc21285_get_irq(void)
 {
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 2908c9ef3c9b..f5d0024783e3 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -14,7 +14,7 @@
 
 #include <asm/irq.h>
 
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/mach/time.h>
 #include <asm/system_info.h>
 
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 5a68b6739ecf..923c808e8ba1 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -19,7 +19,7 @@
 
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 #include "pci.h"
 
diff --git a/arch/arm/mach-footbridge/dma-isa.c b/arch/arm/mach-footbridge/dma-isa.c
index 937f5376d5e7..300cdf6ef223 100644
--- a/arch/arm/mach-footbridge/dma-isa.c
+++ b/arch/arm/mach-footbridge/dma-isa.c
@@ -19,7 +19,7 @@
 
 #include <asm/dma.h>
 #include <asm/mach/dma.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 #define ISA_DMA_MASK		0
 #define ISA_DMA_MODE		1
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 1cb7d674bc81..93ab333e3027 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/leds.h>
 
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/mach-footbridge/include/mach/dec21285.h
similarity index 98%
rename from arch/arm/include/asm/hardware/dec21285.h
rename to arch/arm/mach-footbridge/include/mach/dec21285.h
index 894f2a635cbb..35d10e2dcade 100644
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ b/arch/arm/mach-footbridge/include/mach/dec21285.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/hardware/dec21285.h
- *
  *  Copyright (C) 1998 Russell King
  *
  *  DC21285 registers
  */
+
+#ifndef __MACH_DEC21285_H
+#define __MACH_DEC21285_H
+
 #define DC21285_PCI_IACK		0x79000000
 #define DC21285_ARMCSR_BASE		0x42000000
 #define DC21285_PCI_TYPE_0_CONFIG	0x7b000000
@@ -135,4 +137,4 @@
 #define TIMER_CNTL_DIV256	(2 << 2)
 #define TIMER_CNTL_CNTEXT	(3 << 2)
 
-
+#endif /* __MACH_DEC21285_H */
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
index 842ddb4121ef..f9231e84028d 100644
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ b/arch/arm/mach-footbridge/isa-irq.c
@@ -21,7 +21,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
index 84caccddce44..a028920e8f12 100644
--- a/arch/arm/mach-footbridge/isa.c
+++ b/arch/arm/mach-footbridge/isa.c
@@ -8,7 +8,7 @@
 #include <linux/serial_8250.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index c024eefd4978..bd21c455a495 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/leds.h>
 
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index 9f52f0306ef7..21ac9b2df42e 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -29,7 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <linux/uaccess.h>
diff --git a/drivers/mtd/maps/dc21285.c b/drivers/mtd/maps/dc21285.c
index 70a3db3ab856..8bcb40489f4f 100644
--- a/drivers/mtd/maps/dc21285.c
+++ b/drivers/mtd/maps/dc21285.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/partitions.h>
 
 #include <asm/io.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <asm/mach-types.h>
 
 
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 4de0c975ebdc..f20c2092e4a5 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -18,7 +18,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/system_info.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 #include <mach/hardware.h>
 
 #define BAUD_BASE		(mem_fclk_21285/64)
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 78681d9f7d53..347cb2892833 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -30,7 +30,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/system_info.h>
-#include <asm/hardware/dec21285.h>
+#include <mach/dec21285.h>
 
 /*
  * Define this to stop the watchdog actually rebooting the machine.
-- 
2.43.0

