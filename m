Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554380;
	b=mqv5T94PScKPquW/YfIONNaNA6Ayv/0avJnOxx6lXVSwnjWI5N5ZxZT9I4cdvwMsotyj
	 cFScd5fWoA7Ccl2a4fRagsE/EwlcWYWeBAWY+AEtT8F32QbcmflBMtXkxWjpk3f45R/et
	 z9KNnCtZpDWD47X3OPtvPNsez8TAmShousBLciO3S1Tf0CBtVY6cRR/QL5YdYngDVT80i
	 HNVZyar0fAXXhhOr4Ca23AwHEvLCAW2wY/VNDuZSLjsv3vFJ+77MwMiFjt7YqR7+Fyo3n
	 lx4qRnuzDSOrQSWApK8swq+OqvGb5sdJJ8o1zPG3PG0rOAZwMRaSY9tyVpy3zBXrUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ji5DBvHMt9pEPGCAjXMKV7F4pZO8U3K9gVXBlfCjXhU=;
	b=gTtbHk8EXO5PKDRDZJ1hL4P6njcZYpr9pFVR+TsmZ+0ibaeHHWpPttic3+0iFvFwxZlq
	 j+h9dnLDK7tEfcA9/2+7mRw+2+AnaynG59I5sB++i6zUcr0khergV2MjmyqOWpf2c3xqj
	 guseDsHcdfqsxHyYzGAFbAoWmjtPNuCwJWxuB7rPYgtibOECeiKgPsztWyKKTjw8PGXVR
	 01wkjlGm00DWcnwSz+wqbUr1O3qlIpGxyPiZsEuVrTYRih1F/xPa9khW+Jaxk7yJ0lVoJ
	 e5i0txQ2MTD8fcgMPO6NOcQFod7Odn43iJZ/19rlmaNu4u22fy6RAenOdJima3KVvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmRHwFwT;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9119606A338
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 21:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9119606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmRHwFwT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bccecba199so4855933e87.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554378; x=1796159178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ji5DBvHMt9pEPGCAjXMKV7F4pZO8U3K9gVXBlfCjXhU=;
        b=OmRHwFwTSawmkAFTR+o9w8xLXrxw7BfrpxHcwbaPH2om110faqBJfdN3CDbluszpla
         MCCatk5dE0MmP31YcqDqerFj7VzrSmeoQ6UgRoURqgJbg3tvTLPK3sSHdU/txDIRzCu4
         /GDjSoJKo/n24GC5G2O3xTy2o1Jtjv7zVzLyAuBAJv9beFIE1vfwsOt7NyBDlWl2262K
         3jpc5jYMz3F0/PWkbQMuGx027L6vwwl4AYy7Ust8JJ1H86hY7MfeHndyAAgKBq8YT6Xx
         RYm0U9a09PQznO/2YrgqaRGylyoTDIPFFo5eISmZgxcqnYgRxiuzqEN8CegtQ1Uz5d3X
         DXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554378; x=1796159178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ji5DBvHMt9pEPGCAjXMKV7F4pZO8U3K9gVXBlfCjXhU=;
        b=D/gS6NS0M+Q4a7/oQazDPdGparvfrM4VklAHV70rrPS1ZUuBXlYnGB4fCb9NXR6ZFt
         nrO9VMWY5jarT4lVHk2c6C9CxjAxTznuX1dIqo6wdBcZ3+DhKbdAiZ17nTSjRzQuFxYZ
         Sn+om6zBwrcM5GB7t/5JOx3QDDPMgVTT8qfIzM6FqDezswbsFb8QOil5RUbjv6m50SgZ
         /T021xE8zohFhnCfnvhu+pN0jAGJcSm/rz/IRn9QsJx3NUIgvBwb2ktC2n3B1lOkE5a/
         fKxnJDUjLZ3W1yDiVf0AiZsyjooL2CeGfgdV5+RAFGjZXZT97ne5oq1Han7RMYaBk7Mz
         6Lcg==
