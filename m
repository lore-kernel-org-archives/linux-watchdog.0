Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670703D6CC7;
	Thu, 30 Jul 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447183; cv=none; b=gLM67621y2EXSMYQcNMumo1l2/7tkz92JzktWKGURrI7+AuWEfeRT1MHMQuPzhoyWT3hKTYNm6dlMEuMtHUFeomK9jpT4h6dzOJlH+Kmqfq5g5uIMBAo1B0dyBiFqrnVvDrwTpalyTdzACCMqI16wE+KIl5XfLXPGxG/4t9kZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447183; c=relaxed/simple;
	bh=RLlvXDaPJ4ziCX4773s4tPjEfV3yJMKfVIJNoEOnSqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryN3xBAzAiUSkbt44lX5NOHCFWW5khoQbx65Pr7h+7yJ6rtCP5Xx9kDPel+Ox0fIQUFjnH80XF9NKoS1VvS5fZzJLN/llJexXeKxU4YGCvXSV9zYronnUlsjJqPVAJYMvXu5XQUuOjCmsA4+40a0aNAfg1BYxrxOgTF8mGtPTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE0K83cy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE0K83cy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AD8FC4AF09;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785447182;
	bh=RLlvXDaPJ4ziCX4773s4tPjEfV3yJMKfVIJNoEOnSqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VE0K83cystHdaTp3oSxnd194ON9IsAmeEyHF/wRQOLn7Si1cQ03ZiRuXo5J+X364t
	 /YNOfj3pVoa1JIhL8Qr1bXleFaQvT0tJ2NtMvdWF5SvvPOTFvViwzAG2Zd6WxUx+5m
	 6xtzx+pOAS8ZWhFX/Wqo7755HWfIKoUjKoGIos+h3/FkGB23sA18Vdzxfbki5vWDYH
	 RH5pPCe0lYStySrl75obqmszvAjXx8mTrIBHLs1zxayRH2ZlXOTV420ZHdWyeuy9el
	 2f6BGDrEY34CDihPzDU4aCFB1hLiXXGHDDAxqh0G+/A/F+kBPHs0NANpJuQftT1IGq
	 dlKjlJGkeMnQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FEFC55167;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Date: Thu, 30 Jul 2026 14:32:49 -0700
Subject: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as NMI
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785447181; l=4433;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=8nEYT2TKwUSRpXG+qjzVIpCk/TBIokJuhVt154QVce0=;
 b=+Y7kOBwCqMcBFbFx1gkqaiMxNA6UH74UIohXvN01vimtuhgjTuFeGElt3HEeg1kasVEDnMFwu
 mAn8nUMHFQ0CmSp9RTdMz7upsDYL6cHfdGNWB0o6n6AjmcVPwgvHsmS
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

From: Mayank Rungta <mrungta@google.com>

When a system is completely unresponsive due to an interrupt storm or
deadlocked CPU cores with standard interrupts disabled, a standard watchdog
pretimeout bark interrupt will fail to execute, preventing the pretimeout
governor from capturing CPU backtraces before the hardware reset bite.

Attempt to register the pretimeout interrupt as an NMI (or pseudo-NMI)
using request_nmi(). If NMI registration fails due to lack of platform
GIC pseudo-NMI support, fall back to devm_request_irq().

Explicitly arm and disarm the NMI during watchdog start and stop operations
using enable_nmi() and disable_nmi_nosync().

NMI Execution Call Trace (lkdtm HARDLOCKUP freeze break):
 Kernel panic - not syncing: watchdog pretimeout event
 CPU: 0 UID: 0 PID: 5419 Comm: bash Not tainted 6.19.0-rc5-00022
 Hardware name: Google CoachZ (rev3+) (DT)
 Call trace:
  show_stack+0x24/0x34 (C)
  dump_stack_lvl+0x84/0xac
  dump_stack+0x1c/0x34
  vpanic+0xfc/0x2d0
  panic+0x6c/0x74
  watchdog_notify_pretimeout+0x34/0x48
  qcom_wdt_isr+0x20/0x34
  handle_fasteoi_nmi+0x50/0x88
  handle_irq_desc+0x4c/0x68
  generic_handle_domain_nmi+0x38/0x48
  __gic_handle_nmi.isra.0+0x40/0x90
  gic_handle_irq+0x64/0x234
  call_on_irq_stack+0x48/0x88
  do_interrupt_handler+0x74/0xc4
  el1_interrupt+0x5c/0xb0
  lkdtm_HARDLOCKUP+0x18/0x28 (P)

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 49bd04841f0c..19d8e91cff40 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -51,6 +51,9 @@ struct qcom_wdt {
 	unsigned long		rate;
 	void __iomem		*base;
 	const u32		*layout;
+	int			irq;
+	bool			is_nmi;
+	bool			irq_enabled;
 };
 
 static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
@@ -73,6 +76,30 @@ static irqreturn_t qcom_wdt_isr(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void qcom_wdt_enable_irq(struct qcom_wdt *wdt)
+{
+	if (wdt->is_nmi && wdt->irq > 0 && !wdt->irq_enabled) {
+		enable_nmi(wdt->irq);
+		wdt->irq_enabled = true;
+	}
+}
+
+static void qcom_wdt_disable_irq(struct qcom_wdt *wdt)
+{
+	if (wdt->is_nmi && wdt->irq > 0 && wdt->irq_enabled) {
+		disable_nmi_nosync(wdt->irq);
+		wdt->irq_enabled = false;
+	}
+}
+
+static void qcom_wdt_free_nmi(void *arg)
+{
+	struct qcom_wdt *wdt = arg;
+
+	qcom_wdt_disable_irq(wdt);
+	free_nmi(wdt->irq, &wdt->wdd);
+}
+
 static int qcom_wdt_start(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
@@ -83,6 +110,8 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
 	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
 	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
 	writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
+
+	qcom_wdt_enable_irq(wdt);
 	return 0;
 }
 
@@ -90,6 +119,8 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 
+	qcom_wdt_disable_irq(wdt);
+
 	writel(0, wdt_addr(wdt, WDT_EN));
 	return 0;
 }
@@ -240,6 +271,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	u32 percpu_offset;
 	int irq, ret;
 	struct clk *clk;
+	unsigned long irq_flags;
 
 	data = of_device_get_match_data(dev);
 	if (!data) {
@@ -290,10 +322,25 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	/* check if there is pretimeout support */
 	irq = platform_get_irq_optional(pdev, 0);
 	if (data->pretimeout && irq > 0) {
-		ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
-				       "wdt_bark", &wdt->wdd);
-		if (ret)
-			return ret;
+		wdt->irq = irq;
+		irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
+			    IRQF_NO_AUTOEN | IRQF_NO_THREAD;
+
+		ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
+				  "wdt_bark", &wdt->wdd);
+		if (ret) {
+			/* Fallback to normal interrupt if NMI not supported */
+			ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
+					       "wdt_bark", &wdt->wdd);
+			if (ret)
+				return ret;
+		} else {
+			wdt->is_nmi = true;
+			ret = devm_add_action_or_reset(dev, qcom_wdt_free_nmi,
+						       wdt);
+			if (ret)
+				return ret;
+		}
 
 		wdt->wdd.info = &qcom_wdt_pt_info;
 		wdt->wdd.pretimeout = 1;

-- 
2.55.0.508.g3f0d502094-goog


