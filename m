Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C439DBDB
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333785; cv=none; b=uAZslgqnNqqmVxOUHoc3CJ+gKhY6cHnvGbWbkGLY0JqH2TmRzflKNyLgZD9tVSPB48kGeE9Kd14rT8QFV5eD2IJlPpH59Er2EgD7Vpy22TAv7Vv0muPwKPzfGGdHh9aS0OYI44WjUC8fQcphIlRYSRuqI72tnBIfJUXs7uOCysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333785; c=relaxed/simple;
	bh=3ufb10AULLXCRc+93WKfHnsW4zB0Ekhiadabl5NrCuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D3JwP5qA/sNeBxQzt0VZlDR2m6v269Mt5C6ze+lZSauPl8yMj1c6kaBB1a0KqF8Gj96cFfKxu62VSzLwcVcMvNaV51StNA1ZiDdczOtyDanmJXp6sWjnGeVxh+3b9AkskvFVpVmW3V4JqTM/U9xgTN3DeMGCy4q8HyEzA91f9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AZcDTRYT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AZcDTRYT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C88031A0E8E;
	Mon,  6 Jul 2026 10:29:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 989AC601A2;
	Mon,  6 Jul 2026 10:29:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE0B911BBA004;
	Mon,  6 Jul 2026 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bGOAVF1+CM/D8T82NLLOBoIgqGtihl2W+bH67WLyabE=;
	b=AZcDTRYTFBbFzDwj9eDLF8D+KJyZJeKnGZq8RtFiKenKNXCTsC879oA6XK5AoPDfHNEEHh
	oxQLjU0UMu9w8e50gnhNEA757xx6byI+7r85Cd44Lb3dbcZ0xY27e06e5w0unKIXV6kMZe
	hiZeHATddAEFuWFh/vU7QrNFQyGdRt5oMPATHxQaVFzYjuef+kNa/WkekmRjp9mrZDEzCC
	cDwhAm+HSnIh7VAfIDqwAd4zcBhwqJ7Kp6Run8M+U79piJ6JGQwglhfJRAhRvppHTZ41fv
	lsXSHMViRgytMN95SzEnoJ2CCTPvcDNK1NCyJWub3Tum5nOmwbuiILxLvwMccQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v3 0/2] watchdog: w83627hf_wdt: Add NCT6126 support and
 improve handling of running watchdog
Date: Mon, 06 Jul 2026 12:29:35 +0200
Message-Id: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ7CIBQFr9KwFgPUflpX3sMYAxQsRospSDVN7
 y7UuHBh4nKS92Ym5PVgtUfbYkKDjtZb1ycoVwVSnehPGts2MWKEAeGkwmNdAuOdOY5twL0KQBm
 0uBGEgjRcNSWg9L0N2tjH4t0f3uzv8qxVyLK86KwPbngu4Ujz7tOAH41IMcGqkqStKDRUwU46F
 y62Xyt3RbkS2V8eljycC8M3wtS10N+eeZ5fEWPcjRYBAAA=
X-Change-ID: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333779; l=1671;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=3ufb10AULLXCRc+93WKfHnsW4zB0Ekhiadabl5NrCuc=;
 b=ozhAzEXZh1WY3cV9M1oCTptztBiKkkGvR+5mo29PO0sRSWHUwT6KjXfZCLucZnZGkPogHhWgU
 mqxsycfYmy8DW163INoJdJw/af37yvsoHKzx1O/FOIiA2wSB5P4e0qt
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
Changes in v3:
- Forgot to add case in w83627hf_init() with the chip. Not detected
  during testing because the BIOS probably configure it anyway on boot.
- Link to v2: https://patch.msgid.link/20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com

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

 drivers/watchdog/w83627hf_wdt.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

