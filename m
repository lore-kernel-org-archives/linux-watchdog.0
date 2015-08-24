Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36471 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbbHXRDY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Aug 2015 13:03:24 -0400
Received: by pacgr6 with SMTP id gr6so377370pac.3
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2015 10:03:24 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 7/8] Watchdog: enable ACPI GTDT support for ARM SBSA watchdog driver
Date: Tue, 25 Aug 2015 01:01:22 +0800
Message-Id: <1440435683-7343-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
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
index b2734f0..2719093 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -178,6 +178,7 @@ config ARM_SBSA_WATCHDOG
 	depends on ARM64
 	depends on ARM_ARCH_TIMER
 	select WATCHDOG_CORE
+	select ACPI_GTDT if ACPI
 	help
 	  ARM SBSA Generic Watchdog. This watchdog has two Watchdog timeouts.
 	  The first timeout will trigger a panic; the second timeout will
-- 
2.4.3

