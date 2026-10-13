Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56813E557C;
	Tue, 13 Oct 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870875; cv=pass; b=PEPWFsJhvUmWrT8afRRmS27l2CtaPplvns9Mo5TXImRso+JMkbNP7ZweRReMMw2AK+QZtLLaqKDRQ3+cdIqeuRU6sRCkeqkIhjmvKH0AfZEqbtYQ9keLf2L1n3cV6kEWhGiqvY9MebeX5VB0oZxlUrcqSOdabh77kGhjwY4QESA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870875; c=relaxed/simple;
	bh=TXnqyj+Zy8wcK63iRufFk5f+rTb9CgyLvwubsDtWM18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iX5CbPOvg77qByT1d12aabmtZ1lBhJsFsB93W275dEDiRxfQHcfRT2ssLDyIi1Z19th1DzNuQbJ5BLukQYR0esglTLJtc9FgM78hy3YVsvAXiP5ROs46AzGVXPpB1G1KBb0a8/ZyzXcBVKhlpIF1mcY53Jf74grZkevR+HJ/53A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TVYuUvOg; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TVYuUvOg"
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1569C201EEF;
	Tue, 13 Oct 2026 07:54:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWgfjfZK4Dg+s7NVY/xulweSQTglirc5mjskX8+0R9o=;
	b=TVYuUvOgK3T9CzOQ1bJDgKkCbuib34RYsTB4hFGVkZMRepVnZzbRncQleeyajlHW/AaG+2
	7/rW4l/Ri5bO5dzap5hFZkkeIGiU5B8CD+ktkFCShmvzuakdHlNfQVe3qixW0Oetq+OzdR
	DvBShgLqmTIA2PH/GiRwoNiybynOQ13QoWd3R2NJxgwzVGwzQuHc6ZZGGF5/YRWLhjFfAs
	atnQEpItGxbniE/bPvPY5NmSDiE1BOzcz+rNZzvTLHLBdM99A2cSMJfBiw5bmmj6C7jT1N
	yljPVKE/Ko3I4oze+LENXX5Mdefiq/rGH4rZNbB6oYRhFxS9iKDctqGXIHPBqw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791870870; a=rsa-sha256;
	cv=none;
	b=bO3B3NLU9vQhElJ6yVhud44wd8NueqL9Pyh1v7e/xrbFUDy12NmgpWsIQlDmq6fMShKdwh
	ryfGDl/0rquverrj5iKsM0KXpJeB26dJNicey+cmTvVlBlR3ePBlaTeAeBPyhH6mWtIELx
	MdEnrHwkTw59savvYv8M4Le6H+RLOqaCpCra4rIWPIPBK4WMGu+kiUJLcU8DUSgIpq2dCC
	/2GGrVOZvTSaDezyXP2jV4zvUc59rEVR0grLOlwI8BIkgF55riN15qBo88x+N9fy68WPvR
	XvxS+3StC8m0ROfcnHrcCWWBQXT281a0TCYn1Yy0NOx3VqA71x7vlCPGEHsasA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWgfjfZK4Dg+s7NVY/xulweSQTglirc5mjskX8+0R9o=;
	b=ceeqp0wiodJuoWBoxwR9rg6meQhXEBopNiclO5nhsef9GVXqUuWihFyiWTAxt6VSfy4Tc+
	oL1YmmcxP98W9No2wELJatpviovWNS8ICcgF25Qyc8adJF96MBK2TQy2i1kIcB6yhmqTyn
	vYaR9knFtH0EwVA00iOmRhNN5ukVCYRPligh3Eo6k/x3bPEFnb5XnUj88MgZn3+6RHKXbW
	yWGoAblWZ5h6oYqMrgoqTG2IsmieFXhDp18BiB5ifpJmB1CRY9RLLX3F6enwyu5lYerg7Y
	rimbmzyNd49qO/9hXebMt6WYs7yoZAKXoQ+MLUK75NQpj/lxhrF0ZXF0jKYqBA==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 13 Oct 2026 07:54:28 +0200
Subject: [PATCH 2/2] watchdog: gpio: add reset-from-wdt support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-v7-3-topic-gpio-wdt-v1-2-bc98f05a4578@pengutronix.de>
References: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
In-Reply-To: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=TXnqyj+Zy8wcK63iRufFk5f+rTb9CgyLvwubsDtWM18=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bZ41MT6kLLUuIq1llnuq8UWTiNeYXnxaib2gLREwOU1
 /y0iSvrKGVhEONikBVTZFFZWMEn6vHBM3KaCBfMHFYmkCEMXJwCMJGL8owM+3r+31r9/fNu9SyW
 1xH58f71MftancVesJzbcjbNTSyQlZHh4YKWq3Jz5NVfrFjzNmx10/FrxhVbC1htYmPqHbM3X+1
 jBwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The reset-from-wdt is a GPIO that signals, that the last reset was
issued by the gpio-wdt.

When this GPIO is provided, read its value and set the watchdog
bootstatus.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/watchdog/gpio_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1abc7d0b78a62..ff303ae920bba 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -29,6 +29,7 @@ enum {
 
 struct gpio_wdt_priv {
 	struct gpio_desc	*gpiod;
+	struct gpio_desc	*reset_from_wdt;
 	bool			state;
 	bool			always_running;
 	unsigned int		hw_algo;
@@ -135,6 +136,20 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod))
 		return PTR_ERR(priv->gpiod);
 
+	priv->reset_from_wdt = devm_gpiod_get_optional(dev, "reset-from-wdt", GPIOD_IN);
+	if (IS_ERR(priv->reset_from_wdt))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_from_wdt),
+				     "failed to get reset-from-wdt-gpios.");
+
+	if (priv->reset_from_wdt) {
+		int val = gpiod_get_value_cansleep(priv->reset_from_wdt);
+
+		if (val < 0)
+			return val;
+
+		priv->wdd.bootstatus = val ? WDIOF_CARDRESET : 0;
+	}
+
 	ret = device_property_read_u32(dev, "hw_margin_ms", &hw_margin);
 	if (ret)
 		return ret;

-- 
2.52.0

