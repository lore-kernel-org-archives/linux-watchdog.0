Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576295;
	b=A+rrLFgT/RSwHkq9QR4o9GovqTfZtP+F66pC4/UDGXl1tu1pvqu56/+s4m0MxQj6HKhL
	 gib/NtGj/gh0KJf509qyuTddUXXAwkCnp7MsMQo1+PXnz0PsLwt+Z0Jb0AkWD+ervhZf5
	 ilQL8t/ZU+pDvLTF6tUVZeuI3NZfF/G647Yw3vi3gNh7uaS1TLAkmiqeNCBivnhKL9U0U
	 56b0KP7O/z9CYf2eFIMFUPUiKuOsMo9i4lKKupuLojL22dYx9eqBoYf12qJHQ5HCJeSKd
	 2rhoc+CZMiiCJktWSNzTka3pv7FS2k0d34dj9f6RfMhOME/BHchhBffEXFvQolzAMBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
	b=VBd7Bs2nWZFAbiWxMtfAASzEEDJMh2m1zOO/g0js2/XV+LgeKy5GzlmNUGUA/rZiLzSZ
	 oNXsok7JLAyEv8NTfKCnRnqYJcnoGx1aHFFMLlnzNBdmuan+8HZ932/NtfsZ3O9HAl2js
	 QCvPdV2HcXlh5uoVSHz2H5J8Qk+JGva2kL9hyY3STHmxBFo+VDbccmUKg2RqfLpwkIUCz
	 qanLroJa79Yljb1K3bpYFDuG5ZndZn6llb11AuSNIpaGH+dfIeMCID1sqVcZB3f+CDmqe
	 h6AkHzS+uP+08pF9o+LR/HRx6Dr0M5hP8iqJMdOtPkMA0+rSA+mjTYRa8MU+GWrAJEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUZcJY40;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1660A2638
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 13:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E1660A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUZcJY40
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c45551fa84eso253022566b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576294; x=1795181094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
        b=QUZcJY40kmSdAhUfOhW79cK5E5QISTrh2XUdlEp2D7XZVp8i+5/KXLvIAfbHqqhA0u
         K0ZtGPCzYwx0UEE/0D3oIkikrTZTb4ywiXcFGveZG6ka9AKmDb/8InATI0Zt6S2JQyCp
         a62pvh0Wx3aJrYpsRcW5HMBAzfivjLrzrhe/4vauiRDpdiDoMM+xP8f7ggdZxqb9L3HU
         /VNuNVu28tiOE8NPa/nuEO5M+RRwInO7V8DWxHcNEjzqKPf57sqCciJrQqdA83d+PGcO
         U21OxdeXzYlXeYO1JhnjZH/chZNPbv7Oyg7jUhtDtnUUpn1AaREE0GnXzKlrG9v7/czi
         ENWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576294; x=1795181094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
        b=w/6Ko/c7+2we/aDMuipTCtwfOUZeqDPFsbtO7KbtbC5YsbyNGiG1ksqpero04Q2CYy
         zCMIOPRI1/fZ9F/mjaBj5OSmdcYw1XdJmFDB6dFjoS535yBZBFCpFp3aqNCelXm0CQuM
         Bd3rKApPfcFcVRGqHwWizZFJm215+JbyDZEhPpoXd1qLxURvxR0Q0dDGs29DXIDuYlw1
         0zekG2TCjdT8QTinyjfaOEzAEd91eQEAFARLbC7cq42I53iR9uQ1+7xI1Qx+a7GnHN0d
         9TufsX6qO6FVsnsCTk4ImK3bznTDmcvUMeieJA/muIaQhEhdk7slFNuUeyMT/CjjwMkW
         Eg7w==
X-Forwarded-Encrypted: i=1; AL+hErHbgs6IZNs8LIKHwgrFSylzzCtQ+TwMesa/D0TaiNbtmwK8jtQ9DUYaU/ah0e6cyoz0uBiuF7JRzjrr3orCUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7xxnrp84oRPzlIM9MKo0B0OL+Onf5dHJ2gx+mOHKtQEqErSSm
	R8jKzPo0n+HQJMziDj/xWhQ6yQQgUaYsLuU6XV1q6sxYp9pZP49u0mNA
