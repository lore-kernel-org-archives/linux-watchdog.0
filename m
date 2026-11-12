Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453396;
	b=to8hvacXrFz4wRDPF1sVydsQGQbGX1QkxMzqsSLLA1nbMIEMJnZCBW82vYB9cKomv2bX
	 Tu+9UaCSlAu3bgNgfwTCe+DvoeCii4Xv1AtgEZaDod+JB1ViLAr+D4zK6PRfWsjCdY3vF
	 EJLKnr8DYffWJU/DzoEcY/as12Uppr5bxWRKYPkgds2kr0H7eR4mtE2l3K4rza7f6HlZd
	 RIZN0BwL/0KFB2Y29flYASj0cZFSGXlMOGS3doMeXuxGFhSXbZUpxyTgDajY3JgQJB8nF
	 hHDzCWxAgd5qu0XWn/dbzVaIgvyNKcP31dEVgYYQw7pQB25hlLxIwUC/YgT1xySFuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XgKdwDr8DTTsXMJ8C3e2KtuAgAhzhLqpZNdLut8RxGU=;
	b=oqJ9YObmnw8+KUq2knDVzBT5BTcPRrdmKm+kSqzdmswYqQSoSmIlKe+7bmDXsWHvLuxf
	 z8ByKsap1yEBinyJ4/fZ/BKOKBflu+pX1TUvc9NH2vV9OZGCYTXNQ9FtMbTjbBxbiH79S
	 Rn7ArlRh1fzrkkXpSWIzW0jSTLBixDhrqjjVrL0c/N4ToG+8tcy+8o5hHOH4sADrd/kMB
	 DwRTlEocV/FtM2FG2iNJbbSGPfbI9Zx1v89UvwqNQfJD52Vuv4Lt6c/UvXZPT2DSDcHyG
	 R8vv1JMzyfC7aJ/R5m05RfjNmbsqiZID1y4skDgUZ1v6w3yklN0at5i6ai02XmuvEzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h+5515bP;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDD606A33D
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 03:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DDD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h+5515bP
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3b63b9665so1481699c88.1
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 19:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794453395; x=1795058195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgKdwDr8DTTsXMJ8C3e2KtuAgAhzhLqpZNdLut8RxGU=;
        b=h+5515bPExPrd0gXNn/Ab92VXaOOnTEU7Sb8s9GpvdUv2qY/UKSn6O0tucQQxE+EcY
         XgWNR/C4LOVPSh2rWgAU9BStJzjCBDcQyS05nK94b4RlFsysN7vlFXE77qaY3nfeHNb+
         L1EufRbVLABlWyvUxC6ZKrJU3KbhENNLIzGVzMNAMghBqR+il1xSmvhPKxm8LcgwkXws
         cVQpIhsKBZpIJT1oWEQKytFFfGTWSU+HhdsMWydCZ+yXZPQkmugD6UMF/A9D38ZxmncV
         3EyBOksMGcmHjbas4q4XrHfZeXBkQcpcbLRsdCSEt67QD5hXaKLQhsWURRUg+Xo0/U+n
         ROMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453395; x=1795058195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgKdwDr8DTTsXMJ8C3e2KtuAgAhzhLqpZNdLut8RxGU=;
        b=QXELqwqYRWUemWaf45VkVoeSq/qbnDc0tJZRXok6jmeZ8WM5XdvAwh8CKlwMXItTao
         iwqdDNvIbPMWwppLa8sj2OjhO1+GWyaM3ELtxTPZAxWCtRc+oGGf08xenfrhIgdbq14G
         gww7GtPTsTXS7qnj8VBxE8AntKxkFvDqxAJW+Q20yXky5UMsX79cuiMuwCr09pchDosN
         GtX11NOl3nKRrAJxkMktU/JxJMCpJUtkA8nWqAf1OHozdWfaTQATnEMZolO2CCktMfhP
         B6JbnToufPMTnMRFhXGbqypgX/UixX5huswzrfYaNjnF7rr85ueX8V29CLibcX4kP5rU
         n66g==
