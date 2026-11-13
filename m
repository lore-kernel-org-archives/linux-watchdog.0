Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576298;
	b=5Pdb1PcmMgR27k7Wm9ZHpR24JEGJOqjJ/hDoGTDa8EUTCnxNbe9UVSVhk5LdSL1QAL9e
	 zOrOUAc3JMpB2KNTQ9Q9hLIhtZjjawSy1pM91c9FY7B3k/8b3h57/ndDppOvymo9gKRV7
	 pR4xa58VcvZ5l8s/ZGWvSVxXfZAqv716bx+ollPb47XeDAgHAlCuTcSKnuWbiwBbm72Ge
	 flLnmmYQ2OsjHe1gxFOfrXMsFKYRz5c+NSv+doM2QTsYhpxNlv1u1vY43WgJ8QxRNGcLR
	 6WbgFlnfbeTgEa7BCqmAVx0ohFLHGnlm/DYvyvIIxGH6zTljaW7/x/PlLTZiKezJKPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6BwyZXaVSatDJOrT+DlVGlFui1bbW5cnZJSxQxMX77g=;
	b=XnHkpZONnTOt8BpGekpK0nAZZRPD1USS2acw3zl9SKX3VkCgs3B8mJKCTAmh/QdN0XMm
	 IVRE4RB+gEQWcBZjnro8abZ28JnUacM0ksfpbQIGHXCCYdpO1vvYMvlqI1iT/dKtxNGPm
	 5lREG+Hqo8Isq8iwGSOcvFptN8Ayqru82RjQcHzt6n/ikmZzTShIs/9lhABffM3PwplGH
	 gyAKKY/R8pPMl3ocuT/XKWqa1eoFyDU1HaNGmD9fcTpOuK0SzR2lVO8zF/h/jzW1CLxjD
	 4DFluvD+T30yeVRTlFKzjeZ6gngEsAgUYrhK8zmV8K0GfJK/dozOT3FfVCGdVDjBcyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZUxX97yu;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BF60A263F
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 13:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972BF60A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZUxX97yu
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so954402f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 05:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576296; x=1795181096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BwyZXaVSatDJOrT+DlVGlFui1bbW5cnZJSxQxMX77g=;
        b=ZUxX97yuSpUty+9W3qiJFCDoHj6G6dandGd3P8qa4TSrcJevnOaoaxawYbRrg2+iXP
         aScHQGOTOlJOFvo00czYB4b09PPDOb+T+V9RSbLZxaa0fjVIagK0IgUT69jkgKNJhTbx
         6/cfm6FSiQB5F7ONn2/y15fQ5KsAVz+zl3jxVnn3R/7rP6clqpXV+1M8WBbgutweJHVh
         d7MouLfvm92/px0Ab9Q4lwgmtVDcb6Wd56bfSULmKO0phfc8r9GgD96GBpgHOYiUaCBO
         kv7PT8HyK/s+iXW1YSfBrHwAGlWV7/SyDcSKWoJLVwP6HYRb8H6xcPmis4pswF6WqOci
         hTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576296; x=1795181096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BwyZXaVSatDJOrT+DlVGlFui1bbW5cnZJSxQxMX77g=;
        b=lfxd6yMB6GGLllxW/HlMljFgI6XgXq7lvX2mTkyNQmHvTlh4nPjRHDiflcwj2rfotx
         siM6vSEHu34tlFrgB39Mc/hTqBb2NlZxn4bdylnZdN/+yLTWctI6l4/UJyLHhGAm62S7
         fXqnwFRHMVcUydR5orrwouy3N7Uqrds0mJmvNBUqDM2YKq5c9s7mQBbrCkhCyN9nQ9Nz
         u5HVV7Ojt07CJYK/DtcvsBoq0s1xRqf4ny9Sf8IVONzdk0NvvKXdic0kXtogZ1xrab1b
         JrmdlWP3k1Ts6ysUpz78T+e9coKDEfnZ4eEpiDzCi1MaZAwQzBU5C5QXBPweng6SY+TX
         otiQ==
