Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DE15B971
	for <linux-watchdog@vger.kernel.org>; Fri, 12 Jun 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267557; cv=none; b=iErJpjQf89EcoS3gpnWPNjTncN3XFhYGbVhNqXDCtXCCMVueepd/BCOtZ2/kWwKhXuCMG2NkT3U/EJP4k2OwniphKdzC8cf5eXGUNXbqFb6TsGxJrKT9araxHrjGfXu7rsVDTdC7QaGXEW0s4mPUu2+EpN7x4z1jNQe/MXJpEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267557; c=relaxed/simple;
	bh=bkBMvj3W7HW8JqCDXWu5p8/+Ig+iEYHGU/Im4c53nUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGL7E/SIZJnQcjgdg1/idut1i6hvMA9NSZiWIEb8xPBdDboOSWpk+SMKyd9byiZDS+iXGCcXrX/jPpRqM0GUw0udrG3ZKsuib8sMSkqSRAfg1Mwj7AnHCYmV40aXrBXNsiJuY4EhW9ePWsJnTyAhY0Wkyzt9lzgGjmVJVYIMzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=f8Mv3l0/; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="f8Mv3l0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1781267544; x=1781526744;
	bh=6gYIfPr+Q+VvKl7jn0CxXg8tjMG4iTj46JViCtBXNIE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=f8Mv3l0/rcRCPGlEpHlsXH64rvqEi6XdXzkhAJd+T286cnWdCwaw0LHcGo3s61PUv
	 J5nHUh4zJjZMg6nYKpw5mJ8K2ptK8byAbDUMFd5XtVVOoIzvQZ5ePUrS9qZ2Op8wWC
	 kwVZc+ZJUd3DGN9FErGOO+p1wtbvY23gQAAWAbue5xzKcKza32PF/OyVCUS5wh9l6s
	 nf9Xwt7Iq64OaaQDDqZPbtC5ha3XPs0FeM9hMFvyVbmq7FQbNnxUBu7U1qDTT78o7C
	 it9Y52HepKq2SYXUs1btGUQVvx8N5uc2JVdcYUXTFgqyQy8je6ml5v2J2FRq/w/w+m
	 5HiSaHiozM0yA==
X-Pm-Submission-Id: 4gcJn22kmwz1DF7K
From: Benjamin Frost <benjamin@geanix.com>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	Benjamin Frost <benjamin@geanix.com>
Subject: [PATCH] watchdog: stm32_iwdg: Base pretimeout on timeout when not specified
Date: Fri, 12 Jun 2026 14:32:03 +0200
Message-ID: <20260612123203.1331849-1-benjamin@geanix.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pretimeout was already set and timeout was later changed, the value
for pretimeout would be clamped to its upper limit if it wasn't also
changed, causing the pretimeout to fire constantly.

This is fixed by introducing a local `pretimeout` variable to hold the
effective value, either from wdd->pretimeout if set, or the 3/4 timeout
fallback otherwise. This leaves wdd->pretimeout untouched, ensuring the
pretimeout is always recalculated relative to the current timeout when
not explicitly specified.

Signed-off-by: Benjamin Frost <benjamin@geanix.com>
---
 drivers/watchdog/stm32_iwdg.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index b356a272ff9a..a38e204129ff 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -97,17 +97,19 @@ static inline void reg_write(void __iomem *base, u32 reg, u32 val)
 static int stm32_iwdg_start(struct watchdog_device *wdd)
 {
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
-	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr;
+	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr, pretimeout;
 	int ret;
 
 	dev_dbg(wdd->parent, "%s\n", __func__);
 
-	if (!wdd->pretimeout)
-		wdd->pretimeout = 3 * wdd->timeout / 4;
+	if (wdd->pretimeout)
+		pretimeout = wdd->pretimeout;
+	else
+		pretimeout = 3 * wdd->timeout / 4;
 
 	tout = clamp_t(unsigned int, wdd->timeout,
 		       wdd->min_timeout, wdd->max_hw_heartbeat_ms / 1000);
-	ptot = clamp_t(unsigned int, tout - wdd->pretimeout,
+	ptot = clamp_t(unsigned int, tout - pretimeout,
 		       wdd->min_timeout, tout);
 
 	presc = DIV_ROUND_UP(tout * wdt->rate, RLR_MAX + 1);
-- 
2.54.0

