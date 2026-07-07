Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145A3EFD36;
	Tue,  7 Jul 2026 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439158; cv=none; b=Qv3Um0guVWV5LQ6mneW84FrIPYDreBEbvLCWEgQr4q5Sd3V3T5N+zPq1M4YsEh//uvtAZsRAVuDbIBgLZCGEDffD9BiwD/1yW+1xEwFqeFpkoGptzkCS6XaX2/P1IDrN5PXiUSeJO/jE9A0ii+qmTkd8gLpsqKaHcf80YgwcUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439158; c=relaxed/simple;
	bh=OcMJHHgdj/qKCRnbK+L+0pXpKGBuxeaoVgWMWG6jcqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOZ/FlTmSc1TjHmwauM6o3mPevgRvZOBABgm33wY08L1nmovv6HeZMYLqHovELi3b9LAjzB1FXxWnGbMcUYPVS6suZEGzW0sfMDHUPn3eV7y44oQVdLpiL//R/Tebxj2aGV8F7t5hxWbf8Uey1FqIn4yDEGlFbUdMFbbkJjjC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G6TbSiaR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G6TbSiaR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2252A1A0EB9;
	Tue,  7 Jul 2026 15:45:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EABFA60333;
	Tue,  7 Jul 2026 15:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02CB711BC286F;
	Tue,  7 Jul 2026 17:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783439149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7bXOkjmb5qgVDcwHpi6LSucMRO1IG0FknS7l0QOKem8=;
	b=G6TbSiaR9xiIhffJ2vUxK+anlW/oO1FM5zQ7Hzm9qR5kclxaAVmvVhtk1heFOhHFoJWFcw
	CCZ8+LYDQfgw2vau/8v4KSpF4F4maw2Jff7uJ+nFnzV3MnFGgAgGOzI8UmDuH//pHr8x13
	xKn8V3bgumNcAtBq5bY+EJ98BE9P5zDkh3bN+iCho2k0vzgVOvwiLAftx/vqswGaM1YOll
	vy35B2e/rz+SnLM9rVjgo4MR/wlbnNa1O6eMU6hDUCiSj17WYTruwtVYiIA7gQW31Fn4zM
	qsDW19uZs5aLLNUvoaeUBkHhbWa6g0HpTIgSYwkvCxcFMDpMns8rYH6JoiDMRA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 07 Jul 2026 17:45:02 +0200
Subject: [PATCH v4 2/3] watchdog: w83627hf_wdt: Report the probed chip name
 via WDIOC_GETSUPPORT
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-w83627hf_wdt-nct6126d-v4-2-829e5f63d548@bootlin.com>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783439146; l=1565;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=OcMJHHgdj/qKCRnbK+L+0pXpKGBuxeaoVgWMWG6jcqQ=;
 b=dQv+yI7cLS1y5BJT3Ll0g+CSCELdzaipCshoYZaNiEnSiLdDA+vQ1DvxYIA1YPLtZ+VeUdi28
 eugV5qg3gwzAQ11XdmhA7PTupQZWo2MjyoIhCiFGHWEIS7a8jiRrufw
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The watchdog identity string reported via WDIOC_GETSUPPORT has always
been hardcoded to "W83627HF Watchdog", even though this driver supports
a wide range of Nuvoton/Winbond Super I/O chips.

This is misleading, since the driver itself correctly log the chip name
in wdt_init(), but could report later a different chip name with
WDIOC_GETSUPPORT.

Instead format the identity at probe time using the actual chip name
that was detected.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index a6dfa9d01702..bfe132cfea87 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -316,9 +316,8 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static const struct watchdog_info wdt_info = {
+static struct watchdog_info wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-	.identity = "W83627HF Watchdog",
 };
 
 static const struct watchdog_ops wdt_ops = {
@@ -525,6 +524,9 @@ static int __init wdt_init(void)
 	pr_info("WDT driver for %s Super I/O chip initialising\n",
 		chip_name[chip]);
 
+	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
+		 chip_name[chip]);
+
 	watchdog_init_timeout(&wdt_dev, timeout, NULL);
 	watchdog_set_nowayout(&wdt_dev, nowayout);
 	watchdog_stop_on_reboot(&wdt_dev);

-- 
2.55.0