X-Forwarded-Encrypted: i=1; AL+hErGOoKyLU6f88tpRTifKJDoUMYt6csdL3JIGYP0MygL85/vkpjtXFcaYgiszr3bCwzwWYC5YVVWngb/3bozCbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/tXi7h8SBi9IW1hGCE/O2frAxtQPW0bdHuPXG9tee5k+nOIEph
	Lv89D7ZSkev6ow8VvzXX8WPW8JZbTxdOGQfSQ2YplRF+Omh4HeyTq98QpzLxTXAyv8g4XQ==
X-Gm-Gg: AYBFou39KjpcKvD10NdORQhyiw83uT11rypLuLBmOd2jWjfYOYVt8xsABQEioIAT3te
	6PIOGY2AVvcu15iB8+1GlyQtY3M//csX1iyZmhZdH3coGthb6fIvgmwwTkjCIENmZGP7JxBrqxK
	jyZnRIUqfX/zhAroXb079rzvFACM//1WlGzfjX7M+otWqqh7sc0BRAbOqhnsmFHAKvcNIXDQI8s
	eqUuaHSSTLYz7NpyB4cCjJ5JL/4ewCbKmUCk12lOc/6U6xqiQ0ZNTaxRupm1yzCINpRchXxn4U+
	/CbNFX/NtHynlWxkk66+MAC6cV7/x1Fm/5EEsQI1z7godPMM2CgBwMc9q2fx7hoWwl8DBtPRQ9U
	78boIH1sMsizGqOmkPhRDMn5jCr5yl65oEv3bsGo/jbKCYQ8viQhVebzPiSRYYqIX9mgKZiZ7dg
	rLPsgOuqmNEALCCrievM1GNe1hvhcOzs9vN23yGjsGPdb0TfxkkdS8PEpMovG5qoByotF3gBzej
	XQnu4GfbseZ89HNWkq7duGv1xvqnJQJzujxEs4Ag2JvDH3nob1wetvqDfbDuftGcgrFemErCu0K
	9/BF311gFp0DWP0q8v7vjPmeP8GmNVGRVjnCt3EZdBZOykMpqpI4IxdZmh+8lpy41AXrVjwA9Fh
	TynA7wZQ=
X-Received: by 2002:a05:6000:4a08:b0:48c:49bd:62df with SMTP id ffacd0b85a97d-49c6d63fbc3mr5457891f8f.1.1794576295782;
        Fri, 13 Nov 2026 05:24:55 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d66esm4680211f8f.57.2026.11.13.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:24:55 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 13 Nov 2026 17:24:41 +0400
Subject: [PATCH v7 2/4] clocksource/drivers/timer-vt8500: Prepare for
 watchdog functionality
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-vt8500-timer-updates-v7-2-a1dcc4031b12@gmail.com>
References: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
In-Reply-To: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8797; i=alchark@gmail.com;
 h=from:subject:message-id; bh=5DdTPTv9ZzwJsaVqiqLCcCVuOHUAj1GkaRC43w/zm68=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9518w8+i5yqfT+vsvGOxOjP3yoefKld097NoCp64fX
 /SyvuViaMcEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTvVqB4Z91368/oReCvGIV/9rbBG+svrLCp7T3xYzd/95a9f3St7Bg+DH3lN1
 T4R6L8vf5cWqHdtyuPflUap4Np2DvHbmJXJ1mTAA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

VIA/WonderMedia system timer can generate a watchdog reset when its
clocksource counter matches the value in the match register 0 and
watchdog function is enabled. For this to work, obviously the clock event
device must use a different match register (1~3) and respective interrupt.

Check if at least two interrupts are provided by the device tree, then use
match register 1 for system clock events and reserve match register 0 for
the watchdog. Keep match register 0 for clock events on device trees that
list a single interrupt, and offer no watchdog there.

