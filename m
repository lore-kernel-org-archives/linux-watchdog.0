Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F45334C1D
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965228; cv=none; b=b+3Yd0p0XD6TM5iYdgDqxn3LQkE7ieN/uxYeCB3z53JyZwhmh8OrK/JZhnfym7NcchP0rZvTpzezT0Yke3x9iNC/KvJbDvo3saWWage3FGXQSFBVrfdl7utLBNHY/FARO2Zfcng05a4Wvxixf6PiARv/fvrLo4yiiqCf+cPOZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965228; c=relaxed/simple;
	bh=YCBb6JCBz9uYY2aQS0mNeRjnKbSKsvsyrD2Dfk1TJ64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ep/5tY3K5tKPtwYW5X2WwGM++9RXxHxfLVSYctqUzKmEYWikDLKVWJdcragjJ/hS3tpIDB18BLwdQkc+xuy6U34b0m1P+5iXEuNWpYngfVr0NxRZHoo7bULHwPe12G4RpfyAggOTa4r7iq5V8NgaFAcyJZHGTJsMwZyYROwzNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRRx87hD; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRRx87hD"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso2079229a91.2
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787965226; x=1788570026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOCsF+Q/dEN9C/W+xZWUHpAFMeTYzX55pmMwwrUJKsE=;
        b=hRRx87hDYI0IiaSLgSLJ768W/kTd9QGs68+uhoIX9MwVQZHKR/JfzLUKakIqcCfgxj
         dZ5A2nVj6xdDj8vI8q6Q4ggzYgXG0FW59ggOE/QN2IMssxBT8t6KSPlVHCq8+lOoX0hR
         6G9y44OE8Ae9DdcFOaBU3MbUauvWsCWC+rtrYFAYOFMjPFukJSM2Z+2u3PGmpkdYWgto
         i+Kyy7OjPQGljlq1NVmFmcnuvUM7u73r/ZjnRY2Q3WxrqTnX7Sr46mOxagvX0QXXmZK5
         TaLys9FiOOxXVtQ1WRaSodz+PT+LtAMcdN8JNH0zOC63Fa36RmiJpNBUv8XrGkP/LjSE
         frFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965226; x=1788570026;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOCsF+Q/dEN9C/W+xZWUHpAFMeTYzX55pmMwwrUJKsE=;
        b=dMWBIUiHJB3rtwsYJLYEsbQ9in3iDf8ItMejmOq8SEGopKn2aGigt2uDcvMXdoC7A1
         gehvSZHxac8Wx/sNd2vZrsFmzUImKL+E1VuWyZEzGl2OGygCqDVHAzxGBntjLcqv3j5o
         19xQTeF3OsVEGX1E8Qw098Gj5llUD3YscPkk34anP3/aHr/1YSe92ikHYDWVKBR+QltI
         vIaLkAmXTOfF4CqdCsEkUjifEuhDF2/fXj7/YOBoCYiGPgVorC/r1QbtyaLtK/dZ97N4
         CuV8ycIgfhrkYdP2kerM7bBbBVoJuScXRoit4kZD+68Lot3KkHlw8A52eOYoA4reQwCz
         dXng==
X-Gm-Message-State: AFuF++n1PsQwSbFX9/FgSLPMb4j++0RLFqn+SzneKYZiaP94e6qABQWs
	MCDGMNHAJT1dDwWLM8Rzw/VDjw7jq2eIHUp1QVdT2cOrSNbOX2SIUeP4Qf2Uf1zOo486qxGSLVd
	ouGkda3voSw==
X-Received: from dlah10.prod.google.com ([2002:a05:701b:260a:b0:13b:9fe2:1c73])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0f:b0:380:540:d499
 with SMTP id 98e67ed59e1d1-396d0ed0023mr21152806a91.6.1787965226318; Fri, 28
 Aug 2026 18:00:26 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:59:57 -0700
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787965218; l=1613;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=YCBb6JCBz9uYY2aQS0mNeRjnKbSKsvsyrD2Dfk1TJ64=; b=r+FkIG3uoRHWf8zvZBgP2LQJplrrII+2fgmGZr8wQQQ2+GsRnMTGG35UZNGl1Z6BWeBhh1pd5
 K/xVzdb6L/HA8PJvG3/1noyvj3CcVRcUDkjd0lgDrkwGqB+4wjn32oy
X-Mailer: b4 0.14.3
Message-ID: <20260828-qcom-wdt-nmi-series-v2-3-363979fe6b6b@google.com>
Subject: [PATCH v2 3/5] genirq: Export NMI APIs
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosync(),
and disable_nmi() are restricted to built-in kernel code because they are
not exported.

Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modules can
register and manage NMIs.

Assisted-by: Antigravity:gemini
Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 kernel/irq/manage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40013aa94481..ded8cc33381c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -766,6 +766,7 @@ void disable_nmi_nosync(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 }
+EXPORT_SYMBOL_GPL(disable_nmi_nosync);
 
 /**
  * disable_nmi - disable an nmi and wait for any pending handlers
@@ -781,6 +782,7 @@ void disable_nmi(unsigned int irq)
 {
 	disable_irq(irq);
 }
+EXPORT_SYMBOL_GPL(disable_nmi);
 
 void __enable_irq(struct irq_desc *desc)
 {
@@ -848,6 +850,7 @@ void enable_nmi(unsigned int irq)
 {
 	enable_irq(irq);
 }
+EXPORT_SYMBOL_GPL(enable_nmi);
 
 static int set_irq_wake_real(unsigned int irq, unsigned int on)
 {
@@ -2110,6 +2113,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 
 	return __cleanup_nmi(irq, desc);
 }
+EXPORT_SYMBOL_GPL(free_nmi);
 
 /**
  * request_threaded_irq - allocate an interrupt line
@@ -2372,6 +2376,7 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(request_nmi);
 
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {

-- 
2.55.0.897.gb25b4bd76c-goog

