Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973D34BA20
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533976; cv=none; b=iTKde5FREBpCPUj88Za/8CMgEy7lINLUpDDag4FprIlN8ZF0nnj8JqR4ye1uZfZBQqNDB+RtYBWj/RMoSLT83eYJ1uXpPvwzQ/Kohp6pTinj8gnFHAadfz5NkpxGP7VMYgOv/gq6HwbQKSkOMfp+xv4NxCSRnLfAmTt3colqtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533976; c=relaxed/simple;
	bh=nWAXK5uGotkCh7I/YPn9AT06dBGqGWgcKjwoUi9dO0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jevouGsL+hbplPntBGPKUXrvno+kIOIfvJnTh+Quc6kNkor0TvVyUXzfROPgF80pH6BVAzk/cUq392aqxn8vz15vrNs1kYdCMomlr35c4Z1UwXTZzgAaAKhTBPafy7KALSU0Z0W3jyXXdhQX9eqnGiz1OhiplxWX25N3rFNhcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKMnSBZT; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKMnSBZT"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so4614255ad.1
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789533974; x=1790138774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEXBcYJPnvk5uV+nVCAlRvcg1raCOVIhm5bGvEozAbw=;
        b=EKMnSBZTrZ0jMUZJC1TzmJmLP/O5mGlao9vASrMvfWJUAMwT5mwwfxCd83ewx0hn9Z
         N3+SwKCrxEyjKAbFUivtm0Q8sT+oPzcLIwwRZK2i9zghl2m0SgXYBFel3PlLhNvjno93
         tRpyxJr6KVIUo9ojR2mGzV4F39Yxp+U0YZmhugTX9hNPmsuw1UZZluNfOYp/F9o8yuw8
         ACFfm3mVP2UaRUXOTfXIRwz6P7rUrOe6b0q851lBoO3Mbm8uS3VPA1S/hDcZwqZvkg4F
         yl7+HZNCo9LbEauCbDlUW271t96jDDsHB8bmMYu/e1Ie4jy+1A178Ma/ZhVn0bjZa0OO
         9Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789533974; x=1790138774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEXBcYJPnvk5uV+nVCAlRvcg1raCOVIhm5bGvEozAbw=;
        b=OBkO+Xk3h+316Pf/g59hSEOBxJ5A02KR/T6xdKVjRUIpiib4JoaMFlJoqVQK8L+EDf
         9TEAaBsHym8fEgF48+5Zh4sc7eGWdQVuO/OyD8HE7lWQYpvkWTA8KjkV/aUDgmrolg/K
         tkJz96qDFJLUa9Ad8KD/Vv8SWX2WKxc3iBFmN0yJuBd0INz+Zdj+VnGhbF//i5x9Evia
         D8WrXUVh68P+L2ynjt5qA73oY9MPZn2XwLV6D1ypyZxE70grkUkKKb3ze6V3KC1xMhlR
         l7e4y2Z/hp4JdtNDF8o+3qMPySy/ug7itI/euLjOdEl5NwAFuni8LpL2oVq4JE8OsXNC
         TZDA==
X-Gm-Message-State: AFuF++k/lC8zKyuMeq1knbOvhNPAa7YMHAI1mJ7HzCvD5YjJMqo1Swf3
	PCHRPjT0TlLy2VxuP+ccg/y/0DL1QOXupawwjHvooCg30Te7QJH/7aA=
X-Gm-Gg: AYBFou1+h44q1NwhodoRBSyZlb85FXdfukx54k8ncBloFqikt6jnqHE0nz1K0CHaQCx
	cEUXoJ9GQB8GsG8emnU8cTm7ZIpJ+PFVS27a84a4cp9fsRALjq6UUC8eAVeEg1WN6vQYQu5Q80a
	kCKFEJn7H9c1MnNcXA4WiqaVVOWTsMkcf1eLqc1ijuWGMoKp73esg4pIRtmjnDQZHSv2MtPwITW
	AKbmxKXw6NOLtfNPsigB0u/Ti04DAONN8kk6rcYyD2ag4+1Ou7TYJPBQuxcWDd5IiY4ACB3xUfT
	qZj32SG+VFizQZRSUrSVkhdoIc1W4u2jF7dTxvUG7aUFLHKzSw9QhLFnxqRXZDr4fjfCLWPxI6m
	Gw7t+iSfKibca7HOFd3aweob3XMH9h2rmkrwEpXaMdo+Z2+rerToqB/ZG+YknqmHzf4oTibqBUC
	BL1987zSdyh+L0/5ZO7qyChjnNFJvWviYtYaXjW+eVRCEgLYIPwOiaJxmq4YiDj0CesI0EPi+WG
	+sbQy5DiXOz
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39e1e504f3fmr3291211a91.20.1789533973937;
        Tue, 15 Sep 2026 21:46:13 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bba0696sm2232093a91.7.2026.09.15.21.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:46:13 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sashiko-bot@kernel.org
