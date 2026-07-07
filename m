Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB9430CC3
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439158; cv=none; b=EEiSdXkEGXcG2HgrqF5EjUsBeeeabfALfo+pQyFy+XtK0gQSsaRsgrN08OCujlMecXbhWlij5MJyi9E5I+HZfL7PzlkzXEzDKBP3YnHYSJXP0sFeRNZfxg7MrpwOpAuyogh0XaJbHlW+kI0p1PoOwnRpVIZSyZqXfUin6Z96IWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439158; c=relaxed/simple;
	bh=LvkvyeMwz4SxBMHggvfFv5NP3Rxre6YtmV+NvT9FU9c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O6ftgO0qteTKCOXSorn71j/8eN9H0GXcortVkpjrDi/wH99wmZok89pzjkyaFkE9HF+zXhw7qbQrFt2gbBtySfLJSzQpSCEEH2GWLkJrnrAIkaEnBv6AF+XrphiPkQXBBJxFpwI2LvoTVH2Ar3ZkrBhtNSB5KSCUNgf5xNd0jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h/8m4+7E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h/8m4+7E"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F084D4E40C4E
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 15:45:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A26A260333;
	Tue,  7 Jul 2026 15:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81A0711BC286D;
	Tue,  7 Jul 2026 17:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783439147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=h6c5QMqRTcmD9pdW1ZQTIUhezz2uQgurIIUlMf+cdCY=;
	b=h/8m4+7Ek9hkxXnpB2+1G3IMNQsqkUTYf0hfd22srJdleaWLaW883icVx6jRilJzXf16Sx
	8CGkrGsqU9LftpqluE7YNp+8g5LmATo1RA1+DUVQstNy4eEs8aH9kjjrqT09hUHMngDrzy
	mhI4Z+LrdfNeIboo51lq9h4l7vjiYXAwJ4b7P1TDllv7sWWq5lRXlMj9AJvp/Oq7gtIesw
	gTVJgNCPtDpKr/Nu8MwiS2ii/FovprKqDqedLEjaU9P0JhL6gg0IXV0M45Tf7sdCeDOpa5
	/+Za5XBHj/pUuxcKLYTJDH5zr/8cS3hQ6t0rCaKn9PrQGAXnejM28H7nm0m06Q==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v4 0/3] watchdog: w83627hf_wdt: various improvements
Date: Tue, 07 Jul 2026 17:45:00 +0200
Message-Id: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQrCMBCG4atI1kaStJ2krryHiOTXRrSRJlZFe
 nfTigsRocsPZp73iaLtvI1ovXiizvY++tDmUS4XSDeyPVjsTd6IEQaEkwrfRAGMN25/Mwm3OgF
 lYHAtCQXluK4LQPn30lnn75O73b13vKqj1WnExovGxxS6xxTu6Xj3acCfRk8xwbpSxFQUaqpho
 0JIJ9+udDijsdKzWQ7LDufS8VI6IaT9dYpZTpEdJytphCkFKP3tDMPwAp4D4tpeAQAA
X-Change-ID: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783439146; l=2098;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=LvkvyeMwz4SxBMHggvfFv5NP3Rxre6YtmV+NvT9FU9c=;
 b=2rQotFH4CK2HZDGXK2fOn+tSWykezHSzjpE2x8gNoXLTGETfZCwJlD0HXWzc83bkPRTUOGH9e
 Y6ZR+/pNRImAZWWBh0OJ85PM+TefdQcFp/vVgyvEQmXD16ufgHxXZtd
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

This series improves the w83627hf_wdt driver with three enhancements.

- Patch 1 distinguishes NCT6126 from NCT6116 by reading the low byte of
  the chip ID.

- Patch 2 replaces the hardcoded "W83627HF Watchdog" identity string
  with the actual probed chip name.

- Patch 3 also sets WDOG_HW_RUNNING instead of a single keepalive when
  the watchdog is already running at boot.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v4:
- Updated cover letter.
- The first patch does not add support to NCT6126, but rather correctly
  identify it. Changed the commit message that was misleading.
- The second patch in v3 brings unexpected behavior if
  WATCHDOG_HANDLE_BOOT_ENABLED is disabled. Instead, keep the manual
  refresh, and also set the WDOG_HW_RUNNING bit.
- Add another patch to correctly identify the probed chip via
  WDIOC_GETSUPPORT.
- Link to v3: https://patch.msgid.link/20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com

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
Paul Louvel (3):
      watchdog: w83627hf_wdt: Correctly identify Nuvoton NCT6126 chip
      watchdog: w83627hf_wdt: Report the probed chip name via WDIOC_GETSUPPORT
      watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

 drivers/watchdog/w83627hf_wdt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

