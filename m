Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A7327BFB
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965223; cv=none; b=RCMMtjtsvMP91Qdwj6Q/lM4mWGepN0Y0xiJFYZdm29Xl7v3vASaVp0EqftGyaFJysYK+y08Fta17vXbRsdc01kGvNztNeLODmtFRYNpwQvg3yeH7xt1OQA3eckiSjeBWAXNK2KzweVQRfKKDGqJwkUQ1gdT+iyHyjJEyaggl99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965223; c=relaxed/simple;
	bh=iHfgxNKVO4v4tf6WK7u5A8eKuiYVIUoSXo1yuQ5Ow/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IDG3KPoq8VBSt9VOHWih94YCk6/7pSufkR87SnhJZu/thh38ZUrF/du9DVHilYZEUx9RHQIWrQ0QBMNmsX59EWQwJ/2nLbIztmqSO6DJkVuRzFHA8LxNrrx7z+JeLhMpAQ1BABShwEXtYI4CrgR74wr/WwzoCuk0BqLTr8iv+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmq8qeQT; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmq8qeQT"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so2945911a91.1
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787965221; x=1788570021; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jeJEAsPzG8bLM/eSAQ03cJ81HuHGeRShpXvkYOCkig=;
        b=tmq8qeQTpW7186e5fi4CO+t6TwnRIAOVlgr7HNV+p6AcF7yrX6eolGmc3sYwWLzcj8
         CPMBCyBTOTolQi+SSV0AUDMmnYOveRi42cqnH3X6jIO6Z2X7UoiPbph7baxuVBVSp20r
         qCGyuBdd3TtH1QuqqD4hbv10L6UTkxzahLSm053GLZiqUkHtbRYbdDhSAXcNlYj4XwEw
         kiHGFnm+aWQvs9MHfb9TASXeR4U+n3+j+1+MuTt3YLTqxlHWRppBh5sWCRjfCqPTW97d
         CJJCqt3x0b35Ae8jbpeAZa1Y/3J5KymxeYZ9AVxEJrlYpgqO32NhA/ohOxsEbz6dol2C
         fu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965221; x=1788570021;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jeJEAsPzG8bLM/eSAQ03cJ81HuHGeRShpXvkYOCkig=;
        b=jvnOjooF8ieSN6GQ+L7CN2TdS6BHWho0N+GzFTZXGu2rNirSqH6pZI6zg70ZrNYRZA
         zmIVrguer4wNunPsNilT9AjyKZqZmnaLsEea7CY3ZcWL16cFiLbPSUNXPcOFgFe8XrlE
         DNEYHjR4cONM3eLC0NaWT7h3L3QQ0fBSkAQMrhd2n98xIAF9Qq09HZ5HXbCPQo6Exjbn
         a8VVRVMGu0BvnlPA0GMkzO/SLsdxXER8qCRnb5QiKKhqrbi5anGB9i2zR2n28OS1qjR/
         pAd2Zl1HBvsj8iAM2dVG2zIu2268GqpsGeCIVNa0o2tiCiB084Z15N/zFJR03F52kqMI
         uU7w==
X-Gm-Message-State: AFuF++k96ULtwzK2yN8EsE9QqYXhZbH7IDV1fJaPs6QHCu1jRG6KVfSp
	QXVmHTLHeEVCRSw7XOk2xFWp2kQmmDvntzR0YhKXMl7oAbabu0VV1fKtvYoMQcjZTyehZyKbO7r
	hVmZTT23Htg==
X-Received: from dldyr27-n1.prod.google.com ([2002:a05:701b:451b:10b0:141:3e73:b5e9])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c42:b0:398:9be8:ea6c
 with SMTP id 98e67ed59e1d1-3989be8eb13mr3288145a91.25.1787965220658; Fri, 28
 Aug 2026 18:00:20 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:59:54 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAovkmoC/22NQQ7CIBREr9L8td8ARVpdeQ/TBRakP7FFoUFNw
 93F6tLlm8y8WSDaQDbCoVog2ESR/FRAbCroBz05i2QKg2BCsUZIvPd+xIeZcRoJv2NkSsvW6OY
 s+Q7K8hbshZ6r9dQVHijOPrzWk8Q/6c9Xs7++xJFhrXWrDFdiz+XRee+udlu60OWc3+2qdYq3A AAA
X-Change-Id: 20260724-qcom-wdt-nmi-series-06a48da7b415
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787965218; l=4351;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=iHfgxNKVO4v4tf6WK7u5A8eKuiYVIUoSXo1yuQ5Ow/A=; b=HwthxdUWbcqg5cH5ieSTUXzYHtBUpMsh5QaUg3GFxPuRKWUUU1IMDFa+Mqq0h3/+PQX3W4Sd3
 qphKMjkPgxwBISxewOcqUPkB5zf8o3bEmxkc5U3gYxHmRPrk02FPTWM
