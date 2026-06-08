Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712793E6DDB
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949396; cv=none; b=DjvyACbWdNDD9xzjRaA7bNcTdBmYw3BTSA50azMKo8tqbOTvOgOmNpqVBuZkQvkEEUNYan3S3bev740CnH3YvV3Ge3DSqxZ75MBOhMUjNgzLCW97r3EiReG7la7YXCMx8NkLT5N+bkLTq/JUng3yfDEjbVnY0i/aYFUkR0sQr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949396; c=relaxed/simple;
	bh=DHLaS/bps7xuN9CpIE0XgH/Gp0TcK5ng0HwpXQ2Y+MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBcVXz+sS55wb4m91FRVRuebJzv4nmQ3+VAPbr23MehNY9lJh3IGjpwJk+x7ZbIoUtXOumtehSYMGdTySWRBdIqAKa7lW72s8038RGhwKM5O0v2GDavLOGqbC/TCN6fx7gLN3t0PK13j8s7jx/v5dZFTee6gZuT0OvMMeS9yeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUnpVRNn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUnpVRNn"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e8b45dfb3dso58729227b3.3
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949394; x=1781554194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOjBZkHBZjwgFY+2gRIf62N1RuUWDhpPmFlrCLR4zCo=;
        b=KUnpVRNnk+0MCFABr+ZfnLg3uyYgH1VEQfLxP7+Su2CpqjSHdbXlEB4kNStlAFPICB
         1V1leAI67BAZ+CtnRwY9JVYR6o4D2i0RcBJL09vnJSVKVWrBUxqLa1Bh6tP/TJz5cs1n
         TQUP2ydGAl3O49aL2NoayM/aUMv6BtqmQr86agykDCv9pnE9LiHc6vZKeqOF0uc38K5+
         Dft+OnHJ8RfQjnNMky0O3HutiZQE5JzI2SYfjP33u3LyA1YTBcRaaalQxvOs64e20lQJ
         uibYoBeWfyfCgYGMrlUKNuM1ELWiBvB6IkCoks/Behr9md3dfKbvqkLjwfirl9NJA0Ry
         qD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949394; x=1781554194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qOjBZkHBZjwgFY+2gRIf62N1RuUWDhpPmFlrCLR4zCo=;
        b=jYq2St+HF6uFySQ+0rs+1GV3j/7CiUBQfb2Dr3e5r/v4LQR4QK9rhbvWkMTXTOFUMc
         2tPlkM33s4hEwOIdwC6LpYhtD1XSblfq0wKl+makgnhFWEa+5te/4Kx5HZKrKqKdVf94
         QfaFuoiC/Ha38OPihJs6JeTlBxnbDPjqHQOb4QvSLfyXVCn+E/smDNtAmAxTRlI2CcIu
         zJMMk02wm/VhaSpUTDkBwUeuJbVYR2+TsRHagyzIe64Xxj+9BVB+6uCVH1XA/yWnRCzN
         6Ymo3nCUkr/qZudpS4uBJdvNLM7SFoDSxD0R8f/LXlQGtt98ur0DSSEtICsMbRQoXf0N
         jyOg==
X-Gm-Message-State: AOJu0YwPxIKym58xBbvrjG/MGyzfO83/hMhLfAMv6/Ip/CTs8g7tFyUN
	x6nxcqAuNhUW7mKPsPpxJgkzX54r3RBhaZ2/y30/MRNyIWnoyloKQPoCt93ZsdQy
X-Gm-Gg: Acq92OFqg/KqotVLp0fqAhf9oslwHFUaX13niTqzw0cVud6AS92+hrPRpsuQCxcWWoA
	a+37vTbbS6Fb2dTXqft8LDsCDm/UH1Q8sRU8AJA3ACkK7Wmek8mIeCmt+xFr/oWQuamZM5E5v5A
	NRNusmcGcWOD5/d0p9yJx9Ui5mUFqem+Y57d/RySLhxvR4WgFDGeOd8faoLqNdwtsjSGpy3b4eY
	KnuQl5VN8HOQWVCJRl24/PINWnO9dw0EYatuwdbs72gFPhuIZu/xpHUW1ctEeg2+PLT2VmPEWPN
	gTHlYY8xmOz9hExaDu2qTo6xtsKQDz3c8pN6H08GKEwClkUQsgCkn1eOqQXPtRWgFOABPEapRRz
	nK3JwDivbZqYBkCq47aTrOGj+4oWMjHsbZxtg9tbzmkwi4lhrnNniIsdR3e7yoUi/pDW6GfWCVP
	0zCl33SPBNrVytyuqJ4br3tuPjI6lH4u28lO8nSav0aVX4+SYbW1svocMOO1CejFjGxieJzAzgr
	r0R0eJ0ZZNvBYBM/m1KnZdQiy6NbKrRBzKmi5/HrirXEw==
X-Received: by 2002:a05:690c:46c3:b0:7bd:93b0:bd25 with SMTP id 00721157ae682-7ed0adbb639mr169428527b3.4.1780949394561;
        Mon, 08 Jun 2026 13:09:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea986bsm88688987b3.9.2026.06.08.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:09:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/3] watchdog: sama5d4: use platform_get_irq_optional()
Date: Mon,  8 Jun 2026 13:09:32 -0700
Message-ID: <20260608200933.18669-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608200933.18669-1-rosenp@gmail.com>
References: <20260608200933.18669-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
bother with it as platform_get_irq_optional() doesn't need it.

Also handle EPROBE_DEFER.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index f74f1e8956b5..2536e2f2ab32 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
@@ -245,7 +244,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	struct watchdog_device *wdd;
 	struct sama5d4_wdt *wdt;
 	void __iomem *regs;
-	u32 irq = 0;
+	int irq = 0;
 	u32 reg;
 	int ret;
 
@@ -281,8 +280,11 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	if (wdt->need_irq) {
-		irq = irq_of_parse_and_map(dev->of_node, 0);
-		if (!irq) {
+		irq = platform_get_irq_optional(pdev, 0);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq < 0) {
 			dev_warn(dev, "failed to get IRQ from DT\n");
 			wdt->need_irq = false;
 		}
-- 
2.54.0

