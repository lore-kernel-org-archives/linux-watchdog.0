Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E5352016
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773607; cv=none; b=PY/CDMaK0cGMIh0+yJX7ucRtNUKYijyVjScmIHgitITbqdeU1GXC69J6aLSoMCCro73aKoOjwQBJUZw8LVKQIjWHZVA0zZ13EKCAXoZLbPK3sVzejtjobTPu4J7dBccNVGZhcpdfrSPBr3h3aKANZP/Ve4aZ/5jERuBloxX2xqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773607; c=relaxed/simple;
	bh=rXHgfAoAlRJNqO01tv1FVpBejjD5IsknO2sNv306WQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxqLRqEEEIavg2ZZWl8nwK5uAombwVJvzFglgOuBdeuK6kfxhmycDa2BC+2PzovRFIRSrAVQ0yvv1jZ2OJ40RUrenIp31fSslR7wvx4PNx2aUT9Gc26rxzot6wrkdmD0YhIPaGdgWdl2uqYjp5ygsloWilrQVJidzKjFSvKAUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIdQv2dI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIdQv2dI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so1356795ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784773604; x=1785378404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYun2sAk1Ltg3bxA8Zb4DCt+DIxSBg3GkrvAhMpsGp0=;
        b=CIdQv2dImlRf0tsLAYNG5hLQ8vPReLgagm3gNbDxCv6vNHkj+uI+yMKWMh3nrIXqMP
         SNHw+ytss8skH9qLCK0i8NW9qSexVH6TAfbiW+Nb5fBAyFPKl0EKK8itEDt7VV9LJQ5f
         ZNip2nzQmTjs3g+Im4Gjgqdpmg4ZOsKWPLBr8iwuQh94lJLkcBEG6aUV25cuggextdeT
         2yQPATyyZbrPRDNxIYE8URwYs3eD6g6dVmJzGtgc82i+ZSHrT1GxiyKLESaSzU1Z+OKt
         il/YMssvcWUDYJ8UP70tIXtH+zhybBKoCXse+FTGxaHcn9zf/X24vtriRW1kT7JPvdk5
         h4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773604; x=1785378404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYun2sAk1Ltg3bxA8Zb4DCt+DIxSBg3GkrvAhMpsGp0=;
        b=KxfS7I8+3t0Gp5CVn1dI5gE4GZTPtUhWAe9dZP/lSGB3++tmd3Kdimio65GjKkZc46
         mVNO/L74Zf2JV35oi9phsJGSrinQq0yM8tMXvKt9zXKOx9bBEK6tS2yXwSlwLERubP3X
         kIMpu9tvXLE4saD9jBqYfDsJV5XLA8Rlb+UWSuBE6/Gyp86e6Cbp3fbVcQESmGhVKa5f
         Jf6uo0yftxW0ayEq76u5S9IpO7+l590bhAJ7wE686vTEOR26It+st5rPp7KADT0BaO8T
         ZUnKrVVlzzRt+Dfms71RKYeNCg9tV2z1OmtRNBEgowxop7/3hDc1RVdbtZINGZ/kC6NC
         Hcpg==
X-Gm-Message-State: AOJu0YyrAXJqzccKtykOGbvkWtJWPgvXLOsTpa7KnoWPE8zxu6V9vy7H
	1CJ6KD3M1qzRVBpRT1D6WiAUqPAN7fmG6OIQiy4jcKrdbdTL/rjwkms=
X-Gm-Gg: AR+sD11/5rmsGo6bh8mTaEgB/4GmkZDIS5H8CDlkK4ONBfSo/zBlQZ/rTZWszMoPFgN
	aY1hX228GKaeeJcdxKJkUBv/faZueUxweV3WIL3Q6Ob87JqTWiw53GQCRijNeFmEzFGFhEWHvq7
	HzsCsB9SrPmeRfLogY2mEr6+BkPqycb/i9jVhI7yPrLc2LInKEOUKGPGUs6YQHygH0ubrX/2F/K
	sx2Xlp9LKxMbzrDsqjLPz2294QW1GBVTUxX76Z3SFhJqh5cqdMQD1Nxl+nE/ypEHRWUkdGerHko
	mASTIp2UptWdEPZv0mfjPNNZbB1nSO/FqT2B+llfF8NDpQhJMe8IesIlIEW1Jb6N+DQB4eLMUrx
	rHs4ICQLofwXIAf6VQush0JRAmgGqEme8zGEJrEswEhNwXcMgV+F4r0ECOdSzbZlCa3DIbRB5SE
	/5WKpepg1nRm1l6LtfO2Qi9qK3xfvAAI5iD8E=
X-Received: by 2002:a17:903:3c44:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2cfa6c5e315mr15614105ad.24.1784773603684;
        Wed, 22 Jul 2026 19:26:43 -0700 (PDT)
Received: from t-rex ([2401:4900:addc:f847:290:7ec:f519:db36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc7d8fbsm15273195eec.10.2026.07.22.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:26:43 -0700 (PDT)
From: kr494167@gmail.com
To: linux@roeck-us.net,
	wim@linux-watchdog.org,
	cl634@andestech.com
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH v2] watchdog: atcwdt200: fix return value when watchdog is enabled
Date: Thu, 23 Jul 2026 07:56:34 +0530
Message-ID: <20260723022634.8642-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

atcwdt_get_int_timer_type() returned TMR_UNKNOWN (enum value 3) when
CTRL_WDT_EN was set in the control register.

Because atcwdt_probe() checks "ret = atcwdt_get_int_timer_type(drv_data);
if (ret) return ret;", returning TMR_UNKNOWN caused probe() to return 3
instead of a valid negative error code.

Fix this by returning -EBUSY via dev_err_probe() when the watchdog is
already enabled and update the kernel-doc description accordingly.

Fixes: e4e0848ad046 ("watchdog: atcwdt200: Add driver for Andes ATCWDT200")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/watchdog/atcwdt200_wdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
index 8e3b18aea368..7e757c217b0b 100644
--- a/drivers/watchdog/atcwdt200_wdt.c
+++ b/drivers/watchdog/atcwdt200_wdt.c
@@ -260,9 +260,9 @@ static void atcwdt_get_timeout_params(struct atcwdt_drv *drv_data,
  * register to determine the interrupt timer type supported by the hardware.
  *
  * Note: This function must only be called when the ATCWDT200 watchdog is
- * disabled. If the watchdog is enabled, this function returns TMR_UNKNOWN.
+ * disabled. If the watchdog is enabled, this function returns -EBUSY.
  *
- * Returns: The interrupt timer type supported by the hardware.
+ * Returns: 0 on success or negative error code on failure.
  */
 static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
 {
@@ -274,7 +274,8 @@ static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
 	regmap_read(drv_data->regmap, REG_CTRL, &val);
 	if (val & CTRL_WDT_EN) {
 		spin_unlock(&drv_data->lock);
-		return TMR_UNKNOWN;
+		return dev_err_probe(dev, -EBUSY,
+				     "Watchdog is enabled, cannot detect timer type\n");
 	}
 
 	/*
-- 
2.55.0

