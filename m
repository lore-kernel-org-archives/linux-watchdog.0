Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE965442373;
	Sun,  4 Oct 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116004; cv=none; b=OFBq48hVWYMss4/hnSQEEHXvGwqBlnNNc4AqGBq7bz5D1o7t2LUkmO3e3jYAxqLdx8Ueo4UeoWrWWRyQp4NfOoG4lSkVHAJJ2GuP6Hz+cLmgrjlqGZBlAj7AKrzE3ybdUZnPo0QWXmyPuUbp5Jj3kd9h554A2UqJLpt54UkDeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116004; c=relaxed/simple;
	bh=viT+NiRK13CrvxT14a2ySGsjVIfGuum7xK+gZ+De9RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbpz5smMw0uI7UFH8fT0yr4etcO+OthQh9d2sUH+nkDdgEXwIfeU2uYXcv1rj5h5OreP1utJrmXC3AGUsGz588Dtq6KYpLEipEkNcJ74CbSxBRLmOhJ+l+//o1I5X+hh803joA6kljB5L2JPV+3/x0wj7+HvCanhQ7H5tNfA8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N2K5T/gZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N2K5T/gZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 790371A10CD;
	Sun,  4 Oct 2026 12:13:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E777604FE;
	Sun,  4 Oct 2026 12:13:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E82C71032817F;
	Sun,  4 Oct 2026 14:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791116000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UMH5wO5gbagFxrbWZU7p8IzMJylzMpt3UUiLRijZOzA=;
	b=N2K5T/gZHB2MFV9iYgA0DCj49Xc4brKAzrYo/K+mUBJNpPkSDka6onj1mNRoFy8FdFAiQ1
	xLR5wleEjTvljPVlGvDHTCykuwoJDuNtP2lJL+59zZvXDTAyMe2MMeNEZAEJyBBVAzUY2D
	4WELDKaPalegm+8109fsgDfdyfLzuDx91ik5sJJQe6WTnVXvGTsN/+TmvDvUiRAP1DI7qc
	beqoiAfS7g7Cn4wFgUHGscncpmeyE5eyBADXFsdfsm3KQykUSXqaBi4mM96+WMzCdrusqS
	Y3bWVEANZq3qztXhL8YoGxzp1t+9POKDT5UVToTOFERfz6rgT5lJMi312FjMuQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:54 +0200
Subject: [PATCH v3 6/6] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-6-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=966;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=viT+NiRK13CrvxT14a2ySGsjVIfGuum7xK+gZ+De9RE=;
 b=iTXvjm7Hl5iELqW4b4qJmf5Cvz/YY0ql5HX5UDqXLRlQeBiboFKxDruXKlmrSF1dAdDGOJE5x
 6osWghq7OWkCzc2KhK2YwH/w4bQYwIdsctltAzk+qu4QJKIP0AEgRdT
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The driver currently logs an error only if the chip initialization
fails. Extend the error reporting to all failure paths in probe to
improve diagnostics.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 1aba9efa27fe..bba7882b254e 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -549,12 +549,12 @@ static int wdt_probe(struct platform_device *pdev)
 		}
 
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set watchdog timeout\n");
 	}
 
 	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to register watchdog\n");
 
 	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
 		 wdd->timeout, nowayout);

-- 
2.55.0

