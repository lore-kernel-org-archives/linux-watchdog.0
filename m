Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC46A602
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089928; cv=none; b=VmahfcRuMTidaltuNVn/cB1Qk6d/UEHrnxeO4vdQbIzcVfnz1Z7EFJ336924wiOajt4TVbrRhoxbn0LVu4BRTF49OqLkE1oZ5XoBlPjnjiBuTz3spCPWqkq33UTc6daUd9dkFiKsk5v/tvzHucZ0tIsEcMLc5OVPXXEMm5NgemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089928; c=relaxed/simple;
	bh=EKWup7NpXjx/5zyxyVBu4gZipdA3grJL56SwbhmDByU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRKNkxApW7qX2uaHVCWXoRCJ3iQknJrmXTb2f7xEhjec5Ydj3PMJ60lqGpoBHIka0agpd47FsaTBemE0te3PUey070pjqSblqQba1DMpHG7rkCDkeSkQ+B740Rxf+zyMkTuD34RAJHiEIe4WTEZCB4RR/9WzT6v8ROWrhLIgqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Ld4hTq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Ld4hTq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d004f135b1so37332685ad.3
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786089925; x=1786694725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipEDUjo1dgWKcUN7yswid2Moa8mqqvBMqWr8VJV8G3s=;
        b=N4Ld4hTqY6GVeJGzVvKJ3CkCJVg0andlysvLhPpy5tuUXI88gbOKFmcLi443iyN1+u
         26yGiy21ycDtDrjviVq6bIRRcIDwzNXo6MyYt5NCMNJvCERIfyV8qpIfWpPS/kZ0geBP
         Fk50Ljh/voA++0DroRbAcnJ+wySrG3DNX+3pqntD6gm6Bc/KUrBiZgo9TTuVtKHergoT
         GZkO5AU40sm+Gojsxdu1VfS8u4+LQyYlX5TKMpHlri76kUYzC5btlM+ZXJ86Va0maRd4
         AGmgrATR7Yey+CfU5C84HuCE1ZxUWHikQDfXJlWbGgPsNbX65bxZU+PijEYDmE1Wsr7c
         8eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089925; x=1786694725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipEDUjo1dgWKcUN7yswid2Moa8mqqvBMqWr8VJV8G3s=;
        b=JLX2tp2sn6u8EDvz5Qv1lsVsle6W3ws/oLIZ8hPFkXYHkoEznmDvkqcgMEw/8dgHT8
         MTU10ctPUKYZOrC7jdg0nt5l0GwgajtMdry5ozVnP7k0I/tZQ/y9FWFKnF3jIxcxhjoQ
         6yp44jmr7KkHj2GfzJXae6m02ksOOA3nN/WG3Y2OUbgPlfMMhBaqfIUS9mFI5JK+Ylif
         T3ZgPQWl+qYxFKr5P6wsInWPl5edMRrNJ7qIucaOfTOU3j9DkPlAm9XNO8xd3x+tvLVV
         ArRnCrO+4EUzzuInOoZQPmlTTYhuv2oJKkpzCuZPMpD5HmiPVBCPu1RaCOAjVngqGrPJ
         k62g==
X-Forwarded-Encrypted: i=1; AHgh+RoO2iw8D0CbgMOg2fEm9nPJs+Uz1szuCXgUeUN86fcXdUIGIZLX+yuFzv67ZfMXkyk+R0i+JikSTnB+Q8Eqvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0OEX4qJRfACxSqOuaKoBmOf57EIcLcu5OezyM3Fk39613/eT
	xKYysdK8C9b2YAWkBqCL77gMuH6SmSZOF/Znqlp+KXJjZwxsfdYwEamN
X-Gm-Gg: AR+sD128+uO3nOHsaQ6YuT35EzaQlNiubekBqybgeYknBEJPA2yw9L/pNnKWRFENOTu
	mZwvKyg/6rjpoCX4mNAuH1+OMgQV5vK+6JCPxDVABjQRtl3P9IqgHWPjpywN84slNT666o32zEJ
	6rUrBzkxYqINm7WHeudcNWBzaU874G8VEMvF5xqZibNaE2ZeFgHsSCpsM8IA4fl3fZv84ZfjZ9i
	xiWby9Vrv2m4uO24AYwv7PYGr2aBAAuGP00CBi4FnVQ9jchBSn4qlP+uMBG3hIYG4GIPCcmwcB0
	l0RHbXHdI74Lov1cBYA1hHsDmCl6Y6dJFav8nEfER5HSVKpncT1uP9ZwQfugSRPFl9z44NHH28K
	z92xW35MVcPho+Zd5AL0DEO7aWaPCJPGhoofa0CR62/gAE4Z0MyPc/YhTwVnrHHeoZ6gQi5I27F
	r5cbfwPJ9sU71CJaI9y3swZqvCg6h25OZbXxyjaq6ZRWbOo3FucqQGOI6ALlxqmgDXd534F4HP9
	Rgmw9sRm4URpzYobLNGccLHsJC0vB5R97Hq9xFGSiqgoAh5MPGlOpDePLrSrzZztzbaBkJ6o+ui
	DS5w
X-Received: by 2002:a17:902:fdad:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2d0ca7fd072mr265470145ad.15.1786089924905;
        Fri, 07 Aug 2026 01:05:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a773esm5055305ad.65.2026.08.07.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:05:24 -0700 (PDT)
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
Subject: [PATCH v2 2/2] watchdog: stm32_iwdg: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:04:47 +0700
Message-ID: <20260807080447.35479-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807080447.35479-1-phucduc.bui@gmail.com>
References: <20260807080447.35479-1-phucduc.bui@gmail.com>
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
https://lore.kernel.org/all/20260806062812.26523-2-phucduc.bui@gmail.com/
Changes in v2:
 - Update the commit message and error handling.
 - Propagate all errors from platform_get_irq_optional() except -ENXIO,
   instead of only handling -EPROBE_DEFER.

 drivers/watchdog/stm32_iwdg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index b356a272ff9a..a8d2db2d3cf8 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -287,8 +287,11 @@ static int stm32_iwdg_irq_init(struct platform_device *pdev,
 		return 0;
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0) {
+		if (irq != -ENXIO)
+			return irq;
 		return 0;
+	}
 
 	if (of_property_read_bool(np, "wakeup-source")) {
 		ret = devm_device_init_wakeup(dev);
-- 
2.43.0

