Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844075;
	b=TAJlhFikwe17n9KH+GStMW15Lzt5n9qRmaWY7qdDXJjYWHK3HFf7zqiFgjIGgHWv/Xp1
	 fvCZgzjumfOUerQldX4/BMWsjEMVaF/dQ3Kv3Z/bP4Hirevw1GZbr2tVWMNi1zKpfbOTk
	 rpD15o3kTde6mjoxiuGyrlPLcdJPtDwuhxs+oeFmlnQUp+6yHZoLuA1V4L2578al9Imja
	 gOUbFzyTZ/IarHgpd3PWaFYZe851AGJd0zK+jf3DVZ3gWbaAIF/orD4C14n2Lg6sJ6tOD
	 v5RwK8h8z5mFqGbQpnWDxUUn/S+BsX+C4L69b+QPzKPEKbSNZPGdwexoMvwrCDo2h1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=clDe5T+lnMcAu2QCaqAIBM25j1mGGUWhHQ0Gl7zGb7U=;
	b=PZLL+SbCyp9HUBccpqiBlYNJnjokh6BK2TDc3EDQ27rPKlz1ynkftViCmDv36iOF5ZM3
	 af5+gTE78UD9lOVaLqFEkM9MQW4EIheZqi5TPbGYiYzuqP6/BCSun6Y1SeEwjF/7zDWY8
	 IqbjxlzUWOMGTmnkaMbWc3nZg0totku2XphDZgsA5aiPkCiPFnVUCk7QQi6DFdnqcgVU4
	 8XApZkK67371y+/GotB1gv94BnS46S4CxVoEiRkg+c3F6sv/wyeOGS0Q/2DmKTfwj/BFT
	 2tm8yphxWexx/5ArL0OkBhqFXNzozl6T2itL/UH01regfO1oFOJQmYrPgTiEjinwT6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VHbg+laW;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418B606A31B
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 12:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6418B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VHbg+laW
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e011d370dso1307521f8f.0
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844073; x=1793448873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clDe5T+lnMcAu2QCaqAIBM25j1mGGUWhHQ0Gl7zGb7U=;
        b=VHbg+laWae7qdWoRf9x+wBMuztkCQdnqfHfp9mIJJakuDJT0KiB47aAXP9L60qQ2D0
         /B6V+lzJTNRZeVjuvIX8wEFuNqICUVNkujBINShcuRBIC8fRfYc+PXLlXBdmqZNi8bJ8
         ed0384CPR43IAMXCjdmAUZqrEDyA8mnPjE+n4SIZ1iufwBuTEAoSksHD0g1U+VGZWXF7
         SEgQE8v+1z1085t4eka2p7bD1myIBzVlMhuAiHPwUtNYghIiCY8+dmrUmE2+ZugB1a0c
         yAIRZ0fZfuO/jYOoOG+t7GFwecNBaIzBH1PsORaHHZqokjp36tF91UJVF+BAr3HWHj5z
         i3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844073; x=1793448873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=clDe5T+lnMcAu2QCaqAIBM25j1mGGUWhHQ0Gl7zGb7U=;
        b=wpylTZV4qHdiqDK63kT0szZDitUY5rkGCzT/jFOIv8XYFWEafypZoHjEPwj8mKUgBJ
         Ti8LPJIy/wB506VoePGDee18SnBsvkWF0uved9eJOjvDIk3XmHVFS1yOWhoq1TNOpeCo
         P2gCVGmF6MdOwAUzIiY8z4/eYhzjVVfFEFwJezg4LUUY3Cj2vrtRJMpxbrRJvIRoihTg
         c/PSfjJrka0MPXKvBSzbTJK6zhw3TrYF4U2cO8rE6KlPb2g9gVVoiigGVCwpZtC0N24W
         Gx+QsoppymqR80fDPRfhqKpqM9yCaCdhYBi1wewmqJRPVsDYihaxhL2wnc0Oc8+YH3cV
         gZrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOX/bIt5Curjps4nyoDzGivNbTmvu96rMm96wCnMGKWG+mxocksIEwAVNvxqsUiHd19C1GWPe9sxF+MQUg+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4KJPfDaUAyYTQzyp52nkeXho0cWj/PPxz/FS7dqsLf0Jr6gM+
	77Fr2ZVg9AuBF96+mCD9Etd2c/jd+HYcTYUoiE5MSuUz3W47jaoaHl9m
