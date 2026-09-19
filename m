Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CF1E7C18
	for <linux-watchdog@vger.kernel.org>; Sat, 19 Sep 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845795; cv=none; b=AS+YlipxU5RwQodOGDCYFfhQRMk0pgBCoMV8t68RXdXtziWKEQcD0605bMiXEVw/egyoHy2y4IlZBRluWot9IFBGpznFst/iezntAWki29sT0JcADFfZXiJ/1T2NDwPHp363BdjUh96a3ALHOEboMbqKUNTWCsaAfZKypM/Zd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845795; c=relaxed/simple;
	bh=HkwdYYavoCzUVmVDYA0u9dAUtzhuUn5NkLCIprEbhSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+5evWztfFEqJFiah+CjLXXxlct54dBKZRCIQAfoO43FAjLgLss0ZJLqERfUgl2JTsay3H2dL7hK+9NIhRML/a9yTL86j7x9FprCoyUbD832LYqt1Z/zs7OQa+BfLGTx1sOuH6jUq+JFX3kmd26AP+mzQbrsg0DLFk7Cmpg/uCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4KlA0Zv; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4KlA0Zv"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so5529905e9.1
        for <linux-watchdog@vger.kernel.org>; Sat, 19 Sep 2026 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845792; x=1790450592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ7hjSvC4JR794fg8Wgo8xaMKU0Sd4wen0Z8CCJoqUI=;
        b=D4KlA0ZvCt63M1vppDzspYjOMTFAwxLRbGEXyQU4hmPD6jV5YT1wDG3a927YTZxcFW
         wdzyForZc1vsWf5Ry86+gi+k7H90L/fpgDL6s6RppX3jio3H20fNJAbPSrZqeE0ct75Z
         mKo+LTqiPViOCalr6axEPj5x/gnb2CrNmiFF9j4W84+ltm4MnBiEPVSDC/X5wfFKnafc
         rX4+VIm6JRIWwdlB11nHnEW6LftyjBQeNlTDHeRjGB4hqxohYIYHORf61Vnu1bMe/7ou
         a6xwLVimCKCutqNITyVC4usZSmBLQHihuifYRUSv60VQ4of2k0BBfyQYGXc9pTtClraT
         EaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845792; x=1790450592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ7hjSvC4JR794fg8Wgo8xaMKU0Sd4wen0Z8CCJoqUI=;
        b=VKqXkaBx1FWJu4naWlkwAqp+K1Xfw5/WFFa8GB3xVZ9/E5jsH4DpJaZAqbJ1NRdn78
         /1us0aqFSv04odFZsXozb06fEit/lOG2AqBONRnwv90/vh8guvfg3ItWibsOaF5rkZ7z
         lxHYhqB+p9h7OqwqXDDKDsyUP/1jLpZIAhYdYkNibfIbNSUVe6ejJVWjLh2MCO5cFUQO
         WHN5sAiRZeenuA4Bwo0E8n7xpD6eU7ML98CT52PMpK4PO1pynooGxz8U2aELKPqpQV7a
         JB2oW24KG1ZupqXvFQSdhfHtpwYM729QY+v1sKFfsdi7b3jHFmv89EJw8P0bL/hztG7J
         r5qw==
X-Forwarded-Encrypted: i=1; AKwUvBy2fffGDZUquAX+/vsRV+gH3VYUbSyi3x+l/K2TjDtOd/vhWofYnvPD8XRhFKZMs02qHw8Ra/EluLqRHhVHXg==@vger.kernel.org
X-Gm-Message-State: AFuF++n0umCDqQ0EBLqohpmASqhki4dvSVISlj/HURXerVLeUp54DHGm
	5e+2ugoYRhryCU73whq1db52Zckwo3MRqTrkEqCjEuK14Mbu19wv0cvI
X-Gm-Gg: AYBFou3rURKVJ7+Z4uxuhVwzAAqtSNEuYowjSwuRscOKIltw3FuOvPUr3xLlDL6IZbk
	DfTkEyIxwTP+RlI2k3N7yLwCZ7oT5VqLMGxftta8d6IIIk9OVkLQQeRUxOyEpqHSDuYCE0zXieV
	A5doTLyLK1XX/pDUrYDSGNgcNGsETxC5D/4sWPl29oSWhffYoM7xS9bl6i+aier+H8bGiZfbBil
	qT8bI6vAWzry1Y8mow5J9OMPUYO99HkNTh/x9jFbv0ouxL/m1MZsA4G++bAmD4SzPblFiCLkLbh
	izofPz96tlTZKiQRqZMm5Vlhd+eeZdALuij3pNbZ2iVahUfEGumSLsR//RJqCLmCIrHsMZK3XoT
	bhGawgKVMXi3gfbZKEavb3fUG0pHCRgVW2KIf2couy6ZsD14k0GRxWzOeizZcIzgAHn6xm0b4ph
	UGTUyRcjIaUX6zWy9vMKTbqDOcgP8kePxWNuXMATUseDG9rYOHeGBytQwg9H6eD36MMcK6f4bxh
	a9W3cVMQubB6xRDuU2tcNwA5/50fluW68uQvNkIpyVpsv4Pc0g=
