Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821F3BBA1E;
	Sun, 26 Jul 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091509; cv=none; b=j9tD/d9anQRoC4D0ccTO4vT1hPpSeBcZE+Yszm04qyiDPrQB4TSXiNRDfVae5uygHtXz8/LT1POUfbpUuTc5I34snHa1Ol/wdRwUGBDHc/NSm4eYKudzX5GVxHZti41oJ1uavXi7TzHdhN4GgWQvg7e7+VL9evqKeZhliC49ztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091509; c=relaxed/simple;
	bh=r7gtfrH+drHflPdIPOvOJD3Ta8plsvCzMZ8MTXDKnzw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PKnVtwqp4rl4kQd821UfDoFqmFI5uN0aZMPGz0k3archs0WLMN/0TdjWkqJ9dL3EpzFpQIacqfbxG//0vZ9dTW7Vz0TqsSpcFaITMiZk/LqJi2ZHaiw8LJHA6Mkx/kgVQVqMMrYsepwwx1kOhTdEbZHvJoe0ewoKHLW/bP2HQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nn35ukJp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nn35ukJp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6DC6E4E40F86;
	Sun, 26 Jul 2026 18:45:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E4D0601BE;
	Sun, 26 Jul 2026 18:45:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74B0311C10AB4;
	Sun, 26 Jul 2026 20:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785091498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e2OiOEUrnxOCwKwHNdTh4E6LeSqG8XjeEl108TaYitE=;
	b=Nn35ukJpQ18IfNNtsaA+GeFcKXRitAwflncmfytVdqYGqXqrcmILJdUj1HhZs5ihRwXTUJ
	90H8aEbVXCW2Gu24V/bBSxqLMwR1imyw/oUGNw2rdwnxLpv1RCFH0qTrYz7uU0iMwzlemv
	/TT/daAhMN/L0fM9IzHGpqN1mAxqWhZ/twZXiw9fxI+RejnD2naQS+FJZeR5ZCNUCPCBWG
	eT53SAILrpPxXl+SWpS0yPOKSyXnoFclxfDe7wWwNPsA1Eut4vj8RgoyWZrDpk3SHP2eoz
	7qvAp07fiuwHU3Hr/EyjEGvIvf1fEEuphqR444PvP2lizOoqA4gZkufsInHSeA==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v2 0/8] watchdog: w83627hf_wdt: Convert driver to the
 driver model and add minute support
Date: Sun, 26 Jul 2026 20:44:27 +0200
Message-Id: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQy27DIBBFfyViXSrAmIdX+Y8qqgAPNVVtUiBOq
 8j/Xmxn0Wza5ZXunDkzN5QhBcioO9xQgjnkEKca2NMBucFMb4BDXzNihAkiaYOvqhFMDv712hc
 cxnOKM4wwlYytYY3gtJW9AFTnzwl8+NrYL6c954t9B1dW4L2R4PNSl5a9hqzJgF0cx1C6A2EKv
 HZagBZUy2qglHTEE80440JqppUxoNBv2eq+qZL2UXVyRVAmeqwNocJ66XQjupmjVW0IucT0vX1
 hppvJTmH8j4NnigmW1AL3rQbf+KONsXyE6blesErdGe1/DA7aUMtBMS0fGKdlWX4Ak63Qp6MBA
 AA=
X-Change-ID: 20260713-w83627hf_wdt-improvements-ba2364157d6e
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785091497; l=3003;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=r7gtfrH+drHflPdIPOvOJD3Ta8plsvCzMZ8MTXDKnzw=;
 b=KdLLiaFU9CowN51hxxdmFmTstf0ahzuqhq56rAVzgU5soaJygIVvuvKLQlyfuUZ8Z/b2bl/G3
 IhIDLMqs9NPBAH4W5Tp2PRn+gaAMZHzoBd796vpJ874X7PptzINjpgb
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This series aims to improve driver readability and convert it to the
Linux driver model by means of a platform driver.
Furthermore, support for minute-based counting has been added to allow
timeout values longer than 255 seconds. When setting a timeout value
that is not a multiple of 60 seconds, the value is rounded up to the
nearest multiple.

Notes:

  - PATCH #1: I could not introduce a macro for each hard-coded value in
    this driver, since some datasheets are not available (to my
    knowledge) on the internet.

  - PATCH #7: I have moved the code that refreshes or stops the watchdog
    timer out of the w83627hf_init() function and into the wdt_probe()
    function. Keeping it there would have led to code duplication.

    Since the timer has a granularity of at most one second, this does
    not introduce an unexpected reboot: the timer cannot expire in
    between, as at most a few milliseconds would have elapsed (the
    margin is < 1s anyway).

This series was tested on a x86-64 board featuring a Nuvoton NCT6126
Super I/O chip.

This series depends on:

  https://lore.kernel.org/all/20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com/

Thanks.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v2:
- Initialize res stack variable in PATCH #5.
- Reworded PATCH #1. Describe the introduction of BIT().
- Remove the usage in PATCH #8 of goto in error path.
- Dropped PATCH #9. Squashed with PATCH #2.
- Link to v1: https://patch.msgid.link/20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Paul Louvel (8):
      watchdog: w83627hf_wdt: Replace magic numbers with descriptive macros
      watchdog: w83627hf_wdt: Convert to platform driver model
      watchdog: w83627hf_wdt: Use private driver data structure
      watchdog: w83627hf_wdt: Move register offsets into driver data
      watchdog: w83627hf_wdt: Add Super I/O configuration port as a platform device resource
      watchdog: w83627hf_wdt: Store Super I/O unlocking sequence in platform data
      watchdog: w83627hf_wdt: Add minute mode counting
      watchdog: w83627hf_wdt: Report all initialization failures in probe

 drivers/watchdog/w83627hf_wdt.c | 452 +++++++++++++++++++++++++---------------
 1 file changed, 285 insertions(+), 167 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260713-w83627hf_wdt-improvements-ba2364157d6e
prerequisite-change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936:v4
prerequisite-patch-id: 1162062ebf31e7c2c70ff52b79118b67b00c396b
prerequisite-patch-id: 9638243b3ade2a4e9c3e94664343b235e5cb806d
prerequisite-patch-id: 73803f726f2fab91516b429f79a59c2d3a574cfe

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

