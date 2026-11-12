Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509732;
	b=TkG6mylWC8zkRGfTKWIlMA3ViQf9luN73CoFo8KIAVNNbO8Jk81DeL9XI1r3eid2gN/i
	 2UTnizJhIi9T1SL7uLWsKf7Av7fbGkyk7irLxVBtl76nHzuFM5BA+S4HWlbp97nsJxdtz
	 PcbjR1Xh/ZEM7kCm+pVdy1JSSveFbYIEGWgh1R0sn7gK97vPssInELQSVC/PPh6Goxxaq
	 XNLrh9x+Hs3V4oxWbrlu2ZWkv1+owa7NUV4Z9HPCOYbysPQLeJXXWxIrJvdvZ3/X9oqTJ
	 RIG6mYwpKKUT8n7T2eY1xxzfFHJBwEg8fR2knyL+8evp4jWDXAMEdsudlfc6iObb5aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=M8xbWLTM1tDLF8IdDJE0ybXERn0+Q9azTV5NEZXnfIQ=;
	b=z/wP4lU174KSkP9Z/uNoxSxYRXjW/nt73uKf1CFPwn8XVjwj7I2gwmChln8bqFuOKhll
	 rYJB4usecmqjkd1MP/7Y9tcxdFNHwSGgPb2/I9S5tQ01gu7UOWw5PcDyFWncVXjwLRu1d
	 GjgBYLaIGqmzsyczConl+ett6EIFI7GgLk7akD4Td05uNWw2K1C4bHdEBjseC3XPfNxPd
	 /wP48byrk3wEGThAqQe0uL8qW+MIYe6dNDHCxIewo3gUcqYvXHdrXkXjA4zrkIaCYWe6x
	 +7m8NybcyswgYhlg1EQhcOrPPdhoqLvXezUIHOJN8p4QyiXmjzV0lnStTFSokOa2nOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5cFWKOG;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0660A3838
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 18:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD0660A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5cFWKOG
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e09aa5264so38503f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509730; x=1795114530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8xbWLTM1tDLF8IdDJE0ybXERn0+Q9azTV5NEZXnfIQ=;
        b=f5cFWKOGepWa3WvmrdD3CHuMVtKIexzCjyq0VqHVOdSbgYxpEW0m3UUKSga3v8TXnn
         S9DSev9UxCgrZOwLN7bxu7MIZHTLBoSH5bOZo4wb1SrYCbHqs89f+LeQXrtFUgVRNLux
         C+cA2pYU1c/T13yM/vDCL24DqAU6H6UZzpOm5+dCP0uaBQvenuoxIIZkP1Af0ImL3q6e
         8BlrEMlFocZH+qxeQ7u3rQjqr8vLBTDdxKd8oCMhEHf5SzG8puq+ynegrBHlkV1AK1Aq
         PndDsVt2sEaAm/bfTpzzyeJkKgMuA5Ndq2uV0tkektUAPmH4mtJxlda4fc7IjOa7Nyal
         2SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509730; x=1795114530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8xbWLTM1tDLF8IdDJE0ybXERn0+Q9azTV5NEZXnfIQ=;
        b=gtwbI8rKgeDYJjxBhs3eDPNyE2h3s2mMNFk8TVXjdQiQhV2Wr8LLhfTVLSutAkoHGZ
         rqaOchk9WO4PpQVHuLwvwYCvvjeUklW9D5rwoc2Pd1fXRiCY22M4cozQYSqRSVeNiwZl
         m2MeLSasOP7T+pYRJB2NwOh1uXTXRjU/yMi17IpPvEvaLrtQoIoVkStP6MWj6Xwtc4L4
         0nhc2B+kJfnGmHxA+0Fr6lAsHSiF1Ofm/BSQJ2O3X+hbInNwhtRbE3cuR8z+wuc8EHtc
         M6gmKGelukM+nwLytf5s8zBi3t45bij5O9Hb+iWktR9nvZ53Ud+RB0vM70SWZmnCOla7
         otvQ==
X-Forwarded-Encrypted: i=1; AL+hErFEjsrq4PhwHo1/KrUtIA1sUwsu3vWi3Sy90lhRj45KD3qwfoeOFLB+lfL28e7bQguuB62Q5r/cKZ1Sg6Q7TQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8GPbg2J3CKnad47J7IuVwEirSPHJ6fWAl+wbEK8bCgthojc6Bd
	lW1xefDr+AhHowI9RXxBAv2NTv7stsFT6XCRTnjKsZAYUm9Pm2M1WHHi
