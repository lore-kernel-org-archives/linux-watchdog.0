Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5761C695;
	Mon, 21 Sep 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972943; cv=none; b=Ps6VkAf8Si4uSyE1a6Wv6PPh4vWcKu7bEm6faJUNeqUV2TsZ6/kq/xD0A7pApNyGxBJOHaWFNUmflB3z2EHqa/S7VmcLypdgtZ3DNird+doPreWhiPHoEYtdvNoP/fbQcrNqq8ajHJCTWvxrsDeKPCGMPq7TNeWFzQmwOC92tbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972943; c=relaxed/simple;
	bh=zYD0KpVOxyQHzjtHpV3fSNt9jpDyXWVzvsBzMnMRGa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gjUMmXT1FrAXWBNk2Gc8OOHqu3J1ZrmZJIM5ixsNtOW1jiL7GV0lZF0Ub7xlrDTOw3VGpDWqtbC446H085NRFMN7zVJY4j9/yJ3xGPwnGmQSAXtmzQuxVuoFxtnkFw35gZkEGjQ2Etcg2kF8HGnuMt0MiDKmMNJcbXDroxdzcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dn8R9lKf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dn8R9lKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=sl25kRquHhvqNSb5l8LQ//OWRtYtvBBZ8PbfLgJLckU=;
	b=dn8R9lKfA2SdwDZhkSbTeYjLOsVrOk9cO8keDWvNKA79e/QOcrZbe3VVIzbOkO
	I9SWpvV5V8dr3WFx/pb3NxeIX+wR6lGVoi3b16OPAnMnGGaCHXmtnrhfsPw3bt5g
	k19rlgt27DwzXwL1TFrvxNVzjMwmKL9DxaaZwLCzj4Hts=
Received: from LAPTOP-EGO65D59.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H36r0bBq6sFTCA--.45496S2;
	Mon, 21 Sep 2026 14:41:51 +0800 (CST)
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m18667909625@163.com
Subject: [PATCH 1/2] watchdog: use kstrtouint to parse softlockup_panic=
Date: Mon, 21 Sep 2026 14:41:43 +0800
Message-ID: <20260921064143.81420-1-m18667909625@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H36r0bBq6sFTCA--.45496S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry8GrW5ur47trWrZF1DZFb_yoWkJwb_uw
	1I9r4UWFyjyr12qF42vwsxXF9Iqw45JF1UuFn5tFZrJF1DA398W393Jas5JF93Wa4vyr1S
	9FyUGrsagr1qkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt7KIDUUUUU==
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC-g9mbGqw0a934QAA3J

simple_strtoul() is deprecated. Replace it with kstrtouint(), which
also reports parse errors back to the boot process instead of
silently accepting garbage.

Signed-off-by: 林濬哲 <m18667909625@163.com>
Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
---
 kernel/watchdog.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index e5134ad7b663..420f08140713 100644
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
@@ -422,8 +423,10 @@ static unsigned long soft_lockup_nmi_warn;
 
 static int __init softlockup_panic_setup(char *str)
 {
-	softlockup_panic = simple_strtoul(str, NULL, 0);
-	return 1;
+	int ret;
+
+	ret = kstrtouint(str, 0, &softlockup_panic);
+	return ret ? ret : 1;
 }
 __setup("softlockup_panic=", softlockup_panic_setup);
 
-- 
2.53.0

