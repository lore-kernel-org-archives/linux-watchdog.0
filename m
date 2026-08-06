Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF72F5A36
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997708; cv=none; b=GSjPpz1F3dv1SX82xepISq3pBKpgPccSAuLyjWpovCzgbH9vVJ+FQvaJhTdGNWmD4WfwT2iuNN3wXFoHGMWCAYUxiGp2qwiwjA+ARDIp4dmGg2snkiwTkiaHoGjoVHg72iO4JeoJhE8Usls4AH4Gxic95d6OVAU98uwj/QybJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997708; c=relaxed/simple;
	bh=6wldOQr0R0BwvBtCpWrrip6dF4nyd46yV2ZnmtPG5Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1a1MsSoDDEcXBTqhf/A5tCizuPCmC5rw7gtt3V5KGIX5iAWmwOGIxPFKU2jflDO46ffFESVezziyCLdEIv/RCPt9zbYq8jAC5iqi/GYExP3UhntkLV44VpnULdixu0KdvywsNvHyC7yly4D3LjXdrUQwr27nMhjvCExNDWJZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl+wU1y4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl+wU1y4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so7612985ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Aug 2026 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997705; x=1786602505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o41DLRxqGljyej3mlCmChy2gz82D/J8TfyAhLd7goqM=;
        b=jl+wU1y4t+zz+vhJ5f0tUAYseEtRLFCtvFyJf3Rl2cwNoD8bw/ZevnUwTzAy17hSC5
         wPC/tiiJyVKSQU6cMYlbhuHBdQaRv2prOo776v8zIXNqLqnrAL72j4xigRYyaXAIzuvK
         pdiwGNQ5esnBZEPzEa3Ob47KMx8R9IO0MtpMoStLT9BnjduVFtesi64jesFKgr2YWCN4
         Wyyl1nQ2+YSLEBN9WVGSEbnSdX2S4+oC3vzXp87nyiS74tzfCBPlGbu5abGqkCWt6McU
         aMzx7t3XuEudfsD9Y60KpH+2oLdmbgHGvdDXhDwJ0gblbKQS8B4430UwbnalODFiJd8v
         +ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997705; x=1786602505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o41DLRxqGljyej3mlCmChy2gz82D/J8TfyAhLd7goqM=;
        b=S5f4s98nBKJ4h7x2diG+Xmgn6s/gv0ICJvfZDgc9l3vk9gCJ8ytE/i1v/0Ign6s+HZ
         Ex3gsVh1g5FTU6NPT5ojwD3HWyfeH3ZDMRTrcaoZ3wBm39wbsFciBKsodOnFK7D7xRfS
         M1qaVdrXss7A8+5NcypJ6T/n/gduxE6P3YMSCbSF85TGCwnCLNqZB+Wd8J6EBnGJnk4a
         u6IzhZ/8YTWciIM52UZKELsNF8mzkp4S2swGfWztsVjhH6lEZWz1Kn6vJsrkKAVxDb1r
         ibHG4ilhWM2oBKaJvqlM9x9G+pnypo444/BH4V9Cr3Gu34mTrlCBT9M367o/WjAB02EH
         JhTw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx67PRzw1mzgrfjzlMIY9Pl4V/jtWJ9XNgiHu08nuOuQHQoCmTgcB8Fbw/WG+bNOwISZwY4zhjJ0BMpRCbPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEoKyb9emwJl9sL24XdvWGnS5kFWKJ+WSqzyF6azdGFrFOKO4
	kuTe4T2yOq4hy7arT0Iey3RIw3qG0GnWyTZzGnsTC6NSqznMS05Xa++8Tf881g==
X-Gm-Gg: AR+sD11LFHi2E91rWniz7KHJNsq4kEYakqCqLHgYBMTtoweII3kJ8Rbvj6wB9/Mk6/4
	84Zzw1182Xe9KlQyo6t9YX83O1xNDBUUUZADxphF1Vn/AlKMskNnomtsmrXsUXBsD1PgRuL6fui
	jasUbyoa9PcbTutayID0ose1AVzVHiXOV6d8Vhfuk/Irkg3jCI5aveve3vCD3n0RLEvVP2rlkUc
	EqoBpmHI+7i6KzFKuxWdhCKs1uVJcBVLtFIuGWVvXV6q64xinn4813l1ulRugMWGnCD24oQCONG
	trwYIVUJi8OLptF74DLj0m2wEPQWAsGIU0ZH10XjdeUULqYwRy2bR9qKeUyEsDlo+RjNV9x6dWc
	4PIMKuoCVRmG6/W0hVoiYkfLg9dBFH50dXOkq+zDrX+LdsE3iGjoYKUaGxqzCUdspUVUPbTI2Vk
	BdNnUidijmHiRUdeTvCwlab7O1jIvzj/k7t91eZI7jBLx4ZUorf9oMNQt/G6DxYxcvrMUk6oDZr
	4qNN+N3XPpLQCS/H6/btGYL9dw7ggErdRajhAUZ1jM0jrv1dQn+XPFPQu2KxswD5YmTnH98JNIj
	vMlH
X-Received: by 2002:a17:903:32ce:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2d0f1ab9328mr40995015ad.8.1785997705293;
        Wed, 05 Aug 2026 23:28:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4bda53sm25370095ad.63.2026.08.05.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:28:24 -0700 (PDT)
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
Subject: [PATCH 1/2] watchdog: orion_wdt: Propagate -EPROBE_DEFER from IRQ lookup
Date: Thu,  6 Aug 2026 13:28:11 +0700
Message-ID: <20260806062812.26523-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Return -EPROBE_DEFER from platform_get_irq_optional() so the driver is
re-probed when the interrupt resource becomes available instead of
continuing probe without an IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/orion_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0e145f762f6f..8595073a8179 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -606,6 +606,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	/* Request the IRQ only after the watchdog is disabled */
 	irq = platform_get_irq_optional(pdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
 	if (irq > 0) {
 		/*
 		 * Not all supported platforms specify an interrupt for the
-- 
2.43.0

