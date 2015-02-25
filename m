Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:34357 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbBYNwn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 08:52:43 -0500
Received: by wesq59 with SMTP id q59so3773576wes.1
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 05:52:42 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Cc: lee.jones@linaro.org, kernel@stlinux.com
Subject: [PATCH v4 1/9] mfd: dt-bindings: Provide human readable defines for LPC mode choosing
Date: Wed, 25 Feb 2015 13:52:21 +0000
Message-Id: <1424872349-4155-2-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ST's Low Power Controller can currently operate in two supported modes;
Watchdog and Real Time Clock.  These defines will aid engineers to easily
identify the selected mode.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/mfd/st-lpc.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/dt-bindings/mfd/st-lpc.h

diff --git a/include/dt-bindings/mfd/st-lpc.h b/include/dt-bindings/mfd/st-lpc.h
new file mode 100644
index 0000000..e3e6c75
--- /dev/null
+++ b/include/dt-bindings/mfd/st-lpc.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides shared DT/Driver defines for ST's LPC device
+ *
+ * Copyright (C) 2014 STMicroelectronics -- All Rights Reserved
+ *
+ * Author: Lee Jones <lee.jones@linaro.org> for STMicroelectronics
+ */
+
+#ifndef __DT_BINDINGS_ST_LPC_H__
+#define __DT_BINDINGS_ST_LPC_H__
+
+#define ST_LPC_MODE_RTC		0
+#define ST_LPC_MODE_WDT		1
+
+#endif /* __DT_BINDINGS_ST_LPC_H__ */
-- 
1.9.1

