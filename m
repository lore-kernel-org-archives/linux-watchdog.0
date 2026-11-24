Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554387;
	b=l+D6f1xRbYF+dI0oxz7TaXY5sphd7d73n57pfOg7M2hIwGGYHz8vXn89IZzAy8ivjghQ
	 rDXzFfQPxowZjQ11Y414PjsBuDVBm4yQgT7ksd4QVX992xQNLvSi6f3MDuRmgBUxiLikv
	 ywqf1TBgjWc+/1Fzx/2O0UiArbGkSYeR6yoHkGEUAqCbQNc0Ba/RvCl84nV7XKnKY/z00
	 HsB3Iek69RoR904kmuH2K9aI42XFjsBLYtKDjEyExw+j09leu88p585WjFK7jf29bVUSE
	 j7TGMSfEkwvjwfmT6KbBSMQpuaZL6P+maoxcpDyLcqtPVwX+3+DaQtlTowoOYA+W/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lNAaswrlG/59voK0420Q09D/s4OeQ1/KcKb6MhRwXG4=;
	b=wlFReBlu89fLuWxsVsKC953cBT6zODSbi/zftletEZq8j5Lqbdl6O2xA4NZMrS63ZlLb
	 Ah9Xx/la67CfeDTielB8V1Adtrh3EKMzlCw1mhmKsxPHn63y9AJwH2kdEkOIVjNATx/42
	 PLY3KJfOX5kBETPQvJsBB3TBA1i2wsRsgqtkA1ZzAU/5DqCf2Zs9WLOEz5nrbGHQd9f47
	 VvhktTCFqJ5L42MtkLUOWAqYfX5ACF54WdpinBeWkFud6Lv8qYIqYNrHYBBOKS6/Bw621
	 YhZlQCy05Als/ibyDkFLBzkXLnXAh7GVoMaIH9sRYDfRODNVmZ5MF6UT3dmdbJTpGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nM66Qirx;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5604606A336
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 21:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5604606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nM66Qirx
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso51713231fa.0
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554385; x=1796159185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNAaswrlG/59voK0420Q09D/s4OeQ1/KcKb6MhRwXG4=;
        b=nM66QirxXo8lJFAl/96/3+7oSdudDPzwD0KFHXIFXevFQgXZvH1CAn54rdGiOjjIyd
         pYzp7aXjpGaluKDR1+sR2Dpqjtksx33A3rgSzJiq+5teCnlX4RAgzl8JLzkxRW7AcoLK
         M5QWAQ8KseDuCOC5WfWxYQZU0vW4r3/Nu7y2NCX5TDfIP4GMEDhJarvdxQ1N//LI1WgB
         fD/Y6q05Y/fEyH0oiC0Z0hxEoJMgRRIjsAhBFmiedIpIiO1SfPvu6YbxfVTv27RdU/Q/
         T2kIEd/6cmjx9amkSCEhQFl3mFJGYba/hlBY5esjtfgG9jLCr8K8M49u6Pfby24cxpiV
         K1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554385; x=1796159185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNAaswrlG/59voK0420Q09D/s4OeQ1/KcKb6MhRwXG4=;
        b=jIyliKzulbMhzuXqWvn5DiYDH76q/R74SDUE1gFPE0rlhDGB1PGoCTAaUBJkYg6/Ne
         SpiCKlTpWu0nxyPP6bAyIEhxfasD3WmLTiLswVnmV9l5UzeyfwyMuoNFiTWnL6e6QbJC
         W+90ZiB5Ae2A9CBD+DGAaHXysXwDmZl9OFdU2ACOCcNDsmRddeKcnPIQQ1oQOtl6HW0v
         hwCo/aRDDxJ/Lu9JkCJdoVi5TOi1RsKjIQfgoLWhzKXjWZB/XCkJFjhHOX6ws2INz6kQ
         NA5yG9Zds1LXXpn2Iy/CIx/JojQUFYSHuwi2brMwEHnlygCTTlh6eoK8OqBGJ0a2W3nk
         tIeQ==
X-Forwarded-Encrypted: i=1; AL+hErEt89y76dhlBnrkvdGcJXMHZ1+Opn9xeGSBH6ULXO+A1PvuUBleyWzRudnZbH1nTU71Ywz3D+xmGlh7J5fzlw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8g6pg8RtOE6W6PbBnGlCDSc9vH0FvHk+ZiDiYtVzI13HDx3N7J
	EyS9x9CLgPnaapoNX7NhCD1SlECBmtJmooRrOw+hgCJF22RsX+R3n4xO
