Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576300;
	b=ITND3MClpmWxdmcjCQrP+5OUDqgi4jxcVc0HluKA1cxipCNusKGVY4Prqc8mC05Jg+kN
	 3zzmUDwFi5YbeGGaZnaI4nqjfBhqH2GFCYnqO8DwFGwB/APl1whlO3eCKzaoOoNiH4hmW
	 GW/2erIUO8RjY0t690C0nVg5hYYKTcA0d2+vf3MUw0uIk0EuCOMgDQQoKVbP6oztizQQk
	 iOEwn4XaSjmqibZET7aLekJa5OY7wbMNVALnw9j/4RkDCorxukyejBkoqfWamlaHcshxp
	 F0lBXQ1SubmZXxnCdcMF4R+WVrGXisGnFcCgrWPl2/ZBaPd6llzq10ORWnUlPPHtHlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tjOZX/K6WuuHANRm5zaWFMNlF3ieqw+28w/8fCcYL6g=;
	b=TuK69ffr7HEFNv2kOBmfU91S7+Cwabrap0i4RfLslP1HUk/RLxDardfaJHaJdRnm+e6d
	 40AKdEstpuQfemtDgf90KDsB3+BitZgInqb8Bm3An4QO4K1Jo3zwIzz1avXzElrasY2r2
	 jLb7Zs+kNELanu0vH3GGe8MAFSZykuUSUtqV9N/whDlrflOxKDqNVeQQ7v0K3IzjxxcFf
	 5oNN0iJjfKk8qhGuqQ9Ijxw1+816qLC2s3BR6/iISLAUQiMl/QoLb6sJqhhJX4mbOBmce
	 JWF9z1OJTxALmcIthiEcOdGk9F6ecH7J7YhAfo71/n0Gx/PMpDsJYpgWck39pzj/37w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h32/ZlP1";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D62606B56A
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 13:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D62606B56A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h32/ZlP1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so472081f8f.3
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576298; x=1795181098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjOZX/K6WuuHANRm5zaWFMNlF3ieqw+28w/8fCcYL6g=;
        b=h32/ZlP1Wo92vWWTAbHSZwYOKzXRLUdaDNH5i/YNEzAzZ4buK3QWOfXL+whWvweJgC
         qT1/S09g5mfyKy6wUyX2MDgdYQprsY4v+tIY2x5+1thtY9PLfX3tphe0D2p978V5DMqv
         gO9xG7hlfF3u2uY6okeAtfqFSx7C3dedPrnFMctMYJ7yTZshEYMIUO1pcZ482MgtDgYb
         //iAYihhcMH8b3fXt/k5H4WjtSTLuIWI41azg1szIzB6urAfgTWnKkepMFP7HQo0zkso
         dajZCdaCgcabyEbcM9mhwvHmPEqk23uMIRQdtEF6nT7omDwSC1aBpSJadUtubDLSJuL+
         cnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576298; x=1795181098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjOZX/K6WuuHANRm5zaWFMNlF3ieqw+28w/8fCcYL6g=;
        b=ZyBy64pCR3L00MAjhxvm+6CMHPw6/9dlYiAtEztioVYNLcbnSFZyg31i9LyNVengFK
         BIXHc5t15Hc5WkfsoBE/ptqM+XY6bpQ2+3kqkISfp0cUV/OUim0cRul3lh+kDV3f2eyo
         5sMYbzwIsOM1rbb9vG7T2aBvMBHojeRodPSeFhZKwWAFVu7+LCYDT8S++aOu0eV8Zxjl
         ovdbdPvYmN9VO6TI5KPH366UYAvyK8bHjrB+lETvLWdw9hC+tdlLs2j5optzzt1A8+CT
         gwVrTeBKZx1EZO720W7EAHLab7YjzCsw5c+1+i+7gOjqMBvybCTZ8otChdxHI1PzQLtA
         PeoA==
X-Forwarded-Encrypted: i=1; AL+hErFELz9DQnKsaDaVNyVyMVWr472OlI6GMCsXdGjt0pBKHhaGtnotkY8GTENp9yLJfhqi1qhJmamH4AVWPnfP8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+j+gzEJ2k2zI9mJbluxTn8I3H4imuB1QVR/sDhfQWqOiDUPEL4
	634Ol7keB0evWtfgIZIlSvXPGKpujS18zugdlGyUszHNUxfXvtFZ2MbB
