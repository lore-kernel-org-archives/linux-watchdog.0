Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:48524 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbAVL5R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 06:57:17 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so931462ieb.2
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Jan 2015 03:57:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v2 9/9] MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry
Date: Thu, 22 Jan 2015 11:56:07 +0000
Message-Id: <1421927767-28889-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..7060aa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1439,10 +1439,12 @@ F:	drivers/phy/phy-stih407-usb.c
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

