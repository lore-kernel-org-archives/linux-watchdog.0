Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux@roeck-us.net,
	david.paris@st.com,
	a.zummo@towertech.it
Cc: lee.jones@linaro.org,
	kernel@stlinux.com
Subject: [PATCH v6 9/9] MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry
Date: Tue, 24 Mar 2015 09:25:40 +0000
Message-Id: <1427189140-1935-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1427189140-1935-1-git-send-email-lee.jones@linaro.org>
References: <1427189140-1935-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

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