X-Forwarded-Encrypted: i=1; AL+hErEs6HMRlK/lAIVvUR+Qjwa4nd12AHHA5RBYiHHhGSRFcBF+nQKARthAIrLKLxe9pB9+yCEyG+HitdYknxAJNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7WWH0P2j2BxZsHkByc8cjV+Ep5rpyk7eQhOeJTTtq5PDxXYOY
	zDLinpy4KKkIUF/XCeYBE754AbPiN25WqVH1KgqFzFocYrtj376oScRCDE0ZXOeCz15+EkmA5uN
	TPTUb1NuDuA==
X-Received: from dlbur5.prod.google.com ([2002:a05:7022:ea45:b0:1a3:c305:2584])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea4a:b0:1ae:4ead:8cef
 with SMTP id a92af1059eb24-1b3ced2d774mr2015624c88.30.1794453394997; Wed, 11
 Nov 2026 19:16:34 -0800 (PST)
Date: Wed, 11 Nov 2026 19:16:23 -0800
In-Reply-To: <20261112031629.396819-1-mrungta@google.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112031629.396819-2-mrungta@google.com>
Subject: [PATCH v4 1/7] genirq: Synchronize in-flight handlers during NMI teardown
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Marc Zyngier <maz@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A . Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="UTF-8"

When freeing or disabling an interrupt requested via request_nmi(),
__cleanup_nmi() and __synchronize_hardirq() currently do not wait for
in-flight instances of the NMI handler on other CPUs to complete, which
can lead to use-after-free conditions on module unload or driver unbind.

Regular IRQs and NMIs require different synchronization mechanisms:
- Regular IRQ flow handlers already acquire desc->lock, so tracking
  in-flight execution via IRQD_IRQ_INPROGRESS under desc->lock avoids
  extra atomic operations in the interrupt fast path and extra memory
  barriers during synchronization.
- NMI handlers cannot acquire desc->lock, and querying hardware
  IRQCHIP_STATE_ACTIVE alone does not cover handler execution after EOI.
  Track in-flight NMI handlers locklessly via an atomic counter
  (desc->nmi_active) in handle_fasteoi_nmi(), paired with a dedicated
  __synchronize_nmi() helper that waits for both nmi_active and
  (when supported) IRQCHIP_STATE_ACTIVE to drain.

Because handle_fasteoi_nmi() runs locklessly and cannot mask lazily
disabled interrupts in hardware, force unlazy disable
(_IRQ_DISABLE_UNLAZY) in request_nmi() and mask the interrupt in
hardware before setting IRQD_IRQ_DISABLED in __irq_disable() (matching
irq_shutdown()). This prevents a level-triggered NMI from observing
IRQD_IRQ_DISABLED while still unmasked in hardware and livelocking on
EOI, and is safe for regular IRQs because __irq_disable() runs under
desc->lock and no chip disable/mask callbacks inspect
irqd_irq_disabled().

