Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097313BB9E3
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015003; cv=none; b=pzK2gy5MgyopBTa+CWjOB0ADdOqkt0qkMyFju9yHRiAEDXWgJ5cXGg2ZsJYPZYfiTaAKlNe35KtVVqgkCaA4pspXoxrqZBtb+qpuOWV8mVMX9zBo+X0xjmHD7VlkdyNZuV4lvcD/q3IXErt0RW79seMlovMQeg7SKNQ6vh/n49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015003; c=relaxed/simple;
	bh=7FaE8VdJnohhvqgqFNEK8NlmDgIwt88sxl+bn8YaTsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNT+sFjPsd7iZrZqKFATqaAZHKXMlp/vizmECjxrmIDJEyNF8zBGcP3kYzAZMXlrS6/ouUiBr3MsxxPQy17zhdMgW/3IbvBQhzQGcfk+LbYsk/01g1chbnb02BZDDpu6wAXgFVpu6bHJRLCEtXMRvlErUsJp5Tj35jKpjMv23mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAbIAD0P; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAbIAD0P"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38bf47a6f02so10408051fa.3
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014993; x=1774619793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmpUwafDPJ08vdYxVnIzsE+y/e7zfyVKAjb4p4prvRw=;
        b=VAbIAD0P0F52L0i1q3BfIgS15rlt1RZOqZyR/e4wQTd+yoifrvu2zJ8lnl1vXhY5qp
         sKkik2gT02El1FFMR83Ic0ZSrtypx/U7TNurKz3WwuKEMMgJszwihfODSYAvtF+jP88Q
         RdIfdSVEcWXMrRuysP8/Fe7glJX4Zdh24An8BDpc0bvUINmJTriZHrFZz6zfCcO2HJdS
         9/Rwp4ctyhBLbRO2rD2R07WUZ+ABiSatd3VRgsPsSEmD1DMDwkWWduXkx9/cz9NV/vQa
         YTyETs7o7jXPv2Sp6Vvrt0sDP5Flxxw/cOZzpFvh15TOIf3BTZfAmfWFg/brkrEpsBvf
         26tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014993; x=1774619793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmpUwafDPJ08vdYxVnIzsE+y/e7zfyVKAjb4p4prvRw=;
        b=koKM1Xyzi1HWUSepmCql1LNn8+FA0A9cSiibYaeXek37h4pHngP0LbqtTfkkiv/CTz
         Sd3+/4IWNSJMeyXFZyBWZoPeptWHB0o/agGfFnKUSYnpa2RbJquP2jFP2n6BB6nYZO9o
         yg5XHleawPf/XvgGVmwAu9g3JLlhfNbHTZ7oflRiwvv6K8Ogi2YMkK6P1oQqaRzkeYkd
         ZVjAoYQo+VnVZ5kniHJEyDbu+D/FZneI8cDUNJLxssF1B/Aksfygw5ZIELlenjww/e9p
         YjLf9ix9BQ/kQZe54hWiGuVAb6hhZQHTHDJVzgUANwIVYB6kVPXyVQ4kXbFu4OvYm9Al
         7lFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNglnWdqKG9lZ+vFhog8IJTyfL+JEf2Q5YL4jsQP8+R0M56NioAxym/RyB2UTuhlQ7uFkx9RsixnjreUlcyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRHfyizAaZfmui43udu6JrqR5tsXZHt4/jvRKz/lwPWnsgQUR
	GTvba4Sf+SPBO/6eEBTqFsQqqiq3sOOiB4wyEYEOyBWY2V33Fpe+r9Qs
X-Gm-Gg: ATEYQzwAE06GIDtR/B4zI7BEfRvKPypj5rUbwUxyrf0XuCJjuv43PeVaYzEISIQK2Or
	Q0uMIUdVfEf1zD6MC2Qha+HC+VhgPn7nVQtQH18Olo4irEf8wS05QRcUzh2hINi4+Vj5wSkxr9g
	ddTuwto+NBtv5RW9EUZVrFBAqksWe01Ha29Z2VNXQzPOMhukXm5HZ48e5nEjOeFNg9CGnA71ZmM
	BL8eziOAXHzH51WRQe5zvv/FtXdOyB9REPiWht62dqvtCOjvE+HYf2uyyHlNLUe257SNLdRG+P4
	Ts3ROlxXMS1H0RwgdFTORhPD1ydvYX3XGwQM2q8Pog87xAc29So3PON7QWvMUVRu4SqmqE4XA2D
	ZJUPG0XAO+bcXwVVoldxl+xJzYQHeE1+DuCRsmlLBXzlouAbMT5pCd8vTYI7lKezc9hAm1J8O5m
	V3z8uSD4opUQhXJbp7KFLc+ozGiuQInLqs92BzTG035w==
X-Received: by 2002:a2e:9dd5:0:b0:38b:f49c:8679 with SMTP id 38308e7fff4ca-38bf970c3e6mr7917541fa.31.1774014992823;
        Fri, 20 Mar 2026 06:56:32 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:32 -0700 (PDT)
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
Subject: [PATCH 4/5] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Fri, 20 Mar 2026 16:56:21 +0300
Message-ID: <20260320135624.223863-5-a.shimko.dev@gmail.com>
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

The watchdog controller reset line is not currently managed during system
suspend/resume. This can lead to an inconsistent hardware state when
resuming from suspend, as the controller may not be properly reinitialized.

Assert the reset line before disabling clocks during suspend to ensure
the controller is held in reset while power is gated. During resume,
deassert the reset after clocks are enabled and before restoring register
state to guarantee the controller is properly initialized. Add proper
error handling for reset control operations during resume with appropriate
cleanup path on failure.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 27b5098832d5..c2c5dc6e54e7 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -382,6 +382,8 @@ static int dw_wdt_suspend(struct device *dev)
 	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 
+	reset_control_assert(dw_wdt->rst);
+
 	clk_disable_unprepare(dw_wdt->pclk);
 	clk_disable_unprepare(dw_wdt->clk);
 
@@ -402,12 +404,22 @@ static int dw_wdt_resume(struct device *dev)
 		return err;
 	}
 
+	err = reset_control_deassert(dw_wdt->rst);
+	if (err)
+		goto unprepare_pclk;
+
 	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 
 	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
+
+unprepare_clk:
+	clk_disable_unprepare(dw_wdt->pclk);
+	clk_disable_unprepare(dw_wdt->clk);
+
+	return err;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
-- 
2.43.0