X-Forwarded-Encrypted: i=1; AL+hErEbKrsAsfNSz1+4iU31uW+Wte3Hkocu5DM2cOYlgswAiLPUXffMpdiQTf6iLdjZvNkeV6IbmrQL4rFIpv3rLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VuMcIXJW6NOqoJ5dWfII44FEGR2Y14SUWeykt3v0aW2NcavM7
	l9TKBoLdK6oSwIlhhyvr7E3CkU5rs0eNVa5YNHdXqL70+Tc6OQJl+RZOHBccbTn3
X-Gm-Gg: AZFdTZe0/i6VMf6BQPHH3PvOenLoQSCeXxqNlwigBukGfZ5FHQZ+TMPqN968Mhwdanx
	zjb97/6rG4MVbnK0VZrwD5N4VybchMQVXbEO8BaFOd3Bfpg57keYr8eVJqPuL7Fl8oc4TQGK9oC
	v3DzJOn1cjLxQc4Q+XX19K0R6JMDoBoEVvRUMV4wrM0GCbGI1m91mJjTkX2bJLHSQGeRf5ysZOY
	E+5useaqtvYPvgyGjiahowSK1d9yf6u3U/tE1PMDOivgyLzktD2/4CtUMCvOedN/j4tftVS71zf
	cyIeWKpjV8RqCTSq30XgWdww00bvwk3SwYV6smmxuDoLPCrmldjz36qNp0SriSIGLqLO3wzbx2Z
	o3foGksCncGNwKCre/VJJn5nbzfqnIlu/+k6J7iilGryiXPL+MIOrCQGDWkEC1rUfKvbIxRnoJg
	HpcdYPXCB7wJGtC4e3Zqa4trETmHU6MGC7CoV8Z32qpLe7rKWgo8WTkFZyaPSrxKVHx3sY62kJG
	D6+MXrJV/xpLSyn2OZN2/YhGlD1Vno9NSPX952ZQ1B/J4K2gTuCLNRcchgx9EyC0+gYaELhhXhA
	tDi1LWaQ3CNXu7mnfB5inFjG9N7ZYLQroqrgo9ZjDBwp/HJlSYG3sUuwGC4FPQ==
X-Received: by 2002:a05:6512:6886:20b0:5c1:57f6:2a55 with SMTP id 2adb3069b0e04-5c1bc7c3c66mr3363374e87.22.1795554377996;
        Tue, 24 Nov 2026 13:06:17 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd041813sm4099045e87.53.2026.11.24.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:06:17 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 24 Nov 2026 22:06:00 +0100
Subject: [PATCH v2 2/6] clk: tegra20: Add watchdog reset control helpers
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
Message-Id: <20261124-t20-for-upstream-v2-2-440116846f97@gmail.com>
References: <20261124-t20-for-upstream-v2-0-440116846f97@gmail.com>
In-Reply-To: <20261124-t20-for-upstream-v2-0-440116846f97@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, 
 clamor95@gmail.com, Artur Kowalski <arturkow2000@gmail.com>, 
 linux-clk@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=+8ECPpoBhBW0hO7OEab5QMQVuU3PE8Uce0sGxdle7g4=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQzbrHyeRq/9eFy1l7my/tM1WqGl1Z97lTWrt5WLJtTJck
 53fVWp1lLIwiHExyIopspg9FPrCM8/r/YaXWzth5rAygQxh4OIUgIkw/WX47x8tyL+yytPIy11a
 Kfvdl/hrn3zd8jPyLZO0PT8mGgvPZmS4XB5k9yasIFor3eenj+i31uqLax4F7PLmZFsh/rxibj8
 7AA==
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

Tegra20 has no watchdog block. Instead, the clock and reset controller
can reset the system when the interrupt of timer 1 or 2 fires while the
previous one is still pending, which is enabled through its RST_SOURCE
register. The clock driver doesn't use this register otherwise.

