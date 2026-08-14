Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618F4A33F2
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734890; cv=none; b=nea1zEqRkKCIu+7P4ngCtAaDcGuCCDdob2YKtX5DYURWy7OlaP3v61gCaXbMjxzZoTnbn1Yt64/moqpj94HLoODq8gtuSrmlDFiXOCFfJpV7pbRJZFFIslb2gNtWi5xn+M3PAJ52uTgkPvg2x8Cdt2kPTR6If71o5SfCHZMoGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734890; c=relaxed/simple;
	bh=Z1V63TLbOOJiZ9OWYBLhtvG8u+j5Z+qNWVfO33Rsqbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHgUYSDaT2VL231FhxPqXtE4EbV/8+EHWYruaV7o+9be6RvEMQNoxCLKsR/nlLH+8DLGkqDI/v7xCoUfO5kVmAUseCRnveuQkTDH9KKaWgQ12tm7tMIvtpijNunYPsNeHUTDSvDEF8Ak0vyvX8YXhynvk0PDZMidEAJupgBafZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foTh9Tw6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foTh9Tw6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf452def93so20602445ad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734888; x=1787339688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljw4i24OukbGiQJQCxBeHaTi06GYjymaKq0wZtgmu0Q=;
        b=foTh9Tw6FGITm44TapakljVHUFl7ily/F6IQ2hFlk731P5UIQzGVPrNZa9XC5CXRN3
         Dp4MYl6dzKTx15EnB6FUhr94/HHT7QvmznUNECtOigPx84Gng11bZ8fWYlVOcJSoXTA7
         LaDxlsUM9X6goUVozGHUxcnqfCVVdnt3eSbtFLnA0toEaTjBVZK+Xwpqz221F8e4K9BN
         R6aOfEPY0E4G500WR9nz8+aE5dQqxshAmmTkQ0s/Prhzhe7Pvs0LxmJMtJDxiPazI4Qv
         gbtBirf19IlPyxqyn2vS33xq8USl2Xj9wIxawTlilUU3kkn9dhChLKrDC4PAcmJwjx2p
         qPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734888; x=1787339688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ljw4i24OukbGiQJQCxBeHaTi06GYjymaKq0wZtgmu0Q=;
        b=qzW8AxM6/Q1RUZhX5hFBRTOiV/ghQN48mBlKF+DoAPFxwxl31KfJpPtpkAwvT2FzyK
         Cnv2FOwtUOa1cqK6HEaVDC2gyQsFaBMobkyNIsvZlPFlSlPc7X5nmG/ckB2979Ml3Tr8
         a3Qp9p93k/ugtP8eeaxOs4L0Hs0rH/Ds8hxqkzVNeqcz3iSMCQu4TxKzi7bL3IQApyQE
         VqXXduAN6N03znXaCaCcWyTJ6lw+OU1E+z4ga1H3WZzQZtuFjRszrPeA9af5AIqmQpyL
         X8HgjkiWcGPyJD8mrMp/Qlu4pQpS7ISByIUcC7zOGwpGhfu8iuZ0BRnakquI5Sv5Vhve
         1C3g==
X-Gm-Message-State: AOJu0YzOZ6X2xPLCoSM4St8pX9Ud/dBfaqm+EdvRr8oiLiApoAF7ebVj
	xmPHUYMKWFLdsk2qfWCHT4+p+vFBpny1SN/5fVrE8HFs3wc9dyZWrCu+
X-Gm-Gg: AR+sD122r796UxzCqQM/CUGyWTGJ+tlBwsgTXFQgZs4mC1topxh5r2m/4HrJeaHF8h7
	vCrD15A9UdPAusRWwbvuUNdhL32bnk00R/7nczZaKmZF09XbZSMgKaIjfC6JqLzqFLac63NUPUd
	Ms+Qj+VbFKdpg9INkbWN2LqUNUh/66ht2QStxnhzuQb5/Q3VE26VNjwtVzKCCM0opBo7A5hq+W4
	ucqDUw/MYANLEgVDmULToQp3ZXqaTf4hGQP2ANbPJQXY48fPFCRVzGPVp08Ya3tjE0nlbvXHa7+
	xSaht7qrJxV9Gw4A2vJIZFMkUgwSJD4uNaDoalHPXxDdL2CwkI64EPrbDr3GsyEYnmyFfijzY30
	fXhN09jrsr0DWiMmrKFUq1811pRVV9tykm1yBaXf0MbhhjKg2KioX7XJr1y83fUPHNg5c2qJQSp
	H7/4MthfKO2Z+8dLu6jWwBb9ziZoX+28Z4Sv9yLyQbWATTW0j0yns2aTJyaFrZ1kwrfTxdA+dNk
	8Dg6pPKkJ6+pxjAQif4/UtHR9ijRk3WPYBBWDtOIk+0kBAPp9VTY3NVwlawwkb+uErUPfiT4dOw
	y7Czf04b
X-Received: by 2002:a17:903:1a0d:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d37f7b7ca7mr177972955ad.13.1786734888228;
        Fri, 14 Aug 2026 12:14:48 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:bd48:a716:c86d:67a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ead105a9sm6734865eec.31.2026.08.14.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:14:47 -0700 (PDT)
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
Subject: [PATCH v3 3/3] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Date: Fri, 14 Aug 2026 20:14:14 +0100
Message-ID: <20260814191415.2110732-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS is unused, so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Updated commit message to reflect the change in v3.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index cf28caef31e8..8af2f33b5680 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -40,8 +40,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.43.0

