Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0939901C
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333787; cv=none; b=tDwD1l03g/jLJDuh4wLYHPOksAyvUz1ZdoW7VB+ALpz9J3kvynlifnu4X3MJPlMr2969WFepvCP90jihgDtUxKPfI1GjzhqxsIq0OdVkzuae2dqOCQUlcgM1FGW89QdNHWZbuEibr0rzgNTtFAZ3p58Relhv26X0/mxznkSW2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333787; c=relaxed/simple;
	bh=BVkhSajw/FDBT90m4qHgJKvmH2HZFeIqs9/WyDxzyb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUXsOERbPPoAWxasE2kwhxjuuoozX+ztr3J/w4XN0YFegYwfk5U7qPjDiiT0DP6nzGLv6AkOVit4L179MOmL6eZAB2PnznRr1dn+WuYGNZUjOJHij5Ho8xOPGXxSKhOEgvWv+1jQz8cLPf2zDJLHRCh6mrGyj5IOFvZFNg1rpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A+IVIVrD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A+IVIVrD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 492B61A0E90
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:29:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F950601A2;
	Mon,  6 Jul 2026 10:29:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F16ED11BBA054;
	Mon,  6 Jul 2026 12:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o0Mwfabvget6PZJj+d6IPsQ+q+1jAPtE339stxy3peI=;
	b=A+IVIVrDr2XFxNRVrQZBTFzb3oyptpVBFHvZ61Ccqmr3KXTWtASQiFb3BrGnc2F28dpiKl
	nWgVw1OcEOO/VI7vTHG+ulY6YkPtHjaDJ86HmoC6d35efUgwTBTwwJ8ldWAu7PL3VBVlnp
	u8GfDueR+XCq6R1H7j30ZvxXN/PC40LnNpknhZeqiaz0RFiLFAAdTZmLCDColq/yMMmyVz
	SxGcmN26D/S5gMSaCz50kQzfgyaJaV8KpP84RjUaoovX+0Lcq0cLOl/nKMU6WDe0yCJEne
	z8CyzlOUF1Ol7mySN7tez+pwra9r3ZBRgNmaMY8riK2YBJUMBqyLzYtZzGukag==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 06 Jul 2026 12:29:37 +0200
Subject: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333779; l=1411;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=BVkhSajw/FDBT90m4qHgJKvmH2HZFeIqs9/WyDxzyb4=;
 b=xjfId2721Bnwa1LTSjpffoW7kf6be68l06RtFdX86ELtct8KNXWZjxBdOLXFd/+9TVgc0BdX6
 pGmrpc/ZOIQDNa5ZD0jQLuWvu3g9QQ6zOj86C6lDI1VRHXrkNIfdAWc
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
index a6dfa9d01702..27ef1cce3a14 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
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