X-Gm-Gg: AYBFou0zCmTuelKDIa9MNvutXOOlbKmMP/WYm0SElBOoLiqvsuQCJkM2kJjKU+Zzkw7
	sQOi9lOImxeGyf8G5CWvEC1snVdPyXuvVrra58qi6zUGHxB7zRK4cRMny2aJDAEZSmiitql85Ax
	CDWVREscX4AcR6q5U5xLENe2U0XCeYD4lDWjGoHOY8DBOihWgTnNYPwQ1ZigzQTo+h/Zyj6ooK5
	TlByXgm1PrgLj9/gkfDDz2lQGhNPZN8u6OX31V6EfXC0eofexvLf7jl6+1r/ZVnpCVRuBgmg1oa
	P3d9eBkSGK7csh8m1mHYU4Stg2WfiiE8SoQPP21YB1y+AtUuTW2Sgw6+qu40JDXjCzV1YB9uppN
	ksF8COBNCIyt3jpEnKolT0Nlf4KblVN0O2ENhxlN9b9nBX8IzX+PnTCUon+5Wh1CxIygK4/K+2S
	+FOy5WwhphBtTAZjhP3Rr9D91s4BAkGq7TvlXXj4Ie+AIgMOg4WukLpg4QY/VGUm0SUqBrSPxUp
	zkyi82pzTP2XrJ3c4Pq8eAqCqXVASsd0Y6pUr7jJdGdg/pXLlSSSFL7J/b3ok9e9spIij5PHj+L
	zoEQdyGAR9Yaux5IORhP1MoJ2NBs/TgyaIJWpddZ2If9GSTpUM8QZEOYUArk+aG4b+Q7Za5DPQB
	+I+2YiTY=
X-Received: by 2002:a17:907:72cf:b0:c46:5c4c:7f66 with SMTP id a640c23a62f3a-c5096398aedmr209183166b.14.1794576293494;
        Fri, 13 Nov 2026 05:24:53 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d66esm4680211f8f.57.2026.11.13.05.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:24:53 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 13 Nov 2026 17:24:40 +0400
Subject: [PATCH v7 1/4] clocksource/drivers/timer-vt8500: Add defines for
 magic constants
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vt8500-timer-updates-v7-1-a1dcc4031b12@gmail.com>
References: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
In-Reply-To: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=alchark@gmail.com;
 h=from:subject:message-id; bh=EnyVwDXCZhJWH17WUOtGzbF79lP3UqVzlI+QeOXtwgE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR951+QUrd19pfLzkqLblypmLST4f6m2XmtfR+fux7w7
 Bdv+bGWt2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpjvFh+MPDJnIulv3pBWHtK8ytR5+9CszfKzTDNXR/zft/2S2+HE8YGSZs3/r
 BevexQ4oqh5pnVWZe/7HwSMEcp1/2rl3vO4TZjZkB
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add defines for the timer registers and their bits to make the code more
self-explanatory. While at that, replace _VAL suffixes with more
intuitive _REG suffixes on register offsets.

No functional changes.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/clocksource/timer-vt8500.c | 62 ++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index a469b1b5f972..c4694cf8bea6 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -24,15 +24,28 @@
 
 #define VT8500_TIMER_OFFSET	0x0100
 #define VT8500_TIMER_HZ		3000000
