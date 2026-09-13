Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857C3CB560;
	Sun, 13 Sep 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282149; cv=none; b=FHxZo+lbE/6XXSs4VHaUcmU8Yd6VimSev4bQ04N68krP3004M8Vuqj29maT/Qg2rSOVHFmPpMbrqQ3PUK4qLOXRffhDuod1j93uz8u6/bU+/zlpEBTnmSdsdNG0+Jw7L0EItBXCgNoJnbZrYQR/l+FjTCKOel60ilbbUsv3LdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282149; c=relaxed/simple;
	bh=r3jcwyTedaTxb9b3RfNhohViDgy9af5oaw4AG343a7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFC+KJbMrXfrpN3xaaAz9o/yL1MpntCwq8xcSPhf1roeWOBlvk9W3qJF8OrzFCyvKlsSvCdn9fWaRoMiweNFV1Kbvp8vQbcaHrWlkt8UAKPIwdKtgHnmmKB3KWLapuV6mJSlxLsipSY+bOvE1GkZoB/1P+ojnhkcaJmbsxF+lAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDyNRJAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDyNRJAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36801F000FF;
	Sun, 13 Sep 2026 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282147;
	bh=GR8e9OThUzczma4Aaeh5prTyfxSVnwc9ScJ2htIrV/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDyNRJASTISkX1Dy52ifusp1KPyPNlpx3aqX37nwH6hiRkY9AWq6aOkLTdOfxbVWE
	 10bm+s18xrfWpmJYiX2/A6Vxi915K5YgxQeKrxR/0Wr89F12rhz/Xl588IsnohGuX6
	 +WKabKsqw4zSbBhhS7q5x2Hx4OvzKFux31eD422T7G0u2VGKrakLrq7DeYQ+37UvJO
	 8klPhhKdMhW4dpc0sssjr4ruTcJxg50ckRrPfQLrbvpAy3EolAE0aA97Bcu67Gt/g0
	 6IukYsoPM3V85ghU5xTIDj+i0pb8Sinm2n53WRRQfI3nvw1wWvyUKCztsxRhwdzVHE
	 qNfaePycyACtg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Baruch Siach <baruch@tkos.co.il>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 2/3] watchdog: rtd119x: Avoid division by zero
Date: Sun, 13 Sep 2026 14:48:50 +0800
Message-ID: <20260913064851.8239-3-tzungbi@kernel.org>
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

Fixes: 2bdf6acbfead ("watchdog: Add Realtek RTD1295")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/rtd119x_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 984905695dde..0bfadb58917b 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -98,6 +98,7 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
+	unsigned long rate;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -111,10 +112,14 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
+	rate = clk_get_rate(data->clk);
+	if (!rate)
+		return -EINVAL;
+
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
-	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
+	data->wdt_dev.max_timeout = 0xffffffff / rate;
 	data->wdt_dev.min_timeout = 1;
 	data->wdt_dev.parent = dev;
 
-- 
2.53.0

