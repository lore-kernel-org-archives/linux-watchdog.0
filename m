Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mhqmail.moxa.com ([59.124.42.180]:7557 "EHLO mhqmail01.moxa.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754167Ab1DZKnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Apr 2011 06:43:37 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Subject: RE: [PATCH 1/2] watchdog: add option in menu to support MOXA V2100 watchdog driver
Date: Tue, 26 Apr 2011 18:32:10 +0800
Message-ID: <ECB3782BB8F03341905DD923270296115F6AD9@mhqms01.moxa.com>
In-Reply-To: <ECB3782BB8F03341905DD923270296115F6AD7@mhqms01.moxa.com>
From: =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>
To: =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<wim@iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Jimmy Chen <jimmy.chen@moxa.com>

Add selection and help in menu to support watchdog driver

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1b0f98b..224dc9d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -384,6 +384,18 @@ config ADVANTECH_WDT
 	  feature. More information can be found at
 	  <http://www.advantech.com.tw/products/>
=20
+config MOXA_SWTD
+	tristate "MOXA V2100 WATCHDOG driver"
+	depends on X86
+	default n
+	help
+	  If you say yes here you get support for the MOXA V2100 watchdog
+	  driver.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called moxa_swtd. More information can be found at
+	  <http://www.moxa.com>
+
 config ALIM1535_WDT
 	tristate "ALi M1535 PMU Watchdog Timer"
 	depends on X86 && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3f8608b..df04622 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_BFIN_WDT) +=3D bfin_wdt.o
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) +=3D acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) +=3D advantechwdt.o
+obj-$(CONFIG_MOXA_SWTD)	+=3D moxa_swtd.o
 obj-$(CONFIG_ALIM1535_WDT) +=3D alim1535_wdt.o
 obj-$(CONFIG_ALIM7101_WDT) +=3D alim7101_wdt.o
 obj-$(CONFIG_F71808E_WDT) +=3D f71808e_wdt.o
diff --git a/drivers/watchdog/moxa_swtd.c b/drivers/watchdog/moxa_swtd.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/watchdog/moxa_swtd.h b/drivers/watchdog/moxa_swtd.h
new file mode 100644
index 0000000..e69de29
--
To unsubscribe from this list: send the line "unsubscribe=20
linux-kernel" in the body of a message to majordomo@vger.kernel.org=20
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
