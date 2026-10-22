Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676646;
	b=O0izmG9EljZ6HtwL1QNU7a7UWt6/QyfcDTmHlMj6fnVVKRJf52r/4lYTV4I7MGJFNJsD
	 OffdT2RkacEq+5GhHJ8hspPZOC25YvQ12yIglrBRVnWKryLBt0EW65HG6vEAm1Z8e6bi6
	 lsiQLbaut3YccqvLfjNmUbhqz7Gba7r7HSy/gE04e3GTDo8Kr1uJV0gBNV+CYaPWdVLw2
	 Pz+DuMuxhZ6G/q+lluWIoW8QZStiUCwOq9u/hS/Tgp7ihKYfe4vgJ0MwwRttOc397Lpfj
	 IPohtvz5eBxH0VaKCrPWwcC2I6+chpOOrIZBjLiovGVDp0bZJa4Pq7RMSt2SLCcsZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IGum0Dhauevbw3Uwf/HnryttWD3FBap3x0GWqK5kUvw=;
	b=JqerO6NT1HQH7iIFx8FKo5Kxk6R55xL1MK5WaiF2GtUgfrI2fv5WShLGIhPa8fc6qDUo
	 V2wdZMOYO4Y/IwXgqPCj9ZdTbnFtBWss7vdAgYViZN7UppaFsLk84Y7UThOrGa93i5ewi
	 qSeGCYZOCMK7Jw7hz4GxSJzs+VPNAyfrkRU8ObdOuW3UCYgY8UgMMTblSJEOEdkLWDfnE
	 V4uHyx30gVsmTiVavLzFaIwFfnn+0apivpiJtvrW3k1mBuV4A5Ab+95iqiAvkjFxqIQZ/
	 vxMYZ5Tv+AIDVJNLaW7Uib9IRYrJIolnuyNwlfBoDoXSKAqSK5CdGk5QTrK3fitSv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RDuE7dhM;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658560A4AE1
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 13:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C658560A4AE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RDuE7dhM
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so692015f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676644; x=1793281444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGum0Dhauevbw3Uwf/HnryttWD3FBap3x0GWqK5kUvw=;
        b=RDuE7dhMDt1vV9VLy12Ek2t7MzQ+oYNV07RvBAd8r1kjlXbCDVxyLhJNy5Q6rPNH+M
         w87bO61Ixv3pZoLJuOR6TLEBQNdCOdDVR1h3h3pOM/OkBhz8Grs2doXeUmuO2vZCYs0O
         c5utiXuvyfxxOSOsItpycomUxvIOnNDEshoXG8F+S87tooFO+4bDyiZZC8PgLWuI9CDd
         cqHPFLb25X1GqhWVYkkUazlb3GkOOXT2PxOlrvyOP+LgXeSTwOEMvT5j5B7MWosfqP7R
         5GN5M8+Ox0aiHXkw0nz82TKxL4bi9iqJANtd3AlqaSn82uJFBYAcwl/7WTZavtSkJE9q
         5FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676644; x=1793281444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGum0Dhauevbw3Uwf/HnryttWD3FBap3x0GWqK5kUvw=;
        b=w/0Y+Y2wAUC95+VS8ZBncg+2h7xqE2ox3k34LGf4SFtUPKl+jhvptS8+oB/GpjSTaz
         jhkJAoq2pD0MKPlBVB1uBcKP/QkpDLyDu+QjrGwhS77Wwk/aKVn2z6XG5FqhyJVnvRWU
         hHIvu2foL9tS2uXC5W0YRVCr+CDYBx5mDkMv6PEIB+Naz84Nz7y+zgCBO2P2bMPqVRmX
         TsRzcBGPYNeNXgv9+/2NuOkbXQrElqI8oG1YFoVf/pJzltAA9Gsw8k4TYNaXNeDqiX/0
         IEVA0GgxvAi5lBRsDDgBBhzlqeOepD2Z3EyadBgNvTtEt26LgjRo2XsI12CLlU+xglw2
         d0gw==
X-Forwarded-Encrypted: i=1; AKwUvBzi0x6fkgFYkkUzSzyIm5p1dpaTyePPd8Mnyk6vd40AkteXXYxJQUWb+JR4cmkTH/6c6aYP7hrzCXpWaEctBA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKC1M62VIFefR3SoMgGjRELCp/qkqjQL/3p7KIcxoYjNucpOd5W
	8yAJoOw4efJRUUSbBR/8nr8WmZl20RbEnq8XQ3yuQY8LMWfFSRxzxaev
X-Gm-Gg: AYBFou0QwkMzOD+JeCVFFAu8CYE3fMzAwZomrJX3i+HBK8bXUCeMTwwEjilQwb038iB
	pbIQ5Mj4SRhNIlzn4PanwqDgJCAP3HAzf6jq8ROfqFkbjDjokYDEyuPc9DzdoM++dOFjqnve5GT
	LqSC9PqrXr982mxbDgv3uiDUyDN9cCzrpiJ/ociJDE4c41+C+ErYVk70ReIF4I0GSvKknHsvozS
	sSVywgqPwCmAdhq05E4x8vQv1pnLItk+thnL0iY/oez3qDo5/EblLWkAHd4Jno+/oA2HGOAuIcV
	Ed5a0GvANdFzWBtIzjJ+6jONzXo+rC87ntNqRC65cZpWJ+uHvRy6+Zd8atgnRwig/Swcz91gTHk
	Iu9+KhcXdkyVxk5sYjqcrdfoHgCky0UBgMAwzjkmnWTkjRF2ZJ0sob+JxuYX8arzGVi/AZun30q
	+XQVwHR7Ed5wi4b3atm3nn6W5qlgZ+yGO8y9422hi9pH73/Occ9xW4+Ag4bKkxmuBLUttEXP+NQ
	EXLvUkrpQUOK+zECdnRA0TD8YQtCUJ1zskdP/DFZ3N3P99bc1Ol2wsBKQ==
X-Received: by 2002:a05:6000:22c7:b0:48d:f852:c66b with SMTP id ffacd0b85a97d-48e2d26b3dfmr5786135f8f.22.1792676644028;
        Thu, 22 Oct 2026 06:44:04 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm13621390f8f.40.2026.10.22.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:44:03 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] watchdog: dw_wdt: clean up error paths in resume function
Date: Thu, 22 Oct 2026 16:43:51 +0300
Message-ID: <20261022134354.534642-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134354.534642-1-a.shimko.dev@gmail.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up of dw_wdt_resume() function.

Rework the error handling to use properly named labels that match the
cleanup order. Use unprepare_clk for clock disable and unprepare_pclk
for pclk disable path.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index ec6a09673da4..11caf40d6771 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -393,16 +393,15 @@ static int dw_wdt_suspend(struct device *dev)
 static int dw_wdt_resume(struct device *dev)
 {
 	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
-	int err = clk_prepare_enable(dw_wdt->clk);
+	int err;
 
+	err = clk_prepare_enable(dw_wdt->clk);
 	if (err)
 		return err;
 
 	err = clk_prepare_enable(dw_wdt->pclk);
-	if (err) {
-		clk_disable_unprepare(dw_wdt->clk);
-		return err;
-	}
+	if (err)
+		goto unprepare_clk;
 
 	err = reset_control_deassert(dw_wdt->rst);
 	if (err)
@@ -417,6 +416,7 @@ static int dw_wdt_resume(struct device *dev)
 
 unprepare_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
+unprepare_clk:
 	clk_disable_unprepare(dw_wdt->clk);
 
 	return err;
-- 
2.43.0