X-Gm-Gg: AYBFou3pwXOni0EwSVhuh1m/62YzX/caL9JdlduISROZF1+JmAqY46MQ8sZik9RKWlu
	3B7f2gAjOLnmlKdfS1SI4lKFPAqkxH89NpazFNZ2RsIMj9dIqVKPmCekOBH44FAZDGOniqUR3c6
	LNsJrj1DAeIBQWMYVtpPgFXsDHx1iRKOIkrq8KDD/X42dfTDJMcnUa0fHZ9RNUL0TptCD0boMxA
	Lmmu/BsFWtxDsd9H122jHkO+QYteUaQyqGILjfbImtxRbgEFfZ85yvTNTv00eh88uNGFAomUvek
	sH3yxh0ltl/Y9RmuIhoDB0zn1qc/1BXTmbvJDXwqi86ln9u9Q55Dobrb0tchXnBUUmUd4fDCDR4
	aEwfMHkDTPTe/RML1N03rJ0nyfSlp3mwfZLaiO/fUSWZmuJvKPzrVTAozN8err8bONRD3XhFYtI
	qGafc4jToi9HPScYI+McqYWmNUAGcMVKL8szlEs7xE20adLJkF4mvK/xNF3f1ttP+61IatK2xPx
	OgAHIfxp08pssELoEcFblCXi0Pt02jQSfRzZrWyDFdf6FgFmgIOVAPg53eeKMQyAW7CvuMA/Plh
	48G86WwzwaQp242V/j/O5ON3PPG9msEgI/f9Tpdi8BFpfwwUf95N7MNWDAhuatRwYVDN
X-Received: by 2002:a05:6000:2311:b0:48d:ffe7:e883 with SMTP id ffacd0b85a97d-49c741b1371mr6012548f8f.46.1794576298236;
        Fri, 13 Nov 2026 05:24:58 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d66esm4680211f8f.57.2026.11.13.05.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:24:57 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 13 Nov 2026 17:24:42 +0400
Subject: [PATCH v7 3/4] watchdog: Add support for VIA/WonderMedia SoC
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vt8500-timer-updates-v7-3-a1dcc4031b12@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7950; i=alchark@gmail.com;
 h=from:subject:message-id; bh=hyWHvc0h3BNHC+IYNfkAcOOw1wzOzOaIDKO9cWPzNvA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9519gFZe/do7rxqneGrHZ/JNmPFy0+WO72/LJp/bqf
 t7lwTMvpmMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp7pnPyPBocqxM5Nk3Et+jt/YWzfOITuS81mnP/29ZcW9lxrPN6XkMv1m/v5j
 7Q+bp2Wszlu9iCfls1XKH0TBipefWWcv/1S/ZXMoLAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

VIA/WonderMedia SoCs can use their system timer's first channel as a
watchdog device which will reset the system if the clocksource counter
matches the value given in its match register 0 and if the watchdog
function is enabled.

Since the watchdog function is tightly coupled to the timer itself, it
is implemented as an auxiliary device of the timer device. Build it in
rather than as a module, as the timer it depends on is always built in
and the driver is tiny.

Report a watchdog found running at probe, as one armed before a kexec
would be, so that the core keeps it fed until userspace takes over.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 Documentation/watchdog/watchdog-parameters.rst |   7 ++
 MAINTAINERS                                    |   1 +
 drivers/watchdog/Kconfig                       |  12 +++
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/vt8500-wdt.c                  | 132 +++++++++++++++++++++++++
 5 files changed, 153 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 348229ffcb43..27453b659545 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -637,6 +637,13 @@ uniphier_wdt:
 
 -------------------------------------------------
 
+vt8500_wdt:
+    nowayout:
+	Watchdog cannot be stopped once started
+	(default=kernel config parameter)
+
+-------------------------------------------------
+
 w83627hf_wdt:
     wdt_io:
 	w83627hf/thf WDT io port (default 0x2E)
diff --git a/MAINTAINERS b/MAINTAINERS
index e8c2b1101b68..73039535eba2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4010,6 +4010,7 @@ F:	drivers/tty/serial/vt8500_serial.c
 F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
+F:	drivers/watchdog/vt8500-wdt.c
 F:	include/clocksource/vt8500-timer.h
 
 ARM/ZTE ZX29 SOC SUPPORT
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c884f86be4e3..a252f9c9c2c8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1183,6 +1183,18 @@ config SUNPLUS_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sunplus_wdt.
 
+config VT8500_WATCHDOG
+	bool "VIA/WonderMedia VT8500 watchdog support"
+	depends on ARCH_VT8500 || COMPILE_TEST
+	select WATCHDOG_CORE
+	select AUXILIARY_BUS
+	help
+	  VIA/WonderMedia SoCs can use their system timer as a hardware
+	  watchdog, as long as the first timer channel is free from other
+	  uses and respective function is enabled in its registers. To
+	  make use of it, say Y here and ensure that the device tree
+	  lists at least two interrupts for the VT8500 timer device.
+
 # X86 (i386 + ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 19cb25f51624..5a5a111b4815 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
 obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
 obj-$(CONFIG_GUNYAH_WATCHDOG) += gunyah_wdt.o
 obj-$(CONFIG_MA35D1_WDT) += ma35d1_wdt.o