Instantiate the watchdog as an auxiliary device of the timer from a
platform driver bound to the timer node, as the timer itself comes up too
early to have a struct device. Share what the watchdog needs through a new
header, include/clocksource/vt8500-timer.h.

Unmap the registers if the timer interrupt is missing, so that no watchdog
gets created on a timer whose counter never started.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 MAINTAINERS                        |   1 +
 drivers/clocksource/Kconfig        |   1 +
 drivers/clocksource/timer-vt8500.c | 127 ++++++++++++++++++++++++++++++++++---
 include/clocksource/vt8500-timer.h |  22 +++++++
 4 files changed, 142 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7070cf5dbfe9..e8c2b1101b68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4010,6 +4010,7 @@ F:	drivers/tty/serial/vt8500_serial.c
 F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
+F:	include/clocksource/vt8500-timer.h
 
 ARM/ZTE ZX29 SOC SUPPORT
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index da83483296d5..d060863fcc07 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -197,6 +197,7 @@ config TEGRA186_TIMER
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
+	select AUXILIARY_BUS
 	help
 	  Enables support for the VT8500 driver.
 
diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index c4694cf8bea6..b54ed5d692d7 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -11,6 +11,7 @@
  * Alexey Charkov. Minor changes have been made for Device Tree Support.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -21,9 +22,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
-#define VT8500_TIMER_OFFSET	0x0100
-#define VT8500_TIMER_HZ		3000000
+#include <clocksource/vt8500-timer.h>
 
 #define TIMER_MATCH_REG(x)	(4 * (x))
 #define TIMER_COUNT_REG		0x0010	 /* clocksource counter */
@@ -53,6 +54,9 @@
 
 static void __iomem *regbase;
 
+/* Which match register to use for the system timer */
+static unsigned int sys_timer_ch;
+
 static u64 vt8500_timer_read(struct clocksource *cs)
 {
 	int loops = msecs_to_loops(10);
@@ -72,21 +76,26 @@ static struct clocksource clocksource = {
 	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 vt8500_timer_next(u64 cycles)
+{
+	return clocksource.read(&clocksource) + cycles;
+}
+
 static int vt8500_timer_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
 	int loops = msecs_to_loops(10);
-	u64 alarm = clocksource.read(&clocksource) + cycles;
+	u64 alarm = vt8500_timer_next(cycles);
 
-	while (readl(regbase + TIMER_ACC_STS_REG) & TIMER_ACC_WR_MATCH(0) &&
-	       --loops)
+	while (readl(regbase + TIMER_ACC_STS_REG) &
+	       TIMER_ACC_WR_MATCH(sys_timer_ch) && --loops)
 		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_REG(0));
+	writel((unsigned long)alarm, regbase + TIMER_MATCH_REG(sys_timer_ch));
 
 	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
 		return -ETIME;
 
-	writel(TIMER_INT_EN_MATCH(0), regbase + TIMER_INT_EN_REG);
+	writel(TIMER_INT_EN_MATCH(sys_timer_ch), regbase + TIMER_INT_EN_REG);
 
 	return 0;
 }
@@ -128,16 +137,29 @@ static int __init vt8500_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
-	timer_irq = irq_of_parse_and_map(np, 0);
+	/*
+	 * The watchdog function is available on channel 0, but not on other
+	 * channels. So to use it, the clock event device must use a different
+	 * match register (1~3) and respective interrupt.
+	 *
+	 * Check if at least two interrupts are provided by the device tree,
+	 * then use match register 1 for system clock events and reserve match
+	 * register 0 for the watchdog.
+	 */
+	sys_timer_ch = of_irq_count(np) > 1 ? 1 : 0;
+
+	timer_irq = irq_of_parse_and_map(np, sys_timer_ch);
 	if (!timer_irq) {
 		pr_err("%s: Missing irq description in Device Tree\n",
 								__func__);
+		iounmap(regbase);
+		regbase = NULL;
 		return -EINVAL;
 	}
 
 	writel(TIMER_CTRL_ENABLE, regbase + TIMER_CTRL_REG);
 	writel(TIMER_STATUS_CLEARALL, regbase + TIMER_STATUS_REG);
