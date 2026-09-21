Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB1292B2E;
	Tue, 22 Sep 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056315; cv=none; b=ROk1r22EUHwuMkJDOBzyCGW+NAlDCq10Ezhfpa5ttk6NRKYF1en470hFt/LPSf4othyVgVc2oX5I8Sy4gIdmWmLD9tpfcuW5h+b1OHBardaD4WyRp6aNbmE/rBsTPlhYdv+CuTXmZjlL2ahegusOG8nVvpxILIccV3LZ6wtjzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056315; c=relaxed/simple;
	bh=7LZbzz8AuWhOj2y1AcZipeWI3tuXTVUQCNXEs8Rijuk=;
	h=From:Date:Subject:Message-ID:To:Cc:In-Reply-To:References; b=PyZcXn4rcwkoKBrzf3dZ+01lTYOTKfgm+3tee+B2QrzCfj7pPTDf4UO7vZ3FFcxo8MXb9VcoPM2qBhHITRdd2mo1lbPpQ8dDnHLYJMFBGt7qBfEyGuOK6/GJg+Kim3Jcr4vajPi05N/kJ/c2KWAgJBhZCR2SwaLCEY+rS7LjIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lWt51rzr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lWt51rzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:Message-ID:To; bh=qPg+xT2nZp1LB0v
	ODxjLfG0lJiXbY4waXludc0tE6aI=; b=lWt51rzrWj380Egrr1m9uuRJwzXPxfL
	6sxbIn+/r1FW2XIeuI85benSS6XNBrtcrwaO6wOTfsiJ6n7VbzAZApsAhMYFoGug
	gqnWJOpcQ+v6gYzt6n+6IoHTMJwP0c1MeEm7I+KmMDTMR+oPKdcFjWcv+Q7PL7Qa
	Gvl5vKazDJUo=
Received: from LAPTOP-EGO65D59.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3vxFbF7Jqt9w6AA--.27425S3;
	Tue, 22 Sep 2026 13:51:27 +0800 (CST)
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
Date: Mon, 21 Sep 2026 14:29:14 +0800
Subject: [PATCH v2 2/2] PM: hibernate: use kstrtouint to parse resume= device
 numbers
Message-ID: <20260922060000.10086.2-m18667909625@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, m18667909625@163.com
In-Reply-To: <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
X-CM-TRANSID:_____wD3vxFbF7Jqt9w6AA--.27425S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWrAr4UJFWfKF1UWF13twb_yoW8WF1UpF
	WDAa98J3y7Aa1UGasruFs2vasIqw4kG3W3GFZ2qws3Ary7trsYqrZ0gr15KryUXrWrW3Za
	qF4rtws09rW3GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pZg4dcUUUUU=
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC4QAlK2qyF2CH5wAA3g
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>


simple_strtoul() is deprecated. Replace the base-16 parse with
kstrtouint(); the explicit trailing-character check the old code
needed is provided by kstrtouint() itself. As a side effect, values
wider than 32 bits are now rejected instead of being silently
truncated before the dev_t conversion.

Signed-off-by: Lin Junzhe <m18667909625@163.com>
Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
---
 kernel/power/hibernate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..74f2d20518cc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -14,6 +14,7 @@
 #include <crypto/acompress.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/suspend.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -1278,7 +1279,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	error = lookup_bdev(name, &dev);
 	if (error) {
 		unsigned maj, min, offset;
-		char *p, dummy;
+		char dummy;
 
 		error = 0;
 		if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
@@ -1288,9 +1289,12 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			if (maj != MAJOR(dev) || min != MINOR(dev))
 				error = -EINVAL;
 		} else {
-			dev = new_decode_dev(simple_strtoul(name, &p, 16));
-			if (*p)
+			unsigned int val;
+
+			if (kstrtouint(name, 16, &val))
 				error = -EINVAL;
+			else
+				dev = new_decode_dev(val);
 		}
 	}
 	kfree(name);
-- 
2.54.0.windows.1


