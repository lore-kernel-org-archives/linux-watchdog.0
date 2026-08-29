Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7133A59BA
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965232; cv=none; b=KwASvx7/ZyTVv0KGnyT80QeWyEigQeBGPf1Gpv9BejPoLYRoLlL23AT+ywMYPHMs1ksilpY6f5HEK2o6ldvoXYJXrRNA3eRMbERbmePxlUPNboSob+RZEbGEsNjB2DlR/y+QH22EUmvt79qc/w/jQNS2Khwioz73pzFbJkWSgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965232; c=relaxed/simple;
	bh=AdywQK2vtYiSsYhi6sIq4NfA3XpXoE4VXMIiQOI8gj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgnNuj2c1j3b4gihuDU2EdWrHkswdLXsymyKBCRe/baomlgRbBz/NIyDF3qYz0/WanRu8uM2pFg+WE3XaoDoQRIA5a54EQKgnPKl9/W3QGlwUc2rK3NUYuV2oGO2c+1U2IYxmfiLXfyWrw1gqgu/djlS7E0WRxem+o53lysRp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAHX1gHA; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAHX1gHA"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso2361648a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787965231; x=1788570031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDHpM2Mouytn9B02GRyIXBlE0tDWaaixXQnYQVljoqg=;
        b=HAHX1gHAsfjoiMzvMQudbX4+Se/YwgEMbpyQl7eDfVvw6msEnw6PF1abOJUk71587U
         mQhmJK7bHwZl/6hSlBkUrMT9Ftfzi9R1inUx2oPMFyUZITV637oK1cWEGuv+TxiROszn
         kKmgUkT5cf+8UTUdfmsrHg4JWjy168E/gm2OCvNU8iPOLkT0F99EbFnfEzr23TzlqD7r
         hlgMGIcPWJYUIkkxXfmpfl8oTvrvvZnwf3B0qzF64lenwof/JDnQXK1r6TWRaheHimPD
         G8ZnDkWDp/WpHv72IwZWokffLrE5vZWXEAzcyl0W8a9X1LrWjRZN+GLJcF4eFyGNGQkZ
         wyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965231; x=1788570031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDHpM2Mouytn9B02GRyIXBlE0tDWaaixXQnYQVljoqg=;
        b=g+YLiOkk+DIJV2s0axMQKVKupnJCSeJHnx9USiMKwcjzt1eFFFYf0Fvf11WJNTdyQ9
         B9ntxaI/549ycv9tXcBI09z23H6BgLdWfKqS2jJOQbcXxHOSbGfv3eKKmcisMuhnDV7x
         4AXdziizAqS0/vMymzUhFifRYCWMlN8MnBVjpcp5VyNl0ITHhfThgzbgrHv/+pg250mP
         +RJ/a5IyZDcy+as0UJE+2Y+ZaXRoPjIXK6J/gvX6MmNa3N+UypCwYeDs1EbFzLcj14G2
         Vnom6O9xUjziZqpA69sQXq/7cuzilL5hSPEwx6IuJVPkNO3X8KtgsRZfHCMIjjJWw8aK
         oDkA==
X-Gm-Message-State: AFuF++nvmqiUZEdm5S40LkpvVdqR0CTBKbH6YsC7Xh1pxnXnFSMfsqL2
	t08woiUdpzilUwpHli6L6yG9DJhM1xLRu+cWcmN6aeLIYyxsHLbe0t3jgRQIpWZxn/TJ+9h0Rzh
	1iKUdmbwwvw==
X-Received: from dybcu36.prod.google.com ([2002:a05:7300:ad24:b0:327:dccf:72c8])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e43:b0:37f:fd1f:d30f
 with SMTP id 98e67ed59e1d1-396d0f67646mr20132797a91.12.1787965230440; Fri, 28
 Aug 2026 18:00:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:59:59 -0700
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787965218; l=3708;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=AdywQK2vtYiSsYhi6sIq4NfA3XpXoE4VXMIiQOI8gj4=; b=kxYNMe8TIaM84CWHv8NQ/UaaZjYbEr5I+gGXw5xbYW95jwNEn3HR03JRZYZYYTFOMdblLLspb
 aMj71QLA8ZeAc/oA4IK9jOf3TD9fsjxJeyd2tYbIfiLIXbBs045csQF
