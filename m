Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314367;
	b=qKC4nxP2jCW+xIMjajo/LK+EtQQ07iT4hQFOa4dfpPgxDMH3K2IU00gnFoGvI/TL64RN
	 n0SI8VIiDr5bff+9OWu9f6gFwkTvh8MZ907AuHekL30us6gXGbY8j4M5qrKAGwe9m/CJe
	 rCuwHIf8a6AKac1HsuzM1J5Tw8ZbbCZgHhfKsoiG3g/09UfFEGYAiJ6JMTN4yudCvMkAU
	 ya6UKOIZRN6WANqq0q223rsaUs9MlTbcoCw7dfTfmz4auh3B87FUe2wmTuihRXKG5GSK+
	 BDqzh0Yc3rruOyK0WeTmTryT0Y4VmzTpi6zV1GfSaIN3gDRhaKhvZHbEoSGbuDOjHnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tMC8EGofaq7T5ry8RVT9J8t2/iZrN9dz+SRZa/MGrjE=;
	b=k1oaIQdgdqTseRj2L/lB+eG+fsvQhJi22SQcVKYDq9AFK8PmsbqvZSnvJ0/aTfn5N7Vi
	 ZoxD+9lNC2VmV5lmfQofsM7On2aaGqNRvVmDXDeUIa8fKaXVuEANZgT70IPvrPBaTKg/K
	 BpsFbXyOm59CMXMEKTZdlvhenXBYVqmgeoa9mPDqMaIHcH0+Yr/PwG6nZuhFOLCGt3kFL
	 TH5NYSVUfhc/dVa/ED7nBV4SPC/ac1IGzKhdG82iVR3c1il6yrDmXYc7czHD1mXWnEw0e
	 uQAX2AaUu3GhWUQV5VVwBt8mSRfpOzgwm5OT9khdaEXgCW1Z5o/5Tu/wYpbPDnQVoFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdShT5mr;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A460A3836
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 12:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428A460A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdShT5mr
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so1284082f8f.3
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314366; x=1794919166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tMC8EGofaq7T5ry8RVT9J8t2/iZrN9dz+SRZa/MGrjE=;
        b=mdShT5mrp5jJNanyuEppUWJIl2u1ANKzgTF2B3IYw2t5t905hi9jh+FO813qtWYrgL
         2O4vxBmZtw9DHp84w6vnLDFn4wrF7jy+n8AkuOvx1UKrVSfHG53yk8fadyOWbYkHuo5D
         9UDOCM/8LgmOmOu43TrWh4sGI8Y9XuND9eepOenmK+nb7Eiy5WJqcbUwLP22/yCjePgQ
         hUic7Mtqtvm94aqWRhRra+lzawq+36IBGLwv7+mjC2yGSYxMmLPO/sIPtOc7TfWPnOrF
         7J3YiQGNzQ/YqTmuvDz5r90VnrG7Wy7hBgwbqyj+9swjv5/bDCzSb2TtM4X3x52X4QLs
         tgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314366; x=1794919166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMC8EGofaq7T5ry8RVT9J8t2/iZrN9dz+SRZa/MGrjE=;
        b=0FAkEChBGZwH2tMs3dzySX9INXamXeY1TSlqXTXhIKd/DYvne226odElsVnUBNrxrM
         sRqG8c6TZjEB7QziN0cs8ZDt6P6hOk1WXfn7qEHdxFF1grWlpnNd6JxyBPSZ1pxiU97f
         OZ98SgQ3lu/NAVnq1QsaokoFu4RjvZ6InxhjM0RgI5te7XLE2JTTbMxY7gZSnK3hK7+k
         pBKkbjND4h2jwv4M5e1l0A9U377F3D49GqMQ3fF0VDs49vrNVI6IPr6xOPVjzrYchcP5
         pDoXXyoNM3gk+4bxiXiqklG3k1ox1GytPn4GHD0ftsnj31Rlg1VRpivWR4rWzD/CxcXt
         DlPw==
X-Forwarded-Encrypted: i=1; AL+hErHNJ4yeadyBz5TKmCx1at6fd9d9NkmoGVr8Q09sjFzevvSoehaEd5Zrv0j1+X2Ewknj/SLWtSd6StQCiRQqwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kme0lPGIqKMYx+XHejTYSKm4VLKZKpLPVaraE5Zz838XY4mX7
	soKyjv//G/UjhDJJGvZMfIxjNl/kUR3Hv3XO0mWm6znvwGEnbAqDFiox
