Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E82EEE9C
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122774; cv=none; b=EkxwjVOsCdUWrPtk5Y/U+QVr4ExgiSW0TGZEreFAAB26CCWjjH24j/MWOa7H1mVPlhnUQNuYbTstV1FkNFqIaZI4iKXO7nsxreDGwTb/e4hkO/W6f46cO0wMW8cQHg8DjzmK28jJjnSLwlco1VIVjRY7S4A10MTD7Lm9IsQjK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122774; c=relaxed/simple;
	bh=nRqbKbaWfRz8hfPCtBqKC/mvR+cJJL/qoNAprASWliM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJmpNi6YEGSKrOQpS2YAU+w0PFXkzKqmqio6TnzHbzwW+n6XTJCS7IoL+nena9b408blBt/mQj+24zfH70qiMUnFtOiR6zZhEXVk15Q0tnr7HousaBiw+G4eL0ciG7W+zvfV1Isk23G2DoxCVHt56ievCLozJJP4P7ZiPKPGf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puyML/nd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puyML/nd"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470174001a0so1144847f8f.0
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122771; x=1784727571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSfN1MRxYCHj9lB6dAV7fGSSShXP8EN6Hzd+6qGouO8=;
        b=puyML/ndvkzf9qrRbpjveiZtaq9j+AItRRTyD6nm2g7Ypwq+ZOQVpsAAlnU/JjMo+i
         P7FgMrStaVuRwZJIGetlJxhT2l+ug7Wvex2ynGgkK2CaFy5rAvZ+ahpW+jPzfZjUkjzU
         Oky1rYLlFYtL54aW0eR/tr8IGv16FLWT15ryxRYyoX3SCr2LkJcccyxrdSM4TGkfIpe/
         BiLzw10RIXO0mlbbfICtUuMY7nCO28uPMQwsbCf3pKDblKXFcdX2wOy4vIpVx2FND8Dw
         AO6lXZkWx1gE2HiqJRQN87mvdC+EGWSUOiRHVxj9/aGfUqwzM1IghrEv5R2BstLSvw2A
         ULKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122771; x=1784727571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSfN1MRxYCHj9lB6dAV7fGSSShXP8EN6Hzd+6qGouO8=;
        b=s4b9sWyZudNjX9TIMIH1cIbJ5lsKMEPKl7qxJ+jAv/W1wbOW+Hgk87Ngi0SlwdAD1l
         9vEavHgcDEa3F1wD55fs8iW9cn5kbjT7FsTkOM4BVKZfQjnyPhciub1169eVNelKVsFn
         gwuZmjpd69AYqNsvKC+b9aOyAti+nNMdtc1A28WIoD4YwQjbaJ+W12AbbrLcWF0gBRJa
         0bAVqJmWKeOf+wQUe3UPFdr3cBE4GH5QkjJSUgm6UftraVY1l6KX5BYllSMkJY3BMnhi
         FccV1Q9HbTTDxFqgGKdq9+jHF4YaZ05Oh1M4Druq3kZGI0Hbh0+2JdHRhDaDNsYbrqr8
         1mSQ==
X-Gm-Message-State: AOJu0YzOuQ32cYheV8ZA8a1DLxN7YiLlniq5IowusQEsL6uldijj9lmp
	Dre2nqV9g5w1kzr5wR0oyOYwoAliOwqaUTlYuBGHkZnbk5oxTa9RMERD
X-Gm-Gg: AfdE7cl43SNN2Ehy7OJF26chteUdAqP4qWLYH6W5wYsznAL41V1O09+EFbl3HEYDALK
	7ughNIB2MFFTSbIeQugALKbh61bLAIyzGj4UUjGSfU4i9ohtMAoYNCbmGv+azDxT9DOsLkBxVyZ
	pJ9yzyfLzw5//f4/tpyqStJ1JHxdtJKaUZxLfLkP28Bxk2tMJONXSUkq1tUhanh0HNpEBTNww38
	ZFnDBDuIn78tZ07Oyg034hdLp5qmLs4ALPeIfva4HRQMCKTsJR5fqWycrLff7NfUXYxrSI4QQbS
	K7/qsc7uVGjhVRPsP7LG7VaL7ElRb6x9hejm1/rAbH3sSOrmqpdCP+hNUTwWJjWdDbygDhYgcEh
	UE0iPrKj7likiQPtQidA9lPnYeRICUItYni2juTPrsloLssLposuPnF9aBULbsKVw+8MaO4hyXQ
	BNHiuCfwyGcT42EBn0251wgpF8UvYNOwp7w1pAkBWNrxrjIxneBfWnouVEMx6dIzWY7lRiYLFyC
	bqGkLX+hcT8BXN4iKoWmg06f1U=
X-Received: by 2002:a05:600c:c4b7:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-493f89523d2mr178874425e9.6.1784122771209;
        Wed, 15 Jul 2026 06:39:31 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b35105esm79420195e9.9.2026.07.15.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:39:30 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro
Date: Wed, 15 Jul 2026 14:39:22 +0100
Message-ID: <20260715133922.2129340-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS macro is unused so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No changes.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 0f951219caf8..3c8739902ec4 100644
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
2.54.0

