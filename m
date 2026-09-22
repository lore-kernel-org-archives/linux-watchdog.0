Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE22741B6;
	Tue, 22 Sep 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056315; cv=none; b=EQZxHHUpl2x9AYjCSlDvqJd8FQ4lxx95EYh8EKqRi2FjSqBpC+430fZuLYBJYnrBZbqgMU0y45CtCRFDoE9oZn9LwRtjhgQ4d4ajI208gqBJk5Xj3t9UYiMAawBywoiQFnRdopo6R/sSUe4caz1P3/LB9n+vUGsHUiDyYWrsigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056315; c=relaxed/simple;
	bh=xZUzw7nc1EXcZxSJlwT9qrO1jmIVJYHWDzhEpRJUfr8=;
	h=From:Date:Subject:Message-ID:To:Cc:In-Reply-To:References; b=kiJFN97ULnM1YRz/UkNYE++XVQ8AeyElZOZc8fT7StfIVXe4l9PD94A7nP0rYYBZlLg/pCmOsP4XfuAOs6eWnZ72G09Ta1HQpCv0VRBMWHdtq2pZw0Uvrwpykl+CnXfTcvCh+aR1bsKrQK0Vb5lm0uJZlOHulyPn59md7b5WkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gdwZFPAR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gdwZFPAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:Message-ID:To; bh=KvvFe+sLiESyR6N
	9N/mK1t6EzZTBoUjzMj3IOG+U2Vg=; b=gdwZFPARF5qkWBjh3r37zyODNnxIo5W
	eR/yJau1suUrmApfIJIeCzRWyuI2FCuYvZw2UzBInnWShvhOsFM3vRDGxrH8+zxc
	LoE/otilh4yRyVtpoOmlYfVwhoZyClMl0bY48GAWIWB1iJY502OFv9ArOob990pL
	ZLP1CRuWP07E=
Received: from LAPTOP-EGO65D59.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3vxFbF7Jqt9w6AA--.27425S2;
	Tue, 22 Sep 2026 13:51:26 +0800 (CST)
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
Date: Tue, 22 Sep 2026 13:50:40 +0800
Subject: [PATCH v2 1/2] watchdog: use kstrtouint to parse softlockup_panic=
Message-ID: <20260922060000.10086.1-m18667909625@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, m18667909625@163.com
In-Reply-To: <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
X-CM-TRANSID:_____wD3vxFbF7Jqt9w6AA--.27425S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw47uw4rZw1UXw13tw1rtFb_yoW8Gw4UpF
	WDCayDt3yxt3Wjv3WxAF92kryaywn5Xr47JFW2gws3Aw13tFn5trZ5uryS9r1UZrWagF15
	uayjqr4ruw45tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pircTkUUUUU=
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC-R4kKmqyF15aQwAA3l
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>


simple_strtoul() is deprecated. Replace it with kstrtouint(). A bad
value now leaves the variable unchanged and produces a warning,
instead of being silently clamped.

__setup() handlers return whether they handled the option; there is
no way to propagate parse errors, so the handler simply returns 1.

v2: warn on a bad value and return 1 instead of returning the parse
    error, which __setup() handlers cannot do (Guenter Roeck).

Signed-off-by: Lin Junzhe <m18667909625@163.com>
Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
---
 kernel/watchdog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index e5134ad7b663..7f8c904554a9 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 #include <linux/kernel_stat.h>
+#include <linux/kstrtox.h>
 #include <linux/kvm_para.h>
 #include <linux/math64.h>
 #include <linux/mm.h>
@@ -422,7 +423,11 @@ static unsigned long soft_lockup_nmi_warn;
 
 static int __init softlockup_panic_setup(char *str)
 {
-	softlockup_panic = simple_strtoul(str, NULL, 0);
+	int ret;
+
+	ret = kstrtouint(str, 0, &softlockup_panic);
+	if (ret)
+		pr_warn("softlockup_panic: bad option string '%s'\n", str);
 	return 1;
 }
 __setup("softlockup_panic=", softlockup_panic_setup);
-- 
2.54.0.windows.1


