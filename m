Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507E3FF1B9
	for <linux-watchdog@vger.kernel.org>; Mon, 15 Jun 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535501; cv=none; b=ogCAGewGSIesGHn04iTGfERIaufPN6rpozU3CRAuJG/3Mq902hiG02pCODlUrxVk95EFycCFWFfAvWyn3F1mcRzHTpo19fbEWXpJrAFNG9pC6spvyf7WM0q0u+8wCGJ8NnC3tIBiM9Jt5ElYEmNIoGcuq4Xt88WyDAjmwTNNFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535501; c=relaxed/simple;
	bh=va8GNszpgb7/t/gwdnRucsQlljwc9At5RNRy6s88JyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGfQhaPi7v5U4D3vUQhz9op6KOXueBh/38xE5TyvYypHZiAgCjtHUR3tJaiOT76XG3ex/3j4opw/zn1MUQWzGMN+P0HjjjI8Y9ww/XPCCHphPEasFZNhwldvYqbh0mZC72j+ShOr2Dt4DdCBvec5eGBpnwJtYOtuepOHZ5YzHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=DMZ7+mYr; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DMZ7+mYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1781535486; x=1781794686;
	bh=wGKMuVt9QIbMnaQW8Kyqpw4nDDnj9sx55rnwIqM3UzE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DMZ7+mYrOhpsmSVIREP+m95WfsudHkq014Fwe9KoWvmpEuJKwQsmSdHzE0oN3rdEI
	 wri/RAEUBdrSGZZXEX5Cd2Pg6r/JsjRHm7zJ5x4Rh50jGUNTA45OEto4m9l50PpNaA
	 asWOxrU+s4yDshS4N3vOa3QWoK+ef8FrYSzAq+qSxRXmlS4BcgaNadjDXlOFklzlcO
	 a1OBs1vC7OAUcsY7K3Xc10EauxUWJcJUMRQ86hRsnbzuF/NwZS2AM9/d4Du2x5qnS9
	 JCv+i/Lo/h/eG3rqVZI1YPFLAygVDxsd2hqk0Y099fIvQLuAwvcy/xHYgH56j5OUWh
	 enSCHLIjHJXDQ==
X-Pm-Submission-Id: 4gfCsn5rYZz2SdlB
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] watchdog: take all OF aliases into account when assigning id
Date: Mon, 15 Jun 2026 16:57:59 +0200
Message-ID: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some, but not all, watchdog devices have device tree aliases, those
without aliases might (depending on probe order) be assigned an id
which would otherwise be assigned to one of those with an alias.

This is problematic when for example watchdog0 is an alias for an
always-running gpio watchdog that userspace must handle, but the SOC's
watchdog device(s) get probed first and thus one of those become
/dev/watchdog0.

Ensure that ids for devices without a device tree alias are allocated
from above the highest numbered alias, if any.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

This is similar to how the mmc, i2c, i3c and spi subsystems handle
device tree aliases and avoid using an id that might be assigned to a
device/bus that is probed later.

 drivers/watchdog/watchdog_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 6152dba4b52c..80675f160e11 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -239,7 +239,7 @@ EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
 
 static int ___watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret, id = -1;
+	int ret, min_id, id = -1;
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -264,8 +264,15 @@ static int ___watchdog_register_device(struct watchdog_device *wdd)
 					     GFP_KERNEL);
 	}
 
-	if (id < 0)
-		id = ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
+	if (id < 0) {
+		ret = of_alias_get_highest_id("watchdog");
+		if (ret >= 0)
+			min_id = ret + 1;
+		else
+			min_id = 0;
+
+		id = ida_alloc_range(&watchdog_ida, min_id, MAX_DOGS - 1, GFP_KERNEL);
+	}
 
 	if (id < 0)
 		return id;
-- 
2.54.0

