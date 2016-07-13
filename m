Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
        jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, jslaby@suse.cz,
        christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 5/9] MAINTAINERS / ACPI: add the ARM64-specific ACPI Support maintainers
Date: Thu, 14 Jul 2016 01:53:18 +0800
Message-Id: <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This patch add the ARM64-specific ACPI Support maintainers in
MAINTAINERS, according to the discussion on mailing list:
https://lkml.org/lkml/2016/6/29/580
Lorenzo Pieralisi will submit the pull requsts.

The maintainers are listed by the alphabet order of
their name.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1209323..1e03463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,14 @@ W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/fan.c
 
+ACPI FOR ARM64 (ACPI/arm64)
+M:	Hanjun Guo <hanjun.guo@linaro.org>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+S:	Supported
+F:	drivers/acpi/arm64
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-- 
2.5.5
