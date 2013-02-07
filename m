Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34147 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030249Ab3BGUTT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Feb 2013 15:19:19 -0500
Date: Thu, 7 Feb 2013 21:19:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Alan Cox <alan@linux.intel.com>
Subject: Re: INTEL_SCU_WATCHDOG is orphaned
Message-ID: <20130207201917.GQ7867@spo001.leaseweb.com>
References: <20121125172447.6baf4115522107d5396bc780@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121125172447.6baf4115522107d5396bc780@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Kernel symbol X86_MRST has been removed from the kernel.
> INTEL_SCU_WATCHDOG driver can never be compiled due dependence of X86_MRST
> which remained in the drivers/watchdog/Kconfig.
> Unfortunately, I do not know the right decision on this issue and just want
> to draw the attention of developers to it.
> Thanks!

I added below fix for this issue.

Kind regards,
Wim.
---
commit 5a6e917801729dd8368a5f829438074e1cf010ca
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Feb 7 21:14:36 2013 +0100

    watchdog: intel_scu_watchdog: fix Kconfig dependency
    
    Kernel symbol X86_MRST has been removed from the kernel.
    INTEL_SCU_WATCHDOG driver can never be compiled due dependence of X86_MRST
    which remained in the drivers/watchdog/Kconfig.
    
    Reported-by: Alexander Shiyan <shc_work@mail.ru>
    Cc: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52d83f4..af54904 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -583,7 +583,7 @@ config IE6XX_WDT
 
 config INTEL_SCU_WATCHDOG
 	bool "Intel SCU Watchdog for Mobile Platforms"
-	depends on X86_MRST
+	depends on X86_INTEL_MID
 	---help---
 	  Hardware driver for the watchdog time built into the Intel SCU
 	  for Intel Mobile Platforms.
