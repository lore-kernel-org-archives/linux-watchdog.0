Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D03FC5D3;
	Mon,  6 Jul 2026 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333196; cv=none; b=p24IXBaa7uydcO1LPMcWsSxlowccjIH3qLiHs5arOWu7+RDsyg8JH/9gFjMIsyaYBApcipetPuElmvKjbhQi/5cWRSlSDKJhEN11ELgJH0sIhzd+bVGm6gDaYqfR/8CkS40nGCD3frnqUBZqI14cyQnaYRnGeJvTkqJV1w63VKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333196; c=relaxed/simple;
	bh=BWFHW3NZV2y/pJa/gAwLN7Zsfq7N2HbYXWVkVlLkkr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBljcvTtHNaWEcpt8rC/O6M6fLn4zCnF9VG0h64Vuu+5/8lXBr5Wu00ZlB9A5YXn9i2/MCRR29cpwXUwDS0FVZEcCLpBPmVBIOm3eokGNO8i8VmOCOnTLnd1FvoxH/KD43mGsEX8gMIRCN55/Tr4LlhPNt5qWq6m4SxACmuzylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/dHVdqq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/dHVdqq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7AAAF4E40CAB;
	Mon,  6 Jul 2026 10:19:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48A0C601A2;
	Mon,  6 Jul 2026 10:19:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E592211BBA021;
	Mon,  6 Jul 2026 12:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333192; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=z+rJh0O8lW4TcAbQEar8lE8re30i4P2YcZlFwvXJ4d0=;
	b=R/dHVdqqEafGOVvMyoxnbNq3V0sH9I0w42F/pYz6tRVbXttbeW5hW0IrR5WuzheDfbdjpq
	/afaCZevC5nQeiYqMrJjm7aYfYzXSp9KT9NrW/0UxdOnLekMPAwqE83H7ik3HKHCFyqWE8
	/mYOH2qErXxkY7HbKJuPdD3tR++zIQjfaksblvsna0E770iVg01f4Fwv9x+OAjLQlWeSt+
	L3VxZ9D3zOT9us/KuPFYxiuq7mVk6EXLz2rUYzzFYKcfD3tv9lsrtFz0ZQIR5weV9MJm/R
	6zjy/Sw3xsQlRUd6zwBDEIUBa02Tu0r8fzXrRqk5anKC7ZVoAhQ7PmcJ4ByvnQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 06 Jul 2026 12:19:33 +0200
Subject: [PATCH v2 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-w83627hf_wdt-nct6126d-v2-2-77af74af88ae@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333189; l=1411;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=BWFHW3NZV2y/pJa/gAwLN7Zsfq7N2HbYXWVkVlLkkr0=;
 b=Uo/nNEpzh2TrV76U/5DrDRf1azCzZL/G/5KLpp+U/xdpW0558tOMNWWgzIhbSHztJiw6zTno1
 gqM/bIn7ZkyA+kQqiqDocyaTZB/VXWfQtlYIoNyrLDLbVhr1Oe0CEq5
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

If the watchdog is already running when the driver is initialized, the
driver currently refreshes it once using the default timeout of 60
seconds.

Since commit ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag"),
the watchdog core can keep an already running watchdog alive even when
the watchdog device is not open. This is more robust than issuing a
single manual keepalive during initialization.

Replace the manual watchdog refresh with the WDOG_HW_RUNNING flag and
let the watchdog core handle periodic keepalives until user space takes
over.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 1f649fda8a81..5348c0f79de8 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -240,9 +240,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
 			superio_outb(cr_wdt_timeout, 0);
 		} else {
-			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
-				wdog->timeout);
-			superio_outb(cr_wdt_timeout, wdog->timeout);
+			pr_info("Watchdog already running.\n");
+			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 

-- 
2.55.0

