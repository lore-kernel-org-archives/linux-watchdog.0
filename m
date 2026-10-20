Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483954;
	b=BgREMeKoGHeUrh1TStT8x5Kys4iqsWYYB8EsPPPVNjfUzsTPcO17WusOlZopPsLKPWQj
	 Pv4c+j8o2fmklDpkn6Ssj0shbLMnjISuwLDQxdyCIIOncpgJPJs+LER/Wr2YqYENmjkwy
	 5rCfVOtjru9Z4+1L8S/O3M4e3RxnLT0HlxvGIrNCKqJTgBOJZt+xL9cEr3KRlzl7/f1Sc
	 uf6zL+GMveDWGsaCqE/jPV1wQ+Ozd58X6HuwWK391pS1wpKuw5gkf2ZVt/o17+oC42Oy6
	 4gSvIXQErwXngP5AWTNPzmF6dZTT+oCwDBEs6LJvX74XyvwyBaKmdrqY48sA02Utghw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483954;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version;
	bh=r7HRZlH37o7nCRHXljE1zEBpTnyUA3Gr3O3ohUPMznE=;
	b=jfW/7C+xVRUhlsf8FR0lCz6H4OOqmTF8ng5ZC8J1RIhkAi2/fVNWQo6pBR/fCNnZx+Et
	 hT5PyBRAFf/radcFKzan+3oYhj6QgceuK5OMUMxUNhwXZ7K0yN4lsfue8q4XzYVsZ6jVf
	 b79y5Urz8a+53KvPB3ZCveAiLxao4DxFVn1EdOPLJylouitvQqz2vaVusl16RVr1MUXvE
	 EhNP2T2vND9A32XDQIf7cYvLserUr4A1DP9B0zhGT+g85uUgM95ImQVOEBE0fCSMDeXDE
	 5ag9xCCcYJ0lglrEFAVJGucRhtl+LaUYc71+v/YrTgMGQSEByc+zyaUHh3aymVEhzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="vs/9+e1B";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78036606A31B;
	Tue, 20 Oct 2026 08:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78036606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vs/9+e1B
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18115C63454;
	Tue, 20 Oct 2026 08:13:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FF1A60393;
	Tue, 20 Oct 2026 08:12:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14B6310328A45;
	Tue, 20 Oct 2026 10:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483949; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=r7HRZlH37o7nCRHXljE1zEBpTnyUA3Gr3O3ohUPMznE=;
	b=vs/9+e1BfZTOndS/QVfNnFuTzrg6/QrxsTG8aSmT5mVrI2PDWebDKkKZ/26D4HYtwl6j0M
	/KWe5yYdzf3yLMOC99nXjMuCu46K43Ji0sB8Tq4U19DPbXladm2ahdVxZnj8efsIc79kLv
	MB8ydYAsx8xqrFnCy6xo0/47oO7qbQLpS0MDSU+eWW6jtC+VcxTItXawKlNGNZ9+5fWtQi
	c6U9P36XB4H+5s93f6rrKopRWWBDDcGrcCdtfIfbdL1dEkwCiqLI30h4uZgpa4q/vnCg5o
	2Z+cU+H3RoekZ/LntZieZFOFBWsumTnxa3Gl81kbN0LKz0/md1LnHKTZEIau9w==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v5 0/5] watchdog: w83627hf_wdt: Convert driver to the
 driver model and add minute support
Date: Tue, 20 Oct 2026 10:11:53 +0200
Message-Id: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XS0U6DMBSA4VchvbamPbSnLVe+hzGmhVNXIzCBM
 c2yd7eMxWwxwcuTlI//FE5spCHRyKrixAaa05j6Lg/6oWD1zndvxFOTZwYCUBhZ8qMtEcwuvh6
 biad2P/QztdRNIw8eSlRSmwaJ5ef3A8X0dbGfX9Z5PIR3qqcFvJ4Y6POQXzqtx1jwI/G6b9s0V
 YUAS9HVDsmhdCYXWGtqEYUDBQqNA2e9J8tuY6tiTRX6PrWrJ5SADXdeSAzR1K7EalZsSdulceq
 H78stzPJSsiqgNhaeJRfcyEAqakexjE+h76eP1D3mDZaoq6H/MxQ5L4MiC87cGUvbDLc9uGVBt
 vIn0B481gLgr1X+WlKIzd3KbFkCE7S02mn6a6kba/PHmFW2AkYMKLzTiPfW+Xz+AQG7QlqHAgA
 A
X-Change-ID: 20260713-w83627hf_wdt-improvements-ba2364157d6e
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=4076;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=Jnx23+nchqm1+vy8INVy9+H0oPhn9RfvuuSRZ4WzbBY=;
 b=562HEMYYP+2R5eKe3uXM5lwRV/OTFjuMBe29P8iVKIa8yp8Yo9FQ1F1KFKr2bfqhKqX2L0OD3
 PlnP63wAXFWCmKNvxPLiSTbeJdBUpdlivWUf8Lztbim9S2OxQqR+Dbx
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

  - PATCH #6: I have moved the code that refreshes or stops the watchdog
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
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v5:
- Dropped patch #1 as it does not fix anything.
- Fixed nits and style problems reported by Tzung-Bi.
- Link to v4: https://patch.msgid.link/20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com

Changes in v4:
- Squashed last commit into patch #2.
- Applied suggestions of Tzung-Bi.
- Added one commit in the beginning of the series, fixing an issue
  reported by the kernel test robot that is present in an older commit.
- Link to v3: https://patch.msgid.link/20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com

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
Paul Louvel (5):
      watchdog: w83627hf_wdt: Replace magic numbers with descriptive macros
      watchdog: w83627hf_wdt: Convert to platform driver model
      watchdog: w83627hf_wdt: Move register offsets into driver data
      watchdog: w83627hf_wdt: Store Super I/O configurations in platform data
      watchdog: w83627hf_wdt: Add minute mode counting

 drivers/watchdog/w83627hf_wdt.c | 468 +++++++++++++++++++++++++---------------
 1 file changed, 299 insertions(+), 169 deletions(-)
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

