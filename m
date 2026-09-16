Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0F3CAE93
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550895; cv=none; b=rF9xrIzo09kJLWB6s1l1ct6ShDixNqFNoqxZTEVdyGWWouGLFQQg4IX9WT64hmt0yunxGRIm16K5cxDTj0BAoSlcfWTB327tfZgRherfxxNHYYFf5ZdjvKWzbxG/yAf0Rj83UMVdr59/jFMyS1jsoVnVVZo+UVtwG43WJ5ISOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550895; c=relaxed/simple;
	bh=i8cb/65RfjdVKB1gNPZ0c4xcdU/dhNOfqYFalOWb0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YT+cSHCYR+7yGnvvSJ3VLqasACvVHke82Bxvif+NKwXZYFjbU+/yGsaG/ouZ00HPOt/YA488f6nTMk03LxGkmSODoEMg1H60soXOd0RwIRNZU5zn/piFuLxWAzFmDLSNZ25gZBpX1oLrdNNAOb6Av6uWt+DWCfOkKPlIWU5XK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQwWIRlZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQwWIRlZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so707959a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789550881; x=1790155681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xo7H/CC3TMNfFUOdZ9uePQypBhksHgJvu4rQrR1pwFA=;
        b=GQwWIRlZQYY3D8ju648c/49oU5qg+cp/0eCkGBvX/xO52Jkml8UCHuIh6p2auCJCY+
         r64/+GERFfW39KXobTnaxXb4PJuIrA6KvkkqQq2sQDMX/uGRmFMZza/eGRwKBpPZ/bKS
         TudLWL78xUrL+tbxfXFp1myjZt7t4UU08c8Msk8kfkIo30ubMWYHXPRCJc8imXNFBY76
         f9YUPR7cPvti0hm+GleB7vbTmhm91c2gOKqzUlXZMUen8j22hS3OhOHD6CpOSzsfrQmL
         UDxj7g45LgooajZVuFYJqxaNGxWo2Cr30yklMfDPvBKqH4w37vKUyQx26pnuurUBe3T6
         ceFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550881; x=1790155681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xo7H/CC3TMNfFUOdZ9uePQypBhksHgJvu4rQrR1pwFA=;
        b=hXcLM7L9uCBhwJKqb4COjfihpSv3kcn7AWwvcFVPH1pL9X7KFrzS8JcxjC8XEfsnWK
         VBQSONMo17EAMa5rh5MTQf66NhjHR3oPACSH63nk1RYwZ5ghJq/moHaF0AjsjJrrMIP0
         LriZMpDbvpxD9zf1wbelvfvVjUk1qv3lCOccetB976pGLPnWgyFrMwMYOJvaOXVo02au
         l4vk78kk3ZgEPFW/o+9JxhlsEQy42ZUByo5cUMKIgjQO1yXi34qv1VBnARv8tb06uJtv
         Pz+YBiidHw6f1iaGB6g/8Roibu8Al5XxySZ5J2cK/KEu22Yggzcl8GkcL09vJCeoOBJ9
         LnAA==
X-Forwarded-Encrypted: i=1; AKwUvBwddjF3km960RvJdib/GDCqz57vLU8XYWolCQD02FSI+V6sJxjT7wtGJ/5jkx8l68fnpCtAUr0obi284UmMxA==@vger.kernel.org
X-Gm-Message-State: AFuF++mfP3O0KJwRpsI/Cm6OlTZkGnbBmdhttw8mR+zzFcmqcheGw4jR
	4uIMOBGmobpgpDRv9JbbjjP9os9oMWzVouIch97VJ0uOFLjz3XjcoJg=
X-Gm-Gg: AYBFou0Fp7F6dEFvhED3Od70OeM98eNBVDhdzytl7DQ8UgUkX17iBQk/tTHfZIjhMjG
	MvOPA0d9l+kKIUuWZOpwbPFr7O3BBzy3aEui6GUglMDCcPpWOMJqQpF2hKu/EzixUByf/ix+/sf
	PEFb1Hvz6Z6OlqqwoHQbj0z2Gx3MoG2sYTWRBPYNjD3XmkYOhPPBxHhAvrazZSrLbkJz4rwHHnT
	TPc106OihjN5UE7Ru7pdp/tkVvefx3Qi493sWiG+xDggIiX7V1k0dOevcQ5YyXl/0j+JunA1UEE
	rLrwnm7OwqWVGBsvoeNmmXCGJ7Qat9sfc50E3xafNQYYlpR9lC4b2cS5c5pqOWWDkIeFDAMJpcV
	MNKvUJGyFa14Z0NKzqDv7tzg9o2G2DcR/rVPGQHYr1p3dip/yNiyH7Oyo+AenBu1pvqgHY3rtL7
	UpqlF2jaOZB3N/QQ0wllrwTAmW3Be9di2C7b9rMFBkFCCHp9hUSrsSf+VotFg9xZSgWAXdZ2pU6
	3S6DZSw+4nv
X-Received: by 2002:a17:90b:2252:b0:39d:ec42:df69 with SMTP id 98e67ed59e1d1-39e1e4d3ff4mr4427894a91.20.1789550881491;
        Wed, 16 Sep 2026 02:28:01 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb22ee5sm3784158a91.5.2026.09.16.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:28:01 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andrew@codeconstruct.com.au,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	joel@jms.id.au,
	openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] watchdog: npcm: Propagate errors from clock enable
Date: Wed, 16 Sep 2026 16:27:53 +0700
Message-ID: <20260916092753.187583-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check and propagate errors returned by clk_prepare_enable() when
starting or restarting the watchdog. Also propagate errors from
npcm_wdt_start() through npcm_wdt_set_timeout() and probe.

This prevents the driver from silently continuing when the watchdog
clock cannot be enabled.

Fixes: 975b7f0fe669 ("watchdog: Add Nuvoton NPCM watchdog driver")
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/npcm_wdt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 51348969bf49..0976a580b9f2 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -149,8 +149,11 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 	u32 val;
+	int err;
 
-	clk_prepare_enable(wdt->clk);
+	err = clk_prepare_enable(wdt->clk);
+	if (err)
+		return err;
 
 	if (wdd->timeout < 2)
 		val = 0x800;
@@ -216,7 +219,7 @@ static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		return npcm_wdt_start(wdd);
 
 	return 0;
 }
@@ -234,9 +237,12 @@ static int npcm_wdt_restart(struct watchdog_device *wdd,
 			    unsigned long action, void *data)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+	int err;
 
 	/* For reset, we start the WDT clock and leave it running. */
-	clk_prepare_enable(wdt->clk);
+	err = clk_prepare_enable(wdt->clk);
+	if (err)
+		return err;
 
 	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
 	udelay(1000);
@@ -428,13 +434,18 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
 	/* Ensure timeout is able to be represented by the hardware */
-	npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
+	ret = npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
+	if (ret)
+		return ret;
 
 	npcm_get_reset_status(wdt, dev, data, start);
 
 	if (npcm_is_running(&wdt->wdd)) {
 		/* Restart with the default or device-tree specified timeout */
-		npcm_wdt_start(&wdt->wdd);
+		ret = npcm_wdt_start(&wdt->wdd);
+		if (ret)
+			return ret;
+
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 
-- 
2.53.0

