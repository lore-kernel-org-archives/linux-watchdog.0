Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E43BBA14
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015000; cv=none; b=U88yLg3n/ClNakMzsVuHA3XbxyR8z14XznP3ZeRY6cd2purkWCgbHxehGaq6Rje9yE9hhzkSindnKK33tUsseAvOzA0StTNuUEgCsBdHgDxUVZemOrEPCbLbic+pzS1zypYkQ2LlitndQhqn59tzD2el0sp8UlYATvTuNE7HgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015000; c=relaxed/simple;
	bh=9Z1569EW5/z8x6z+WqMDSTPE2H3JIeADeawCkPvKVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkE02mJ2I7+vSB0oIdv7qnTO0lKK6riVej/PpWww+g97o1d1+KtHQWJ9ogBPZv3lrzklZ2Lb2U3hHrxbd7ak1g4JaY4nLjGdjVSeYVEMwwJwWoQ6YOpiwJDyTUn/L3NimScYLsA0q6nSIqhilP93C1O8u1macljFXO1TsXp7KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIqE9AYI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIqE9AYI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so7665401fa.1
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014990; x=1774619790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz/ujuKHoyfD9OPh8IeUI9Wanq79Wodbu8Mk271DzDQ=;
        b=PIqE9AYI6Up8jbJuUxgjyU7Ssjno4bcAdukX6Qwa6W1IiGzxbjhHmyc8+myCcuFwBM
         aibQ2hHXxifSI8vxIWrjA3XgG9nq84SYskYBl8JZ6n+NG4RiRzBg2KEQz6TsM+Ua1dWV
         N6Qel/1xuEHBaRECV3UH+fKApjnwXbr6oZmF/2REjOQM/lJcOiL5sXoI/nHqzrLdNieq
         mZdikkcqA+5Ey79aOMCUICM8R1Xvn7OXv20KWeEvritj8K+S7ecvJRAyaWEeuoR49Fth
         79KbRawep2oo2cqPGkoASUXfCR6KuboVaHePY1Y4w4O28FZYmnPXgTjYCakl+QO/owp7
         lrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014990; x=1774619790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yz/ujuKHoyfD9OPh8IeUI9Wanq79Wodbu8Mk271DzDQ=;
        b=JwKMXCbxSOm8h6/cGRkoiPFqnWCsl6V0SGo0t1WCzvildIlHM8Y0Jf+sFAcNDaNXFi
         VJ300MMl3Q2B6ON6PHRN8+VWb80RShzo+kLItb3EqTlsEbXaOQuNbuxtFmJ2zsbC4BbF
         K4Ka/xzI47qbjYpdwQSQ5EkCdxNLJaHGwu916R45V9IEZr1jcPCtoB8pGmya/FWHGLMN
         PDijv52IfOevLBbxa3Awbttc8mj/dHeMILTL4UUg9j/YDxPfjNUTUJv75rXADnnz7nty
         yyZlM8fv60sdmy04k3U/1MVmpIGgbjGzxxHNYJkMX+90VTCmp+UdJhfn+0Xb2wVXmr/l
         2wig==
X-Forwarded-Encrypted: i=1; AJvYcCV/+kFoxni9Q8uCKbhNEJ7o6+WS0DRAC3SdfOemqoZzcaKd+1NDOd84xUNcOzfsXzsnP2YXnh0SQBt8b4bYAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0x7AGA8rjRo1WwIL8kuwH01uyeceXkvwC4n7wPnbRakFQXxx4
	1tb4AxRnTN0NHj7uTkXygFdtZIKd0x5Sn298/POPD8LD+Bicb1EFBCCe/H1L1Q==
X-Gm-Gg: ATEYQzwOOkicHmeKd/qkcWU1Iw5q2XK6um7l7TDleu/KletB6Cqchvwx1smUH0MzfsX
	P8y60vWGSHTwQKBNcE35hJoMAUoBYL4YcOSh5oDnDgkSUDWEXC8to9UMqbR8wzKrJ6PXSeb43le
	cRt5uAeDMFeMa3FCwtszoZjUD0eMhG3vl7CkQUpvEwq0xnLGPZDfD6+lCOcXuPl7lJyDdTCEo7V
	quFHHUZA5UU8PwVGPO5K82y8egRjxSmm8nkhIFd/76GvwYldzeM/U3zVKsQzFaM5OHUZYKnJDru
	pgWjw7/smGTHGgVjsJc4+/dNV8mxZ67z66a1oDHx9hdYGgdmSgNoD3n9GKhCKsVGaYAH7KvJuhs
	czj3mFkEbTR39e0nkSvirtw6WyL3YHsFfxLjZVrMcPmeKDztxghU19l6LEW6LFTanQ6YztcDPjP
	QFsD0q6wn3c+DgzTzENAErlkkjjO9xXI6ZzQEOdtEl8Q==
X-Received: by 2002:a05:6512:1248:b0:5a2:8077:bfcb with SMTP id 2adb3069b0e04-5a285b50351mr1116460e87.31.1774014989853;
        Fri, 20 Mar 2026 06:56:29 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:29 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] watchdog: dw_wdt: add error handling for reset control deassertion
Date: Fri, 20 Mar 2026 16:56:19 +0300
Message-ID: <20260320135624.223863-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320135624.223863-1-a.shimko.dev@gmail.com>
References: <20260320135624.223863-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset_control_deassert() call was performed without checking its
return value. This could lead to probe continuing even when the device
reset wasn't properly deasserted, potentially causing register access
failures or undefined behavior later.

Add proper error checking for reset_control_deassert() and return the
error code if deassertion fails. Also replace &pdev->dev with the local
dev pointer for consistency with the rest of the probe function.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 3450402b7707..724ba435b3c8 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -588,11 +588,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt->pclk))
 		return PTR_ERR(dw_wdt->pclk);
 
-	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	dw_wdt->rst = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(dw_wdt->rst))
 		return PTR_ERR(dw_wdt->rst);
 
-	reset_control_deassert(dw_wdt->rst);
+	ret = reset_control_deassert(dw_wdt->rst);
+	if (ret)
+		return ret;
 
 	/* Enable normal reset without pre-timeout by default. */
 	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
-- 
2.43.0