X-Mailer: b4 0.14.3
Message-ID: <20260828-qcom-wdt-nmi-series-v2-5-363979fe6b6b@google.com>
Subject: [PATCH v2 5/5] watchdog: qcom: Register pretimeout interrupt as NMI
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

When a system is completely unresponsive due to an interrupt storm or
deadlocked CPU cores with standard interrupts disabled, a standard
watchdog pretimeout bark interrupt will fail to execute, preventing the
pretimeout governor from capturing CPU backtraces before the hardware
reset bite.

Attempt to request the Qualcomm watchdog pretimeout bark interrupt as an
NMI (or pseudo-NMI) using request_nmi(). If NMI registration is not
supported on the platform (e.g. pseudo-NMIs are disabled), gracefully
fall back to a standard interrupt via devm_request_irq().

When NMI is used, register a devres cleanup action to free the NMI upon
driver unbind, and use enable_nmi() and disable_nmi() during start and
stop.

Assisted-by: Antigravity:gemini
Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 drivers/watchdog/qcom-wdt.c | 52 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 4eb1bf979012..82eaf8786426 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -52,6 +52,8 @@ struct qcom_wdt {
 	unsigned long		rate;
 	void __iomem		*base;
 	const u32		*layout;
+	int			irq;
+	bool			is_nmi;
 };
 
 static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
@@ -74,6 +76,28 @@ static irqreturn_t qcom_wdt_isr(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void qcom_wdt_enable_irq(struct qcom_wdt *wdt)
+{
+	if (wdt->is_nmi && wdt->irq > 0)
+		enable_nmi(wdt->irq);
+}
+
+static void qcom_wdt_disable_irq(struct qcom_wdt *wdt)
+{
+	if (wdt->is_nmi && wdt->irq > 0)
+		disable_nmi(wdt->irq);
+}
+
+static void qcom_wdt_free_nmi(void *arg)
+{
+	struct qcom_wdt *wdt = arg;
+
+	if (watchdog_active(&wdt->wdd))
+		qcom_wdt_disable_irq(wdt);
+
+	free_nmi(wdt->irq, &wdt->wdd);
+}
+
 static int qcom_wdt_start(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
@@ -84,6 +108,8 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
 	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
 	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
 	writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
+
+	qcom_wdt_enable_irq(wdt);
 	return 0;
 }
 
@@ -91,6 +117,8 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 
+	qcom_wdt_disable_irq(wdt);
+
 	writel(0, wdt_addr(wdt, WDT_EN));
 	return 0;
 }
@@ -256,6 +284,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	u32 percpu_offset;
 	int irq, ret;
 	struct clk *clk;
+	unsigned long irq_flags;
 
 	data = of_device_get_match_data(dev);
 	if (!data) {
@@ -311,10 +340,25 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		if (irq < 0 && irq != -ENXIO)
 			return irq;
 		if (irq > 0) {
-			ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
-					       "wdt_bark", &wdt->wdd);
-			if (ret)
-				return ret;
+			wdt->irq = irq;
+			irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
+				    IRQF_NO_AUTOEN | IRQF_NO_THREAD;
+
+			ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
+					  "wdt_bark", &wdt->wdd);
+			if (ret) {
+				/* Fallback to normal interrupt if NMI not supported */
+				ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
+						       "wdt_bark", &wdt->wdd);
+				if (ret)
+					return ret;
+			} else {
+				wdt->is_nmi = true;
+				ret = devm_add_action_or_reset(dev, qcom_wdt_free_nmi,
+							       wdt);
+				if (ret)
+					return ret;
+			}
 
 			wdt->wdd.info = &qcom_wdt_pt_info;
 			wdt->wdd.pretimeout = 1;

-- 
2.55.0.897.gb25b4bd76c-goog

