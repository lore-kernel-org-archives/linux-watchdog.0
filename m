Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C539989D
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479330; cv=none; b=iwDjvPtymL+70Luiu3i75BAf+jcBL5XizbVGb4buRKPQKnGxXaViKeK5E64afhA52S8l0ddgat3ffJpLA9BTNjSG4ax5J1PAN1oYqt+4OajXSVvtWbIR18azL+nkmZPpf/tKvK/zjIN0DmZxSkpjMXbj9W+Z49SHzDUaZJix/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479330; c=relaxed/simple;
	bh=XdXbxzYOyRL9BMXBoZ9hBoRMRpmsTwclUCDp8/IFa0U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tn6ElqcSwQQCAayrMsyd7k57Eru0ysEF89dN4iEzP3Xsz3qlCot+h+fiosxcUmyE9u1Dhd53GAVY7C/cz+mHA6XXOSw6qPu/6x0m7/yqfG8X6FJdcLIGfPY36LY0OPcH1PHqSSTyDgH81JVvCdmp1N4GD1HvzlVTzkou5bzkiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRpK0B08; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRpK0B08"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7c61b5292so4498745ad.0
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Jul 2026 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479329; x=1784084129; darn=vger.kernel.org;
        h=mime-version:content-type:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GPT8b76Shosej/KjvNS2NPoD6NlNLwF/hXEZPW50eNk=;
        b=TRpK0B08b8nhHMIYb1UVmRsO7piglmq+Y4oAlDJ40A/xU2Ku9fpnN4Zy7UrcqLVSi2
         FaMMwHPlXyykxlCcUcwFPg8QfVwVZZmg/GxxqiulqJxtNOGsdc1TsW8yByaotCcYZ7V1
         ychdZc55jlhv/ulE7OsYV9ZRo0e+b8qzFyjVXyXI2D4MzWVFklaV8WNywJc6++MgY33A
         cPfbwIdkRUOXqPR6NNmBXuIeJN5QkYj3izauJaXv2XGB2k7WN2OIy3wKe+w/M/LgM6rh
         OZTU7cNYFOV7NNa1T07SGI3KuLnxEakNK5C4Vd/oHkfFNdoYPnFj1LSihEpYVCXCg0fp
         EEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479329; x=1784084129;
        h=mime-version:content-type:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GPT8b76Shosej/KjvNS2NPoD6NlNLwF/hXEZPW50eNk=;
        b=qCgoHEOJnFfHICh9bdZ8pzPxzC6xrABpsfUlsBqKWM/Ni7Yf942yG9x4Y7wDUy0cnm
         oKcsEbXY9SL1BSHe9Vy2INMLWjq4sSeTlWjvmUJ80s0espYtIVqiJdTPHouUCbCPhYop
         4wi+woFlbRF3GBQAMPhhS1zOFxiJVIk0MJSZb+ebqORc6abAbTUVMjOyJXATTqBbKw9e
         5J8wRFd0bCUAPdp1hEzs4aH3NJJPvVxAqDj8z9jFxFLl4/0LAKdwJ3QjddRoC7lDaaqW
         65HaWEyX9Sx4E435G8dC/O7Ns2dJCDiZd5YwO1ycRP5v2uTTrK7Kt+3+wa/LA6YX2F+d
         rIgA==
X-Gm-Message-State: AOJu0YzM2NpnvHeV6clnpDRiNWCTHF+AVX4PpnwpF7F0dW747Zrq1uSG
	iGuN29w632CVvVE+iZJ72Ev+JJrd4aeWOkXcD+bMeID0uXyvwVzdgQeG
X-Gm-Gg: AfdE7cnGd7ZpW3Swq1nykFkZtskcLEOY4rxF1+RkiUhwP6wUybN0IJbyRUlRJXZFq06
	GJoJsopww8XJ3j168ce3d9eHCOTxSjiBzy+BVpzpoQt/W76wPygpGGXEPJH68GEwErZqewSvLgf
	gRV6uqo02e7fy61mBy1uEWhWlIjZSsKyzAey1JRxeTdaO8gaBqBusHGoKjQ54XdQHVc0Uf8dPLw
	Gly4RjMMTQzZk+YPWHVb4XQIsZr4ZZauKentkum1iNfnLaYAGBSMGmRNapxXTt4WfGFNj9LiNyj
	XZz1oYsZLtwHfZmU1Io5KExYw9/GBiqNtwNj0Q70mMkfykWrACKtXVFjh2y01Vke2Jk+mw4KycR
	6YEv/3YxkYqXzIx8xM0jK+iQCzlUnkt2PrdI0wVHcyQmDoTx9z1bXBsC2YujVq5NctFTWwXCV+b
	rvGohAVQ==
X-Received: by 2002:a17:902:e5c5:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2ccea2cbd6amr6676265ad.14.1783479328950;
        Tue, 07 Jul 2026 19:55:28 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e284sm20325545ad.40.2026.07.07.19.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:55:28 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: airoha: Prevent division by zero when clock frequency is zero
Date: Wed, 8 Jul 2026 10:41:54 +0800
Message-ID: <178347932594.81327.4834644880399144119@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

clk_get_rate() can return 0 when the clock provider is not properly
configured or the clock is unmanaged. The driver uses wdt_freq as a
divisor directly in airoha_wdt_probe() to compute max_timeout and in
airoha_wdt_get_timeleft() to compute the remaining time, which results
in a division by zero.

Add a check for wdt_freq == 0 in probe and return -EINVAL with
dev_err_probe() to prevent the division by zero and provide a
diagnostic message.

Fixes: 3cf67f3769b8 ("watchdog: Add support for Airoha EN7851 watchdog")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/watchdog/airoha_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/airoha_wdt.c b/drivers/watchdog/airoha_wdt.c
index dc8ca11c14d8..4bd333189b87 100644
--- a/drivers/watchdog/airoha_wdt.c
+++ b/drivers/watchdog/airoha_wdt.c
@@ -147,6 +147,9 @@ static int airoha_wdt_probe(struct platform_device *pdev)
 
 	/* Watchdog ticks at half the bus rate */
 	airoha_wdt->wdt_freq = clk_get_rate(bus_clk) / 2;
+	if (!airoha_wdt->wdt_freq)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid clock frequency\n");
 
 	/* Initialize struct watchdog device */
 	wdog_dev = &airoha_wdt->wdog_dev;
-- 
2.51.0


