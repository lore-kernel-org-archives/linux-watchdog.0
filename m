Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C3347536;
	Sun,  4 Oct 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116000; cv=none; b=VOR0wc62bIs3BEJk3WWdScMCqjsspz1hkqM8jzJSRQbBjDleif1DatilyGJSQTtOREnJzapaOeWNdxK2YNcyiCfWV66cQpmucX2EqICN2XxbMVnoyw8hOx0RIR2zia5jYtQBJYb/PaXNKqVgUtbLPcvtszVr/+hR3T8B7pdlgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116000; c=relaxed/simple;
	bh=unRFb8pvoPnB5AFoly37nlAWXq57NwFnnuxRp9uK2ys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=urKLF0HzW7v78riRDq2SJNlh51otJRQZ700NRGJfAXyHUK7nPFJtAl2jFELPLtRny+Sym1d7z3cSDwvIuYusYQllvCsgg+9rxXMDH4xHcXZOhj+HSTzr1ZOGRvd5O3sHgq4BHQjdm5Lpbd7W8jVSSntEp62jsI01Al7mkIFG+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KIqFjXfe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KIqFjXfe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7AD764E41155;
	Sun,  4 Oct 2026 12:13:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D01A604FE;
	Sun,  4 Oct 2026 12:13:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B8D910328192;
	Sun,  4 Oct 2026 14:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115994; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zWeURrWVM4W1aguDZ0kFwmW+PEiMrUye4Mm3gtU49KU=;
	b=KIqFjXfeCwnN6rzir3cvYZh7kNpAvsRDI+MJfitZNGT+OsF4PbftD0TanG7dH4uqzymQLN
	CU34LMkWy8FrcqntmApXVaNfmxsRtc0FqYJihCm8mzswB3ruTFqzEtr5TnEQ05nZWyqY0/
	wOgdxzE2xMTbG/XUa8gbziyiZXIT5OGLiLN3ZMsnMb0vdWYKf4I5N9ZRFNLIAtLzHkd775
	RKl++8TjBjrKqyb7SXJBaD5/I9wrrbTQcDLFLR7Cf5xu3gP1MEkjPW31EIEYJtS/noXN4p
	zJM13T900P3rOjPv+Z+axBJBdNYjgGugpZz1ZuXsympTqhRPEvo6fbJ8ryu2yw==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v3 0/6] watchdog: w83627hf_wdt: Convert driver to the
 driver model and add minute support
Date: Sun, 04 Oct 2026 14:12:48 +0200
Message-Id: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WRz07DMAyHX6XKmaDETfOnJ94DIZSkDgui7WiyD
 jT13UnbHbbLOP4k+/Nn+0ISThETaasLmXCOKY5DCfVTRfzBDh9IY1cyAQaSKV7Ts64lqEN4P3e
 Zxv44jTP2OOREnYVaCt6oTiIp/ccJQ/zZ2K9ve04n94k+r8BrxYTfpzI072XE2YTUj30fc1sx0
 BiMNxKN5EYVA62VZ4EZECCkMmC0tajJrWxb7aqsuVcdfJYcZEeNZVy6oLypZTsLsqodYsrj9Lt
 dYeabyU4B8WDhmVNGFXcoQmMw1OHFjWP+isNz2WCVujKa/xgCjeVOoAaj7hir2wy3PvIRCwqrv
 KCxYKVnAPesZVn+APfkK6zvAQAA
X-Change-ID: 20260713-w83627hf_wdt-improvements-ba2364157d6e
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=3545;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=unRFb8pvoPnB5AFoly37nlAWXq57NwFnnuxRp9uK2ys=;
 b=vg7fdcT75gal7pZfXE7BpqMhdfClFsC0gTRuoMjuv0/1JQ7pu0PqTYAE6+/QsE65qvH0hHdak
 MH7KOzLpsKxB263H+bi0kogLTc9D+u2hJGjgHDaNKZxldBbbfyyKlNJ
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

Best regards,

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v3:

- Drop the platform device resource for the Super I/O configuration port:
  claiming the shared 0x2e/0x4e port could break concurrent
  request_muxed_region() users on module unload (Sashiko). The port
  address is now passed via platform data together with the
  configuration keys.
- Patches 5 and 6 are merged into "Store Super I/O configurations in platform data".
- Validate platform_get_device_id() and platform_data in probe before
  use.
- struct watchdog_device parent member is now assigned to pdev device
  instance.
- Re-parent this series on 7.3-rc5.
- Remove the dependency in the cover letter since it was merged.

- Link to v2: https://patch.msgid.link/20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com

Changes in v2:
- Initialize res stack variable in PATCH #5.
- Reworded PATCH #1. Describe the introduction of BIT().
- Remove the usage in PATCH #8 of goto in error path.
- Dropped PATCH #9. Squashed with PATCH #2.
- Link to v1: https://patch.msgid.link/20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com

---
Paul Louvel (6):
      watchdog: w83627hf_wdt: Replace magic numbers with descriptive macros
      watchdog: w83627hf_wdt: Convert to platform driver model
      watchdog: w83627hf_wdt: Move register offsets into driver data
      watchdog: w83627hf_wdt: Store Super I/O configurations in platform data
      watchdog: w83627hf_wdt: Add minute mode counting
      watchdog: w83627hf_wdt: Report all initialization failures in probe

 drivers/watchdog/w83627hf_wdt.c | 443 +++++++++++++++++++++++++---------------
 1 file changed, 282 insertions(+), 161 deletions(-)
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