X-Gm-Gg: AYBFou3nO/XK5UkyGTjMY0NedOKgD3BqKa8whjGJlJ2/z6O9uiByUIvHUzs+1YVmRxW
	CuTRnY761+YHgxHHXEFOACWqHglSDMqNv03ve/pAbtKQ+ra7OJABRVPGdYaMuJ7S/rglvJfS+l5
	URhw84+0aCWjO+B8vmmd+hBqVylttt+lmJnHRWhCzoTcWsAWbWtuVPIjTlZcH7GKe45aoViuKBF
	z+LwPQMqtastsNxBAmn5D2kARvuV8q+tz/RHa84665fX8ynUWoDzYDa2L0b65/F2wXh+Ig4wg3R
	osyJxZCvaYySxyzayNvA+mPx59FZQVLFfwnYErl6AcR5v0THG9yycetrYrCGZDZ7HaYjJmdbh5V
	60r92Ql4Ln1gt7CcEEZCu33aAKDEiqgqNXGZSOfhlDC5ETjzk7JlMQhzkAyBgGSEFjYQtOZJAYO
	Igt8HArdP6bjNoZ7DtlvoaFiTt9oI0WFawYwTzr5tFugAHa13E/baLmdy9DskQr/ODJ3be9QS1y
	8GWKCgkJPzYZdPJpWtB75gz4nkcZxGC++SOgkGeUIyQi4ALIvcfb+wY+eWcKOoc2G1rUOpyHlmx
	S5T7IxC6YZOGt+3sjiZWDfSFwwUbC7XK8zNpgPdmYBOoOhIj2Xc55CbTz12/136R9taFbl78YAa
	i4zybCsqA
X-Received: by 2002:a05:600c:6092:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4bb55a44be7mr2737975e9.8.1794509730281;
        Thu, 12 Nov 2026 10:55:30 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28d0b2sm71734755e9.7.2026.11.12.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:55:29 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 22:55:11 +0400
Subject: [PATCH v6 4/4] watchdog: vt8500: Add a restart handler
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
Message-Id: <20261112-vt8500-timer-updates-v6-4-fd1cea645d1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=alchark@gmail.com;
 h=from:subject:message-id; bh=mhiGhVHaKTYXayUI3xItTRTmu/lVOn1Xybq1LOkaLfI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9457KJNYU8KBxuukRh1TepIj3vSFT2Y3K/HRezn62L
 ZPLXcmwYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKne9Jbhf7bE/eTPHLPCjjzMiZf8bpdj4/j46HTVI4v+dUrFXHPf9ZiRYc2lfdM
 Klr9VNJebZHyI5YRmybOTQT9V3px7HCA7U0SllxMA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Reset the SoC through the watchdog when the machine's own restart hook
leaves it running: the PMSR write in vt8500_restart() has no effect on
WM8950, so a reboot there ends in "Reboot failed -- System halted"
unless a watchdog armed from userspace happens to fire.

Arm the match a millisecond ahead of the current count, which leaves
ample margin for the register writes to land.

Register at priority 128, the default for restart handlers and also the
priority of the ARM machine restart hook. That hook is registered first,
from setup_arch(), and handlers of equal priority run in registration
order, so this one runs right after it and only matters where the hook
fails to reset the SoC.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/watchdog/vt8500-wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/vt8500-wdt.c b/drivers/watchdog/vt8500-wdt.c
index e0f838fd1d50..0ce1e2b06410 100644
--- a/drivers/watchdog/vt8500-wdt.c
+++ b/drivers/watchdog/vt8500-wdt.c
@@ -25,6 +25,9 @@
 
 #define VT8500_WDT_DEFAULT_TIMEOUT	30	/* seconds */
 
+/* How far ahead of the current count to arm the match for a restart */
+#define VT8500_WDT_RESTART_TICKS	(VT8500_TIMER_HZ / 1000)	/* 1 ms */
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -75,9 +78,18 @@ static int vt8500_watchdog_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
+static int vt8500_watchdog_restart(struct watchdog_device *wdd,
+				   unsigned long action, void *data)
+{
+	struct vt8500_wdt_info *info = watchdog_get_drvdata(wdd);
+
+	return vt8500_watchdog_arm(info, VT8500_WDT_RESTART_TICKS);
+}
+
 static const struct watchdog_ops vt8500_watchdog_ops = {
 	.start			= vt8500_watchdog_start,
 	.stop			= vt8500_watchdog_stop,
+	.restart		= vt8500_watchdog_restart,
 };
 
 static const struct watchdog_info vt8500_watchdog_info = {
@@ -107,6 +119,7 @@ static int vt8500_wdt_probe(struct auxiliary_device *auxdev,
 	info = container_of(auxdev, struct vt8500_wdt_info, auxdev);
 	watchdog_set_drvdata(wdd, info);
 	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_set_restart_priority(wdd, 128);
 
 	/* Let the core feed a watchdog left running, e.g. across kexec */
 	if (readl(info->regbase + VT8500_WDT_EN_REG) & VT8500_WDT_EN)

-- 
2.56.0

