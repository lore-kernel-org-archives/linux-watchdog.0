Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE33128DF
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400477; cv=none; b=ErlGQNMYQ0u7ZQcUlTH/0AS+Qc3CVW073m8SV7HUqTfL1OPvp9WJV7QE071VKXX8VAUA0dHG30Yl0hrXsXs2HOJHzPh9vTD9B0o64SkbHxRdeVrsaqP6G9xTjx38v4AC92WRN6pUoN3ycqI/7yikOopWeIWaSao7kzkdPHPoU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400477; c=relaxed/simple;
	bh=bE2KCEJdrrJw55h1Di5C0KV9/9GsaRt1ZOW67UORtRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rwk61PoxSwOW8JC2JTQsnGo6I3EFX1UMFfIdRhCjJVNoQHiCffAoUQtxAdfdgpGQMzpPCQPbupMqBlMq2UqoWoZQlhxl2Hq7XCpUgds3MxchLoqMiupi6w1fJyMkTnUstgbkKwRTx5L5YIFFmnfXxlvfE0h2iHWU4P5uJJhACO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhAv1aLe; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhAv1aLe"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3122336a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788400475; x=1789005275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68bkm8EEb6YqFfA3bh03KzDOlaOODwR3iq85SSUanRo=;
        b=OhAv1aLe8PCFn09LrtNSiVfys/A4FFF5KyhM2zTBoKiJU3//yzo7eFok+7E5yDWKBr
         cre9uDYjTO7rtzQGQLN04smhXmeieWAHPTT4tmzHDRSWdtLaJuTc0RSve/KaVgzmaBb8
         mmfJfw1wGzyR+C3DM74Iy25irE3zRgOiHr6XodSHJVMccgvGtaE/5yOK1VgEDb1y7z69
         XKRUxLxcOAG2LgDwjQXebwhk1gXFyG3p22TZIG9+o1ycP7YhnayyKHOh0cNSxHsU+0yF
         /Mn+Xslsv2t0Gyh9VtMy2fuu1x4HDseH5OQ54pAbAu6Oz6hgLw4lpBWOMCx7huuRX6M6
         1ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400475; x=1789005275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68bkm8EEb6YqFfA3bh03KzDOlaOODwR3iq85SSUanRo=;
        b=rRecBLHRtKF1e5lDF/uSQ84CKPJv3bla4Wyhp2L9kmojZRfhp+8FvUcziuR0kJIngA
         tsk+LnQDEkOvnB16e6VpOkjUYsz2Qou1GoXU58IuhPvo8QYJ3BJaXZ7GoqR9+C/qwMwN
         W15kx5ssZsVPnathXR9fhFOY9fTCo2MIQda6pz5rSBNkEKIyZ9SX8TNqlB5rLsLHoBKS
         Zs484AEpA/idKzYTqjlxIQHQLn9Q9Oeb0dSns1efcnd0QFVhZ+lCBzox8Y6mPLT1jrgD
         hGg7Ozv3HHZTpISprnkLlsdUCaCGM2LupjI+j2AicKzcAYR3vNMpTF3hTcebYX58Lpbi
         ZEuQ==
X-Gm-Message-State: AFuF++k27F3Ex/0cD0SVoUC6N0DkEZCcpHfu/eTw7UUtHZD8BF22Y43C
	3LrOdrZ5jmADfPa2GwKFNd8932Q/UE0HPZkalpz9byy2+wdG0PPjz15Em6u+IFn7ukrCek5Opm1
	RxsBjABtwtg==
X-Received: from dyaz1-n1.prod.google.com ([2002:a05:693c:6381:10b0:328:321b:bc79])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8f:b0:398:c8ef:3644
 with SMTP id 98e67ed59e1d1-39aee156f4amr13369746a91.15.1788400475319; Wed, 02
 Sep 2026 18:54:35 -0700 (PDT)