X-Mailer: b4 0.14.3
Message-ID: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
Subject: [PATCH v2 0/5] watchdog: qcom: Support NMI pretimeout warnings
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

On ARM64 Qualcomm SoCs, when a system freezes completely due to hard
locked CPUs with standard interrupts disabled, a standard watchdog
pretimeout warning interrupt (bark) fails to fire. To diagnose total
system lockups, we need to transition the Qualcomm hardware watchdog
pretimeout bark interrupt into an NMI (or pseudo-NMI).

Enabling NMI pretimeout handlers within a loadable driver module requires
addressing NMI teardown synchronization, exporting NMI registration
APIs, and ensuring watchdog pretimeout governor dispatch is NMI-safe.

This 5-patch series achieves NMI pretimeout enablement for qcom-wdt:
 1) Enforces that interrupt controllers claiming NMI support must
    implement ->irq_get_irqchip_state(), and synchronizes in-flight NMI
    handlers during teardown (__cleanup_nmi) to prevent use-after-free
    bugs during module unload or driver unbind.
 2) Implements synchronous disable_nmi() to ensure in-flight handlers on
    other CPUs complete before returning.
 3) Exports request_nmi(), free_nmi(), enable_nmi(), disable_nmi(), and
    disable_nmi_nosync() to GPL loadable kernel modules.
 4) Replaces spinlocks in watchdog_notify_pretimeout() with RCU to
    guarantee safe governor execution from NMI context.
 5) Updates qcom-wdt to request its pretimeout bark interrupt as an
    NMI (or pseudo-NMI) with fallback to standard IRQ.

Testing & Verification:
 - Built and tested on ARM64 Qualcomm Snapdragon SoC (Google CoachZ)
   loadable module configurations (CONFIG_QCOM_WDT=m).
 - With GICv3 pseudo-NMI enabled, simulated hard CPU lockups and
   IRQ-disabled hang conditions via lkdtm. Confirmed that qcom-wdt traps
   the watchdog pretimeout bark interrupt as a pseudo-NMI and safely
   executes watchdog_notify_pretimeout() without deadlocks.
 - Verified that runtime transitions between pretimeout governors in
   sysfs execute safely.
 - Booted with pseudo-NMIs disabled and confirmed that qcom-wdt detects
   unsupported NMI and cleanly falls back to standard IRQ.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
Changes in v2:
- Added patch to require ->irq_get_irqchip_state() for NMI-capable
  controllers in irq_supports_nmi(), and synchronize in-flight NMI
  handlers via __synchronize_hardirq() in __cleanup_nmi() to prevent
  use-after-free races during teardown.
- Added patch implementing synchronous disable_nmi() wrapping
  disable_irq().
- Exported disable_nmi() alongside other NMI APIs in genirq export patch.
- Re-ordered series to cluster genirq core changes (patches 1-3) followed
  by watchdog core and driver changes (patches 4-5).
- Fixed compiler warnings in watchdog pretimeout RCU patch by adding const
  qualifiers to local governor pointers.
- Dropped `irq_enabled` tracking from struct qcom_wdt in patch 5 since
  watchdog_dev.c strictly pairs ops->start and ops->stop calls.
- Used disable_nmi() in qcom_wdt_disable_irq() for synchronous stop.
- Link to v1: https://lore.kernel.org/r/20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com

Note on Sashiko review:
Sashiko AI review on v1 noted a pre-existing issue regarding the lack of
desc->request_mutex acquisition in free_nmi() and the request_nmi() error
path.

This pre-existing behavior is orthogonal to this series and not affected
by exporting NMI symbols or in-flight NMI handler synchronization. To keep
this series focused on module export, request_mutex handling is left unchanged.

---
Mayank Rungta (5):
      genirq: Synchronize in-flight handlers during NMI teardown
      genirq: Implement synchronous disable_nmi()
      genirq: Export NMI APIs
      watchdog: pretimeout: Protect governor access with RCU for NMI safety
      watchdog: qcom: Register pretimeout interrupt as NMI

 drivers/watchdog/qcom-wdt.c            | 52 +++++++++++++++++++++++++++++++---
 drivers/watchdog/watchdog_pretimeout.c | 45 ++++++++++++++++-------------
 include/linux/interrupt.h              |  1 +
 include/linux/watchdog.h               |  2 +-
 kernel/irq/manage.c                    | 45 +++++++++++++++++++++++++----
 5 files changed, 115 insertions(+), 30 deletions(-)
---
base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
change-id: 20260724-qcom-wdt-nmi-series-06a48da7b415

Best regards,
-- 
Mayank Rungta <mrungta@google.com>