X-Gm-Gg: AYBFou34X0WTa4/nuK7VIlH5V7VT9oC5yGM6y/FqF2N0v1/a4vrOMSe5OPL9iUoeyWJ
	rBt4pkEZljfcTbBcT2tHtDcewD8GDI9l2h2JGw344PQ5XfmikthTJ9fHnrUIxuXN8R8Q8frdWOH
	jqjV1gZ4zOoWL8ZRVurPsS9tQVO6MbCtCRzayEM0+WxH5L8dgTiUIQ0/KRKC2sl/h6Vi3gwb2dk
	6H6Gwm3toliZW4GHlc92bAs7e1QZ4uQXmzVwOafweAs5zPleWjX9RrKiRlcwsMlHGEhMx02y93I
	VJXAhktJUI5Q3HO6OzW46RyXNluiEE5WKnZBAIpvLxRRpIsfEjiyh+xQdVUq9j8xZT6gNA77aYP
	Vtzs3ljoKH7Mv0CY6No7UQdPr32ZM3J3bxIBezLwZBzVnqF8In9eBWmGxJFl3SFg5VCkTx/hNTm
	hXv5Mupn6wtPtt3nXHVJw9K7raIlDRafhKI/hCXB6YcaD1tyQ366v7q11aInXV1d4Zs4dPo6VpT
	0kv0zcfDrEEokOxNkSS9487d7vFTJEW6lSDLXdQHEMVc9LMzInisUOx
X-Received: by 2002:a05:6000:2411:b0:48d:fbf2:555f with SMTP id ffacd0b85a97d-48e3eb8d497mr2806535f8f.55.1792844072587;
        Sat, 24 Oct 2026 05:14:32 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm3860411f8f.59.2026.10.24.05.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:14:32 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: tzungbi@kernel.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] watchdog: dw_wdt: fix reset line management
Date: Sat, 24 Oct 2026 15:14:22 +0300
Message-ID: <20261024121428.18862-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v3 of the series fixing reset line management in the dw_wdt
driver.

Testing:

$ ls /dev/watchdog*
/dev/watchdog   /dev/watchdog1  /dev/watchdog3
/dev/watchdog0  /dev/watchdog2

$ ls /sys/class/watchdog/
watchdog0  watchdog1  watchdog2  watchdog3

$ chmod +x watchdog-test
$ ./watchdog-test -f /dev/watchdog0 -i -s
watchdog_info:
 identity:              Synopsys DesignWare Watchdog
 firmware_version:      0
Support/Status: Set timeout (in seconds)
Support/Status: Supports magic close char
Support/Status: Pretimeout (in seconds), get/set
Support/Status: Keep alive ping reply
Support/Status: Keep alive ping reply

$ echo mem > /sys/power/state
...
...
[ 1560.147058] PM: suspend exit
[ 1560.371470] usb 1-1: new high-speed USB device number 3 using xhci-hcd
[ 1561.031825] cdc_ncm 1-1:2.0: MAC-Address: a4:2a:95:e8:fc:e4
[ 1561.037736] cdc_ncm 1-1:2.0: setting rx_max = 16384
[ 1561.054408] cdc_ncm 1-1:2.0: setting tx_max = 16384
[ 1561.084713] cdc_ncm 1-1:2.0 eth0: register 'cdc_ncm' at usb-xhci-hcd.2.auto-1, CDC NCM (NO ZLP), a4:2a:95:e8:fc:e4

$ ./watchdog-test -f /dev/watchdog0 -i -s
watchdog_info:
 identity:              Synopsys DesignWare Watchdog
 firmware_version:      0
Support/Status: Set timeout (in seconds)
Support/Status: Supports magic close char
Support/Status: Pretimeout (in seconds), get/set
Support/Status: Keep alive ping reply
Support/Status: Keep alive ping reply

$ ls /dev/watchdog*
/dev/watchdog   /dev/watchdog1  /dev/watchdog3
/dev/watchdog0  /dev/watchdog2

$ echo 1 > /dev/watchdog0
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x09a7baab
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x0599dce0
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x01926467
$ [  110.392536] watchdog0: pretimeout event

Thank you.

--
Best regards,
Artem

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20260320135624.223863-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * Reduced from 5 patches to 3: manual reset handling is replaced by
      the devm _deasserted variant from the start, so the intermediate
      states that could leak the deasserted reset line are gone and every
      commit is self-contained.
    * https://lore.kernel.org/all/20261022134354.534642-1-a.shimko.dev@gmail.com/T/#t
  v3:
    * Squashed the last two commits.
    * Add error check for reset_control_assert() in dw_wdt_suspend()

Artem Shimko (2):
  watchdog: dw_wdt: use
    devm_reset_control_get_optional_shared_deasserted
  watchdog: dw_wdt: manage reset line during system suspend/resume

 drivers/watchdog/dw_wdt.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.43.0