-	writel(~0, regbase + TIMER_MATCH_REG(0));
+	writel(~0, regbase + TIMER_MATCH_REG(sys_timer_ch));
 
 	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
 	if (ret) {
@@ -163,4 +185,91 @@ static int __init vt8500_timer_init(struct device_node *np)
 	return 0;
 }
 
+static void vt8500_timer_aux_uninit(void *data)
+{
+	auxiliary_device_uninit(data);
+}
+
+static void vt8500_timer_aux_delete(void *data)
+{
+	auxiliary_device_delete(data);
+}
+
+static void vt8500_timer_aux_release(struct device *dev)
+{
+	struct vt8500_wdt_info *wdt_info;
+	struct auxiliary_device *auxdev;
+
+	auxdev = container_of(dev, struct auxiliary_device, dev);
+	wdt_info = container_of(auxdev, struct vt8500_wdt_info, auxdev);
+	kfree(wdt_info);
+}
+
+/*
+ * This probe gets called after vt8500_timer_init(), which leaves regbase set
+ * only once the clocksource counter is running: that counter and match
+ * register 0 are all the watchdog needs, even if registering the clocksource
+ * or the clock event device failed afterwards. Create the watchdog device as
+ * a child, since the registers are shared.
+ */
+static int vt8500_timer_probe(struct platform_device *pdev)
+{
+	struct vt8500_wdt_info *wdt_info;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (!regbase)
+		return dev_err_probe(dev, -ENODEV,
+				     "Timer not initialized, cannot create watchdog\n");
+
+	if (!sys_timer_ch) {
+		dev_info(dev, "Not enabling watchdog: only one irq was given\n");
+		return 0;
+	}
+
+	wdt_info = kzalloc_obj(*wdt_info);
+	if (!wdt_info)
+		return -ENOMEM;
+
+	wdt_info->timer_next = &vt8500_timer_next;
+	wdt_info->regbase = regbase;
+	wdt_info->auxdev.name = "vt8500-wdt";
+	wdt_info->auxdev.dev.parent = dev;
+	wdt_info->auxdev.dev.release = &vt8500_timer_aux_release;
+
+	ret = auxiliary_device_init(&wdt_info->auxdev);
+	if (ret) {
+		kfree(wdt_info);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, vt8500_timer_aux_uninit,
+				       &wdt_info->auxdev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(&wdt_info->auxdev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, vt8500_timer_aux_delete,
+					&wdt_info->auxdev);
+}
+
+static const struct of_device_id vt8500_timer_of_match[] = {
+	{ .compatible = "via,vt8500-timer", },
+	{},
+};
+
+static struct platform_driver vt8500_timer_driver = {
+	.probe  = vt8500_timer_probe,
+	.driver = {
+		.name = "vt8500-timer",
+		.of_match_table = vt8500_timer_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(vt8500_timer_driver);
+
 TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/include/clocksource/vt8500-timer.h b/include/clocksource/vt8500-timer.h
new file mode 100644
index 000000000000..956863d50d02
--- /dev/null
+++ b/include/clocksource/vt8500-timer.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef CLOCKSOURCE_VT8500_TIMER_H_
+#define CLOCKSOURCE_VT8500_TIMER_H_
+
+#include <linux/auxiliary_bus.h>
+#include <linux/types.h>
+
+#define VT8500_TIMER_HZ		3000000
+
+/**
+ * struct vt8500_wdt_info - timer resources shared with the watchdog
+ * @auxdev: auxiliary device the watchdog driver binds to
+ * @timer_next: returns the clocksource counter value @cycles from now
+ * @regbase: timer register block; the watchdog uses match register 0
+ */
+struct vt8500_wdt_info {
+	struct auxiliary_device auxdev;
+	u64 (*timer_next)(u64 cycles);
+	void __iomem *regbase;
+};
+
+#endif /* CLOCKSOURCE_VT8500_TIMER_H_ */

-- 
2.56.0

