Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36190 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbG0Ni2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 09:38:28 -0400
Received: by wicgb10 with SMTP id gb10so112859611wic.1
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2015 06:38:26 -0700 (PDT)
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: [PATCH 4/5] iTCO_wdt: fixup for the header
Date: Mon, 27 Jul 2015 14:38:11 +0100
Message-Id: <1438004292-16382-5-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Prevent nested inclusion of the header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 include/linux/platform_data/iTCO_wdt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/iTCO_wdt.h b/include/linux/platform_data/iTCO_wdt.h
index ce53c2b01f6d..0d4f0e87594f 100644
--- a/include/linux/platform_data/iTCO_wdt.h
+++ b/include/linux/platform_data/iTCO_wdt.h
@@ -3,6 +3,7 @@
  */
 
 #ifndef _ITCO_WDT_H_
+#define _ITCO_WDT_H_
 
 /* Watchdog resources */
 #define ICH_RES_IO_TCO		0
-- 
2.1.0

