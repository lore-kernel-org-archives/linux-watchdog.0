Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6939182C
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724548; cv=none; b=Wyi/0YR6bD572LmU+RxJShlyN/UOYek/K9ltrhmmuRdes4xTY8RA7Ziacfok4KzFM+TuJl71KfSZLXNku2pHlmNVG7KFM+FEBtFp9IOyfGn+sfApVrMHA/3wlfQ75ze++Ter9H7InBUo62uoo+p4+/vjvLptpUJDxlYL2pDOBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724548; c=relaxed/simple;
	bh=v2mMaBBmt663P7etC/gwcN/TGi3NXch3loqrN3fwMic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV8N12HBIRn+r/C5uNJ6OtQgS7cD/g22MMGYOk643zLvPX7wtqqqGaTF0qF413UrdbwioveJ51EcdgehhUDbWjH2McCNj85no9qnqn1xECYoJsi2LCYfs1I2k79VAPY0pQqd59s0Ze2eImKfK8pW34NvH9qDr0IE93vNdk/sLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y773nulj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y773nulj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so648038a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724546; x=1788329346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ugg8199IfDxwFl4QrtTEc3PoHF1XmNDtm3ErPR/zFQA=;
        b=Y773nuljmRA2/hkbf1yP/UQn/mWyEhi1tqBWU7a38qS4SEYcDKs8OEqEJLokWfLlsU
         J0lnj3myVJhisZZ/2TtYeF1P5BJXrwVkm48b2vNPi2h5MaexEn5MyzvzzyU2Nb0hlbpP
         mdnVkQYMEVLTbBy/6vbSqreHNpnXTRPKETO+barjIEQcDAGMFzgw/PU6uRgY2ZQ2umd2
         9j7HU6fbMryheG9ULl99WWldF8QoOgqkkygxg9AoPkXOJC0J2Faf63tOP0Pf6CywUKDn
         n4gO7A2y48jEIA37L51atZoe1qQbzax2BlH+HMH9uEQ+afFNwT2W2YN+0UtLGhwr0IHE
         vsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724546; x=1788329346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ugg8199IfDxwFl4QrtTEc3PoHF1XmNDtm3ErPR/zFQA=;
        b=LoRwqBDGhi+l0jSdupdSrsM0Ho+arFjkulWT8GrBfPOE8PCZXgJ1rqempuA/+19Kgh
         tL6UmB3HiTF0pwpMce7TxXMevK/d+VGCj1qZbLwfXLbytFTFKDxLc00UMB2pkbIUXnE/
         vegz74PcaJMNyhg+hi572SmV54Tp3UyfWAiZ6LG0GIW3N/kCyoWZvRg3i5iSaGtrXOsM
         XNrnbG6Re2uLwjsN7tYhAr4FxgxQemZpjZLXGYEf5S0LyMceRkVbMDkgGYUG058ANIGU
         6udRHsmWMeMUKmjy7JDLgcgmPXGc5HGKq/SUaP7iztL1zWNf11XLl6NJxcXRvv9QVzw5
         oYXw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ+HzqKFELGKxwW9oXZdb+dpYhYnmdLBZWdg1HmVPWlvFLt6tA/fHwbOl5WVmZZGUg7NpXZfN3KZrliL6TUw==@vger.kernel.org
X-Gm-Message-State: AFuF++lr0jtFYuEiGiEtMMCBj+rqh23FdsAAVnTeEtDwpIBThfdKHNaM
	hqu7UK102QMmgMDgsU3yKxhY+gVsmj8cl1xJg8Rz/eGqYCeOhfeJrlI=
X-Gm-Gg: AR+sD12SrhbOCfFdbHOKuCnY6v04o65V3bEdEATtMwPZ3RXkmduRG7BhEBE4sUvSzUu
	qQWde3hXEBDWTw4zlTutkeEPWozMx7oKGJupLoZcrW/MM1jplB3tCuZb38R2dYI81xS2QSWnd6R
	/R7lJoD9REJc6tTOTKxA8czLu/Hua9GKqP8OkJIpY2DPpAyt/VJXLUippopCYgA2wnKrpTa3ykN
	Xf6kiWYg9bxn9doJMInIQ1SXQksHS7Poc3OWaYZ5g9ZTxczRqWWWTTShOAMwpWX+D1Efsc30r20
	BFaYq1XeLOhkaJm/7LuXI0/UA0xI03JocUMLamMysBAUvk75aNMLWq89N4rRgQRcvoXZw28rh9l
	y1/UsRCiGF2zGPBUoWdVLIUOXfepSXVnxtx5mgfgU+TtHD/jYDUT8v+2PZTKt+4PUD9zhydjH7X
	MqvpSdjcVb2mlQZD0h+0w/x0wfZPEiIX1uu256tYn8+y878uIQ3bkCDJaLdHxdnnsiHgIdjIbQk
	w==
X-Received: by 2002:a17:90b:2c88:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3966d20e7aamr10465797a91.7.1787724546383;
        Tue, 25 Aug 2026 23:09:06 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:06 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 1/8] watchdog: cadence_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:32 +0700
Message-ID: <20260826060839.203297-2-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/cadence_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index ad46b33ce5f2..ba2efccef467 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -359,7 +359,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
-static int __maybe_unused cdns_wdt_suspend(struct device *dev)
+static int cdns_wdt_suspend(struct device *dev)
 {
 	struct cdns_wdt *wdt = dev_get_drvdata(dev);
 
@@ -377,7 +377,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
  */
-static int __maybe_unused cdns_wdt_resume(struct device *dev)
+static int cdns_wdt_resume(struct device *dev)
 {
 	int ret;
 	struct cdns_wdt *wdt = dev_get_drvdata(dev);
@@ -394,7 +394,7 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
 
 static const struct of_device_id cdns_wdt_of_match[] = {
 	{ .compatible = "cdns,wdt-r1p2", },
@@ -408,7 +408,7 @@ static struct platform_driver cdns_wdt_driver = {
 	.driver		= {
 		.name	= "cdns-wdt",
 		.of_match_table = cdns_wdt_of_match,
-		.pm	= &cdns_wdt_pm_ops,
+		.pm	= pm_sleep_ptr(&cdns_wdt_pm_ops),
 	},
 };
 
-- 
2.53.0

