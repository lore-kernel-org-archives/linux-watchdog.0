Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96E495531
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734877; cv=none; b=WQrR7VvwMh8NEx2EdrG8QeJQ09qARz8AvKiAdGCwcfSHAIWGmB0RHSVLFIvMW5JMUvRcKoNpzkBChWTkn7xa6xY8jw3nYy/ampkox0+yI7vb+OzjqoYuUOMp4PBuCX22dD8qxyn9vhieZZmwcWZw19Z9SVZYRCmjbxEbqC2ZyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734877; c=relaxed/simple;
	bh=8727gXZzYTROxIR5HGpxGjzxN4WQSN+2qsZrYVWVvfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnVN82qfItqJs3ncieufLCYLYho7EIKp0sIRGSN4enHzQlgRvsL9u4pI1mDeb2amf8llOBzvotr49FqMoULCISYrFZzLBPGQEp/NRowNI4R95YAXa1jbhDY/v3T3SeCi2S0U9PeWh2g8XM+cg9WwhQ4XY1MDaDGX9fGCJ1S3m/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHPqSVzW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHPqSVzW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1051435a12.2
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734875; x=1787339675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JSeOiu3PqmKguSCJ1LnWjvXgMVRQ25FZdqW3g7+zy8=;
        b=dHPqSVzWON4lFcXSDA+PoXo5HR9I2a0hDoBr/AfI8hOS4X4Xq8nVr98g/Hy7yQdSEE
         CQ5ZobsHQr/qZZNC4RH4rr6JBMCxx6HQErDMvBQBK5WffptfTFLOEXmJY8Ynra+jDRR7
         fih8UHl5AmhocDK2IiOu8ZaO6y86oKhU1UvGFTA2Y5eA9ORA3eEKhtFSCrfty8cwq2lN
         zeb9QFhnU4Xuip/e5AoMZZC+pDjSnf2H7QbP25wGHVJjmaxNqKmuwGv1yLo+D3cU9V8u
         pJbtyckyIgbVx4Vw+wQFCUz939phxTJ+/Z2EdAWaLJgafUBhKWGQitGQr8O5zDkMlbtd
         kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734875; x=1787339675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JSeOiu3PqmKguSCJ1LnWjvXgMVRQ25FZdqW3g7+zy8=;
        b=PCqbKjsPmYUVmWI+1AneKwSJzLHwxNAYc6d8zehFELT9oOrbI/z6UG9cyeYOgvoEGC
         +OZ1CmsPmJQY9sNj3KfYGLUla1Qt1GK9qJk8B/CmLNw1zR9BtNn4vU8j1qdPg92gruKp
         NZkjMlaGlAYllf7IAM2DPWcFxUuZJrNP0Ltz64zz6/P9/PntOCRIkiZNFIcs2f/YVE3R
         dsDKp4q61Q+9IwZTeUKeidnLleKlfdI3cxBeliJSIjk7HhqS5eqw5CHuXvcdL/spqqKF
         vPDReenGIeuN+LRplsiw4yVeP88I2ncrJ27vvqT0Dx9t47bIE19Ub5mLEyarMxXF3z8C
         qIsg==
X-Gm-Message-State: AOJu0Yzc9AEV/r6tWvBvssV16qWmcAsHAHICCELIH2UUhj/9i1LYyeJd
	MlH4jPntB9wPSVrSqSxqC2qQvnOzC5WtNJ0bEySBWID5xYsukAA2+IcG
X-Gm-Gg: AR+sD10wXpuRysGI6A1N/zSoX37LNKmDQwXIy9bqp36QScNejD/LDnwJ90IpG70mh5V
	N/KYXkP2FVHfF0IAzAYq3IjfUBkHD5DGy7cCCmGxDAl4ojFWIEWssOBgHZcrre6aXpE8RNzrGxe
	xSfqbUN9L+8YJwFsuP03EEuVwopDIosZMOL+k+XZC4SvLULG7P7cCaSn5WuWlAfA17+t56vGn+Y
	SvU8ITvKANlT1Vs1/XDpReZY5gh6d1EiQI2LcZNwT/cSvqzwFppcjdmgKGDGS90oozZxXwVF9/T
	3J2r0aHSV4AGWVONZwZb5CggG/xJ/A88N0pHQW9jQRRJIF9ryBo0OzKZWDZF6QS3UIx2+1f3Jj4
	5LbDe6aX0n682cgY9zJcy/+BoJAFkFqq1SmIdrRXwZlH0CdcMasQTE8VtVil7wDBQssLXKhCTja
	VoB5S1vwlPEU+4Hqs6bJPUv/x+sB0Lw+3b+CgeyLk7Vnixg+UJ3c+YBzbcjOmopiS88tIR214sU
	5NqD5W6ZRY1sDM2rd2Vz12zhgLCOKO0IAlgt6h6xutwfD9QGxwHakhE90onjb70ZlIO0DUfQry6
	/TLhkvn5
X-Received: by 2002:a05:6a20:94c8:b0:3c3:a9ad:a747 with SMTP id adf61e73a8af0-3cc71ddaabdmr7015988637.26.1786734874862;
        Fri, 14 Aug 2026 12:14:34 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:bd48:a716:c86d:67a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ead105a9sm6734865eec.31.2026.08.14.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:14:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Fri, 14 Aug 2026 20:14:11 +0100
Message-ID: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series converts the WDTDCR register access from raw
readl/writel variants over to the regmap framework using
devm_regmap_init_mmio(). This conversion serves as a preparatory
refactoring step. It allows the driver to subsequently support
syscon-based system controllers natively by passing along alternative
regmap handles without forcing messy architectural branching at runtime.

Note,
 - This change was suggested [0]
   [0] https://lore.kernel.org/all/c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net/ 
- Patches are rebased on top of next-20260813

v2->v3:
- Patch#1, is split from v2 patch #1 to make thing easier to review.
- Moved unwinding changes to patch#1.
- Set use_raw_spinlock to true in regmap config as certain watchdog operations
  runs in an atomic panic context.
- Updated commit message to reflect the change for patch#3.

v1->v2:
 - Dropped patch #1 from v1 series.
 - Switched to use regmap_set/clear_bits()

v2: https://lore.kernel.org/all/20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  watchdog: rzv2h_wdt: Propagate WDTDCR access errors
  watchdog: rzv2h: Convert WDTDCR handling to regmap
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS define

 drivers/watchdog/rzv2h_wdt.c | 80 +++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 23 deletions(-)

-- 
2.43.0

