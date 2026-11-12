Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453394;
	b=4ezEun81fIJi3Q3dYo89OtGzO5QYZW25+Orzt+pBBERzQ4w2eleVvJKccTRLNQb9jUTC
	 8YUTF8mKm4iCSStao7pQAWtD1UXKLKgAsnWTZD6a0bWjw7BpLxaEZ4ZbksF3KmTfiZA7o
	 MPyxIRmOwVnGMl+O/JceP3acP5VJyTqAaN0RGnmaBvwAXG/wSBtqMnaAutBMSLIsakddD
	 YL7eUjhj4IQuj6wM04/8d/vmKZL/PA05WwBENp32ikYIvrlZ4104O7tNqugeHfCKqZ+qG
	 RGmKQS8+fiS0x414huVaqHZG1aiRo7dP5E+wKC1IBpZecegpYHF7yFRSJHDMSZYfQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Sa/7J0bgFeB03Uztp+5L2ZzPguvvcrGxau3eNVvTqdI=;
	b=kjys0XT8IePBNK6v0Ccd4wm7mTsqeKgSPvGrDjOXc3/9xfh8bVJR7Tsy6HT8DlhM6DTA
	 PPJ0srjgegYWWCZYpu+hcyLB6tOWiSgVYU0mGeyK1O022WTIFiwDrve1h3yd9PijmrR8F
	 YLgyP6JlxQh6H5ck5/QeOrQBTyTXOi1RenVHbrpd0WrJBByA+TeW2mZ/5FLn0vxkQTh/W
	 J9PkWn2GxqXsHPy66ifp7mvLKQPppC8BBPKXv3bRjhObkFa7oDFqUOkIZsA0Tfpi+ryI7
	 AuDU4gMlCWu+iqcgKAQfz105anffTxIvEs+vZe3v0wtW0IkPaq6zYFL1ETfdb4GkNyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qPTz9Fzb;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C843606A32A
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 03:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C843606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qPTz9Fzb
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375bac6bd21so355328eec.0
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 19:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794453393; x=1795058193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sa/7J0bgFeB03Uztp+5L2ZzPguvvcrGxau3eNVvTqdI=;
        b=qPTz9Fzbkh0MjGTX47msgUuwEL8WpQzXVrSVMDtKuOXKb+bsCxdHCw1c29Ohyai4u1
         Wofhxyoyj2+i+8fGk5/jZX8xGcK9pis3yWAmu7m4moh6p0L2FuAznQDWFEO0Eobg4yBc
         O+9kyzOxzzojxrym5hCWed0lUzkwlnTr3J4IuHZNJG9W0qeFls8RreyvpzRZysRi3kQZ
         nW6gjYDj3Tnjs051JrUbyNxuJbeR+8oLGKVrl6Y4Yz/T7ixMhjcc7Q2TuM4BLcoaTwKK
         SLaFr3G6GYjcQL/sf1ge8Va2bZH32eXtL7yaHpOUxkoKwP6f9q4Xorev3hOCHQXSPizB
         hO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453393; x=1795058193;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sa/7J0bgFeB03Uztp+5L2ZzPguvvcrGxau3eNVvTqdI=;
        b=ENYkgZaEXy7XWgoUzvyPp6nRGT/exwT/NZFxGRiqf8YByIMUbRUDm17dQ44yNx69uG
         /B7q7vRHEAVjX3yh6sYilxUl1XgKaz4cIdwF4Q4B6eWUFDV05r4hFNG1dUaozeXp80AA
         Vbxd5iYqMXov9OCX+HVE39Klz+1WvvkTSn3RXIlx6eysMAM21MScNGT8R22Yj0fBTbY+
         BPZGVr2ZQPVNFzqHPfY6PMMwJ4ii/DcRGu8vzgF6UdHSb886MxzjhhMp3QBQNN9Iz/Ax
         YvfRtjluCBq3eUphJ8nAGcbq8HDbCBR0Ajzy03n1QqCn+0o8EnZi11oGHFC/5TLmclP4
         RSyQ==
X-Forwarded-Encrypted: i=1; AL+hErETjQMSjxPDc0VlOFkkD2vpxOcO+hb7slOk1u1fm79BiUSluJDK25kj6kJ1B7njval26PZa8oWUL1xXLmHJeQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z84lr6Ir6ExMhaUdW3cdnEzU+RolamCigcfVQvdsnv9YaZ95Iy+
	OAIBnWtLKu2xJdxY2g18JJmbXFtQyE4ZbfMgcOlW3Cm65FqvcASmHquDnY8vhlzS47fkQV7xJje
	nDG6u8hauBA==
