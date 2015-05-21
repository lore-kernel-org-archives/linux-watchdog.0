Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36026 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbbEUIdV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 04:33:21 -0400
Received: by pdfh10 with SMTP id h10so100486365pdf.3
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 01:33:21 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v2 1/7] clocksource: export "arch_timer_get_rate" for the other drivers
Date: Thu, 21 May 2015 16:32:30 +0800
Message-Id: <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Some devices get clock from system counter, like SBSA watchdog
driver. They may need to get system counter rate.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0aa135d..4327bf9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -410,6 +410,7 @@ u32 arch_timer_get_rate(void)
 {
 	return arch_timer_rate;
 }
+EXPORT_SYMBOL_GPL(arch_timer_get_rate);
 
 static u64 arch_counter_get_cntvct_mem(void)
 {
-- 
1.9.1

