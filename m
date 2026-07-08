Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C063B9D9B
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488342; cv=none; b=KrbpPtZakqf5X1Ca8/KhKc0JjoizcuVsKYsC+NyEpt+kVt1Pi0K92eGy8Dr5rKpVmO+W08YC3uI5TeCMlqdc7plsBVwBSf8T+tsSEHJVoSILX3Zt/2cvgv4liH8DnHXr1mjUgtCvoUrZ2xOqWqT7qhGZI47VTKFZVZn0ecZfzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488342; c=relaxed/simple;
	bh=uD2eHmsAXDNgN2JcJNb++3ee6aQax+t1blS5oQsjPFs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j0OH1o4NxAwWiqfb9Dg0caBk3FzDpQCWTCXR/d+L5LPmr4MsxIONnZSA1xKPg67JFqBKvozPmnhKJ0hBXPawARpopgNUpY1rqtF8TwH18pq6vX9afm6jqAkymz9dbR4Eqv+RPGpsuU3oqkbufpYaFaVxaSnw6Gw8o6XVhXAVWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEkWDUtC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEkWDUtC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8478a25f268so188265b3a.2
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Jul 2026 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488340; x=1784093140; darn=vger.kernel.org;
        h=mime-version:content-type:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCJbRYM03Zdue9mTOhEjBMPBbpypEGh2oBDW7dTU2ME=;
        b=VEkWDUtCl82T6t/TaTkh1aSurwKcs3BkeU42kzi5708Q5RLQCa+R+VZCgBk/Pflytf
         75MIT82EdrGFxU5skgz09Qv4oz7EMTqovXXbk0nmnajlaDxNvZ18c9WzIQcM8gVUQrmg
         II3CLy+9inN2QE34m+y84jnVjQTdC5mfbjOczqACnWS96afCi0yiuHOe27e2SgoFMjlT
         Bv5TQFJzn5o7PL5SneTqWFWDbTLxeBq44GcE2m3nVycn5BHIhqWsGxsw+Ey5h/nTxsb6
         3ILv5izUBosKk9XsAlqqNRRWvM2dhzGpXSwdNvbdYVBmW3JZH48iCZ056W6E4Oys+HkR
         29NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488340; x=1784093140;
        h=mime-version:content-type:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mCJbRYM03Zdue9mTOhEjBMPBbpypEGh2oBDW7dTU2ME=;
        b=DSv+EVuZFFl4PKuSRxSuPpHTOAawgfJCi99MShUX+8yBkY8SnpXlaZtKXBLP22GwQ4
         sdeyi7iyI9U/lvL2U57spWimbFUsWr0lr07NzhZe6Q5lmaL5+T3Ps7/JITqSyb8Q0ZQu
         63pvlUz5ZJFL+8RzPsmBJSFL/+x2pIhKVbYIfB8Fgr2NWgSZjAgrD2Z1oHv2SPu5AenW
         iZo65xpxGWxIE18wkBmaLUTAffc0aN6240bPyH8+YevnYFGAmt7amczdPCoR4a+oAaeZ
         /0AEg1Yrv28FMaQuZtYQtijgBJV9hXwwoioTCa2XV3yQQkmud30M7M3VTLTmSTGKijfw
         5uZA==
X-Forwarded-Encrypted: i=1; AHgh+RrsiU9ruYMN7vR43sL2HTurRWOGgo2bujAUEgRzNpEgKmHd4I6X9a72snGz+O9pwH0DPhQA6UFc4/IMyRgqGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhbOvOBYc1TkSZjDiEVrDm6yH2aeT6V2LFIsJ6ZIDGhRtZnvm0
	U9fMdBRpcO6nSMKC3OMfzKyWbzI9wIFkJBWvwb99AuelueeaIJbjgAdj
X-Gm-Gg: AfdE7cnvO0kepa/s/vwRDK8sYogGdBIb35k4//+yhzGpw90MKP4MY3XkmlJv2QmAXp9
	g54EEfzvRL2LY1Vxq4iTIJA1zsskVPiJuw2HL6FilXkQ/Im1DKaI/glwapWrGEax3dR2u1yDNaU
	MLnnxb0zUYGP5V3P/OLxVvvuO1nYy4pMuSYAvKP/umclCuIyZNJhqINNddqR/Zt+YG94yN/b6Ju
	b7VD5e6tZNSuG4y2RtlyYvMCcbNyqbIthmZ8MDGQuWrG34qj+vZjooy/yyjjNpx9x4WXXrmLew3
	C+HI7rRfvZAlCfynQQZcJRccmaTiGbAgJz+aOwNqX7fOYzDlbfKUkcmPQ6D6y9ppXfCBDIcCbmw
	EFbgY7tQ8xUi8Bhsfrbsa0QbAbCbEYdEhSF89AVkKpArW12nbkrH9oCR/k+fsaxdkuUp9dSFeF1
	TIHmf3/w==
X-Received: by 2002:a05:6a00:92a8:b0:848:2f74:d8d1 with SMTP id d2e1a72fcca58-84842fffea9mr1139737b3a.66.1783488340226;
        Tue, 07 Jul 2026 22:25:40 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm6445810b3a.61.2026.07.07.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:25:39 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Christian Marangi <ansuelsmth@gmail.com>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: airoha: validate heartbeat module parameter
Date: Wed, 8 Jul 2026 13:24:37 +0800
Message-ID: <178348833669.86438.10575372757097263872@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The probe function directly assigns the heartbeat module parameter to
wdog_dev->timeout without any validation. If heartbeat exceeds
max_timeout, the product timeout * wdt_freq (computed in
airoha_wdt_start()) can overflow the 32-bit WDT_TIMER_LOAD_VALUE
register, causing the watchdog to expire immediately and reboot the
system.

Fix by using watchdog_init_timeout() which validates the timeout
against [min_timeout, max_timeout] range, and falls back to the
device tree "timeout-sec" property if the module parameter is invalid.

Fixes: 3cf67f3769b8 ("watchdog: Add support for Airoha EN7851 watchdog")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/watchdog/airoha_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/airoha_wdt.c b/drivers/watchdog/airoha_wdt.c
index dc8ca11c14d8..67160d760d84 100644
--- a/drivers/watchdog/airoha_wdt.c
+++ b/drivers/watchdog/airoha_wdt.c
@@ -150,13 +150,13 @@ static int airoha_wdt_probe(struct platform_device *pdev)
 
 	/* Initialize struct watchdog device */
 	wdog_dev = &airoha_wdt->wdog_dev;
-	wdog_dev->timeout = heartbeat;
 	wdog_dev->info = &airoha_wdt_info;
 	wdog_dev->ops = &airoha_wdt_ops;
 	/* Bus 300MHz, watchdog 150MHz, 28 seconds */
 	wdog_dev->max_timeout = FIELD_MAX(WDT_TIMER_VAL) / airoha_wdt->wdt_freq;
 	wdog_dev->parent = dev;
 
+	watchdog_init_timeout(wdog_dev, heartbeat, dev);
 	watchdog_set_drvdata(wdog_dev, airoha_wdt);
 	watchdog_set_nowayout(wdog_dev, nowayout);
 	watchdog_stop_on_unregister(wdog_dev);
-- 
2.51.0