X-Received: from dybme13.prod.google.com ([2002:a05:7301:188d:b0:36b:c499:531f])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c395:b0:36d:6a77:960a
 with SMTP id 5a478bee46e88-377deaea7camr1365990eec.1.1794453393029; Wed, 11
 Nov 2026 19:16:33 -0800 (PST)
Date: Wed, 11 Nov 2026 19:16:22 -0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112031629.396819-1-mrungta@google.com>
Subject: [PATCH v4 0/7] watchdog: qcom: Support NMI pretimeout warnings
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Marc Zyngier <maz@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A . Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="UTF-8"

On ARM64 Qualcomm SoCs, when a system freezes completely due to hard
locked CPUs with standard interrupts disabled, a standard watchdog
pretimeout warning interrupt (bark) fails to fire. To diagnose total
system lockups, we need to transition the Qualcomm hardware watchdog
pretimeout bark interrupt into an NMI (or pseudo-NMI).

Enabling NMI pretimeout handlers within a loadable driver module requires
addressing NMI teardown synchronization, allowing global interrupts in
request_nmi(), exporting NMI registration APIs, and ensuring watchdog
pretimeout governor dispatch is NMI-safe.

This 7-patch series achieves NMI pretimeout enablement for qcom-wdt:
 1) Synchronizes in-flight NMI handlers during disable and teardown via
    an atomic counter on struct irq_desc and unlazy hardware masking.
 2) Allows global interrupts in request_nmi() and updates /proc/interrupts
    to display per-CPU counts for all NMIs.
 3) Implements synchronous disable_nmi().
 4) Exports request_nmi(), free_nmi(), enable_nmi(), and disable_nmi()
    to the qcom-wdt module using EXPORT_SYMBOL_FOR_MODULES().
 5) Replaces spinlocks in watchdog_notify_pretimeout() with RCU to
    guarantee safe governor execution from NMI context.
 6) Updates the panic pretimeout governor (pretimeout_panic) to call
    nmi_panic() when invoked from NMI context.
 7) Updates qcom-wdt to request its pretimeout bark interrupt as an
    NMI (or pseudo-NMI) with fallback to standard IRQ.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
Changes in v4:
- Replaced hardware-only NMI synchronization with a lockless software counter
  (desc->nmi_active) and unlazy hardware masking via __synchronize_nmi()
  (Patches 1 & 3) (Thomas Gleixner, Marc Zyngier, Douglas Anderson).
- Allowed global interrupts in request_nmi() by dropping the mandatory
  IRQF_PERCPU check and updating /proc/interrupts for NMIs (Patches 2 & 7)
  (Thomas Gleixner, Marc Zyngier).
- Switched NMI symbol exports to EXPORT_SYMBOL_FOR_MODULES(..., "qcom-wdt")
  (Patch 4) (Thomas Gleixner).
- Added Patch 6 to invoke nmi_panic() from pretimeout_panic() when in_nmi()
  is true.
- Link to v3: https://lore.kernel.org/r/20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com
- Link to v2: https://lore.kernel.org/r/20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com
- Link to v1: https://lore.kernel.org/r/20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com

Testing & Verification:
- Tested on ARM64 Qualcomm Snapdragon SoC (Google CoachZ) with GICv3
  pseudo-NMI enabled: verified NMI pretimeout bark delivery, /proc/interrupts
  accounting, runtime sysfs governor switching (noop/panic), nmi_panic()
  execution, and driver unbind/rebind teardown.

Mayank Rungta (7):
  genirq: Synchronize in-flight handlers during NMI teardown
  genirq: Allow global interrupts in request_nmi()
  genirq: Implement synchronous disable_nmi()
  genirq: Export NMI APIs for qcom-wdt
  watchdog: pretimeout: Protect governor access with RCU for NMI safety
  watchdog: pretimeout_panic: Use nmi_panic() when invoked from NMI
    context
  watchdog: qcom: Register pretimeout interrupt as NMI

 drivers/watchdog/pretimeout_panic.c    |   8 +-
 drivers/watchdog/qcom-wdt.c            |  30 ++++-
 drivers/watchdog/watchdog_pretimeout.c |  45 ++++----
 include/linux/interrupt.h              |   1 +
 include/linux/irqdesc.h                |   4 +
 include/linux/watchdog.h               |   2 +-
 kernel/irq/chip.c                      |  35 ++++--
 kernel/irq/manage.c                    | 148 +++++++++++++++++++++----
 kernel/irq/proc.c                      |   6 +-
 kernel/irq/settings.h                  |   5 +
 10 files changed, 225 insertions(+), 59 deletions(-)


base-commit: 2a500a04d6f969318c05f46aedb6e73fc1963a00
-- 
2.56.0.611.g1030f0b940-goog

