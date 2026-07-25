Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E013C4B63
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975418; cv=none; b=E7qjMa6LZ20G9jGrhfyTIZtvir6d5KyPOvspoPrrGa3TGzBl9sxNCVkfL94S+JbCe9/q/MhiauDjpkzFC+CwbJ8WEJgnnXt+2eWF6Z1TbZN+qmJnXYePEWVbT2J6205ghgHctcaTmlYgrSt5zitZEmNBXlL7+ic0DKsecdvl1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975418; c=relaxed/simple;
	bh=2aOv+K9z2H6nhu88y/n2r1k0b9k0pzEgy5EnFzHktgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svlSMYXeJR3phJGCuCtycWiV2fDQJV+mT+9olarsxHfeZEP8/LZPUL+73L872fMuQMmEkHhQAcduFcET/KnUqxcMBBmGPKbp9GyY7LPbkZKrgRbSHeLV4Z2B95XRnvoTaoJo0Iobo+blA51Qwih49G3zVxUzCLT5JYZ2Qpzk5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SJuP4/1j; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SJuP4/1j"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AE3BD1A121B
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C61560398;
	Sat, 25 Jul 2026 10:30:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E25811C13103;
	Sat, 25 Jul 2026 12:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975410; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vOhmFHDvMiMdKvl5yy/ryj7atqFkE4E8DO6SWKY14to=;
	b=SJuP4/1j1aO2k/iYWuBu6kvWUFxDCu0AJagpNFz1RnixwNm6/hsSfVvR6w88DbEb8JAenx
	G0TcZ0DZ/uDfn0dFq2XiYiF8KkoQWQkgum7hZ12Vd6MpECaa6njiT4EnoUHOV6H3ugkv/q
	MVsqpvj9GDRCT4mX3xBrn3HMHjTf6g0fEFnhFavIM4h9LBFDWNJf75so1IwkdBelAFUPzA
	3EV6iolGdsisuILJIXlSGPealBkNAi5N4ycXzlAaoicl+2P37l+YXy7OKSRsrcUu8YBAdf
	NMyNzX1iIoDxWHNcLRbbuZH+2AFjll+T8Gc7QJmX2rrbUKy9YiOBvR1c2Y3utw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:35 +0200
Subject: [PATCH 8/9] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-8-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=1912;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=2aOv+K9z2H6nhu88y/n2r1k0b9k0pzEgy5EnFzHktgs=;
 b=8HWoBnadH1HuzR1V3zySARV97pICh37nKaRvdADT451DCXjp6C1KDfQ94gEKGZPLAJWDo/JVg
 lr/zvKEQTc1D0drc1LNmqW2LFGKWbpoRmX5mFXTS0ljTqkU9Dhu5wz4
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The driver currently logs an error only if the chip initialization
fails. Extend the error reporting to all failure paths in probe to
improve diagnostics.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 90d41f21aa5e..cf1a3fb3a6fd 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -479,12 +479,16 @@ static int wdt_probe(struct platform_device *pdev)
 	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res)
-		return -ENXIO;
+	if (!res) {
+		ret = -ENXIO;
+		goto fail;
+	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
 	snprintf(data->info.identity, sizeof(data->info.identity),
@@ -524,10 +528,8 @@ static int wdt_probe(struct platform_device *pdev)
 	wdt_set_timeout(wdd, wdd->timeout);
 
 	ret = w83627hf_init(wdd, chip);
-	if (ret) {
-		pr_err("failed to initialize watchdog (err=%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		goto fail;
 
 	if (data->early_timer_val) {
 		if (early_disable) {
@@ -541,16 +543,19 @@ static int wdt_probe(struct platform_device *pdev)
 		}
 
 		if (ret)
-			return ret;
+			goto fail;
 	}
 
 	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret)
-		return ret;
+		goto fail;
 
 	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdd->timeout,
 		nowayout);
 
+	return 0;
+fail:
+	pr_err("failed to initialize watchdog (err=%d)\n", ret);
 	return ret;
 }
 

-- 
2.55.0

