Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D5405C36
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880250; cv=none; b=UgPyFcKUyuEeJxZct6MvPrNJV/BA6EE5r1759e17ooQdhWeRuUfuaZV5TYoR2KvuVgbaU4I9ROFli4uuAp3o+Hge+T4PzsPu9+z70XnaVWHGvJ2BOVoomeSdKntsJzQa/MW5hw3WdLxyXIC0xg8nd/iFROhP8wR9QALpe67zAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880250; c=relaxed/simple;
	bh=qgUPj4siwGCgom4E5sxnCpQq5g0TZBPcfzB6gSvVGUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvrD05eKDrQeB1SWojVGKd0wF5RWr0e4xsChlGNwAYrevIE0Nul+t0C6xkL+iDhVBfixAdcCul8u8u2uWPdh4mVqGR66Suca/FANHmY/WqsvI3lhGgJpWgxs8N9PM94I2Va8m6DMS71MhvBuBWGaotE7h5F8ya8CzubbX16pW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=D/9I0bxu; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="D/9I0bxu"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 54FAB780799;
	Fri, 15 May 2026 23:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778880247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSV3fYIA9Y0YFJrJJ7+hOS4ommyui8eNyLI1Kj+8Tj4=;
	b=D/9I0bxu2MffVV1fTzmfiB2zKQVAf5HkT1aOFpFvynCneXdyszbs/Rn33Vjy0LeMQNJdvk
	DpXvwqnwS1uFkJdqrs4OSe0YEqfRHbRU6FcET+7LgOoxGFs3jDX8z+qj1QOW6YkMY8yf3K
	HqX2DyPc8dH3sWM1QzJfgxcKXb6HwGDpgyOW8d770XmDp7EGonopgVVLSBjkBx6xeJdy/r
	ttpTfWHsfG5gc+tquYT8LDedvt1md0eNAIOcfQrZUYmtCz+QOC90yooPGIAtpJEeDLms2g
	gx0xhdkpTUiruX3QH3JyPG24doB63JFaAP4w88SupBY/t47KYq3N10dLWCPtYA==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 1/2] watchdog: realtek-otto: prevent PHASE2 underflows
Date: Fri, 15 May 2026 23:23:50 +0200
Message-ID: <20260515212351.752054-2-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515212351.752054-1-sander@svanheule.net>
References: <20260515212351.752054-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For small pretimeout values, ((timeout - pretimeout) / tick) might be
rounded up to the same value as (timeout / tick). As a result, the
number of PHASE2 ticks may be zero, causing an underflow when
subtracting 1 to configure the hardware. While this results in a
longer-than-expected time to system reset, the duration of PHASE1 and
minimum ping interval for the watchdog would still be correct.

As the watchdog core ensures pretimeout is strictly less than timeout,
ceil(timeout / tick) is strictly greater than floor(pretimeout / tick)
and the number of PHASE1 ticks cannot be 0. So instead of rounding up
the number of PHASE1 ticks, we can round down the number of PHASE2
ticks, maintaining the current behavior while avoiding underflows.

The original helper function is now inlined, as it doesn't save any
duplication anymore.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/watchdog/realtek_otto_wdt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 2c30ddd574c5..1495e8a8cbb5 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -114,12 +114,6 @@ static int otto_wdt_tick_ms(struct otto_wdt_ctrl *ctrl, int prescale)
  * the value stored in those fields. This means each phase will run for at least
  * one tick, so small values need to be clamped to correctly reflect the timeout.
  */
-static inline unsigned int div_round_ticks(unsigned int val, unsigned int tick_duration,
-		unsigned int min_ticks)
-{
-	return max(min_ticks, DIV_ROUND_UP(val, tick_duration));
-}
-
 static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned int timeout,
 		unsigned int pretimeout)
 {
@@ -140,9 +134,9 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
 			return -EINVAL;
 
 		tick_ms = otto_wdt_tick_ms(ctrl, prescale);
-		total_ticks = div_round_ticks(timeout_ms, tick_ms, 2);
-		phase1_ticks = div_round_ticks(timeout_ms - pretimeout_ms, tick_ms, 1);
-		phase2_ticks = total_ticks - phase1_ticks;
+		total_ticks = max(2, DIV_ROUND_UP(timeout_ms, tick_ms));
+		phase2_ticks = max(1, pretimeout_ms / tick_ms);
+		phase1_ticks = total_ticks - phase2_ticks;
 
 		prescale_next++;
 	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
-- 
2.54.0

