Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC42EEE9D
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400476; cv=none; b=k2V5RskZgoBa8BNYrltvjeLJ9bCBX+UdDlDIuOxE9hyQQ+nCTUIBEYPzufsrBqUkKbDmYPb3ri+tyLqVAuIBgYD3xCBJKjnhDw/kQtQm7wStRvcBUWBbWAWsEoyBwZqoB83X2190iigPZhXG4dKY/geoGUn6kpy8gfMvKwUrgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400476; c=relaxed/simple;
	bh=2gBLdRb1tH11tec2Sox8fa5ZuVnWfYlxGOi5cpI2yXM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dtn4bVO2ioAIffZgjDJNNNrl35UZqrW2N1P9iQg+szLS8sNVj80KttqOjHP356lznOoJjJ3XegUOGq4rFqJoNbZVkwFYcgrOAT/k1Gr9Sk7SRvwIHpyd3RJL0B2Js8nbg/O6xLoOi1Qp6zggz9cfrQV+6EjeOAh1xoBkY4rv6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQXPpoRK; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQXPpoRK"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d7293f13c6so23943055ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 18:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788400473; x=1789005273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4dFoNTDM7ToHvC7MveDkasF/b3V5NgSEejzUsk5Rh0k=;
        b=NQXPpoRKC9psckS6Iq8LQaJaInFJTOdKjZwTcSRZr7Lt3JEmHgQuYBuEZ2Vcd7b2g+
         aREB9Kn6vUHxY2apNzY5cvRhx3y7nAKpiML6LVYKqvL+UAMd9/A9aMFNRzGgtsEkCj7F
         mz5AraZAgcQAyNWrEJypCDpc0Bx9uPXBOzVoFuIchD9gkX0oEyhbmjPgsOdjysyLE3Zu
         WpS6L8VeZ7F17qkpJv6rvn/y8r+n4EmNUEimDO1R7gtAgzEGpWUKY9B2zNRIRs5XvoXX
         RlUA8xQcP0ow6/Rr6fqCtyoTuoO3FdN69P02X6VqAt1LVZXxB7s1zWJi8z1G2km+stUK
         JtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400473; x=1789005273;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dFoNTDM7ToHvC7MveDkasF/b3V5NgSEejzUsk5Rh0k=;
        b=FpJdpzk3rCt8DH0ocQtwqLHhSI28aID8TrR+pM5+eM7ZZxPiD+c9dK6b7DgTNnxn2f
         B+3oTDiiHjVZGTq8yv+SPqWbKmKnLEQU/lCKiNgm5ZRbmNPz0nmTmNrDsONTUqhLeuQa
         509LWPX61BBOXzupB67iMOSK4170j6oIXx4yMlU5KykoQ7NfMQN4OziLeQ+RZjIAJPfS
         zTYPT6hzx2l5mdhrcLwDuoFlsIF/pG3Jreceee5w/vEyNHm3+lt1naMkBTWqV6Yt6xrS
         jtAEvC8mGIxtEXvtULzMMj4CfVbj6eC0DHzUMMsqxbQCLoLUZhICFtilaeNu4ghf5Q/w
         7Ngw==
X-Gm-Message-State: AFuF++k5uVMqM1Z5JaeNpPQmJ+bcfMhT0JH1XO3gnUotdBmhv18UUTp1
	Jfav49aQjCPeEu3UCFGH4TOGlkZHYL4FZ2VZopU/Q2sP/3EtaHmDObpSNOT9+svKeENAKhWzdBh
	LSbEH8yV+Hw==
X-Received: from dysc26.prod.google.com ([2002:a05:7300:3b1a:b0:332:2edd:e13a])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d547:b0:2da:e68f:45b4
 with SMTP id d9443c01a7336-2daec641a74mr127906995ad.8.1788400473467; Wed, 02
 Sep 2026 18:54:33 -0700 (PDT)
Date: Wed, 02 Sep 2026 18:54:17 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEnTmGoC/23NTQ6CMBAF4KuQrh3TP0tx5T2Mi0ILNBGqLakaw
 t1t0cSYsHwv876ZUTDemoCOxYy8iTZYN6bAdgVqejV2BqxOGVFMBS4ph3vjBnjoCcbBwmcMWCg
 utSprTg4oLW/etPa5qudLyr0Nk/Ov9Ukkuf16DG96kQAGppQUmghaEX7qnOuuZp9uUQYj/SGSy m2EZkSwqqxaI2pR/yHLsrwBd/gHwPwAAAA=
X-Change-Id: 20260724-qcom-wdt-nmi-series-06a48da7b415
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788400471; l=4986;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=2gBLdRb1tH11tec2Sox8fa5ZuVnWfYlxGOi5cpI2yXM=; b=9nnKCz1Fyt+fHFAbLnLumUakuUO2mNMbGRydMH84GxEL5HbwRYW172JED1VT/+4fTglzfWkqL
 /G3Lkw4uYXtDdotst72SCs3lcQWGdbtZKHOJFqq3kqZt8ESyRCZkWr6
X-Mailer: b4 0.14.3
Message-ID: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
Subject: [PATCH v3 0/5] watchdog: qcom: Support NMI pretimeout warnings
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
Changes in v3:
- In __cleanup_nmi() (Patch 1), serialized teardown under desc->request_mutex
  matching __free_irq(), preventing concurrent request_nmi() from racing with
  teardown.
- In __cleanup_nmi() (Patch 1), kept desc->action intact across
  __synchronize_hardirq() to prevent lockless NMI handlers on other CPUs
  from encountering a NULL pointer.
- In __cleanup_nmi() (Patch 1), moved irq_proc_update_valid() under
  desc->lock in the second phase so it observes desc->action == NULL.
- In qcom-wdt (Patch 5), enabled the NMI once during probe (enable_nmi())
  to balance IRQF_NO_AUTOEN and removed interrupt enable/disable calls
  from qcom_wdt_start() / qcom_wdt_stop(), avoiding unbalanced enable
  warnings on WDIOC_SETTIMEOUT / WDIOC_SETPRETIMEOUT (Douglas Anderson).
- In qcom-wdt (Patch 5), simplified teardown to unconditionally call
  disable_nmi() and free_nmi(), dropping is_nmi tracking and watchdog_active()
  checks.
- Link to v2: https://lore.kernel.org/r/20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com

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

---
Mayank Rungta (5):
      genirq: Synchronize in-flight handlers during NMI teardown
      genirq: Implement synchronous disable_nmi()
      genirq: Export NMI APIs
      watchdog: pretimeout: Protect governor access with RCU for NMI safety
      watchdog: qcom: Register pretimeout interrupt as NMI

 drivers/watchdog/qcom-wdt.c            | 33 +++++++++++++++++++---
 drivers/watchdog/watchdog_pretimeout.c | 45 +++++++++++++++++-------------
 include/linux/interrupt.h              |  1 +
 include/linux/watchdog.h               |  2 +-
 kernel/irq/manage.c                    | 51 ++++++++++++++++++++++++++++++----
 5 files changed, 101 insertions(+), 31 deletions(-)
---
base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
change-id: 20260724-qcom-wdt-nmi-series-06a48da7b415

Best regards,
-- 
Mayank Rungta <mrungta@google.com>