-#define TIMER_MATCH_VAL		0x0000
-#define TIMER_COUNT_VAL		0x0010
-#define TIMER_STATUS_VAL	0x0014
-#define TIMER_IER_VAL		0x001c		/* interrupt enable */
-#define TIMER_CTRL_VAL		0x0020
-#define TIMER_AS_VAL		0x0024		/* access status */
-#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
-#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
-#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
+
+#define TIMER_MATCH_REG(x)	(4 * (x))
+#define TIMER_COUNT_REG		0x0010	 /* clocksource counter */
+
+#define TIMER_STATUS_REG	0x0014
+#define TIMER_STATUS_MATCH(x)	BIT((x))
+#define TIMER_STATUS_CLEARALL	(TIMER_STATUS_MATCH(0) | \
+				 TIMER_STATUS_MATCH(1) | \
+				 TIMER_STATUS_MATCH(2) | \
+				 TIMER_STATUS_MATCH(3))
+
+#define TIMER_INT_EN_REG	0x001c	 /* interrupt enable */
+#define TIMER_INT_EN_MATCH(x)	BIT((x))
+
+#define TIMER_CTRL_REG		0x0020
+#define TIMER_CTRL_ENABLE	BIT(0)	 /* enable clocksource counter */
+#define TIMER_CTRL_RD_REQ	BIT(1)	 /* request counter read */
+
+#define TIMER_ACC_STS_REG	0x0024	 /* access status */
+#define TIMER_ACC_WR_MATCH(x)	BIT((x)) /* writing Match (x) value */
+#define TIMER_ACC_WR_COUNTER	BIT(4)	 /* writing clocksource counter */
+#define TIMER_ACC_RD_COUNTER	BIT(5)	 /* reading clocksource counter */
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
@@ -43,11 +56,12 @@ static void __iomem *regbase;
 static u64 vt8500_timer_read(struct clocksource *cs)
 {
 	int loops = msecs_to_loops(10);
-	writel(3, regbase + TIMER_CTRL_VAL);
-	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
-						&& --loops)
+
+	writel(TIMER_CTRL_ENABLE | TIMER_CTRL_RD_REQ, regbase + TIMER_CTRL_REG);
+	while (readl(regbase + TIMER_ACC_STS_REG) & TIMER_ACC_RD_COUNTER &&
+	       --loops)
 		cpu_relax();
-	return readl(regbase + TIMER_COUNT_VAL);
+	return readl(regbase + TIMER_COUNT_REG);
 }
 
 static struct clocksource clocksource = {
@@ -63,23 +77,25 @@ static int vt8500_timer_set_next_event(unsigned long cycles,
 {
 	int loops = msecs_to_loops(10);
 	u64 alarm = clocksource.read(&clocksource) + cycles;
-	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-						&& --loops)
+
+	while (readl(regbase + TIMER_ACC_STS_REG) & TIMER_ACC_WR_MATCH(0) &&
+	       --loops)
 		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
+	writel((unsigned long)alarm, regbase + TIMER_MATCH_REG(0));
 
 	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
 		return -ETIME;
 
-	writel(1, regbase + TIMER_IER_VAL);
+	writel(TIMER_INT_EN_MATCH(0), regbase + TIMER_INT_EN_REG);
 
 	return 0;
 }
 
 static int vt8500_shutdown(struct clock_event_device *evt)
 {
-	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
-	writel(0, regbase + TIMER_IER_VAL);
+	writel(readl(regbase + TIMER_CTRL_REG) | TIMER_CTRL_ENABLE,
+	       regbase + TIMER_CTRL_REG);
+	writel(0, regbase + TIMER_INT_EN_REG);
 	return 0;
 }
 
@@ -95,7 +111,7 @@ static struct clock_event_device clockevent = {
 static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
-	writel(0xf, regbase + TIMER_STATUS_VAL);
+	writel(TIMER_STATUS_CLEARALL, regbase + TIMER_STATUS_REG);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -119,9 +135,9 @@ static int __init vt8500_timer_init(struct device_node *np)
 		return -EINVAL;
 	}
 
-	writel(1, regbase + TIMER_CTRL_VAL);
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	writel(~0, regbase + TIMER_MATCH_VAL);
+	writel(TIMER_CTRL_ENABLE, regbase + TIMER_CTRL_REG);
+	writel(TIMER_STATUS_CLEARALL, regbase + TIMER_STATUS_REG);
+	writel(~0, regbase + TIMER_MATCH_REG(0));
 
 	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
 	if (ret) {

-- 
2.56.0