X-Gm-Gg: AZFdTZdWuXWbjNmuMmov5+xKDmIt9/+yjih6ZLOqrZdg74k/4wMVKdeiz2E8mFEUn5z
	1HBAYnPZpKeqF3hTtKECM0AHwZED9t2puJoYpZW6ReSxel4JGXl4qNkoQ9lLJaAD474yMuQUkyE
	w0aFKBXtxzbzwOOG2ppTSrOFi416nL97KTxUG6UFhzjauRe6sW4+tqBoptcMf/4c9E81gqydwLA
	LXe7N5209bkpW86wgsU9CBHVaovsU9TqfYyk8dzRy0d8YyMyKB/ODNj+nDJPBhEwacwGPpeLHs/
	W26NHYWNvAFNjOSkTttcojxrhx3cA++7GkgD+JpJhLWDg1z/u7EN5Jr4vp8nZBOtwWmVWxn/2Pa
	ffGD6N9Qi2TM09+ntf0YRd3CcvwYFeG9P58lRHBycyA6tIfFU71kRZEHk4ppkc5Ia+Gm6Du6kky
	142Ad+bU6Sii4ZJi2ciUKzE5X6gqX9Sxw31WyU8zHinlmnPAVnaD8GEsWpCrtUKtIciHzeZoixK
	lpIx0vi/m93lE+KNWwOC1exiN75xDJbcqLrsBZ9otbLFh6dsUslPXW8rbY/9PbkVNGBtOL0nLHU
	vnwpeO1t1Gb5uwRZrCQzk3+r80FXuz6BU07EsUQ3m8MTfwJLHSYXaWP+k6YHyw==
X-Received: by 2002:a05:6512:31c3:b0:5bf:b945:4334 with SMTP id 2adb3069b0e04-5c1bc907788mr4479568e87.67.1795554384653;
        Tue, 24 Nov 2026 13:06:24 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd041813sm4099045e87.53.2026.11.24.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:06:24 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 24 Nov 2026 22:06:03 +0100
Subject: [PATCH v2 5/6] soc/tegra: pmc: Add a partition power off notifier
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
Message-Id: <20261124-t20-for-upstream-v2-5-440116846f97@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7068;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=EIJn9URgd+OIum2dJE2qaWWljUi0FVplkW6brLl+DU4=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQzbrH+fSmPkGfSuWePWJPL+426dkmlJn31Xlf1Msbzg2/
 giyfrOso5SFQYyLQVZMkcXsodAXnnle7ze83NoJM4eVCWQIAxenAExkvTnDP8ULh96eNvhvu6Qn
 +vcil+RlVw6ufMaqXSWh/fH4tWy1qlCGPzz1RUFvd68+nvbFZZ/Cp50n43+t1lvNvPLEPhOG8FM
 X9zIBAA==
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

After a watchdog reset, which doesn't reset the PMC, Tegra20's boot ROM
hangs if the VDE partition is powered off. Unless booted with
tegra_pmc.vde_always_on=1, the PMC driver powers the partition off when
it registers it, and genpd powers it off while the VDE is idle. The
Tegra20 watchdog driver will need to stop the watchdog before that
happens.

genpd notifiers can't be used for this: they only reach devices attached
to the domain, which the watchdog isn't, and the partitions are powered
off before their genpds are registered. Add a notifier that is called
before a partition is powered off, from tegra_powergate_set(), which all
power off paths go through.

When a notifier is registered, it is also called for every partition that
is already powered off, except one kept powered on with
tegra_pmc.vde_always_on, which the PMC driver powers on when it registers
it. A lock is held across both the notification and the power off, so a
partition can't be powered off unnoticed while a notifier is being
registered. Registration uses the early PMC, so it works before the PMC
driver has probed, which is when the partitions are first powered off.
The notifier, including the hook on the power off path, is therefore only
built on 32-bit ARM, the only architecture with an early PMC.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
 drivers/soc/tegra/pmc.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/pmc.h |  19 +++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index abef3fed637ff..d959ae4d0f13b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -31,6 +31,7 @@
 #include <linux/irq.h>
 #include <linux/irq_work.h>
 #include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of.h>
@@ -520,6 +521,34 @@ static struct tegra_pmc *early_pmc = &(struct tegra_pmc) {
 	.base = NULL,
 	.suspend_mode = TEGRA_SUSPEND_NOT_READY,
 };
+
+/*
+ * Notified before a partition is powered off. The lock is held across the
+ * notification and the power off, so that a notifier being registered either
+ * sees the partition still powered or is notified.
+ */
+static DEFINE_MUTEX(tegra_powergate_nh_lock);
+static RAW_NOTIFIER_HEAD(tegra_powergate_nh);
+
+static void tegra_powergate_power_off_begin(unsigned int id)
+{
+	mutex_lock(&tegra_powergate_nh_lock);
+	raw_notifier_call_chain(&tegra_powergate_nh,
+				TEGRA_PMC_POWERGATE_POWER_OFF, &id);
+}
+
+static void tegra_powergate_power_off_end(void)
+{
+	mutex_unlock(&tegra_powergate_nh_lock);
+}
+#else
+static inline void tegra_powergate_power_off_begin(unsigned int id)
+{
+}
+
+static inline void tegra_powergate_power_off_end(void)
+{
+}
 #endif
 
 #ifdef MODULE_PARAM_PREFIX