Date: Wed, 02 Sep 2026 18:54:18 -0700
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788400471; l=3610;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=bE2KCEJdrrJw55h1Di5C0KV9/9GsaRt1ZOW67UORtRM=; b=dha/+VPi5wuM7UdPO/1XF9HZSmAR/XqpDTHcJIxBqJzhfyhT19FY80yrKQ+LJzW/o6ROI7Hlg
 PHNzsL4pmTmD9r5wgrNEtWnXGHm5j9qgAy967G/Z8qtZfDequtawel/
X-Mailer: b4 0.14.3
Message-ID: <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
Subject: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during NMI teardown
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

When freeing an interrupt requested via request_nmi(), __cleanup_nmi()
currently tears down the NMI and frees the irqaction structure without
waiting for in-flight instances of the handler on other CPUs to complete,
which can lead to use-after-free conditions on module unload.

Because NMIs cannot acquire desc->lock or set IRQD_IRQ_INPROGRESS without
risking deadlocks, synchronizing in-flight NMIs on other CPUs during
teardown (__synchronize_hardirq) relies on querying the hardware
controller state via __irq_get_irqchip_state(IRQCHIP_STATE_ACTIVE).

Enforce that any interrupt controller claiming NMI support via
IRQCHIP_SUPPORTS_NMI must implement ->irq_get_irqchip_state(). In
__cleanup_nmi(), serialize teardown under desc->request_mutex, shut down
the line, call __synchronize_hardirq(desc, true) while keeping desc->action
valid to avoid racing with lockless in-flight handlers, and only then clear
desc->action, tear down the NMI configuration, deactivate the interrupt
domain, and update proc status before freeing the action structure.

Also add a WARN(in_interrupt()) check in free_nmi() matching __free_irq()
to prevent freeing NMIs from atomic contexts since synchronization and
resource cleanup can sleep and spin.

Assisted-by: Antigravity:gemini
Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 kernel/irq/manage.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2fbff2618a1e..a9973b61163a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1379,6 +1379,14 @@ static bool irq_supports_nmi(struct irq_desc *desc)
 	if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
 		return false;
 
+	/*
+	 * NMIs cannot set IRQD_IRQ_INPROGRESS because they cannot acquire
+	 * spinlocks. Synchronous disable and teardown require querying the
+	 * hardware state via ->irq_get_irqchip_state().
+	 */
+	if (!d->chip->irq_get_irqchip_state)
+		return false;
+
 	return d->chip->flags & IRQCHIP_SUPPORTS_NMI;
 }
 
@@ -2034,11 +2042,20 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 	struct irqaction *action = NULL;
 	const char *devname = NULL;
 
+	guard(mutex)(&desc->request_mutex);
+
 	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
-		irq_nmi_teardown(desc);
+		irq_settings_clr_disable_unlazy(desc);
+		irq_shutdown(desc);
+	}
 
-		desc->istate &= ~IRQS_NMI;
+	/*
+	 * Ensure all in-flight NMI handlers on other CPUs complete before
+	 * clearing desc->action or tearing down NMI state.
+	 */
+	__synchronize_hardirq(desc, true);
 
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
 		if (!WARN_ON(desc->action == NULL)) {
 			action = desc->action;
 			irq_pm_remove_action(desc, action);
@@ -2046,12 +2063,12 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 		}
 		desc->action = NULL;
 
-		irq_settings_clr_disable_unlazy(desc);
-		irq_shutdown_and_deactivate(desc);
+		irq_nmi_teardown(desc);
+		desc->istate &= ~IRQS_NMI;
+		irq_domain_deactivate_irq(&desc->irq_data);
+		irq_proc_update_valid(desc);
 	}
 
-	irq_proc_update_valid(desc);
-
 	if (action)
 		unregister_handler_proc(irq, action);
 	kfree(action);
@@ -2068,6 +2085,8 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	WARN(in_interrupt(), "Trying to free NMI %d from IRQ context!\n", irq);
+
 	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
 

-- 
2.55.0.970.g62bdec98f9-goog

