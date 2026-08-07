Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE5455173
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090639; cv=none; b=ZiGldDBbUlFAye/+sb/X7PKPdRnibIQgF9jkwwUfOpPFkDHX3UljkHDVfJrN7WsDbtJx+/6MuQkaXBLrRQLbqF8niNhh2pUyK8TqFWxgfYEpy4l+qGe1GaVwUcbzsw/9OF30Uuu7eOKfblQ2bq0Hnmxxo/GiXMhJgE8LEeZ8wSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090639; c=relaxed/simple;
	bh=lKJGpRyWh581Dqnj+3PEzfeC3ZAXZUwu2Hc1iYFreuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxOk+dgIn5yW03Ike2dO8oLYZTx4uifGktz+SHjegL/5jx+Pp0gOdlAk7xEni/ygQarY6RGcVf3a5cLWfnZNKn1qNeddBR3gzRuYprbMigk7F3BjqPMqbpBJxSz8q0GzdpWTx0iJV5tGeifF1ACWSYv1LT6X9OP/drNwBxZ9tzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX0j2CUQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX0j2CUQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so3733737a91.1
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090637; x=1786695437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRtunFUAHa1sE6x3tYfwm8b9CkZHcpqXiGycwufdeh0=;
        b=gX0j2CUQcQp0KYGsc65nICrTD4ONv9Hp10YFwTJYmKkLJlOahV164F2VZ9AH8r3IQe
         AfVqlPKlgIhb40ZBgJsMpa0jUGLLL8xBSaLr998T3X4kfADCIsxWLV6z7CuAxPpTFdE+
         /qC/mnUPT4rJmz7QkXr6xB5C3tQ9zfHP28phncnwIqifzKijkWh+9rwUwzICaXKjyCe+
         vrLkVKmomm3q4YQnK8OOw0pPq0ODjYyjGnyBQScE0RQUhkEjwswzuzJjTkVX9bHfE+4B
         y1VU8ODZ479leqE5X91Ip5cdjBoSI4tLgUDiXC/jbjsv9OTLssao+X5SFC4GGpAI7Yli
         GRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090637; x=1786695437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PRtunFUAHa1sE6x3tYfwm8b9CkZHcpqXiGycwufdeh0=;
        b=tPd9QXSFPeabdenjsp+Op6xKgHaphN5ncND7G6tyWFmjscchJNTH+VA0iXaDAWD6c7
         tdT2ZmfwX8at/Fru3bEbz64onC0GKhqtr6jX2NB0+YFv6ckox3FiiVRKH9bC8js3sImq
         3g0nqgkvU09tYzmWRfeIYMIBH8MLaYfmZ/If3pWOLY6mviXdHQLFpwkYj3AxV4H8oky1
         Z9S2iv/Maqxk6BhPX8xiKSB2GBCOasVV9+vjVrbJ9+8pIpB3vU93NcILo5wObd4umpZU
         RBkaHQFWDx1qNxScj68r4PeM3quhSlV7yhjw07jiNuw9gZfAo8xHJ76QOID8/wLJJYVq
         YdGA==
X-Forwarded-Encrypted: i=1; AHgh+RqPxLN1cYQ/f8sHaW7qqqS/g9E1KaKRxZbk7+D8zbp36/WrGKz0hflXlmhAyPvK1DDWFSLi292u39jozlu3tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx246X+ePzlT2hRWDK6EO9FHOUOaL40nCsPUuFGhXzs+PZ+ZzG8
	qS8YBdFdWQ0iIvtmHGz41RPY/fhCD1/sw1dGZRl/PeBXtg/Rgvbc+f7c
X-Gm-Gg: AR+sD10W2f3FzJqvRqnUruGoXFwLzJJqE56sOftRZcbm4jyt1iMQ/b74Qa0IJonKGz4
	QZ4sjkXBxvVhdXpajo5kj4eUuZf8Kiu51LuKCcGWMMfQVdDZA3l5CzOtP4b3akMgaJePUQEKUXc
	nrK4nq9w33MUWQNyZw+neCE9bxW2kJ6xq6ztEzrd8MxCvgFzImVTHPEdpCvFJdscxQyW6XIEEE6
	dgajsjIwHex+77iBwthHK6bcOPkTjxosCm4PKY28xFov5yR2XFikgk3XgcJjpdeXHO4Z0tdoBlJ
	Z80cz9gpKNqoa9Ynu8qBM9bsSHmh2mT7KEyeqTUCWK8e+scEFd8I9AHeS7xGQtfGb4ypdSeZZ5m
	zAWAzEMAW+XqjaghPx8TKhgojEBbJ8/Sa0AsXYm3Hv2il6G57pdgWvB85b9OWxew7fqNyimEhxW
	VvfvRy70/dZ/+MpjsU9r7wLYY2HMYwrDAjdI5NXRdjR0ysF7KJLPqt4jz9v1JdTFn7+/G1/wxuA
	Vi9iIfAFcoh/zB2mUvSWWe2BW77/F5RC9+GvF5G8IwsvZOCWpuF+xBoRVVXW9n45B2H/YiZIwxd
	Qix6
X-Received: by 2002:a17:90b:3a8d:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-3903c5b9f70mr18650486a91.13.1786090637616;
        Fri, 07 Aug 2026 01:17:17 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:17 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/4] watchdog: dw_wdt: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:51 +0700
Message-ID: <20260807081652.38692-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
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

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c3fbb6068c52..39031445d754 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -611,7 +611,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 		dw_wdt->wdd.info = &dw_wdt_pt_ident;
 	} else {
-		if (ret == -EPROBE_DEFER)
+		if (ret != -ENXIO)
 			return ret;
 
 		dw_wdt->wdd.info = &dw_wdt_ident;
-- 
2.43.0

