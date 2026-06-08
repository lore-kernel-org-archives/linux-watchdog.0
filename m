Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49B3E51DB
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949393; cv=none; b=EFTw9LMYMivA8+EWH315JWQ0JurtSlqaJldWyi5BOryMYSZ3XJUjedwnev11LhYK83ssafe3HXoe8zI69MckiE9nE2xIuFpctZIR7uVxa4Dr9FRO8/IHcEQstzu2iNASE0Mxb1qdUwY31VHqaf8r8Re1mDrecFFgPGOfLJSRvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949393; c=relaxed/simple;
	bh=Vfxy0xR4+o7qW+hcGItiYMUsgjgNxpRK4qYdYOUTlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArYDhI7DGBCJGisXpnwtToYHqYyoI/RXReksnrukUO29lo5Lm4ZWAyFJLZLxZzxcUcezsI746r5b/AhRpvHR/p8uoK/qpg0wYYhsio05VZDfO/Md8epeHjtDR4l84CKIR3zSBZfaZwev1lgw7nqpnl3YHftR0U6WdHLZjjnvB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD6ibNVT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD6ibNVT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e1916922b9so53132637b3.1
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949391; x=1781554191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i69UPaPeukOXG1EGWuJPIr1RJ331Tq2Fgh3Di6Gql8A=;
        b=bD6ibNVTs3e2J2/mTMqTDerwiezeZKJPNnB/n2SlmMF95rgAl1fpBYCAymWJaolzCa
         HQS4pk745nK84E0DlX4mweLQWgJujee5/mQnJlwuaVdoMmnVhjWrEuCuTKW7olvvRGTc
         YdoEeYZy+bRNCLwizWzZ6OzvvqKMpwFhGd9mvQ5fZ9DunGijgFO1xHN5Gj5z+YVBlGKa
         63YItm+e24Anv78oZRZMbkWRePDVPVdYOs10H6KXxVUuLWzzObuZH7gSajitol43sysV
         n7HBeQejDLPCfgf+xHbHMy2xhQx/tam5z/wTyj3C4eB6AQRhpUefSFBJgtXhmmORPTJZ
         237w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949391; x=1781554191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i69UPaPeukOXG1EGWuJPIr1RJ331Tq2Fgh3Di6Gql8A=;
        b=mpKIQPqVWzQ9FDIVOR9x8VoDqYxQocIRQZKA1orF3p+fiAFRerQaND9TAEDLFFRxIv
         N6inaSiVGA6bbHC38zKoL9xFz2R27ATHhqDN0FnyhY7tOAsMnGuXfGWQyLdMV/RsUwLo
         3sXmCqmuYyWGxPpw7b7wrcwvdeRwdS16NxaahNIP4rR781mtmjuST0uRBIGPGQJUdn9o
         e59Da8z1rgS9d/vC87Lvuw3vl3v1/ctzg6jaKESxNBgYO8sZcoP8D0GKoCpf2SuHLGtn
         JcMG3mCpzHzr2fRPZOkfG4OT1jUQfxvr/O1rXO5v8jiivyRblIoSaNY3LuVsga9whf7m
         4BKg==
X-Gm-Message-State: AOJu0Ywj6HsSDG2rgG3dOBeKqprXi28ctWFej8IUUd9cnj2lBN4J60kQ
	8fHG9EU2YYE2L8gpF7Q2fjb4kkQ8a2zTlMGX3k+8fTxL1CLXZXtYh4/viQMgIs4F
X-Gm-Gg: Acq92OHnP4NvNrpmLkLSXTQOixlj508dIFFKrSJ2G7gi1b21GsqgZpRn0qizsBvd/iL
	5asiM8aG2v0TY+Q4dfjLMeNBNGvFgLh9/IQORM0V0uPR9QlTLoVJOv1Stl6PYCWRzDconHQeL3c
	zYHtKR03Kr6WiNnhp8pVePonXZMKWn8ehaKomx9Ru/NBVHy4gbr3ZTvKwb8Q098xZdY0n2CyH/V
	mFxigSwYn04ajSPDnTPIFbgd5dCO2XYt+0dx6LGdwfz9sdwZR6O3QPEWREN+KIKTWgmHv6Xxjny
	tryrtk61SbqUWeLBm6wFYwUz1dd6+Dtnpsumv1kBwYqZ/5rHUIY1ArVvkE9GcuOP2dkwr7lvMe7
	vTimTDznYUEEgo286NEcluRyZmVB/t6Rr/gD/gWKUX2PXnL4NFbl5n0xJTDg6G7dteSL2gxMxyM
	RIIZvnolQfl8qsQZOXdSKKMH0MbX5hu8+/f3QcEefTjdcbhfG3V7TeUq90xZnubP04uAxynmIBW
	dxkCvvLdnpHeNzsaVg0ZSlu2dN84ZXM5XHxpwK8hK4CTg==
X-Received: by 2002:a05:690c:e003:20b0:7ef:c894:2101 with SMTP id 00721157ae682-7efc89429admr69439157b3.37.1780949390968;
        Mon, 08 Jun 2026 13:09:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea986bsm88688987b3.9.2026.06.08.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:09:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/3] watchdog: sama5d4: fix IRQ and timeout bugs, use platform_get_irq_optional
Date: Mon,  8 Jun 2026 13:09:30 -0700
Message-ID: <20260608200933.18669-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three issues in the sama5d4 watchdog driver:

Patch 1: Return IRQ_NONE when the status register indicates no watchdog
interrupt is pending, and pass the configured timeout (not the hardcoded
default) to sama5d4_wdt_init().

Patch 2: Replace irq_of_parse_and_map() with platform_get_irq_optional()
for simpler error handling and EPROBE_DEFER support.

Patch 3: Move platform_set_drvdata() before devm_request_irq() to prevent
a NULL pointer dereference in the interrupt handler if the shared System
IRQ fires immediately after registration.

v2: address sashiko review

Rosen Penev (3):
  watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
  watchdog: sama5d4: use platform_get_irq_optional()
  watchdog: sama5d4: fix NULL deref in irq handler

 drivers/watchdog/sama5d4_wdt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--
2.54.0

