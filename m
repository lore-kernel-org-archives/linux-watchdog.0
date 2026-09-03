Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00959324716
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400480; cv=none; b=EVe1xXCGAYgE+ZZkvngkLnJTKqwRztvZBotmgyagLFo9Iwrdm9x7HFNUp5yMbNeAqI8zg1Qyl9dQqJNbbxqlIKXMUGX52doC8uRk/TgC5y5oH4fWq31/oyOpKG+bXprFIZyHbX8tAqbG59usmUcofIvGxm5Q6vViI0YY5l93LbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400480; c=relaxed/simple;
	bh=wedRPiAO/DhYjzS65XL5l3RIbBJTHI5WnzKxvRx2w6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tsQlVy5ZSz656bfGTuqN7YhOw8LsvE6rCDpJVc+PIvb2pWCH+BL4VqhqGn3mvncrAc0jZLtldFkjuOrMyiNcTSrNwDcJKGFxQGyKAdSUuaf/Z01Jhet0lU9NfRcR35bay6C4CvNWy8Om3PPIse45oN2Vj0p/UYF7ropyVOY3ZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr7trrTp; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr7trrTp"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso3306191a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788400477; x=1789005277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gERcKiJvkri4DmMi/VqLqHTF/JjRCW5D7m7rLo+8Tk=;
        b=Rr7trrTpEa5AALTc0Y64Q1swCFPhDAt+kwgufDkpkQKv4IQdBr8u8fdS5p153h6CsY
         wLySNri11D2XbKC0436e53m74JS3yAiq8M6QnICh4BCFGwAq3BIBf16ySxGSdNf45ed/
         ZX6THRldnyhhIRAl8a73mxpHP529aqqhBHlmvI98Ye/UbIL5pqxlKG/JJwxiNy13g3fM
         iJkR8v7wV7yOp6j0QItNtlhKZetXIHpUQjG7tdqpb+iaEqQ2KFPoCK2SGdOHolwZ5CYK
         vvRtsFmBllThmsWuqXB1ZZeXGXFZcckxovAEHL3ewMBFHuaIQe3CMaBKvwTowLJOdLFD
         wn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400477; x=1789005277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gERcKiJvkri4DmMi/VqLqHTF/JjRCW5D7m7rLo+8Tk=;
        b=I3F8rOazSQjvW4OkCDQ6JK6cp46yscaydeTlCN3Qn8R0r5FkZmLBy25mf0/EQlu/uh
         xpV0UJBo7lD+kHmTXcVck7WN6Rfpiel5b+7FLP7dIufr487o+10ttfKKkbSd6f8FgG5Z
         I6UmL0J1oYFXt42WVrFZSCAlhqoVwoYSPzGvwhq1eK82C5IF1lKkad7MhSIAg55QWF6O
         UrM1ERMwniTR7+HR0A46SMnEZTKRepwLO+CyaomWMpIjBdFjDqAmxKqkhIQNdL3LRXeB
         BWduWGzesbej/ZRt1OXJMqnC1UZi9pcL29bap/UH2UAWKeRXwCR/tceqmLcAyw0v+JlY
         J/jQ==
X-Gm-Message-State: AFuF++kwLK8b7EElNuZG65B3rrle5Od6/eM8dkzqBvlca33rWrxwXyVA
	kcZagrMKjtOQvP2edN6Xi5hIInVe7OQYbc/VhQkQpfKW9vVWp0wz9SfFANn21Hok1cC28N4ATJB
	qZfPJRWs+WA==
X-Received: from dltt19.prod.google.com ([2002:a05:701a:c973:b0:141:37f6:f90a])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2750:b0:398:e73e:5a0c
 with SMTP id 98e67ed59e1d1-39aedf5d887mr13782819a91.1.1788400477127; Wed, 02
 Sep 2026 18:54:37 -0700 (PDT)
Date: Wed, 02 Sep 2026 18:54:19 -0700
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788400471; l=1942;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=wedRPiAO/DhYjzS65XL5l3RIbBJTHI5WnzKxvRx2w6M=; b=Bk+0b9J+Ip6aLIdap95wpcVo+WSJNhfEkYqvG9iufWjfAIILdJI9E93ZPSzsVW9AKSzT0G3JG
 AQrXvjsTwEpDpuE0LB53ta58tWomN/xbNxv2UYqa6QC1ZNos5kXoTtw
X-Mailer: b4 0.14.3
Message-ID: <20260902-qcom-wdt-nmi-series-v3-2-f3999362a9ea@google.com>
Subject: [PATCH v3 2/5] genirq: Implement synchronous disable_nmi()
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, disable_nmi_nosync() is the only interface to disable an NMI
line. Drivers stopping their devices in process context need a synchronous
variant that guarantees any running instance of the NMI handler has
completed on other CPUs before returning.

Implement disable_nmi() by wrapping disable_irq().

Assisted-by: Antigravity:gemini
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 include/linux/interrupt.h |  1 +
 kernel/irq/manage.c       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe0..f13b3ab3829a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -243,6 +243,7 @@ DEFINE_LOCK_GUARD_1(disable_irq, int,
 		    disable_irq(*_T->lock), enable_irq(*_T->lock))
 
 extern void disable_nmi_nosync(unsigned int irq);
+extern void disable_nmi(unsigned int irq);
 extern void disable_percpu_nmi(unsigned int irq);
 extern void enable_nmi(unsigned int irq);
 extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a9973b61163a..009633b5b654 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -767,6 +767,21 @@ void disable_nmi_nosync(unsigned int irq)
 	disable_irq_nosync(irq);
 }
 
+/**
+ * disable_nmi - disable an nmi and wait for any pending handlers
+ * @irq: Interrupt to disable
+ *
+ * Disable the selected interrupt line. Disables and enables are nested.
+ *
+ * The interrupt to disable must have been requested through request_nmi.
+ * This function ensures existing instances of the NMI handler have
+ * completed before returning.
+ */
+void disable_nmi(unsigned int irq)
+{
+	disable_irq(irq);
+}
+
 void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {

-- 
2.55.0.970.g62bdec98f9-goog