X-Gm-Gg: AYBFou0F9UMWneABlNLhZ9uCWu+4J3599yIz52i3+N3QOYQ2g4Xwvwd5VYWZ03trFi9
	9I1RZJVvWxvgOvXumlDmS1zhQVi8G4mIn+JbZvJo9qURllfRJZAwWrDJmV+KT1lEKEkRlY+nybE
	dKTqS4BpPSKmbbaW8AgaSfFcTWWrsfJOrQx/2le/8PYRqMbSZ0YLvdjRAEyuJPrJMBhiOu2odsE
	esWqmU97R81M+WVeqfaujYxii43TctZeXhj7uHakZ5f8WZDROXY0Qz6mMIUW3TNMmNsT+EnNinr
	tKcKAwQfSlfakRRYv89EKBa/AWxhZXvac06TlWrHwcxK2Al/P3KE05er1m3lo/cbN6eLDV0Je9s
	XtTK6emvxBWHNSAH8b83P9MLnO7PYjXDezbnYOLWTVQroWNKXYGWaj3B6ySyYEdmzO4bsDjRRME
	OUp9Q8aJSXJZkEA0/5aGKhNAqnUjuSeIb6s8pPaJ8tdsV3zorNL6n5mCfbGP1VnXLhwrNrZYJwN
	tdrgS/ilaqMrhN3SA7zNxYxmJ2yBYdtaWnmG5LWH9511JV7i3yTw8MZxe7J3G0EOIG3tZCkgeYN
	mKYHlwgUnPr7TphjkoDH5XMpk1/vQqd4Bg3nxNwo
X-Received: by 2002:a05:6000:46da:b0:492:7969:b4d2 with SMTP id ffacd0b85a97d-498308b98bfmr3018884f8f.40.1794314365416;
        Tue, 10 Nov 2026 04:39:25 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm5050033f8f.38.2026.11.10.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:39:24 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 10 Nov 2026 13:39:11 +0100
Subject: [PATCH 6/6] watchdog: tegra_wdt: Stop on Tegra20 VDE power off
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
Message-Id: <20261110-t20-for-upstream-v1-6-5923449951fe@gmail.com>
References: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
In-Reply-To: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, 
 clamor95@gmail.com, Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9546;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=n0wxVat+z1yCXWm8xKBK+6Td9OvyeLIKDcb98Fw/Kjc=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQ9ZngaIVAUcUfSXEtDqUhNkv8fum8tnYH1zbPXWRyYP8K
 JPpL9o6SlkYxLgYZMUUWcweCn3hmef1fsPLrZ0wc1iZQIYwcHEKwEQ44hgZtnEkTlh0k/+3nFXI
 jB16HXUT264LG3jltrx7tEBWWXTbL0aG2SuEYpxOL3mT+aWsvvxd8OVFppor5+3RNJt6Lkykue4
 vBwA=
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

A watchdog reset doesn't reset the PMC, and Tegra20's boot ROM hangs
after it if the VDE power partition is off. Unless booted with
tegra_pmc.vde_always_on=1, the PMC driver powers the partition off when
it registers it, and genpd powers it off whenever the VDE is idle. A
watchdog started by the bootloader can still catch hangs early during
boot, before that happens.

Register a PMC partition power off notifier to stop the watchdog, and
the watchdog core's pings, before the VDE partition is powered off for
the first time. If the partition is already off, a watchdog left
running by the bootloader is stopped instead of taken over. Afterwards
the watchdog refuses to start with -EBUSY, as a reset would hang, even
if the partition is powered on again. If the notifier can't be
registered, the driver warns and keeps the watchdog running.

Stopping is the default. With tegra_pmc.vde_always_on=1, the partition
is never powered off, so the watchdog stays usable. Booting with
tegra_wdt.stop_on_vde_off=0 also keeps it usable, but at the risk of the
system hanging instead of rebooting.

The watchdog operations and the notifier share a mutex, as the notifier
runs outside of the watchdog core's locking.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
 Documentation/watchdog/watchdog-parameters.rst |   5 +
 drivers/watchdog/tegra_wdt.c                   | 143 +++++++++++++++++++++++--
 2 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 348229ffcb43..3f7a1831c5cb 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -600,6 +600,11 @@ tegra_wdt:
     nowayout:
 	Watchdog cannot be stopped once started
 	(default=kernel config parameter)
