Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33988 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933199AbbFWQBE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Jun 2015 12:01:04 -0400
Received: by pdbki1 with SMTP id ki1so10084434pdb.1
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2015 09:01:04 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v6 7/8] Watchdog: enable ACPI GTDT support for ARM SBSA watchdog driver
Date: Tue, 23 Jun 2015 23:59:40 +0800
Message-Id: <1435075182-20182-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch enables ACPI GTDT support for ARM SBSA
watchdog driver automatically, if ACPI support is enabled.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e059850..50a70f7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -157,6 +157,7 @@ config ARM_SBSA_WATCHDOG
 	depends on ARM64
 	depends on ARM_ARCH_TIMER
 	select WATCHDOG_CORE
+	select ACPI_GTDT if ACPI
 	help
 	  ARM SBSA Generic Watchdog. This watchdog has two Watchdog timeouts.
 	  The first timeout will trigger a panic; the second timeout will
-- 
1.9.1

