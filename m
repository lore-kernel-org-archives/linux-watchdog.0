Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43405 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbcBIKRw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Feb 2016 05:17:52 -0500
Date: Tue, 9 Feb 2016 11:17:48 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/3] watchdog: ts4800: add hardware dependency
Message-ID: <20160209111748.4973e203@endymion>
In-Reply-To: <20160209111549.7e9b4fbb@endymion>
References: <20160209111549.7e9b4fbb@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Technologic Systems TS-4800 is an i.MX515 board, so its drivers
are useless unless building a SOC_IMX51 kernel, except for build
testing purposes.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-4.5-rc3.orig/drivers/watchdog/Kconfig	2016-02-09 08:53:37.465170476 +0100
+++ linux-4.5-rc3/drivers/watchdog/Kconfig	2016-02-09 08:53:45.001221261 +0100
@@ -468,6 +468,7 @@ config NUC900_WATCHDOG
 config TS4800_WATCHDOG
 	tristate "TS-4800 Watchdog"
 	depends on HAS_IOMEM && OF
+	depends on SOC_IMX51 || COMPILE_TEST
 	select WATCHDOG_CORE
 	select MFD_SYSCON
 	help

-- 
Jean Delvare
SUSE L3 Support
