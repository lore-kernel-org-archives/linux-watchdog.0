Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BF3D75B5;
	Thu, 30 Jul 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447183; cv=none; b=GYEah9joJtZYpRUY2bWUY3jNlCVFPgC4ccl8aHRr4+DKmOdVPRO6S3bkxO4sphZkOpYtcegXnzhmDAdNBpJLU6E82NPPb1hS6ZERzoKgX1mLydPQRHl3+u3qmM2HkEHsEPKWuQ2pbFGDQsPwLgVZlqW9OUI/aiVd2C6+IPMpmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447183; c=relaxed/simple;
	bh=eRhty6GrrEg3GxuUbOcfzmWSVNdAZkXUSYEBqJvLTH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7nInw3jeBAKwHzvswR0kdHinncZuYr6fXcA3/8n6zgcoGezQ8n/W6W9EZqXdWxRrWrh3K8FZZlY91fablW2lz2PZHJ1zjnLVyFP2kjjNyWJuYAOkhbykkpkNQW+C8Usi7z6923V1o3s7j3L20Icwldph78R2TSUH6zrUtmg4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjSPnvjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjSPnvjM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 864C9C2BCF7;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785447182;
	bh=eRhty6GrrEg3GxuUbOcfzmWSVNdAZkXUSYEBqJvLTH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SjSPnvjMhaz/kf6hyq+AqWur8t+T5TGYlzdGqrHOdRxVXS1M7zpTDkJEPLLoiP2/D
	 Tao7JWDE5QtK6vBMNVLpvSW9l56ms31G1nUVaX0Jw64bI0adePZ523BDZg/NFSMvvb
	 sfqQMztcyBC17+l8l87hrJtQtn5IqSKzQVEgM/u46fkyukl/E55SUSFuabEga0w98g
	 VYOgxT2SJ8GIUGtvv9JrO7JNtmy1EW3MmaisoMkDiyOfH+CacP8bGrndld7XcOmWCK
	 PKe9rUauBGi4PrwlIW0cmAQRah6pWgHsxC2RLlZhSqPOHLIHGFTN9RMyKXZUpAiN/b
	 Ie5WXy9FGk+uA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB3C5516E;
	Thu, 30 Jul 2026 21:33:02 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Date: Thu, 30 Jul 2026 14:32:48 -0700
Subject: [PATCH 2/3] genirq: Export NMI APIs
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785447181; l=1464;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=rdW88WNWcCzQEMOzt9UqoD+4nGwHea4B7drgBd3eHzU=;
 b=3/hZMpOPEiZ5AgoGkMS7xLaW0yXKNd2LDLMcEOXBpzSUTCs92XAcKOlhVpgR0C6pNiERQ1T0W
 vtfwKHZuM49BWOjMyvs58IuE3bJdpxbH/LQjAaRS7D7j/wWGmIJ4eMG
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

From: Mayank Rungta <mrungta@google.com>

Currently, request_nmi(), free_nmi(), enable_nmi() and disable_nmi_nosync()
are restricted to built-in kernel code because they are not exported to
loadable modules.

Export these APIs to allow loadable modules to register and manage NMIs.
This allows watchdog drivers configured as loadable modules to register
their bark interrupt as an NMI.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 kernel/irq/manage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2fbff2618a1e..fb0b8da32f4c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -766,6 +766,7 @@ void disable_nmi_nosync(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 }
+EXPORT_SYMBOL_GPL(disable_nmi_nosync);
 
 void __enable_irq(struct irq_desc *desc)
 {
@@ -833,6 +834,7 @@ void enable_nmi(unsigned int irq)
 {
 	enable_irq(irq);
 }
+EXPORT_SYMBOL_GPL(enable_nmi);
 
 static int set_irq_wake_real(unsigned int irq, unsigned int on)
 {
@@ -2080,6 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 
 	return __cleanup_nmi(irq, desc);
 }
+EXPORT_SYMBOL_GPL(free_nmi);
 
 /**
  * request_threaded_irq - allocate an interrupt line
@@ -2342,6 +2345,7 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(request_nmi);
 
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {

-- 
2.55.0.508.g3f0d502094-goog