+obj-$(CONFIG_VT8500_WATCHDOG) += vt8500-wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/vt8500-wdt.c b/drivers/watchdog/vt8500-wdt.c
new file mode 100644
index 000000000000..e0f838fd1d50
--- /dev/null
+++ b/drivers/watchdog/vt8500-wdt.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: 2026 Alexey Charkov <alchark@gmail.com>
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/moduleparam.h>
+#include <linux/stringify.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#include <clocksource/vt8500-timer.h>
+
+/* Offsets within the timer register block */
+#define VT8500_WDT_MATCH_REG	0x0000	/* timer match register 0 */
+#define VT8500_WDT_EN_REG	0x0018
+#define VT8500_WDT_EN		BIT(0)
+#define VT8500_WDT_ACC_STS_REG	0x0024	/* timer access status */
+#define VT8500_WDT_ACC_WR_MATCH	BIT(0)	/* match register 0 write pending */
+
+#define VT8500_WDT_DEFAULT_TIMEOUT	30	/* seconds */
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
+
+/* Arm the watchdog to reset the SoC @cycles counter ticks from now */
+static int vt8500_watchdog_arm(struct vt8500_wdt_info *info, u64 cycles)
+{
+	u32 deadline, sts;
+	int ret;
+
+	/* Let a previous match write settle, as the timer driver does */
+	ret = readl_poll_timeout_atomic(info->regbase + VT8500_WDT_ACC_STS_REG,
+					sts, !(sts & VT8500_WDT_ACC_WR_MATCH),
+					1, 10000);
+	if (ret)
+		return ret;
+
+	/*
+	 * The deadline is matched against the hardware clocksource counter,
+	 * which is a u32 value incrementing at VT8500_TIMER_HZ and continuing
+	 * past wraparound. When the return value of timer_next is greater than
+	 * U32_MAX then the match should occur after the hardware counter wraps
+	 * around, thus we take only the lower 32 bits of timer_next return val
+	 */
+	deadline = info->timer_next(cycles);
+	writel(deadline, info->regbase + VT8500_WDT_MATCH_REG);
+	writel(VT8500_WDT_EN, info->regbase + VT8500_WDT_EN_REG);
+
+	return 0;
+}
+
+static int vt8500_watchdog_start(struct watchdog_device *wdd)
+{
+	struct vt8500_wdt_info *info = watchdog_get_drvdata(wdd);
+	u32 timeout_ms = min(wdd->timeout * 1000, wdd->max_hw_heartbeat_ms);
+
+	return vt8500_watchdog_arm(info,
+				   (u64)timeout_ms * (VT8500_TIMER_HZ / 1000));
+}
+
+static int vt8500_watchdog_stop(struct watchdog_device *wdd)
+{
+	struct vt8500_wdt_info *info = watchdog_get_drvdata(wdd);
+
+	writel(0, info->regbase + VT8500_WDT_EN_REG);
+
+	return 0;
+}
+
+static const struct watchdog_ops vt8500_watchdog_ops = {
+	.start			= vt8500_watchdog_start,
+	.stop			= vt8500_watchdog_stop,
+};
+
+static const struct watchdog_info vt8500_watchdog_info = {
+	.identity		= "VIA VT8500 watchdog",
+	.options		= WDIOF_MAGICCLOSE |
+				  WDIOF_KEEPALIVEPING |
+				  WDIOF_SETTIMEOUT,
+};
+
+static int vt8500_wdt_probe(struct auxiliary_device *auxdev,
+			    const struct auxiliary_device_id *id)
+{
+	struct vt8500_wdt_info *info;
+	struct watchdog_device *wdd;
+
+	wdd = devm_kzalloc_obj(&auxdev->dev, *wdd);
+	if (!wdd)
+		return -ENOMEM;
+
+	wdd->info = &vt8500_watchdog_info;
+	wdd->ops = &vt8500_watchdog_ops;
+	wdd->min_timeout = 1;
+	wdd->timeout = VT8500_WDT_DEFAULT_TIMEOUT;
+	wdd->max_hw_heartbeat_ms = U32_MAX / (VT8500_TIMER_HZ / 1000);
+	wdd->parent = &auxdev->dev;
+
+	info = container_of(auxdev, struct vt8500_wdt_info, auxdev);
+	watchdog_set_drvdata(wdd, info);
+	watchdog_set_nowayout(wdd, nowayout);
+
+	/* Let the core feed a watchdog left running, e.g. across kexec */
+	if (readl(info->regbase + VT8500_WDT_EN_REG) & VT8500_WDT_EN)
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+
+	return devm_watchdog_register_device(&auxdev->dev, wdd);
+}
+
+static const struct auxiliary_device_id vt8500_wdt_ids[] = {
+	{ .name = "timer_vt8500.vt8500-wdt" },
+	{}
+};
+
+static struct auxiliary_driver vt8500_wdt_driver = {
+	.name =	"vt8500-wdt",
+	.probe = vt8500_wdt_probe,
+	.id_table = vt8500_wdt_ids,
+	.driver = {
+		/* Unbinding would leave the hardware armed with no one to ping */
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_driver(vt8500_wdt_driver, auxiliary_driver_register);

-- 
2.56.0

