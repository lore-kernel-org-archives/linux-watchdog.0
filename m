Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509725;
	b=xOdJxNRN3c7+bHG2ndrRG1xvNuPdrQeDD/rnS13Z2+8Pc9slIXnaLEXOV822Rr3yw6Jk
	 Y3Ua8/hCwjSv/X224Fjm4C7T6iqcjBXmr5gKB/mdIWYrk2NnPAZR+QT9JSLzaePdOzKZc
	 mISQmh1OW92zwbSQ508K+iQVm501Tf8tu6DdCUSK1eA5+umPvT0lgWh9WlxkccVIUx8UB
	 0GeOTNCwLN7ZzWfHZJV8qa64OvAMYfZycOm4S9DeDrwpmKV7cYaKjv3K9CDH9sIUlqoSQ
	 AOZmKA3TXDT90Yp7035fRNmG8hePNE0lxka86+5eicb3zsNcD1FrKgrtE8ad5jL0EHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
	b=Z+YMK+gzsc6YcII+dUMtRS42rEP60+utERUHOJv6/GxRdRjwJB5W2JhuNwGH9voMo2Lj
	 8M/RV+bc/6Md8EgW82AnCfBBCabdulO5/hC5PM0kDSpdyKG6XOBNcxJ0xQqHIk0+8jYEY
	 BG6+mVkqv8AbONfBaPaaIIm6UyK3Y2bSVzrGKNuuyOiBWaRwJxRhoxqtxXuoiImvadvwT
	 SI3g2mqO5olUzp1CgDrUBLEEoJiqVRZm0wVdd6k/yH6gvyJbczKWDE6I+1278r7pWiQ93
	 wTyQ+O+gU9kd5hSN7yODxNhXiYjDXabPwTFrWX5BM9fNbj3jMRVAla4wMffZ50wkSVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUHItoli;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED6606A8B8
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 18:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8ED6606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUHItoli
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so7743355e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509723; x=1795114523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
        b=BUHItoliVUunVb9q2HMInjMIXURcpWmo5x+MDSgCzfux//hOv/v5JERePi5sTf7VlI
         uZYPx7bV5nfQO+B9zmxLJm4SluP/6bouRVHKeS0QMqvVDMzgmPevS3z7i1SA29LskJ/l
         2QEvPPNoj6WYEW63NKHKhafxyvAHlPLAEn6rGSERA5DNO6dfYsFyV2vumbodThP5F422
         7yxwBF5vksWrwpSFnAQGY0jMLiK2KlyMp2gstPObglydsnxnwHFCpQKMwGKIxdugOBet
         B4cDa5rr/MiYuFjlv7eRSZ7kGBO8O7lxuhNVcRSccqBehQ0CO+sjAHdVnbnZiOxiS7Jt
         1T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509723; x=1795114523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4iEaD8NWzFH56Fd6ulOFSIYM+4Rcg1gxrmby4HTmHM=;
        b=kraASTgmWKT1VfYfK9kG6izRpxvvXhvKC2v9TA0/7lmsHl6GwaI1bLVSUXuILwVW1/
         hrYVD0kYuPpk7NT1nkkJtpDa8oSyZ6ASGUSzHUf7Z3wpGnbfL1+r8beG14cIiiuFYMgV
         kWY44FdUcylpoZqAFDR4zy6UhnXC8AfljDRa4Q0Fs6xpV0rwzyF07OIRF54XnIfNwtrq
         2uMBpHMqFc0oO90mA5l9nkW4wVxvHSEQyqVV4p/A+1maM/uinbwXOL+8+ux1d4wh5Qvi
         S7Vmrcr/qaVv8ydnReDrksL3ALZG3LGXRV9amQaV+4d8f/1WUKKrQdkxsmSsTfBM+qTz
         4z+A==
X-Forwarded-Encrypted: i=1; AL+hErHE+/4pSop6R5+rhsGw3jAq3lFI205yvDdY7hQmtq3WpGHg5EWZxKc64zS0B9KL2C5d0yo6zP9rwbofTVmshg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NhAfGDQYEkLRLLTLKazXodWHuDsXeKg/vzgeKuXroUCqSw5BW
	x1pVjSn5VwmRL4rDn8nKaat8d+7up6oAIXzsEHs225dJEyQ1Up/qAxhH
X-Gm-Gg: AYBFou1JmvlegoHNzgeYYbkgdGW9wXjVOCYYxDY9Su978juBQJoY76uBgOXNSUsuPG7
	8P72XCpYYb878M4fi01a0v6XMzdjXhAlKgzitju6reHJcGU3HF0LBK02nRqoRqffzHpnlI6GwxT
	jlkcN6/OB10AuswocN63W/h1gEeq3dv2+9omiilMyTKv8X5IPzKznfgv7VEmrCQRYRZ6JM0BKcB
	lcjZtHDtQ+9oTo+rhc64FuvYtzhnNhNO7WC5ThZ6Vx37fga2AH0YyCO+AVNhKHX2HADhHc+1H/o
	1oDtrECBy4iZhmSOTvOK0qST1M3VyYj7ZBI+vWw3B4F2q2s2jtOg9s7jKpCPhcBjbdKxJVgKOyS
	gSlh3s2X9m8lInzmWPotEb4Ns5x5U92XqlJ7dmskTLYXkCbUmbx0KSR0d1UQZIlD3CGcU1oJfR4
	RWmGA90YOLRxE2Sf4EhssjOm6u3X32ysK/3WGAAsxgEnWBB/fO2z6YIdh2cwAiQnswCSLgsYTXj
	E5d0qZOQ+JteW2+84WHxZNavQtlevcLwt7U4gFsjAaqIqp0K1zsZzHylDpDSv2yAXmpcVQ4matm
	jEIJ5kO2Xbmmh/EosY2xxkWLDs/IXZgsPe3xA66n2/itfMilukfDQ/h094pcNj8/2mPga+6Rhoi
	gTPEvTGo=
X-Received: by 2002:a05:600c:354a:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb55a61152mr3023845e9.5.1794509722810;
        Thu, 12 Nov 2026 10:55:22 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28d0b2sm71734755e9.7.2026.11.12.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:55:22 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 22:55:08 +0400
Subject: [PATCH v6 1/4] clocksource/drivers/timer-vt8500: Add defines for
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
Message-Id: <20261112-vt8500-timer-updates-v6-1-fd1cea645d1f@gmail.com>
References: <20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com>
In-Reply-To: <20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR94566fN/rX09CX+SE+N1+sltrHncie1l+zM+0u0c3B
 gve23Gkp2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpvsvI8D923c+Yj1skqsW9U1b5zJ9wOOksR5e1QdGZJdV27QlPtC8wMnQvPrM
 m5HQX640vBQ9Kdz+TeG45xdhw/fmr50XuLGte8osTAA==
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