+    stop_on_vde_off:
+	Tegra20: stop the watchdog for good when the VDE partition is
+	powered off, as a reset would hang the boot ROM. Booting with
+	tegra_pmc.vde_always_on=1 keeps the partition, and with it the
+	watchdog, usable (default=1)
 
 -------------------------------------------------
 
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 7c2c21f90de5..d36310c50f78 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -14,6 +16,8 @@
 #include <linux/stringify.h>
 #include <linux/watchdog.h>
 
+#include <soc/tegra/pmc.h>
+
 /* minimum and maximum watchdog trigger timeout, in seconds */
 #define MIN_WDT_TIMEOUT			1
 #define MAX_WDT_TIMEOUT			255
@@ -86,7 +90,12 @@ struct tegra_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*wdt_regs;
 	void __iomem		*tmr_regs;
-	void __iomem		*rst_source;	/* Tegra20 only */
+
+	/* Tegra20 only */
+	void __iomem		*rst_source;
+	struct notifier_block	powergate_nb;
+	struct mutex		lock;		/* hardware and vde_off */
+	bool			vde_off;
 };
 
 struct tegra_wdt_soc {
@@ -109,6 +118,21 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 	__stringify(WATCHDOG_NOWAYOUT) ")");
 
+/*
+ * After a watchdog reset, Tegra20's boot ROM hangs if the VDE partition is
+ * powered off, which the PMC driver does when it registers the partition,
+ * unless booted with tegra_pmc.vde_always_on=1. By default, the watchdog is
+ * therefore only used until the partition is powered off for the first time,
+ * which still allows a watchdog started by the bootloader to catch hangs early
+ * during boot. tegra_pmc.vde_always_on=1 keeps the watchdog usable for good.
+ * Clearing this keeps it usable as well, but at the risk of the system
+ * hanging instead of rebooting.
+ */
+static bool stop_on_vde_off = true;
+module_param(stop_on_vde_off, bool, 0);
+MODULE_PARM_DESC(stop_on_vde_off,
+	"Tegra20: stop the watchdog for good when the VDE partition is powered off (default=1)");
+
 static int tegra_wdt_start(struct watchdog_device *wdd)
 {
 	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -222,10 +246,9 @@ static int tegra30_wdt_init(struct platform_device *pdev, struct tegra_wdt *wdt,
 	return 0;
 }
 
-static int tegra20_wdt_start(struct watchdog_device *wdd)
+static void __tegra20_wdt_start(struct tegra_wdt *wdt)
 {
-	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
-	u32 period = wdd->timeout * USEC_PER_SEC / 2;
+	u32 period = wdt->wdd.timeout * USEC_PER_SEC / 2;
 	u32 val;
 
 	writel(TIMER_EN | TIMER_PERIODIC | (period - 1),
@@ -241,13 +264,10 @@ static int tegra20_wdt_start(struct watchdog_device *wdd)
 	val &= ~T20_RST_SOURCE_WDT_MASK;
 	val |= T20_RST_SOURCE_WDT_EN | T20_RST_SOURCE_WDT_SYS_RST_EN;
 	writel(val, wdt->rst_source);
-
-	return 0;
 }
 
-static int tegra20_wdt_stop(struct watchdog_device *wdd)
+static void __tegra20_wdt_stop(struct tegra_wdt *wdt)
 {
-	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
 	u32 val;
 
 	val = readl(wdt->rst_source);
@@ -256,6 +276,35 @@ static int tegra20_wdt_stop(struct watchdog_device *wdd)
 
 	writel(0, wdt->tmr_regs + TIMER_PTV);
 	writel(TIMER_PCR_INTR_CLR, wdt->tmr_regs + TIMER_PCR);
+}
+
+static int tegra20_wdt_start(struct watchdog_device *wdd)
+{
+	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret = 0;
+
+	mutex_lock(&wdt->lock);
+
+	if (wdt->vde_off) {
+		dev_warn(wdd->parent,
+			 "not starting, a reset would hang with VDE powered off\n");
+		ret = -EBUSY;
+	} else {
+		__tegra20_wdt_start(wdt);
+	}
+
+	mutex_unlock(&wdt->lock);
+
+	return ret;
+}
+
+static int tegra20_wdt_stop(struct watchdog_device *wdd)
+{
+	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	mutex_lock(&wdt->lock);
+	__tegra20_wdt_stop(wdt);
+	mutex_unlock(&wdt->lock);
 
 	return 0;
 }
@@ -264,15 +313,20 @@ static int tegra20_wdt_ping(struct watchdog_device *wdd)
 {
 	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
 
+	mutex_lock(&wdt->lock);
+
 	/*
 	 * Clearing the interrupt alone doesn't restart the timer's period, so
 	 * the reset could follow as soon as half the timeout after the ping.
 	 * Rewriting the timer setting restarts the period. The interrupt is
-	 * cleared afterwards, so one fired in between doesn't count.
+	 * cleared afterwards, so one fired in between doesn't count. While
+	 * stopped, the timer setting reads back as 0, so this doesn't start it.
 	 */
 	writel(readl(wdt->tmr_regs + TIMER_PTV), wdt->tmr_regs + TIMER_PTV);
 	writel(TIMER_PCR_INTR_CLR, wdt->tmr_regs + TIMER_PCR);
 
+	mutex_unlock(&wdt->lock);
+
 	return 0;
 }
 
@@ -296,6 +350,45 @@ static const struct watchdog_ops tegra20_wdt_ops = {
 	.set_timeout = tegra20_wdt_set_timeout,
 };
 
+static int tegra20_wdt_powergate_notify(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct tegra_wdt *wdt = container_of(nb, struct tegra_wdt,
+					     powergate_nb);
+	unsigned int id = *(unsigned int *)data;
+
+	if (event != TEGRA_PMC_POWERGATE_POWER_OFF ||
+	    id != TEGRA_POWERGATE_VDEC)
+		return NOTIFY_DONE;
+
+	mutex_lock(&wdt->lock);
+
+	if (!wdt->vde_off) {
+		wdt->vde_off = true;
+		__tegra20_wdt_stop(wdt);
+
+		/*
+		 * Stop the core's pings. If user space has the device open,
+		 * its pings don't restart the watchdog either.
+		 */
+		clear_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
+
+		dev_info(wdt->wdd.parent,
+			 "VDE powered off, watchdog stopped\n");
+	}
+
+	mutex_unlock(&wdt->lock);
+
+	return NOTIFY_OK;
+}
+
+static void tegra20_wdt_unregister_notifier(void *data)
+{
+	struct tegra_wdt *wdt = data;
+
+	tegra_pmc_powergate_unregister_notifier(&wdt->powergate_nb);
+}
+
 static int tegra20_wdt_init(struct platform_device *pdev, struct tegra_wdt *wdt,
 			    void __iomem *regs)
 {
@@ -326,18 +419,46 @@ static int tegra20_wdt_init(struct platform_device *pdev, struct tegra_wdt *wdt,
 
 	wdt->tmr_regs = regs + T20_WDT_TIMER_BASE;
 
+	ret = devm_mutex_init(dev, &wdt->lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the VDE partition is already powered off, the notifier is called
+	 * right away and stops a watchdog left running by the bootloader.
+	 */
+	if (stop_on_vde_off) {
+		wdt->powergate_nb.notifier_call = tegra20_wdt_powergate_notify;
+
+		ret = tegra_pmc_powergate_register_notifier(&wdt->powergate_nb);
+		if (ret) {
+			dev_warn(dev, "failed to register VDE notifier: %d\n",
+				 ret);
+		} else {
+			ret = devm_add_action_or_reset(dev,
+					tegra20_wdt_unregister_notifier, wdt);
+			if (ret)
+				return ret;
+		}
+	}
+
 	/*
 	 * The bootloader may leave the watchdog running. Take it over with
 	 * our own timeout and timer 1, and let the core ping it until user
 	 * space opens the device.
 	 */
-	if (readl(wdt->rst_source) & T20_RST_SOURCE_WDT_EN) {
+	mutex_lock(&wdt->lock);
+
+	if (!wdt->vde_off &&
+	    (readl(wdt->rst_source) & T20_RST_SOURCE_WDT_EN)) {
 		dev_info(dev, "watchdog left running by the bootloader, taking it over (timeout %u sec)\n",
 			 wdt->wdd.timeout);
-		tegra20_wdt_start(&wdt->wdd);
+		__tegra20_wdt_start(wdt);
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 
+	mutex_unlock(&wdt->lock);
+
 	return 0;
 }
 

-- 
2.56.0

