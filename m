Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6A339714
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975411; cv=none; b=ZbiOYNJHXp8lXNeANzARWU8YDPynjRoW3jVEQ6vZhmJv5IVMTF15N1H7zrG2KQBtLMJyQhLK8vaS829wNV6pUgfGcbZWGqRKB5RihAqPHVFVoubyoZEngLLMBOR/7OUPWiIX7p2epm7xCTGKagT9y5QxtyfJ5phdvBELcf2vdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975411; c=relaxed/simple;
	bh=6YYTTdeuHpYfJYkPf0H6r0ScBN7lQOz4Zz4+SsQ2vVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TdsaraYgvGpiB8vDCAs4w+ZR814sg0LnuAfc44GiW7XeYMSxdV33ISyNuELlX5mbsEHkSH3efw9ymKPD3j8ramZQw5wCePAvB3eIOz7eHjBQXLqYPxxmeesvdJW1oEPadlh6fXTTPWuimZ2mnrvAQXK4VqKaTXfK2pJALbP3Q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jsHRtqhI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jsHRtqhI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E53BE1A121B
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A222560398;
	Sat, 25 Jul 2026 10:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44EAC11C1252A;
	Sat, 25 Jul 2026 12:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/PjSD5Gu1CfnUnM98zYPicZhZ2UYRRFO/rssbVaFtoU=;
	b=jsHRtqhImP9T7z7ojbiPC3KUpAdVQIn4r37CFvwR3EBbdb/QQxSw3elgbTcMdPU5KpaGCN
	AH/GWKMKM8ionc1LUNJm0Hm9xj3sV0tvEIxjdn5xswt1cnO5V48RjbngLOjfgi/4GvEy7b
	HmqeveAMdoxN53xobEwkx1TNpSwlCgQB9/NryvR8OJ7R/crRimxgmn30LkYT9gKH61UJU/
	cZJNAi54qAs/iWmxlPB5XcZNVI5zNjPfLNApI38E+k/g003r6rzMrFqtMMZ++n9dt8HNcu
	o+TP2Uu6CJFbzrH4LuUrJxouYv1bNdBGR9+0JSLYUn3fNKJMkQWQIX2zat0RmQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 0/9] watchdog: w83627hf_wdt: Convert driver to the driver
 model and add minute support
Date: Sat, 25 Jul 2026 12:29:27 +0200
Message-Id: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32QzU7EIBSFX6VhLQYo5acr38NMDNCLxVgYgeloJ
 n13mdaFblye5Nxzv3NuqEAOUNDY3VCGNZSQYhP0oUNuNvEVcJiaRowwQSTt8VX1gsnZv1ynisN
 yzmmFBWIt2BrWC04HOQlA7f6cwYfPPfv5dOhysW/g6j3wx5Hh49Ke1sOGrCmAXVqWUMeOMAVeO
 y1AC6plI1BKOuKJZpxxITXTyhhQ6Dfs2B2oZPiLGl0VlIkJa0OosF463Ytx5eiONodSU/7aV1j
 pTnKkMP5P4ZVigiW1wP2gwff+yaZU30N8bA3Qadu2b1wXrjNfAQAA
X-Change-ID: 20260713-w83627hf_wdt-improvements-ba2364157d6e
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=2973;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=6YYTTdeuHpYfJYkPf0H6r0ScBN7lQOz4Zz4+SsQ2vVA=;
 b=kfLvBA2k7vwymODIJkxWsjwdMh2cWJA1bej7cbXKEl+9cuk0hUz0+k46Bqcy3O+6RirBFQvfP
 Cd3iuEy5kR1AOpDKlO3BkgBESPdEuod4ajsH6HKYpWdsV0vNKTF8X5w
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
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260724-w83627hf_wdt-improvements-v1-0-71be4f59ef3f@bootlin.com

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Paul Louvel (9):
      watchdog: w83627hf_wdt: Replace magic numbers with descriptive macros
      watchdog: w83627hf_wdt: Convert to platform driver model
      watchdog: w83627hf_wdt: Use private driver data structure
      watchdog: w83627hf_wdt: Move register offsets into driver data
      watchdog: w83627hf_wdt: Add Super I/O configuration port as a platform device resource
      watchdog: w83627hf_wdt: Store Super I/O unlocking sequence in platform data
      watchdog: w83627hf_wdt: Add minute mode counting
      watchdog: w83627hf_wdt: Report all initialization failures in probe
      watchdog: w83627hf_wdt: Use dev_* logging instead of pr_*

 drivers/watchdog/w83627hf_wdt.c | 457 +++++++++++++++++++++++++---------------
 1 file changed, 290 insertions(+), 167 deletions(-)
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

