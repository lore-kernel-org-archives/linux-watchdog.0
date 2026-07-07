Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1A416122
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439158; cv=none; b=nc6PCd7ZtO7KJcfqmGwt4TbOw/jTJkGPOTY6KGk4WwsWv5A3rtmBMZN2bITuiCk5vjx6uiv23ylQF37wrMAw9KKQVtyxN7EVYt6SHGJFYU3RZNIei0glWlvj3gRMA02O1ERFals+ODklRMSXF8KwG3RHsdyM68yUde7Ooij45LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439158; c=relaxed/simple;
	bh=3MFOyvC97mLr54rbX9Aq5yHTBv4gXCB7eikERpdHIJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DC/wlHmsmb4kbtAr6mLJ+rElBoMJnHmDqjpxNgXvcCSjDIRGdTSWmvt4e25Pf4YirwHUqPJvcNCRQ2x+hve0Mh8ezMtOrmrTA9Rj+stqzwcRIDDayDJXNP3kkwWnhOi1K4FseRJmsMscTb6Dw8v2BgensALNZhlRJUZSbkjjZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dz5OiCA7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dz5OiCA7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 402634E40CC8;
	Tue,  7 Jul 2026 15:45:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0EE6760333;
	Tue,  7 Jul 2026 15:45:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B58AB11BC2870;
	Tue,  7 Jul 2026 17:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783439150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ak/WPegoF/QeLPx0IlW0UHG6sEbYSCMhD56HIG9rt4=;
	b=Dz5OiCA7LIxJkpSbCGrl5pKRVgOZ2gpbbzytxHQctYE2VGmzi+wldeqOqDSLA/6j9KJJnW
	q+2q0+sGIxj7YnHQoTswVjN2UXMQdmwyd+YsdSl1+C7r72mnlV56jPTqlWb3CgXaEcc851
	Adkqrx8MjnPHrjfTaIlXvbVuVDsKDOuoR+uYCjX/ZO/fd3Ff3qE5M9fbpJWZRgbh/iNLn3
	KXeery0dWBICcRkGg0b1Ai/4lSo+fOmSbtHvipXvUNCY5LkInek96MRQBHqu0U6WHWTjZU
	eInDN+SLY5HbLslHV/LDAZuZVWM276EDDsWbtlb0mDJMqc1/F0oBtbuoZtCcCg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 07 Jul 2026 17:45:03 +0200
Subject: [PATCH v4 3/3] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-w83627hf_wdt-nct6126d-v4-3-829e5f63d548@bootlin.com>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783439146; l=1060;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=3MFOyvC97mLr54rbX9Aq5yHTBv4gXCB7eikERpdHIJ8=;
 b=d08vs0r8xVZBldcp2XLRAImXX7mdhovbxZSgN0f4Xf5x9/k+DgWOJzfkvm0mfYpAgIOlFSz08
 lT8jSM1NSDDBiNxXy2uY9J86NvdM+JDu+Ymn7LiUAaHOufP6/MrO+Hh
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

If the watchdog is already running when the driver is initialized, the
driver currently refreshes it once using the default timeout of 60
seconds.

Since commit ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag"),
the watchdog core can kick an already running watchdog alive until
userspace open the device.

Add the WDOG_HW_RUNNING flag to the watchdog status if the watchdog is
already running.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index bfe132cfea87..db77599e43a0 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -244,6 +244,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
 				wdog->timeout);
 			superio_outb(cr_wdt_timeout, wdog->timeout);
+			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 

-- 
2.55.0

