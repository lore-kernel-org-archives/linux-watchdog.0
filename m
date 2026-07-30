Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E193B71A6;
	Thu, 30 Jul 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447183; cv=none; b=LvF7++qeJufSN5qtvc6H+/WxlVz7sDrQmHwZudeu6ILhXtThDvokBjleTC3QUui8QOZkkbieV7DA3K+wYlDHC70W0hvrSLQJdDV4uPI6bN/PFk4G4/uAjlH6rRY4nkQNoPMB9Ww5R2SkO4mTED7j+P+xV9MfsCFX4UabTcM4Pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447183; c=relaxed/simple;
	bh=E00UjiY9NGFXivfMUet7mSE4cZ9O3b+2c5MluuPTLmQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=alq9ehCoHa4CIC2MCefY+QZSG9LYxp8c45GNdoKMfSAW/THKmu6pbH5Glo1XWOGwINGm0Jget7FyKY/tMJwgVb04HB1FIGFDTEiGdc9g+IANL9btV02ePsgq6p9zAqeH3AAz7m1YeyzEN8a74uK4BcQvcgtaGac4g1E4ruLCeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSNqkABE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSNqkABE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A00BC19425;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785447182;
	bh=E00UjiY9NGFXivfMUet7mSE4cZ9O3b+2c5MluuPTLmQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LSNqkABErTHWTqIOfSbAkJy21aYexHW/Tir+rOxJJ7mqj+UMzVNQyXr409rAHLy0G
	 5AUCCtZrWluHgQ0Jv37kdATb3E4Ds+QMlMs3e7MX/peqe2tjqUM1/MZDIsyMdY1s5+
	 iRQlL1pqrwDvdqR1rWpMC72KjfVquJD8dWH2Jw0ymCDCauU5+8k6VqOXNm96nTebkK
	 qseAOZoUMYsPcwAFA/rcmNdAFo9hqjeAvJ9c38hS2MU1EdI3XzA7pz0J250bAT2fN4
	 V7WvqkvYPmf9l+Baq7Ht8UbEYb5ToF5XlJ0BVBcPkWvMqS24MeApL/4FT7MjTwh6Vn
	 Ocs1pLQj2WFmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE1C55162;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Subject: [PATCH 0/3] watchdog: qcom: Support NMI pretimeout warnings
Date: Thu, 30 Jul 2026 14:32:46 -0700
Message-Id: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7Ca2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3cLk/Fzd8pQS3bzcTF2IZl0Ds0QTi5RE8yQTQ1MloM6CotS0zAq
 wqdGxtbUAKmScq2UAAAA=
X-Change-ID: 20260724-qcom-wdt-nmi-series-06a48da7b415
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785447181; l=2279;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=E00UjiY9NGFXivfMUet7mSE4cZ9O3b+2c5MluuPTLmQ=;
 b=xBPfmoKsQ/I33VuZIsAs6ZyS5mn84msN1YcbFg2FZUvdVLGIogeKQ13E9wuGaA+EGPbkxedtQ
 O8eKW00VAxaBSx8IucQpmg/mCjApdn+ITmCAPonxuNF96QQvGykrDeG
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

On ARM64 Qualcomm SoCs, when a system freezes completely due to hard
locked CPUs with standard interrupts disabled, a standard watchdog
pretimeout warning interrupt (bark) fails to fire. To diagnose total
system lockups, we need to transition the Qualcomm hardware watchdog
pretimeout bark interrupt into an NMI (or pseudo-NMI).

Enabling NMI pretimeout handlers within loadable driver module requires
making watchdog pretimeout NMI-safe and unlocking GPL module access to
NMI registration functions.

This 3-patch series achieves NMI pretimeout enablement for qcom-wdt:
 1) Replaces spinlocks in watchdog_notify_pretimeout() with RCU to
    guarantee safe execution from NMI context.
 2) Exports request_nmi(), free_nmi(), enable_nmi(), and
    disable_nmi_nosync() to GPL loadable kernel modules.
 3) Updates qcom-wdt to request its pretimeout bark interrupt as a
    NMI (or pseudo-NMI).

Testing & Verification:
 - Built and tested on ARM64 Qualcomm Snapdragon SoC (Google CoachZ)
   loadable module configurations (CONFIG_QCOM_WDT=m).
 - With GICv3 pseudo-NMI enabled, simulated hard CPU lockups and
   IRQ-disabled hang conditions via lkdtm. Confirmed that qcom-wdt traps
   the watchdog pretimeout bark interrupt as a pseudo-NMI, safely
   executes watchdog_notify_pretimeout() without deadlocks.
 - Verified that runtime transitions between pretimeout governors in
   sysfs execute safely.
 - Booted with pseudo-NMIs disabled and confirmed that qcom-wdt detects
   unsupported NMI and falls back to standard IRQ.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
Mayank Rungta (3):
      watchdog: pretimeout: Protect governor access with RCU for NMI safety
      genirq: Export NMI APIs
      watchdog: qcom: Register pretimeout interrupt as NMI

 drivers/watchdog/qcom-wdt.c            | 55 +++++++++++++++++++++++++++++++---
 drivers/watchdog/watchdog_pretimeout.c | 47 ++++++++++++++++-------------
 include/linux/watchdog.h               |  2 +-
 kernel/irq/manage.c                    |  4 +++
 4 files changed, 82 insertions(+), 26 deletions(-)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260724-qcom-wdt-nmi-series-06a48da7b415

Best regards,
-- 
Mayank Rungta <mrungta@google.com>


