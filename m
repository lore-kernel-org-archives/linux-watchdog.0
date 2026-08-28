Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555137F005;
	Fri, 28 Aug 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933662; cv=none; b=NhrHNS6PdtaBGIMTziDR/VnrY7whlWUDcQKhLMMPMdrm5UMgucEHFuMtP8wUUKf/fAhvzWpjJoINUFofG0xvSlskyUDUoG37HrQ9+FV12eVlg0rgdmuiWbbpMADAQCFrC8XBAsNSR6HbbBxVXxxCVU8EULTWSpz0zkLE7S8I09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933662; c=relaxed/simple;
	bh=GUVMlPBqorGNHEaYkE5JHdBzgeJmUwRqUdNGKalZWeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdizEdT1tgtdSEl8pGobUs011JtxK6YkVd5y9hA3o2YsWrEEVdLrN6fCXlItrF8JaDmWIUpubs26wf/DWklu9DuX/IHc7W7W28h+sl7OXxSRpz66ZHSIcwQXgp8Bp/GLnfcfzduhV+D8gKyHTP7PAudkgjWVzgf1YzhMCE5aEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mER4yMBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mER4yMBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9B1F00A3D;
	Fri, 28 Aug 2026 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933660;
	bh=1He0nuVEZ70S3mDkyW6KyaGY0qZMdr5/mK+PSSvUnpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mER4yMBCDUxzVUrs+HhMywGGVYWLVeWOaMCuarKxey5fjAbm+piWI1BpWZ1soK/g5
	 X907VVnknmmfelI1hHo8d21hQ7LDnajwumXPgyzpxc4Sjst0ghzEKzeboyIe9lr0y4
	 UkIuP7oqYsyyN79KvFIcZWazcp1ALjtPnDWThlhAagd04nuf55/AoHIdS92zs6xrVb
	 /X3VV7PI0rO7C6hPgrF7rsO8Yccjjm39DSPxQ3TTL6PzmtElK2037fk0+E+u9gVY93
	 FeIdkFlpCn8h9dHc42mTXAcC/S63D5L1BZ3BdZ4radj7L/Lb7KGvPpdKGcW6rqeVq+
	 fUAVz2BgEtvyg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 9/9] watchdog: msc313e: Replace commas with semicolons in probe()
Date: Sat, 29 Aug 2026 00:13:48 +0800
Message-ID: <20260828161348.13212-10-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828161348.13212-1-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace commas at the end of statements with semicolons in probe().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 6af865750ad0..e375810bfc2c 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -134,8 +134,8 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	priv->wdev.info = &msc313e_wdt_ident,
-	priv->wdev.ops = &msc313e_wdt_ops,
+	priv->wdev.info = &msc313e_wdt_ident;
+	priv->wdev.ops = &msc313e_wdt_ops;
 	priv->wdev.parent = dev;
 	priv->wdev.min_timeout = MSC313E_WDT_MIN_TIMEOUT;
 	rate = clk_get_rate(priv->clk);
-- 
2.53.0