@@ -731,8 +760,14 @@ static int tegra_powergate_set(struct tegra_pmc *pmc, unsigned int id,
 		return 0;
 	}
 
+	if (!new_state)
+		tegra_powergate_power_off_begin(id);
+
 	err = pmc->soc->powergate_set(pmc, id, new_state);
 
+	if (!new_state)
+		tegra_powergate_power_off_end();
+
 	mutex_unlock(&pmc->powergates_lock);
 
 	return err;
@@ -5167,6 +5202,76 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid)
 	return tegra_pmc_powergate_remove_clamping(early_pmc, id);
 }
 
+/**
+ * tegra_pmc_powergate_register_notifier() - get notified of partition power off
+ * @nb: notifier block
+ *
+ * The notifier is called with %TEGRA_PMC_POWERGATE_POWER_OFF and a pointer to
+ * the partition ID (unsigned int) as data before a partition is powered off,
+ * from a context that may sleep. The PMC's partition locks are held, so the
+ * notifier must not call back into the PMC to control partitions or register
+ * notifiers. Its return value is ignored. It is also called for every partition
+ * that is already powered off before this function returns, so a partition is
+ * either still powered once the function returns or the notifier has been
+ * called for it. A partition that is kept powered on (tegra_pmc.vde_always_on)
+ * is never reported, as the driver powers it on when it registers it.
+ *
+ * This works before the PMC driver has probed, as the PMC is set up early on
+ * 32-bit ARM, so it covers the partitions that the driver powers off when it
+ * registers them.
+ */
+int tegra_pmc_powergate_register_notifier(struct notifier_block *nb)
+{
+	unsigned int id;
+	int err;
+
+	mutex_lock(&tegra_powergate_nh_lock);
+
+	err = raw_notifier_chain_register(&tegra_powergate_nh, nb);
+	if (err)
+		goto unlock;
+
+	/* the base is switched to the driver's mapping under this lock */
+	mutex_lock(&early_pmc->powergates_lock);
+
+	if (early_pmc->base && early_pmc->soc) {
+		for (id = 0; id < early_pmc->soc->num_powergates; id++) {
+			/* powered on when the driver registers it */
+			if (tegra_powergate_is_always_on(id))
+				continue;
+
+			if (tegra_powergate_is_powered(early_pmc, id) == 0)
+				nb->notifier_call(nb,
+						  TEGRA_PMC_POWERGATE_POWER_OFF,
+						  &id);
+		}
+	}
+
+	mutex_unlock(&early_pmc->powergates_lock);
+
+unlock:
+	mutex_unlock(&tegra_powergate_nh_lock);
+
+	return err;
+}
+EXPORT_SYMBOL(tegra_pmc_powergate_register_notifier);
+
+/**
+ * tegra_pmc_powergate_unregister_notifier() - unregister a power off notifier
+ * @nb: notifier block registered with tegra_pmc_powergate_register_notifier()
+ */
+int tegra_pmc_powergate_unregister_notifier(struct notifier_block *nb)
+{
+	int err;
+
+	mutex_lock(&tegra_powergate_nh_lock);
+	err = raw_notifier_chain_unregister(&tegra_powergate_nh, nb);
+	mutex_unlock(&tegra_powergate_nh_lock);
+
+	return err;
+}
+EXPORT_SYMBOL(tegra_pmc_powergate_unregister_notifier);
+
 bool tegra_pmc_core_domain_state_synced(void)
 {
 	return early_pmc->core_domain_state_synced;
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 53f6d02889dbd..c574a6e81a1ad 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -231,14 +231,33 @@ static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 #endif
 #endif
 
+/* event of the partition power off notifier, data points to the partition ID */
+#define TEGRA_PMC_POWERGATE_POWER_OFF	0
+
+struct notifier_block;
+
 #if defined(CONFIG_ARM) && defined(CONFIG_SOC_TEGRA_PMC)
 bool tegra_pmc_core_domain_state_synced(void);
+int tegra_pmc_powergate_register_notifier(struct notifier_block *nb);
+int tegra_pmc_powergate_unregister_notifier(struct notifier_block *nb);
 #else
 /* needed for COMPILE_TEST */
 static inline bool tegra_pmc_core_domain_state_synced(void)
 {
 	return false;
 }
+
+static inline int
+tegra_pmc_powergate_register_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline int
+tegra_pmc_powergate_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
 #endif
 
 #endif /* __SOC_TEGRA_PMC_H__ */

-- 
2.56.1