Export helpers to enable and disable this reset with timer 1, and to
check whether a bootloader left it enabled, so that a watchdog driver
doesn't have to map the controller's registers behind its back. The
read-modify-write of RST_SOURCE is serialized by a spinlock of its own.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 60 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/tegra.h       | 16 +++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 9da82dd7965ba..4b2e0e4540a5c 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -17,6 +17,13 @@
 #include "clk.h"
 #include "clk-id.h"
 
+#define RST_SOURCE 0x0
+#define RST_SOURCE_WDT_EN BIT(5)
+#define RST_SOURCE_WDT_SEL_TMR2 BIT(4)
+#define RST_SOURCE_WDT_SYS_RST_EN BIT(2)
+#define RST_SOURCE_WDT_MASK (RST_SOURCE_WDT_EN | RST_SOURCE_WDT_SEL_TMR2 | \
+			     RST_SOURCE_WDT_SYS_RST_EN)
+
 #define MISC_CLK_ENB 0x48
 
 #define OSC_CTRL 0x50
@@ -132,6 +139,8 @@ static struct cpu_clk_suspend_context {
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
+static DEFINE_SPINLOCK(rst_source_lock);
+
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, NULL, NULL, _parents, _offset,	\
@@ -1164,6 +1173,57 @@ static void __init tegra20_clock_init(struct device_node *np)
 }
 CLK_OF_DECLARE_DRIVER(tegra20, "nvidia,tegra20-car", tegra20_clock_init);
 
+/**
+ * tegra20_clk_watchdog_enable() - enable or disable the watchdog reset
+ * @enable: whether to enable the reset
+ *
+ * Tegra20 has no watchdog block. Instead, the clock and reset controller can
+ * reset the system when the interrupt of timer 1 or 2 fires while the previous
+ * one is still pending, which is enabled through the RST_SOURCE register. This
+ * enables it with timer 1.
+ *
+ * Return: 0 on success, or -ENODEV if the clock and reset controller isn't
+ * Tegra20's.
+ */
+int tegra20_clk_watchdog_enable(bool enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!clk_base)
+		return -ENODEV;
+
+	spin_lock_irqsave(&rst_source_lock, flags);
+
+	val = readl(clk_base + RST_SOURCE);
+	val &= ~RST_SOURCE_WDT_MASK;
+	if (enable)
+		val |= RST_SOURCE_WDT_EN | RST_SOURCE_WDT_SYS_RST_EN;
+	writel(val, clk_base + RST_SOURCE);
+
+	spin_unlock_irqrestore(&rst_source_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra20_clk_watchdog_enable);
+
+/**
+ * tegra20_clk_watchdog_is_enabled() - check whether the watchdog reset is enabled
+ *
+ * A bootloader may leave the watchdog reset enabled for the kernel to take it
+ * over.
+ *
+ * Return: true if the watchdog reset is enabled, false otherwise.
+ */
+bool tegra20_clk_watchdog_is_enabled(void)
+{
+	if (!clk_base)
+		return false;
+
+	return readl(clk_base + RST_SOURCE) & RST_SOURCE_WDT_EN;
+}
+EXPORT_SYMBOL_GPL(tegra20_clk_watchdog_is_enabled);
+
 /*
  * Clocks that use runtime PM can't be created at the tegra20_clock_init
  * time because drivers' base isn't initialized yet, and thus platform
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index f1034e14c1a44..2c88b9c78d88d 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_CLK_TEGRA_H_
 #define __LINUX_CLK_TEGRA_H_
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/bug.h>
 
@@ -195,6 +196,21 @@ tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
 }
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+int tegra20_clk_watchdog_enable(bool enable);
+bool tegra20_clk_watchdog_is_enabled(void);
+#else
+static inline int tegra20_clk_watchdog_enable(bool enable)
+{
+	return -ENODEV;
+}
+
+static inline bool tegra20_clk_watchdog_is_enabled(void)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_TEGRA124_CLK_EMC
 void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
 				    tegra124_emc_complete_timing_change_cb *complete_cb);

-- 
2.56.1

