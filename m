Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53E380FDB
	for <linux-watchdog@vger.kernel.org>; Sun,  5 Jul 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260069; cv=none; b=l/y++f2kERumtjS4WT6kN6ipA4nC1OWUlq51EcsL1ez06MmypNMMtibHu3Elwxf33kjUDCGT009kApb8yjCuRAK9YMeGidLnM4JyDIIv5izDtgYwsOO3rgpHg6HOhh1XabeSg5L1g0QqhGWjyHLMJYsaTS1K4b3r6mbuxqCNjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260069; c=relaxed/simple;
	bh=y91yCTn5OqFNj2gv1AniQU1l6RNsFXdk6j7Az5+Zq40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/5na4BJt7dUHdP7AP57oCbOKzQx8xbLeoF0wUvhMB4Nobv6ztzq/9LgLffF99VekeyA5G2iNqxUGpRHDzI2FE8i07AmsH2wvCo0zHPdRSjoNfud6haISjYrNEt5rvy2JfAceC1No1K/FcxkOM4Sv/gSNKBvMnKq1123GUIZP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYXqgQgH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYXqgQgH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso12771035e9.2
        for <linux-watchdog@vger.kernel.org>; Sun, 05 Jul 2026 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260067; x=1783864867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xmqz/oZ7aMrIDGMWhF1UArCU3La3CqQcUQWUOpBKws=;
        b=QYXqgQgHEaBx6XUSTiY3uoJR+O6Ccge+vKzmE0xtzCuiVP9Yc4V49H2IzuSiEGckJ+
         FH+q3MhMn++hpycQErlbhEQJPpPT0zIwSl2jTLBzoN+O7aKjAfMgyQiBFIELOyd09Z0p
         UUvsSnbfI1h/LYD520tBUja/x6lNncCKc5NcxUQUnbA2zpmAlhkl233r+cbNZRRjnTi/
         0gxnjMBjF38pX9rV3po9gxYvppbcA0z355LeXHSmX3A4QuNhvInrV2hgdV1fcPTHt8/V
         vGSLBQMQQX3aMS5TCSm9SiA9WRxBk6ZCaSD5S6bePJGa7mAURT1eCcUfCOtmQV7djbdU
         xTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260067; x=1783864867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xmqz/oZ7aMrIDGMWhF1UArCU3La3CqQcUQWUOpBKws=;
        b=GEDdFqUtUJ4ppToSrnm4gHsvmGTyD7b/92UreJIatIk1RlMcvpMmQkzc4hUpZx2yng
         +uxOjY3jszceNAY07zxj1FDjiRLacakhBaVtgDAPqQAFw+DvC7Tos8s5xJAvdtl3qqCu
         VhEw7Ml2qq81VCkd4VSRbYjwAr/J/sCKFhWFF7az5sdW/5Z+opHlTuMhtgl7v0E4S+Gf
         Kxf8k62L9dYULq7YudNadYUWqAFuiRFIuQr0C05kZym0ld+EAxdroibgtVfaImdr9W6f
         F5kcTcuywtaei3Ra7/vRpC2bcFLNi0Lqy9Qxpl8NyUPIZGB9aaZiY5g88QhLCmbm8rm0
         vd/g==
X-Forwarded-Encrypted: i=1; AFNElJ9tHD9EpJUYSF5lMa5QgmFUb9H8Ny63tA174lBSFeLP3RCIldwY12F/gbcFrz6NlDOmfU+hC2NbbBB0MOJCxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxbr4kBUCUafddJfe43emZAdsJwlMtYpErhOglNRUpwZQh6yL
	34GfUvwmU+FhShSO5xoZ/yKIqSjZj5YKiQB2dhwKs1No7yV+pixG3OnW
X-Gm-Gg: AfdE7cll+cpqo0ltsayiXwOr6QmGuWZUIEHrVtFrDuPcOGLEIsQGmZsPCJ4zv5vNkvN
	G0nfhgzp7dI6DMvR8xuSn5ZWCZ9Zlfg8wzamQ1G3V/0nPYnxq4kxuURurJmHwDE6tUU63T2tZTQ
	8OrZJQm5SDRXLGgF9G004f94nMwxcFC7+t3cYIM0DUruSOrkUTCNw9E48S2URzVUROcKJB1vf7Z
	o5JhTdWwrD6T4t2J8q8Qx43oQNb8bVyfySp1aKZT9hb4B595vMH8Q6xUBhJkrar/ILN7gRg36Ej
	nfIR7d3oyzYSS5WgnB3nw7jt+3zyl0o3GxNbn6eJlATwRhW2Ml1MF/lxPNGpPQptZqgu32nNP3Z
	92SECrR5dMJ4E0pIWgEaTl+ovYyV8paro82MwUbS5g+PiIPw5pZ4U25sFm92wls7r2EYDZyd/Aw
	zJNjCYwVF5vPHjavAzp0UQ0ZI=
X-Received: by 2002:a05:600c:524b:b0:492:40e2:358d with SMTP id 5b1f17b1804b1-493d11de9bcmr79035685e9.16.1783260065332;
        Sun, 05 Jul 2026 07:01:05 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm275911115e9.10.2026.07.05.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:01:04 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	joel@jms.id.au
Subject: [PATCH v3 0/3] watchdog: npcm: Add reset status detection support
Date: Sun,  5 Jul 2026 17:00:57 +0300
Message-Id: <20260705140100.1543486-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series documents and implements reset indication reporting for the=0D
NPCM watchdog driver on NPCM7xx and NPCM8xx systems, and documents the=0D
optional GCR syscon property used by that support.=0D
=0D
Patch 1 updates the watchdog binding to allow the optional=0D
``nuvoton,sysgcr`` property used for reset-cause reporting.=0D
Patch 2 adds watchdog documentation that describes the bootstatus=0D
mapping.=0D
Patch 3 reads the SoC reset indication bits and maps them into the=0D
existing watchdog bootstatus flags for NPCM750 and NPCM845, while=0D
leaving WPCM450 unchanged.=0D
=0D
Addressed comments from:=0D
- Krzysztof Kozlowski: https://patchwork.ozlabs.org/project/openbmc/patch/2=
0260622083046.3189603-2-tmaimon77@gmail.com/=0D
=0D
Changes since version 2:=0D
- reword patch 1 to explain the hardware reason for the GCR phandle and=0D
  why it is needed for the reset-status support, per Krzysztof's review=0D
- cache NPCM750 reset status in SCRPAD2 so later watchdog probes can=0D
  report the same boot-time state=0D
=0D
Changes since version 1:=0D
- Modify reset detection handle in the watchodg.=0D
- reword patch 1 to use the GCR syscon-property wording from the=0D
  applied NPCM reset binding update and drop the optional property from=0D
  the binding example.=0D
- reword the patch subjects and commit message bodies to match current=0D
  kernel dt-bindings, docs, and watchdog style.=0D

Tomer Maimon (3):
  dt-bindings: watchdog: npcm: add GCR syscon property
  docs: watchdog: npcm: Add reset status description
  watchdog: npcm: add bootstatus support

 .../watchdog/nuvoton,npcm750-wdt.yaml         |   6 +
 Documentation/watchdog/index.rst              |   1 +
 Documentation/watchdog/npcm_wdt.rst           |  71 ++++++
 drivers/watchdog/npcm_wdt.c                   | 217 +++++++++++++++++-
 4 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/watchdog/npcm_wdt.rst

--=20
2.34.1

