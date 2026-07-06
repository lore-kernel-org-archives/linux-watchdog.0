Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB76442117
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332882; cv=none; b=OepVxae4lTFmxzPBsMY7H1vUrLg/DJllHUpAv07evCfoMqu5JxgOoNqwrKT/+YFSJVqtV85p+vVbNsTHIOc26AOgA1wDufw5ZEPyTAhjy995k0UYFoPdMCWoCeBA3HFvkIsPhuflKfyjNp1r/HxGepCDlIc8fgZaiSXEqigpDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332882; c=relaxed/simple;
	bh=Qf0yiV2CF/VrA2PBrjHyO0zeoIQxKwbiSIIOGojbXnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ch9EehiknRqZbyovTQruGhMmf/k2g1PFJfHKhXK47qxw31LK99V0jcOzvCW4f1r6LplDQkocEGKoZPInX80EcKYlkF0MEEK4uBSoydmG9+OKF6InrIWR18p3TotoXiV/TDSUHKpikVrBOKfV4HguMFUqSXQ4nGLoNWUoV6sLMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bYiMNRvD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bYiMNRvD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F5A11A0E8E
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:14:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14B6C601A2;
	Mon,  6 Jul 2026 10:14:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A77711BB9FF9;
	Mon,  6 Jul 2026 12:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783332878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0xydVSBWHWsCNcw3lIpJAISoV15rJw8dXg/LrMkcssk=;
	b=bYiMNRvDlTmSturX/UR4arLSsbHQELXSKGBQL6nCtAv70LLwpoCkktcrrzMae/bV323v02
	kN0MWhFTINWToOOA9fejwhA7ICjPoqCt+U0rhwiflJAN/LRcfQE0IDr8LLKHyn4JDvSNwS
	rdfw34R91m8kr69Y9QF8/Or3hqOlYeFjoZ8nwHdoa+tD3vDRKGSH+/2ELGBiy09ec6YUCJ
	7zq9sULZrGlq5cd0U3MUkIUhnFkXnrXNfq1iRbpIZ7O3AorpXUhuxVZQU1GQmOuBgbmM3o
	zFVaNK53/AH8CxGiPg9BC3FBeSJm/kxISnR+zRXGW9a9rmZ+rm4wAncAFN1WQA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 06 Jul 2026 12:14:10 +0200
Subject: [PATCH 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-w83627hf_wdt-nct6126d-v1-2-c5b0d51691c6@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783332875; l=1411;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=Qf0yiV2CF/VrA2PBrjHyO0zeoIQxKwbiSIIOGojbXnI=;
 b=+IbQez2a1l7Z+qaRs50NNgBjSKCHuiqWEGoqFZzZJIvqa+f9Rj+zJxrOAQPnFFNJhogdvFvRk
 hn72/8Lxa4sAhW9tXm2/Y3+UJE0xE+R/7E55yoOOhsRBghxWihiwd/U
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
index 9533baa45384..067831caa964 100644
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