Update __cleanup_nmi() to serialize teardown, shut down and synchronize
the NMI before clearing desc->action and NMI state, and warn if
free_nmi() is called from interrupt context.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 include/linux/irqdesc.h |   4 ++
 kernel/irq/chip.c       |  35 +++++++++----
 kernel/irq/manage.c     | 111 ++++++++++++++++++++++++++++++++++------
 kernel/irq/settings.h   |   5 ++
 4 files changed, 130 insertions(+), 25 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 779d6023c5c2..f1fabddf9650 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -65,6 +65,9 @@ struct irq_redirect {
  * @threads_oneshot:	bitfield to handle shared oneshot threads
  * @threads_active:	number of irqaction threads currently running
  * @wait_for_threads:	wait queue for sync_irq to wait for threaded handlers
+ * @nmi_active:		number of NMI handlers currently running (normally 0
+ *			or 1, but can briefly reach 2 if an NMI re-triggers
+ *			between hardware EOI and atomic_dec())
  * @nr_actions:		number of installed actions on this descriptor
  * @no_suspend_depth:	number of irqactions on a irq descriptor with
  *			IRQF_NO_SUSPEND set
@@ -107,6 +110,7 @@ struct irq_desc {
 	unsigned long		threads_oneshot;
 	atomic_t		threads_active;
 	wait_queue_head_t       wait_for_threads;
+	atomic_t		nmi_active;
 #ifdef CONFIG_PM_SLEEP
 	unsigned int		nr_actions;
 	unsigned int		no_suspend_depth;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1..565cb0233fff 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -364,13 +364,19 @@ static void __irq_disable(struct irq_desc *desc, bool mask)
 		if (mask)
 			mask_irq(desc);
 	} else {
-		irq_state_set_disabled(desc);
 		if (desc->irq_data.chip->irq_disable) {
 			desc->irq_data.chip->irq_disable(&desc->irq_data);
 			irq_state_set_masked(desc);
 		} else if (mask) {
 			mask_irq(desc);
 		}
+		/*
+		 * Mask in hardware before setting IRQD_IRQ_DISABLED so a
+		 * lockless NMI firing before hardware masking completes does
+		 * not observe IRQD_IRQ_DISABLED, skip its handler, and EOI an
+		 * unmasked level-triggered line into an infinite NMI storm.
+		 */
+		irq_state_set_disabled(desc);
 	}
 }
 
@@ -792,21 +798,32 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 void handle_fasteoi_nmi(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
+	struct irqaction *action;
 	irqreturn_t res;
 
-	__kstat_incr_irqs_this_cpu(desc);
+	atomic_inc(&desc->nmi_active);
+	/* Ensure nmi_active is visible before reading action or disabled state */
+	smp_mb__after_atomic();
 
-	trace_irq_handler_entry(irq, action);
-	/*
-	 * NMIs cannot be shared, there is only one action.
-	 */
-	res = action->handler(irq, action->dev_id);
-	trace_irq_handler_exit(irq, action, res);
+	action = READ_ONCE(desc->action);
+	if (likely(action && !irqd_irq_disabled(&desc->irq_data))) {
+		__kstat_incr_irqs_this_cpu(desc);
+
+		trace_irq_handler_entry(irq, action);
+		/*
+		 * NMIs cannot be shared, there is only one action.
+		 */
+		res = action->handler(irq, action->dev_id);
+		trace_irq_handler_exit(irq, action, res);
+	}
 
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
+
+	/* Ensure all handler accesses complete before decrementing nmi_active */
+	smp_mb__before_atomic();
+	atomic_dec(&desc->nmi_active);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ec3ecb0e48ce..3fb77a2d954d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -48,11 +48,72 @@ static inline void synchronize_irqwork(struct irq_desc *desc) { }
 
 static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_state which, bool *state);
 
+static void __synchronize_nmi(struct irq_desc *desc, bool sync_chip)
+{
+	struct irq_data *irqd = irq_desc_get_irq_data(desc);
+	bool inprogress;
+
+	do {
+		/*
+		 * Wait until we're out of the NMI handler before taking
+		 * desc->lock or polling the irqchip. This might give the
+		 * wrong answer due to the lack of memory barriers.
+		 */
+		while (atomic_read(&desc->nmi_active))
+			cpu_relax();
+
+		guard(raw_spinlock_irqsave)(&desc->lock);
+		/*
+		 * Ok, that indicated we're done: double-check carefully.
+		 *
+		 * Holding desc->lock serializes with prior state updates (e.g.
+		 * IRQD_IRQ_DISABLED set under desc->lock) and protects
+		 * __irq_get_irqchip_state(). Together with
+		 * smp_mb__after_spinlock(), this provides a full memory
+		 * barrier pairing with smp_mb__after_atomic() in
+		 * handle_fasteoi_nmi() so those updates are visible before
+		 * reading nmi_active.
+		 */
+		smp_mb__after_spinlock();
+
+		/*
+		 * Pair with smp_mb__before_atomic() + atomic_dec() in
+		 * handle_fasteoi_nmi() so all handler memory accesses complete
+		 * before __synchronize_nmi() returns.
+		 */
+		inprogress = atomic_read_acquire(&desc->nmi_active);
+
+		/*
+		 * Also check hardware active state when supported to bridge the
+		 * window between hardware acknowledge and atomic_inc() in
+		 * handle_fasteoi_nmi() on non-percpu_devid SPIs. Ignore the
+		 * return code; inprogress is only updated when the chip
+		 * supports it. Note that if a chip does not implement this,
+		 * disable_nmi() is still safe, and free_nmi() is as safe as we
+		 * can make it (though an NMI acknowledged just before masking
+		 * that has not yet entered handle_fasteoi_nmi() could race with
+		 * irq_nmi_teardown() resetting desc->handle_irq).
+		 */
+		if (!inprogress && sync_chip)
+			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
+						&inprogress);
+	} while (inprogress);
+}
+
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
 	struct irq_data *irqd = irq_desc_get_irq_data(desc);
 	bool inprogress;
 
