Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C213BE643
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089921; cv=none; b=YOpjq1B0M8dcz7I1s55tYgGr8m88VPZJpQ7z7mruk0ThEkJacUJyUEx+65kK4dIF/6MWSg3Fuph3NudVJLwMhcXvEuBmMEaYsNQxha4yaphIVdqK1FCR1u8CMOacIyywOHq5YNKBYD6N3+QNBgootej8KCW5/aZFioD6+nsPNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089921; c=relaxed/simple;
	bh=VJEqFmIMaXu9sUCszrH0NerfQhdCPrwOn08E9fRD+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjYWuziKBqh9iW++Uy0sUPHRMKbq5GBbAL6dw4ES1WeqMxk2zt4ZG0btQOt0FV7OY9zL8zcCsWeDqRnVIKysilDtwdivqSnzH69wpBpBy64CFNLuXrITDEyLMilhU5pNBos6gzxhD6kObGH9krKwXfkCLrwwBdoqWClCaMOhcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afW5FP7/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afW5FP7/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caea3f742bso42513585ad.0
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786089918; x=1786694718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LC4v35vhZtMejQWnehiMNguB6SbMB/Zs6JddkjPBTUQ=;
        b=afW5FP7/4up9TTt8Wm4D6WtJq6LECJQhY6ACIoaihANPHsiX288KKusLhAIpXbB3Tl
         v0HHJ9T2OQV0qzBFX4Fzs5NVbVmpgXSQoIo1WWqpO6SMhYbvHqpLzZDrZRFkOrDr76/d
         jHkSDbjMY5HY+I5McDzXtkCKUZb9DYWuEnPyIHkF/WuSCKyFQQg1n5h1h7TyjAArqv6t
         vduTn8oT0Hl/Wy0viaMooQrr0k0kWjahJvk6ZRrYR4Og2A3+osCeskmAPqbPccWlezB1
         wij1e5qXZNGFoNRGi1mGKbkA0CTCoWVOM9/AcXNbTbxrKlxx/D3LMquzew0WxrgrV7nm
         U2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089918; x=1786694718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LC4v35vhZtMejQWnehiMNguB6SbMB/Zs6JddkjPBTUQ=;
        b=sfBlVMqJBggeDlbmm34oMlimXyawPll3d7kjc9VVbGlQIsniKX05gfyjBxbqSEZjJ9
         saqeeizTld2zANpnKfA/apLUSWB8ReOLLvKcl8jdDNehxe6jvSK88kz7IwaZPDB/maGH
         6PO2+5iyWZY5nVRtFlGW7U0EDCEhrM22em/dI9PiAnwA8NWDnxedYr9UQNc0eB6ey1jH
         ulMaWvEishU7HurHwvb3XOTGoQ9ml+nE++MSe3U26dp4RZ603Cgy0j26Ol5K1XETKw0X
         f3ocE44kvPjzmrdLqdjzSCqVrdgk14kllSy1GkKP4NoSy0pT1ZO5AVC2EJA8XuZF+k9U
         vc2w==
X-Forwarded-Encrypted: i=1; AHgh+RoM+EvGICtg62x2oD2jRJRq5dt8jNvOY95pt8vxI29iOWe3nPK4USu9rO4T7hkaxfEm4RfIgezS5zV3ovAtWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywci92AmySFT+sMIzhbsLMEN141ybrKDx8XIhcU/qE1xL6EkieZ
	oLol1+emo+cu7MW0mk4PBL6fNPx3hBA/dp9RwUSmlJr0rLdvplK06RaJ
X-Gm-Gg: AR+sD11oFRHvekxVEVvcK2dl3L52TlMS0WNdQU+2JQmCT6dKWsMHXZLYZ7v4+S5tEZF
	SO7wja3hyd+CR0SXta3VJgxLG2UnN/03xUeViCMI6lSKdL2RAWelg85rNZ05E+92+hzLlYHgVJo
	QLoFF1AYAyeA0C9glMSIrrOxbnrn2VKPRhMlx6qcnkfUV9ONLltCRI3JS2g7NxYwwnIxF++fnZ0
	xTEcQANOfyBDhnirF3nhfJOOmGxdgKA3KCfvApiWwYQorIgA22lrkqlvn9thhhaL08DgLgHiPWo
	z2qKqX8oUGS17QlcNlkkFnrkvhPgWlegTaw2e9JvgD95ahmOpPawxtesYhQyPGKJ1Hn+WvE2r3z
	6X+DWN0DhD/WSlu3088MFWRC/lQP2tCOpA6t3zLQLts3J9oEt7wUzPIxNLlQmGKKOKHK388Or+t
	Xk1RU0CnR6qoUZRUXr5Qav8OMrZhApmDrXkqpd3AiayYfdRsMHDFTZYuUmJA/E1vtPzZu/RdyI3
	xZtzwvp7PgVxoUzqvcFsCi8XBggitB9oHdci3PgPe16Sd3YH9FICtsVjaB26HOAW2SAeM2yb5Kd
	qO+2
X-Received: by 2002:a17:902:eccc:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d0ca71b437mr210831635ad.6.1786089918382;
        Fri, 07 Aug 2026 01:05:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a773esm5055305ad.65.2026.08.07.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:05:17 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 1/2] watchdog: orion_wdt: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:04:46 +0700
Message-ID: <20260807080447.35479-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
probe without the IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1:
https://lore.kernel.org/all/20260806062812.26523-1-phucduc.bui@gmail.com/
Changes in v2:
 - Update the commit message and error handling.
 - Propagate all errors from platform_get_irq_optional() except -ENXIO,
   instead of only handling -EPROBE_DEFER.

 drivers/watchdog/orion_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0e145f762f6f..f79a14c4e222 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -606,6 +606,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	/* Request the IRQ only after the watchdog is disabled */
 	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
 	if (irq > 0) {
 		/*
 		 * Not all supported platforms specify an interrupt for the
-- 
2.43.0