Cc: linux-watchdog@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	tzungbi@kernel.org
Subject: Re: [PATCH v3] watchdog: msc313e: Propagate error code in resume()
Date: Wed, 16 Sep 2026 11:45:57 +0700
Message-ID: <20260916044557.74124-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912164221.966851F00893@smtp.kernel.org>
References: <20260912164221.966851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sat, 12 Sep 2026 16:42:21 +0000 Sashiko wrote:

> [Severity: High]
> This is a pre-existing issue, but does leaving the watchdog framework state
> flags intact when the clock fails to enable cause a system crash?
> 
> If msc313e_wdt_start() fails, the clock remains disabled, but WDOG_ACTIVE
> and WDOG_HW_RUNNING are still set. The Linux PM core ignores device resume 
> errors and proceeds with system resume.
> 
> The watchdog core's PM notifier then calls watchdog_dev_resume(), which
> immediately invokes msc313e_wdt_ping(). This unconditionally writes to a 
> memory-mapped register:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_ping() {
> 	...
> 	writew(1, priv->base + REG_WDT_CLR);
> 	return 0;
> }
> 
> Can accessing these registers with the bus clock disabled on this platform 
> trigger a synchronous external bus abort and a kernel panic?
> 
> Additionally, a subsequent stop operation unconditionally disables the clock:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_stop() {
> 	...
> 	writew(0, priv->base + REG_WDT_CLR);
> 	clk_disable_unprepare(priv->clk);
> 	return 0;
> }
> 
> Since the clock enable previously failed, would this extra 
> clk_disable_unprepare() cause a clock reference count underflow warning?

Hi Tzung-Bi,

I think we can address the problem Sashiko mentioned by making the clock ownership 
explicit in the driver.

If msc313e_wdt_start() fails to enable the clock, the driver should not subsequently access
the watchdog registers or call clk_disable_unprepare() as if the clock had been successfully enabled.
In particular, we can track whether the clock was successfully acquired and make ping() and stop()
operate only when the clock is enabled.

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 4a5cce2a16b1..437b8ace0a00 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -29,6 +29,7 @@ struct msc313e_wdt_priv {
        void __iomem *base;
        struct watchdog_device wdev;
        struct clk *clk;
+       bool clk_enabled;
 };
 
 static u32 msc313e_wdt_get_hw_timeout(struct msc313e_wdt_priv *priv)
@@ -60,6 +61,7 @@ static int msc313e_wdt_start(struct watchdog_device *wdev)
        if (err)
                return err;
 
+       priv->clk_enabled = true;
        msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
        return 0;
 }
@@ -68,6 +70,9 @@ static int msc313e_wdt_ping(struct watchdog_device *wdev)
 {
        struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
+       if (!priv->clk_enabled)
+               return -EIO;
+
        writew(1, priv->base + REG_WDT_CLR);
        return 0;
 }
@@ -79,7 +84,10 @@ static int msc313e_wdt_stop(struct watchdog_device *wdev)
        writew(0, priv->base + REG_WDT_MAX_PRD_L);
        writew(0, priv->base + REG_WDT_MAX_PRD_H);
        writew(0, priv->base + REG_WDT_CLR);
-       clk_disable_unprepare(priv->clk);
+       if (priv->clk_enabled) {
+               clk_disable_unprepare(priv->clk);
+               priv->clk_enabled = false;
+       }
        return 0;
 }

How do you think about this idea?

BR,
Triet
