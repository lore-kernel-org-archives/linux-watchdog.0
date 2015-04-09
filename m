Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38876 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbbDIOr5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Apr 2015 10:47:57 -0400
Received: by wiun10 with SMTP id n10so101095408wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2015 07:47:56 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, a.zummo@towertech.it, david.paris@st.com
Subject: [PATCH v7 9/9] MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry
Date: Thu,  9 Apr 2015 15:47:34 +0100
Message-Id: <1428590854-14095-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6239a30..2bc71e7 100644
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

