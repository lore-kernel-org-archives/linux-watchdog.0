Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8677558214;
	Tue, 22 Sep 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088656; cv=none; b=MZRAqfH1FPfOQYFObS3CwEPTAlBiUkvXm7e8ODnxi/v8cUC8TclTK6SuYLci2cShJzq9VElNpJ1LTcpcXaPG5T85VDwUWJsxrYxGXeT6hpriMtw7iU6wioOp2DSQNvNle6sI5eWKoqINHmhxS5DTYKdyvsitfyhGVu1MGW1OosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088656; c=relaxed/simple;
	bh=lDtmhJmV6Wbp5HKP9IFkRyOu/lRw+F/mFuEyXnPycd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc:
	 In-Reply-To:References; b=iqL0fq2JRJ8MLmvCFag4HiO5USaTuPAsLuue79CQHtNNP4DqxczySrbWsvXj05mvzoJnFzFp8VHZ0ojHpcZ3PBtty5eKNnNL+aiZs4tsDlqgRCoAo39yLzBOJ6qyxiS2PqRhsdhC/rIlq+WFs6uPoN0ClllnlsDiA9K6US/vVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BKiChnHw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BKiChnHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-ID:To; bh=PbjitZa4y0zkebEx9oxqzAkgxp1VA1mYLEfDSrjZZOg=;
	b=BKiChnHw7QR+FtUVdUEzp11z9zsBu0D0Onc+FrC8j3HJzswQwnAg4nYtYlQ+HC
	uqqBIQGlzW8UVLdnfCbfQ6hHRFBbhWcXFDZC9IzK32c8t8Ure3mDD+V+EBfCNDEx
	JsbABNK0zKELj/Vl7IboNOWfQWqEMYBWi07t3WA6G/Cfg=
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
Date: Mon, 21 Sep 2026 14:29:14 +0800
Subject: [PATCH v3 1/2] PM: hibernate: use kstrtouint to parse resume= device
 numbers
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <20260922153000.10086.1-m18667909625@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, m18667909625@163.com
In-Reply-To: <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
 <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
X-CM-TRANSID:_____wD3fwSqlbJqh3OTAA--.12933S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWrAr4UJFWfKF1UWF13twb_yoW8WrWfpF
	WDAa98J3y7Aw4UCasruFs2vasIqw4kG3W3GFZ2qw4fAry7trnYqrZ0gr1YgrW2qrWrW3Za
	qF4rtws09rW3GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirOz7UUUUU=
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC4g-X3Wqyla-G3wAA3c


simple_strtoul() is deprecated. Replace the base-16 parse with
kstrtouint(); the explicit trailing-character check the old code
needed is provided by kstrtouint() itself. As a side effect, values
wider than 32 bits are now rejected instead of being silently
truncated before the dev_t conversion.

Signed-off-by: 林濬哲 <m18667909625@163.com>
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


