Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512126;
	b=BjxTzHicU96W9aaLTjDKLe4h6I4a3pBJOoU2wKQ2VOCtZcSAvAbu9r+geVp6xBbabxiz
	 X9FdBbwOmAPdQtWbzotJyZvMpWSkhdIOlAiD2eni9sAO69JWAVzzJhJTiCl00al0amYvi
	 Jq4oPBQprOVHk9sNH5HU185q8lwjm11TvQgAj7Bpt+9yXLkLPAvthNb2NWHY404PO4uJ4
	 sujJXD2QrWOynJ7ekh6lUEE0PHyn8ZsWwaQmDEdhcMpcMupdYUMpGJSdvLmaNaQYu4WRY
	 BfocuUwVl64/znbBlQbeDemvO7yPTDwzWeRZuqkkUAgGP6YHxr61DYnKWGOlpAgNVWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512126;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lb6my5FSJvWsKhWZWYQZN9OfYvHuCz8dE2fTFZGx0hk=;
	b=Dm1wawHUa/A1O5CAbmSgYrJcBb4Iz3XfWrht6qDCT0VKi5j9fCYTlx1fRxicXx6SusXx
	 It5jaCYok+EmWvHESM6lN2ITKwDZ3OHOCq+z2krdbIZwlkbRcu/51wgkok9gh6KEQsYN7
	 W0cs9NbHjddicbkgmdwObRxVnGw3KvLczsOuPsPD7Lz8va6H3DtGogsUevL+oETzim20q
	 77qfb941wSjwitByGOYHgpcvUZqrh2Ib426kug93Sy5w39YO4fbW2JmlEIJmGxdJGMqxn
	 MMe+R9xSHn6dCzGAGW4wSyQnseJbWuAWkxFhDe3ZxmVsFLyHDGVn5vE0h0BFTHfxBVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlESMlYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18390606A68F
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlESMlYS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795512125;
	b=rUvEo+SvC2UthA5WPqAW/0Z7c18cxDYdnYUlt6/vxVwyMl6qsegDh95d1O6j81FrVk8l
	 P48cQeugDt/tfbjr+s8IyQQa2tou7KPpFCU4ff6/wrAQBmcvIfjPTynKP+5jRLDFdffeT
	 pQ2Ztn7yMkfH/0QA5haTW3BzNcG7a7s+KrMyhsJ0pN5b2xf/fZjWfKeEHIDAjaOZcDpmb
	 dlpW76ZCY+w5Dd3x6PFEpYFhG5nuqWrnOE5qcSGTLS8EZDQl6FN2YF5EVDyhlFHWFWYCz
	 AVTAbYWO0eMJP4se7Z05QWW7Rk5jwHGDxENNIVXyZylLkNl7ysp2j16jBBMXO+e+GpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795512125;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lb6my5FSJvWsKhWZWYQZN9OfYvHuCz8dE2fTFZGx0hk=;
	b=D/PBFD6xfdwNRyIw1A2OUn7ou9gqXD/E3N0pMjgK1VZpLifW7xf/UGOa3pNj2UxW3nOc
	 zprCcm+19vfMnU2UtqCXNhE/EB6aPQRSKYrEKhFYYOytTjyJnVhvVDLjHsg40c7qaGrHq
	 cMpQf4/H+J5wI93wPJ5K4V4ePIELQvhdRO03tY/4yqLmeU4p2xf/8kk0yMuiHS200AK5S
	 KRwYFAgqXVwxeAHEx8iy7PyMrTEWCyeoS2/BAJT0yVvosRAl4pbf6jjOoMjvq5qwuhWZQ
	 i+AGvbOBB1lNo3q7BGX+X3g0l4mYOL1bAH73STkUNNFRG8REKaw5peuq4FoULL0HsqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C87681F000D2;
	Tue, 24 Nov 2026 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512125;
	bh=Lb6my5FSJvWsKhWZWYQZN9OfYvHuCz8dE2fTFZGx0hk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=BlESMlYSoe8UUWHv14/hbKYcg1vNlb6HeFhYhw/a5ts2xSFaR/LA5hUnQ+DPb1/2j
	 0JLxBNoH1t3h5nJJNMp1PQEOl48UHzKdGvvrercEt24vJ8jQ3gJ+9SDvwfbxA93/IJ
	 T7VZ+O8KW61sZVqfZXHP0DsoImhPHwYqsyvt1iWhTuU4zbavZ/0DbikmzQy6Hw1e+k
	 2/Wsz0gS4tlB5g5s6KB0XwDs1IChXuccMC4CavocLbolu1ILzQx5KshRaf143KdQ1F
	 j3cg4iepkzIByS5jSBOM0jFEehlYov+T9cCdXs1B9erhCzxc3aD8jrY9dezBQVET+k
	 eZngvmNW66MhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A4464C97C;
	Tue, 24 Nov 2026 09:21:59 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 12:21:59 +0300
