Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDE3F787C
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333193; cv=none; b=O2bKHnxtUE5DolghqIcYtxhQwPRfvMlBhrqaDGntHWzlRuKNI7szu/p8GW4PmbhW/xyyLz4edspjJEgq0cNVHvvRaXElWiUvj/FmNZleQW7jmWn3xmwTysPBqa1vENCkqywvG2V6G53PRi3Y37oLd4nfpPxgkm0X6+6rmf6spAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333193; c=relaxed/simple;
	bh=kycHmRr4zEJfZ3obQR+zPwIdDzsGtC7l360sZRYdXAE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h8RO6vUndT6wkPbHNUtkzj3d2olynCGOPTnZdVi2jiWMIjTE8B9/Sk4u/YmyNvd8u3I3rzqrTaynfTtaunNoKlD+gVDtDjU9aQpWCqUzsDs/CJXBxFAY5yYWogCtyqsMG/W41AYMgg/s/CtOwxnwUIbiA6Qmrw34gvRN6iQy4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AKdEQXs3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AKdEQXs3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0BAA81A0E8D;
	Mon,  6 Jul 2026 10:19:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D526F601A2;
	Mon,  6 Jul 2026 10:19:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8040E11BBA016;
	Mon,  6 Jul 2026 12:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=F0c+5I2+h+MTLMo8GadFPiZtTvPDMFTwHc0SiR9PuGA=;
	b=AKdEQXs3CMnpKo+l7/BHYnfIP0vCNLscZz737SUf0SbGHfcH/BJ2jsQ++TxcOsMwUk7+er
	PJLq1qkx+xHfculBFCWlxuXDDc/BUr6q4WE3dMZ1v+cGhAq5FFTwLUr4yb/uUI52teZ+8x
	ecs4PRVILxBt8m1ViqvjwM51PpYC6LUtJxYWAzQU/K9wWmvoo4yHiF0ljohSeAGuTuUxL1
	PuiKp/fNC7eDbmLIJbnFCIupJoSUxebEOO8xNDy2srVLY+2gfLnAClQUJre8R+9Nah+0pq
	sgX745kVirRi9hFNc//fyK5YcfAVk0NOQlP9RCffbFSxvx6oN/6e/hR/X8yhug==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v2 0/2] watchdog: w83627hf_wdt: Add NCT6126 support and
 improve handling of running watchdog
Date: Mon, 06 Jul 2026 12:19:31 +0200
Message-Id: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pq2hEFc8R+GGPpAxmhr2goaw
 r8LGJcuT3LvORNEG8hGOGYTBDtQJO8WkLsMdN+6i2VkFgbJJfKSF2w85CjLvjuPJjGnEwqJhlU
 tF6i6Ulc5wvJ9BNvRa/Oemi/Hp7panVbZuugpJh/eW3gQ6+7XwD+NQTDOdKG4KQRWQmOtvE83c
 nvt79DM8/wBQadWHM4AAAA=
X-Change-ID: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333189; l=1409;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=kycHmRr4zEJfZ3obQR+zPwIdDzsGtC7l360sZRYdXAE=;
 b=1irrKJQvlOl20hEnoKBwmtZiDeAGkgQ30Xl74o7nr6sKi7RwVmI1cJcNArOU5rX06ODqFhMsn
 PKD5LkFMFXdDnDLR9doIOE6DctudDda839snW2PnnbstqlEcGLID6wi
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

This series brings two small improvements to the w83627hf_wdt driver.

The first patch adds support for the Nuvoton NCT6126 Super I/O chip. The
NCT6126 is compatible with the existing driver but requires reading the
full 16-bit chip ID, as it shares its high-byte ID with the NCT6116.

The second patch improves the handling of watchdogs that are already
running when the driver probes. Instead of issuing a single keepalive
using the default timeout, it relies on the watchdog core's
WDOG_HW_RUNNING support to automatically maintain the watchdog until
userspace opens the device.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v2:
- Small mistake in the first patch. The NCT6116_ID macro is redefined.
  Fix it.

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Paul Louvel (2):
      watchdog: w83627hf_wdt: Add support for Nuvoton NCT6126
      watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

 drivers/watchdog/w83627hf_wdt.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