X-Received: by 2002:a05:600c:310d:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fc4f85891mr103323205e9.5.1789845791767;
        Sat, 19 Sep 2026 12:23:11 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm93535485e9.5.2026.09.19.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:23:11 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	davem@davemloft.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] watchdog: cpwd: serialize device access against cpwd_remove()
Date: Sun, 20 Sep 2026 00:23:01 +0500
Message-ID: <20260919192301.272194-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpwd_open(), cpwd_ioctl() and cpwd_write() all read the global
cpwd_device pointer directly, while cpwd_remove() unmaps p->regs and
then sets cpwd_device = NULL with no locking shared with those paths.
misc_deregister() does not revoke file descriptors that are already
open, so a process holding one across an unbind/remove can still
reach cpwd_ioctl()/cpwd_write() afterwards: it will either dereference
p->regs after of_iounmap() has torn it down, or run into a NULL p once
cpwd_device has been cleared.

Take the existing cpwd_mutex around the whole of cpwd_remove()'s
teardown, and have cpwd_open()/cpwd_ioctl()/cpwd_write() re-read
cpwd_device under the same mutex and bail out with -ENODEV when it is
NULL. This makes any in-flight call finish (or fail cleanly) strictly
before or after teardown, instead of racing it.

Fixes: 8ab0dc333eac ("cpwatchdog: Move to drivers/watchdog/cpwd.c")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/watchdog/cpwd.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 13a4d47e68cd..48f5e92b8cbd 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -368,9 +368,14 @@ static irqreturn_t cpwd_interrupt(int irq, void *dev_id)
 
 static int cpwd_open(struct inode *inode, struct file *f)
 {
-	struct cpwd *p = cpwd_device;
+	struct cpwd *p;
+
+	guard(mutex)(&cpwd_mutex);
+
+	p = cpwd_device;
+	if (!p)
+		return -ENODEV;
 
-	mutex_lock(&cpwd_mutex);
 	switch (iminor(inode)) {
 	case WD0_MINOR:
 	case WD1_MINOR:
@@ -378,7 +383,6 @@ static int cpwd_open(struct inode *inode, struct file *f)
 		break;
 
 	default:
-		mutex_unlock(&cpwd_mutex);
 		return -ENODEV;
 	}
 
@@ -387,14 +391,11 @@ static int cpwd_open(struct inode *inode, struct file *f)
 		if (request_irq(p->irq, &cpwd_interrupt,
 				IRQF_SHARED, DRIVER_NAME, p)) {
 			pr_err("Cannot register IRQ %d\n", p->irq);
-			mutex_unlock(&cpwd_mutex);
 			return -EBUSY;
 		}
 		p->initialized = true;
 	}
 
-	mutex_unlock(&cpwd_mutex);
-
 	return stream_open(inode, f);
 }
 
@@ -413,9 +414,15 @@ static long cpwd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct inode *inode = file_inode(file);
 	int index = iminor(inode) - WD0_MINOR;
-	struct cpwd *p = cpwd_device;
+	struct cpwd *p;
 	int setopt = 0;
 
+	guard(mutex)(&cpwd_mutex);
+
+	p = cpwd_device;
+	if (!p)
+		return -ENODEV;
+
 	switch (cmd) {
 	/* Generic Linux IOCTLs */
 	case WDIOC_GETSUPPORT:
@@ -482,8 +489,14 @@ static ssize_t cpwd_write(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
-	struct cpwd *p = cpwd_device;
 	int index = iminor(inode);
+	struct cpwd *p;
+
+	guard(mutex)(&cpwd_mutex);
+
+	p = cpwd_device;
+	if (!p)
+		return -ENODEV;
 
 	if (count) {
 		cpwd_pingtimer(p, index);
@@ -618,6 +631,8 @@ static void cpwd_remove(struct platform_device *op)
 	struct cpwd *p = platform_get_drvdata(op);
 	int i;
 
+	guard(mutex)(&cpwd_mutex);
+
 	for (i = 0; i < WD_NUMDEVS; i++) {
 		misc_deregister(&p->devs[i].misc);
 
-- 
2.55.0