+	/*
+	 * Generic paths such as synchronize_irq() (e.g. suspend_device_irqs())
+	 * and synchronize_hardirq() can be called on NMIs; redirect them.
+	 */
+	if (unlikely(irq_is_nmi(desc) && !irq_settings_is_per_cpu_devid(desc))) {
+		__synchronize_nmi(desc, sync_chip);
+		return;
+	}
+
 	do {
 		/*
 		 * Wait until we're out of the critical section.  This might
@@ -2044,29 +2105,38 @@ EXPORT_SYMBOL(free_irq);
 
 static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 {
-	struct irqaction *action = NULL;
-	const char *devname = NULL;
+	struct irqaction *action;
+	const char *devname;
 
-	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
-		irq_nmi_teardown(desc);
+	guard(mutex)(&desc->request_mutex);
 
-		desc->istate &= ~IRQS_NMI;
-
-		if (!WARN_ON(desc->action == NULL)) {
-			action = desc->action;
-			irq_pm_remove_action(desc, action);
-			devname = action->name;
-		}
-		desc->action = NULL;
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		if (WARN_ON(!desc->action))
+			return NULL;
 
 		irq_settings_clr_disable_unlazy(desc);
-		irq_shutdown_and_deactivate(desc);
+		irq_shutdown(desc);
 	}
 
-	irq_proc_update_valid(desc);
+	/*
+	 * Ensure all in-flight NMI handlers on other CPUs complete before
+	 * clearing desc->action or tearing down NMI state.
+	 */
+	__synchronize_nmi(desc, true);
+
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		action = desc->action;
+		irq_pm_remove_action(desc, action);
+		devname = action->name;
+		WRITE_ONCE(desc->action, NULL);
 
-	if (action)
-		unregister_handler_proc(irq, action);
+		irq_nmi_teardown(desc);
+		desc->istate &= ~IRQS_NMI;
+		irq_domain_deactivate_irq(&desc->irq_data);
+		irq_proc_update_valid(desc);
+	}
+
+	unregister_handler_proc(irq, action);
 	kfree(action);
 
 	irq_release_resources(desc);
@@ -2081,6 +2151,8 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	WARN(in_interrupt(), "Trying to free NMI %d from IRQ context!\n", irq);
+
 	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
 
@@ -2337,6 +2409,13 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 		goto err_irq_setup;
 
 	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		/*
+		 * Force unlazy disable so disable_nmi() / disable_nmi_nosync()
+		 * always mask the interrupt in hardware; handle_fasteoi_nmi()
+		 * runs locklessly and cannot mask lazily disabled interrupts.
+		 */
+		irq_settings_set_disable_unlazy(desc);
+
 		/* Setup NMI state */
 		desc->istate |= IRQS_NMI;
 		retval = irq_nmi_setup(desc);
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 0a0c027a5d34..4fefdf062dbd 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -163,6 +163,11 @@ static inline bool irq_settings_disable_unlazy(struct irq_desc *desc)
 	return desc->status_use_accessors & _IRQ_DISABLE_UNLAZY;
 }
 
+static inline void irq_settings_set_disable_unlazy(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_DISABLE_UNLAZY;
+}
+
 static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 {
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
-- 
2.56.0.611.g1030f0b940-goog

