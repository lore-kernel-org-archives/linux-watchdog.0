Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EF37BE64
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350400; cv=none; b=OANZijBWFctae00rHykefRZwWyy8MzebIsdXygOGQDml+l+LkbE0PRvNNLGvCMAGyB58KBO+tdG4kMoUYNZZWglecOOtnL9aDqKA+FJfRDfvJvvG25eeVb8H7QE0rzokYdgGFjsKrTVbxFCgU/XJ7Xs2QzAErDkFUiwiM04HJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350400; c=relaxed/simple;
	bh=62L9uynb/se0eilndyIIvfvtAW6tC/LHcDa5OnCWfwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=to009AHIk/PZVPqiUIQFt9ZAxeBuMLtRClGl8z7qYzFncj7p4f/tJfmYMgIc63P5G7fQm16tKfhc41aw7cm55OLbpQ0Dgt3NXhg3G1vfR8oBEIkTSERZ2KoDHhTTu/oibSp7EHUC7FOog/cb4GmMG4P+fbMF4mJt3x4zOc1PmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDZOY7TU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDZOY7TU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1751212a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786350399; x=1786955199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nj9W1H0BK4w+o3hytXvjAjHkDEStVnmqIzc1JlXFMlw=;
        b=DDZOY7TUGDxmAH3jbz/VIofZTxxf25LIc/mzFoSqDo/bY7+kRx7h8R4m/B5MlDMFDb
         mkq/ytwisAAw0sosG+MB9Frsh/vS+JXsBYf7oqtYiqSwmsZRC4b5Mcav8c7pWbbEbObo
         oFl8wKHZ73WFqe+d20C6CyuZcQ1b0mn6clCpTy86ZuXst45LTsdYfIp7i/8wLUnWW8E1
         tPMBiMlKuBYRfuevyfwODjx9mDEaTEGVsU2VEeAgTcEvcouA6ZvXbbHjiqzNLTfhgZ5O
         rEAntpkpFmK3TovPXIL+MTaEtE3on9IKflIvOL2e6mSaSF9WvcHoeKMJSvECQDRhqp8g
         a9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786350399; x=1786955199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nj9W1H0BK4w+o3hytXvjAjHkDEStVnmqIzc1JlXFMlw=;
        b=nPHvTlO+CWWyuTFDj8skebZeua9wTQcUUITSGzP38vPMmzt4l8MmMTafbKn6XTbLBY
         491iCsjglF+s9cqryHX6U0E/sebRSXUkxXKyz1jJV232i0GjDxhbYKobWlTiEpeKlBuf
         bMyXC38iYGkePMKVUHnyjRy98wJ3qgW4bSro8O72V1LMYs64ZH/bSolMYEt/u8UFAv7F
         THX9MMTzm2ZJ/9wXyfyseOJQu8txf90a3nAhWOJkXl3ZE4nCKqlIj6b4iH1Op5fHPrqU
         5bOWeW1bzMK4/0V+ofkEoBeX0llI3r7TUTnX0FGScj7/RID3nUAVvz94MU74Mk4WFheL
         OsOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8se5C97gsKNRavO0ii7CPzcXRlobcnYbR1cPihI09MM7p592kMm1phIhK7tM7b/IIN7+Qp3JzXswpw2ekUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6Khnnvitr7cfV2nTBxExz/flMohr5C9mtrCkO4rZcYjmgN35
	dffzGiHZnlly6VbmEsh6DlIIOeQKB377KWm9+POKZC8qU4gF8WeP9Cl8
X-Gm-Gg: AR+sD11W/yOSkWMG3qM7tZlfZANLmtBrxO8bgQt/Bdyy1kCv2ZJj13kfHp5q+EA53cT
	ElEbWwBWHKsJ4aY82RzZy41+wW6o9DPkCUYZPcrskwqKxlUVUfUSm1WvZ9d4qQvnHoQgJ/xp4F+
	L00IcCIV7yKoICwupdD0N/3HqBTBSdGmkvYkJIdpripEop0KZlgcrVhtEtOZHrsYMTEWrsREgli
	5F/+5WTOuhSAIaWd7tRAbPJxC27kGsmYzi4FE4lZx920E9Ecki6BgPLvFNDpShFhTsQkPwQ163x
	2+I4ZW8htUZxoRyw7UmEgYeZbfO1icI4+cpuJsj/kIJT6tbMUJpW2MteZ6AOvPm8uQZhzUDCN5V
	IbZquBINbRL5EK9AwHZ24mzgblHXPj8SE7YFHlDLuzEVibAtvFz7BnslxwcScuyEzn734Fb1pGX
	9bISAmG/mKhMpcTt7YYi/9sZCPNZo9VTFa6prS6Im+YuwE29LR9iSsNrVnfr8b7tEIsXdJUVkVa
	JWjqFxOnJwP1evQZsb47cq0Z9Fm17mhODSiHeibm4RnLNQDd5gpoe7VZYi1KPj2ZkUirh11J+Iu
	mhE+
X-Received: by 2002:a17:90a:ec8b:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-3903c5d313bmr43348272a91.13.1786350399025;
        Mon, 10 Aug 2026 01:26:39 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95c40sm11595151a91.8.2026.08.10.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:26:38 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3] watchdog: orion_wdt: Propagate errors from optional IRQ lookup
Date: Mon, 10 Aug 2026 15:26:05 +0700
Message-ID: <20260810082606.42623-1-phucduc.bui@gmail.com>
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

Link v2 : 
https://lore.kernel.org/all/20260807080447.35479-1-phucduc.bui@gmail.com/

Changes in v3:
 - Use goto disable_clk instead of returning directly.
 - Add similar error handling for the second platform_get_irq_optional() call.

 drivers/watchdog/orion_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0e145f762f6f..6715186aeac4 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -606,6 +606,10 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	/* Request the IRQ only after the watchdog is disabled */
 	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO) {
+		ret = irq;
+		goto disable_clk;
+	}
 	if (irq > 0) {
 		/*
 		 * Not all supported platforms specify an interrupt for the
@@ -621,6 +625,10 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	/* Optional 2nd interrupt for pretimeout */
 	irq = platform_get_irq_optional(pdev, 1);
+	if (irq < 0 && irq != -ENXIO) {
+		ret = irq;
+		goto disable_clk;
+	}
 	if (irq > 0) {
 		orion_wdt_info.options |= WDIOF_PRETIMEOUT;
 		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_pre_irq,
-- 
2.43.0

