Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43156 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720AbbCDSHB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 13:07:01 -0500
Received: by wibhm9 with SMTP id hm9so9497755wib.2
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Mar 2015 10:06:59 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Subject: [PATCH v5 9/9] MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry
Date: Wed,  4 Mar 2015 18:06:38 +0000
Message-Id: <1425492398-27340-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
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

