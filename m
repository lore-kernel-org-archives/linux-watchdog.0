Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEA3CAE7F;
	Sun, 13 Sep 2026 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282150; cv=none; b=sAgujC/qHE55bJKd/gKs6itgDnuvvh6Jt1oHfITx9Q6PniEy/DvwTV8423OPfwvjfyMhCGyImNLcT9PkLmQp0rBWSRKYqYFZ3C50Lc0y4/3y/PGDtbZKIxYgF+YAuFCMf2J7im5MYTyLmuHUMtdqT+fGLiOCJHKIegcWOAQKSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282150; c=relaxed/simple;
	bh=pa9bi2gTpvDqDAwkZftMhy3DJPdhjXbXtM/QyyiPXq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg/zZu6fn8yxakDFpRozEu15/zr+Pc7n13hbWEU/DnDTcGSozvv9owgs6OArKpyDuiGSxYWfh74P5HNUhRVgHH7UgLKv5c5X7k3qhN36vTjvw8x6z3jq/Rnql1Nf8KVuBi8HYMjxJLkBO+s5H0mjrfpTfWWCmxMJt1ZUPKyAE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6CBRuU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6CBRuU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668401F00893;
	Sun, 13 Sep 2026 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282148;
	bh=RH7auDzRZm51pq9Ic6ls/26JXCqmBMKMAK5aSQaL8cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6CBRuU8fsWJxZyFpdXf0wfRSrKuLpDjGZcDV1dnIryvvH4sAdlJkyeV7RxjSxQzD
	 /vtiVpkwFmblTvKBN5UzFdaY0xTBNkzfnreTTev1lEnJ2CS93ns3S95Hi3snMfPJXm
	 ZhUNvFTVTXrd1/HpFLchKpYcQ7y5lRy4uJd9PIp1DQsohY/CHA45UrrOg10zDzBC57
	 r0S7nzAjxiJlfBtEoRV8WOMsQMZUajBTXBIG7pfZccMI1Uqwg2xKAjYD8xKDrExA0V
	 iiIUsJz+M0Eu6YGYRWEZt/O1kscRLwp81QYP/LUvTsqUUtWEEHoynEXFNbhjl+WV+e
	 uAjkkvwyd74bg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Baruch Siach <baruch@tkos.co.il>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 3/3] watchdog: rzv2h: Avoid division by zero
Date: Sun, 13 Sep 2026 14:48:51 +0800
Message-ID: <20260913064851.8239-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913064851.8239-1-tzungbi@kernel.org>
References: <20260913064851.8239-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_rate() could return 0.  Avoid a division by zero panic.

Fixes: f6febd0a30b6 ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/rzv2h_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..83540dd9a37b 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -278,6 +278,7 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rzv2h_wdt_priv *priv;
 	struct clk *count_clk;
+	unsigned long rate;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -314,8 +315,12 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "Invalid count source\n");
 	}
 
+	rate = clk_get_rate(count_clk);
+	if (!rate)
+		return dev_err_probe(dev, -EINVAL, "Invalid clock rate\n");
+
 	priv->wdev.max_hw_heartbeat_ms = (MILLI * priv->of_data->timeout_cycles *
-					  priv->of_data->cks_div) / clk_get_rate(count_clk);
+					  priv->of_data->cks_div) / rate;
 	dev_dbg(dev, "max hw timeout of %dms\n", priv->wdev.max_hw_heartbeat_ms);
 
 	ret = devm_pm_runtime_enable(dev);
-- 
2.53.0

