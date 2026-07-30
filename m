Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DE3D811B;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448827; cv=none; b=IfkEjejvdR2E7XxCPRZT+smxULOyHQQRc6/CHs91GFVwkdwDG1grB2D0ejNi8lMt4jslGvDgTY7hMdgU6e+NnpqiBgai/ekX1pqogYxkspLHmHySeJ/FFkbPmJAGpLkz5+hPFbm8x/7QG6KChEqr+kOSuVCifPZFQotYGxET15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448827; c=relaxed/simple;
	bh=Fs4ESrYUNwOx1GQcctjVjuAY5GAIM0pyAfX46shxH2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fw2lAdB7WKDdzhUbRIG09pZSW6yliz4aLrDnfmi1zNVffeJHL4lScIcn012YfDvL9Ixbxzi2wubaVsKpcpBxfgNMZxxw+JiQ91o+7HsVey8c0i10woEL+D3sId8VXE6BXzMuGLrGzPVg0Uz/siooiUJUJoDiH6Or2mGhD1MjARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FazDR7Md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FazDR7Md"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23E2EC2BCF4;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785448827;
	bh=Fs4ESrYUNwOx1GQcctjVjuAY5GAIM0pyAfX46shxH2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FazDR7Md1OHw8VM4u7NFeJUAVpf04S+Q9AkUgEEtNP1mSXbBRqhFUCdkllU/KneqW
	 7DmB3QukPl6+gH7G8p9tLutTwF1wCcJxMO2Q9LffoBzLuyqElEJJnsQto939MndTbh
	 UD2rX+IwLZdRMnxOHz/fBoJ2mZN8MKr2MHt9cngN3XVaWcsAHuxBgm+tQvjs1whAvi
	 2ytu4WtHAFnOvuLgw7AijCLFGBjzlX3Rut/t7EtPWAoRTUu9JMmcj9jP9Bu/sDu0RX
	 Q3Zj/skJbfbrVYSpGaVpqj/qI9q8BtJn+GJ8ZdQxy2tMUhN0BC6PpKWavZU0aEFb3f
	 MpxcbGY8HwAzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C25C55171;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Date: Thu, 30 Jul 2026 15:00:22 -0700
Subject: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout governor
 to tristate
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785448826; l=1193;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=f5W+Lr+D6y/aPDppSlY4If7YQ/lnBLFc82lZnHrC3p8=;
 b=Hf4P9bSr81uHIQQkvhAXzHtv5u6EsLHuPCyFHF87+AgJlZxnV2Im4CKn8mSyruug2su1FpHEp
 56Xv8Y21o6KBAE2X0DCKFqfbZZCLGUxHUf6aOYrJO3wz4BxKCnDqU8q
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

From: Mayank Rungta <mrungta@google.com>

Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout
governor") added the "dump" watchdog pretimeout governor, but restricted
it to built-in code because trigger_all_cpu_backtrace() was not exported
to loadable modules.

Now that CPU backtrace APIs are supported for loadable kernel modules
via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
tristate. This allows kernels to deliver the pretimeout governor as a
loadable kernel module.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 drivers/watchdog/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9f013d774897..922741dd837c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -99,8 +99,8 @@ config WATCHDOG_PRETIMEOUT_GOV_SEL
 if WATCHDOG_PRETIMEOUT_GOV
 
 config WATCHDOG_PRETIMEOUT_GOV_DUMP
-	bool "Dump watchdog pretimeout governor"
-	depends on WATCHDOG_CORE=y
+	tristate "Dump watchdog pretimeout governor"
+	depends on WATCHDOG_CORE
 	default WATCHDOG_CORE
 	help
 	  Dump watchdog pretimeout governor, all cpu backtrace is

-- 
2.55.0.508.g3f0d502094-goog


