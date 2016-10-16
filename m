Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp486.redcondor.net ([208.80.204.86]:47335 "EHLO
        smtp486.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbcJPMP4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Oct 2016 08:15:56 -0400
Received: from astoria.ccjclearline.com ([64.235.106.9])
          by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
          via TCP (outbound) with ESMTPS id 20161016121132842_0486
          for <linux-watchdog@vger.kernel.org>;
          Sun, 16 Oct 2016 12:11:32 +0000
Received: from [174.118.92.171] (port=60154 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1bvkHn-00055S-08
        for linux-watchdog@vger.kernel.org; Sun, 16 Oct 2016 08:11:27 -0400
Date: Sun, 16 Oct 2016 08:10:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: Standardize leading tabs and spaces in Kconfig
 file
Message-ID: <alpine.LFD.2.20.1610160808580.25776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Replace small number of lines using leading spaces with proper leading
tabs and spaces -- purely an aesthetic fix.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fdd3228..97bf4c2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -72,16 +72,16 @@ config SOFT_WATCHDOG
 	  module will be called softdog.

 config DA9052_WATCHDOG
-        tristate "Dialog DA9052 Watchdog"
-        depends on PMIC_DA9052
-        select WATCHDOG_CORE
-        help
-          Support for the watchdog in the DA9052 PMIC. Watchdog trigger
-          cause system reset.
+	tristate "Dialog DA9052 Watchdog"
+	depends on PMIC_DA9052
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the DA9052 PMIC. Watchdog trigger
+	  cause system reset.

-          Say Y here to include support for the DA9052 watchdog.
-          Alternatively say M to compile the driver as a module,
-          which will be called da9052_wdt.
+	  Say Y here to include support for the DA9052 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called da9052_wdt.

 config DA9055_WATCHDOG
 	tristate "Dialog Semiconductor DA9055 Watchdog"
@@ -1623,16 +1623,16 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
 	  The value can be overridden by the wdt_period command-line parameter.

 config MEN_A21_WDT
-       tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
-       select WATCHDOG_CORE
-       depends on GPIOLIB || COMPILE_TEST
-       help
-        Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
+	tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
+	select WATCHDOG_CORE
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.

-	The driver can also be built as a module. If so, the module will be
-	called mena21_wdt.
+	  The driver can also be built as a module. If so, the module will be
+	  called mena21_wdt.

-	If unsure select N here.
+	  If unsure select N here.

 # PPC64 Architecture


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

