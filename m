Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:43378 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbBYNw5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 08:52:57 -0500
Received: by wesu56 with SMTP id u56so3718237wes.10
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 05:52:56 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Cc: lee.jones@linaro.org, kernel@stlinux.com
Subject: [PATCH v4 9/9] MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry
Date: Wed, 25 Feb 2015 13:52:29 +0000
Message-Id: <1424872349-4155-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..19af007 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1461,10 +1461,12 @@ F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/reset/sti/
+F:	drivers/rtc/rtc-st-lpc.c
 F:	drivers/tty/serial/st-asc.c
 F:	drivers/usb/dwc3/dwc3-st.c
 F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
+F:	drivers/watchdog/st_lpc_wdt.c
 F:	drivers/ata/ahci_st.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
-- 
1.9.1

