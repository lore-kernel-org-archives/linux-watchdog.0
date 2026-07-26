Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754D3E49C7
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091544; cv=none; b=vFT7ebcFamj6k+5HpRpgws8LkCRLygu2lI7kf93CYV6ORhWOSvmR2vmN/6xVxSPr9nwto69ktIV+djaZBzAMclgcQOcN0hvJwGDh0NtqLaHgwWa4sXMteMhhTQ0avWDVtQNg+qKvH3OZ2YHU/g3Xm3SzIBirZQdtQk8dpx+Z/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091544; c=relaxed/simple;
	bh=ESEGWz7WvRdIHFMhrkNN7sG0mCt9tn9zfpv6Oiu3DLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYEm8VqDK1oe2N5lBpMSiF5f75OOCAp5GvGXLt8ZZjrzPBQ14p9USC/y8DsrgZXO6W7SH0GHYSYSRWWV5eVW6efrPj1Lx4Ug2e9rXgpP+TpFLpdbG3czDzlKpnLB/jUdD+364DvrEHOw2KOQL6SAZkgtcSH+p7J+/zsHgV/VEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qbZ70/PE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qbZ70/PE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ED1B51A1264;
	Sun, 26 Jul 2026 18:45:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCB8E601BE;
	Sun, 26 Jul 2026 18:45:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF29A11C10AAF;
	Sun, 26 Jul 2026 20:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785091537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fDdKKC6ohzN9gKpm6o7MiU5hJnWDzzqiL8Kl/7INzRU=;
	b=qbZ70/PE08sJOGdRoc+2kTZVuQoj7PxtAxosb+A8nui/w2I/QcxtOPKKodZkF3uGMiSNzo
	ZftT5b1TmemKYNyaO0RE+NV3FwXKMYU6Q3wp+eyD06fy9kIJvsJThmS/mV1PAlKl6ZtRG7
	pTMlB1npivbBAOkIpOqhwFaGxO3BKYNLXfydBW44slAjLgnD9xPd5TPSfFM2kjMNkykrMt
	UIoDr5rpt7VR3oHZWSs5GkDi9O8pQ+7w3jAivz9omtatmAOWs4dx7R3V5m+E8Rua//5ZWV
	adlrj9HyG08wBIOqX8ydMQpCn8nnzdKoh2UwbsQcK0B+wphrC0GYZnlixyL77Q==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 26 Jul 2026 20:44:35 +0200
Subject: [PATCH v2 8/8] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-w83627hf_wdt-improvements-v2-8-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785091497; l=1369;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=ESEGWz7WvRdIHFMhrkNN7sG0mCt9tn9zfpv6Oiu3DLM=;
 b=ZQI4YM978y9TNehy8Kf/YxpHbIudqDWS8qNVVbgrpiVUBq8+H4GL/0uY1lWxBOEB+bHJXHXmm
 fH7imo32UJyAoVoWll0LwJwNWMD56/akBbAufkHE5mHwDSigJ+ga/4U
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The driver currently logs an error only if the chip initialization
fails. Extend the error reporting to all failure paths in probe to
improve diagnostics.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 2957364485eb..7b50865ae824 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -485,7 +485,8 @@ static int wdt_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res)
-		return -ENXIO;
+		return dev_err_probe(dev, -ENXIO,
+				     "failed to get I/O resource\n");
 
 	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
 	snprintf(data->info.identity, sizeof(data->info.identity),
@@ -540,12 +541,12 @@ static int wdt_probe(struct platform_device *pdev)
 		}
 
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set watchdog timeout\n");
 	}
 
 	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to register watchdog\n");
 
 	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
 		 wdd->timeout, nowayout);

-- 
2.55.0