Subject: [PATCH] watchdog: arm_twd: Protect the clock snapshot until
 notifier registration
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
Message-Id: <20261124-arm-twd-clock-notifier-v1-1-62933570ae27@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJbQpGr2Jc4HQK409rplVJC
 He3yvJbvLdAZhXOcGwWUH5LlhQrzK4BmoY4MoqvBtva3hjrcNAHlo9Huie6YUxFgrCi25Pxh45
 9GxzU+KkcZP6PT+fN+XW5MpXfDdb1C5QDF3B6AAAA
X-Change-ID: 20261124-arm-twd-clock-notifier-47c1d95ed0f4
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795512118; l=2819;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=p2sYExYr/jO4sa/Pzc9YiL7jgTYBz7CEinmU5GG86Do=;
 b=VKSH9DQH5NzG5wXNQbbOG5bM9NbRQJgeAnhBSlyzzi6f4pHjXYtULw/lPg3h+b5QIcFQJ/Czw
 eEoM9dcRDujDm1+ygFz9bhuJ7EyXNGWMydoWQ6zWkzX9PVC+5WhAtZm
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

A clock rate change can complete after clk_get_rate() returns but before
probe registers the clock notifier. The driver then misses that change
and keeps the old rate when programming the watchdog counter.

Take temporary rate exclusivity before reading the clock rate and release
it after registering the notifier. This protects the snapshot against
changes from other consumers, including changes to an ancestor clock,
until subsequent transitions can be observed. Release the protection on
the zero-rate and notifier registration error paths as well.

Fixes: 52d91ea73e05 ("watchdog: Add ARM TWD (MPCore private) watchdog driver")
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
This is a single-fix follow-up against watchdog-next, rather than a new
revision of the accepted driver series. A rate change from another CCF
consumer can finish between the rate snapshot and notifier installation.
Temporary rate exclusivity closes that handoff without retaining the CCF
prepare lock or holding the watchdog mutex across a CCF call.

Validation: the old and fixed clock-backed probe branches, actual CCF
functions and the actual TWD notifier were exercised with 25 deterministic
interleaving/unwind cases under both GCC and Clang ASan/UBSan. The full
modified driver also builds as an ARM module with W=1, with all imports
resolved. These are offline checks; no changing-clock hardware test is
claimed. The separate maximum-timeout policy for future faster clock
rates is unchanged.
---
 drivers/watchdog/arm_twd_wdt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wdt.c
index f83770109..aa974da23 100644
--- a/drivers/watchdog/arm_twd_wdt.c
+++ b/drivers/watchdog/arm_twd_wdt.c
@@ -553,13 +553,21 @@ static int twd_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
 
 	if (clk) {
+		/* Keep the rate snapshot stable until its notifier is installed. */
+		ret = clk_rate_exclusive_get(clk);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to protect clock rate\n");
+
 		wdt->rate = clk_get_rate(clk);
-		if (!wdt->rate)
+		if (!wdt->rate) {
+			clk_rate_exclusive_put(clk);
 			return dev_err_probe(dev, -EINVAL, "clock rate is zero\n");
+		}
 
 		wdt->max_rate = wdt->rate;
 		wdt->clk_nb.notifier_call = twd_wdt_clk_notify;
 		ret = devm_clk_notifier_register(dev, clk, &wdt->clk_nb);
+		clk_rate_exclusive_put(clk);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock notifier\n");
 	} else {

---
base-commit: 43495d289b7cc30f95791fb7cd7999d766b659b8
change-id: 20261124-arm-twd-clock-notifier-47c1d95ed0f4

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


