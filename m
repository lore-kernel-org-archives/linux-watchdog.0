Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293990;
	b=e1kCuMJlCJAfq7s+cCg16RP2+99EpDa8M8XQqpKYSefdajixMFgIyRcE8459PdqAlrz2
	 j68qFjTQ6b+xC13qknSHxWlcxYgPvnQQslW14zJZ+50PEQxU5gePyONyYhUuyVJS7n7Yp
	 IS1P0IFDjEhesKbSZrIC/7m0WAwld4PgdMjBr2Okfepl+z3GZ8NB5jZHbumBLB+rMiDQb
	 eqpiKeoE4UkovLM3O0xwQa5IZqK6JHKwwSHAmvAlL07p1m6xZNO1wIj6Mnv6M0o9QRTwG
	 bIKKFuipGxrhSjzPYz96AVu1k4OsX+RhQ2NlCjEoYUIFSGrrVVDWtp37pPBQfcqj1YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
	b=2PucU5IGFvd1/l9CJ7mK5r9xg32VwyENZCQfGhOPJNLGpcw6Q9tPpG/0ajXYJ07PMecd
	 7u8LuqK8iC8xxn8Pvb55vKQSjSBIEEto0prf2+zqIOzQTJGTjrVAWa6T91DxJni/R4QFs
	 zDsBAaZk33B7BNw0sdxfHGzp0W39B44uOtKU2UqIFfoC5Nr2qziaRHpjk7Er9YE3x8YSS
	 ybVgegKi6wzB7fMSTH/moXUY8Cj4H7N6wnWQJms7L6MnQeJErW2VCy1NQjGv9XqrcEK+J
	 nOvzG9Iwbb9lXqDBlYiPcFDYFM4aVzAIfGaBe4nwKmQ1dPZ34zVrQ5zAO7+1deEo2Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm3NRQ+h;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79A606A32C
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 20:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E79A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm3NRQ+h
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so858681b3a.3
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293989; x=1795898789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
        b=Cm3NRQ+himgMCRSGF7x3bxAvLJEDq7eK3ClrL11yur+/cYppSjoErValcHG54qVL8q
         KeHUdt3EryIdsjU5vCq+shBOEHWjIByKj5RJn9Riq1/5gX+HSpeaLcl/Izx224bLV9Wu
         x0v6JbKInmHgTxiAwCBsCD7tG4zKR+ZphSvkGUYId3DrHCJ5N8HkP0ZCiDB9f19HsvfR
         krcSoGGZbhHKwgh2xSs+BwgfCC0OsCNMxN0gOjHJvppy/hnIHq2TnQw/wRw6pPEX0s1D
         r8cBbUzeCgNYuX0fqYV6Qkn0HlkfmU4UbtL+/nLKNmnURTYWCWcj/17sbxgV1bjO32oT
         LzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293989; x=1795898789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
        b=HcZ9OJ4bwxP6omYRLXIDk5Mor8u2+YZOlDN+O9KysH4R3n0vjYVTP5krTnmqN65LH3
         y+iliFNQSZfDY2ldy7x4t9IsIGRakvQF/6H1rjg8SXMIARfTGY+AFe1m/2OHlQQK2U4H
         gxhPTAoMmJX56PUIS/F8/sZgtJqHBUXIYQD1gdPSN/HfN9RGpQqHWFgSGWPQq77HnJss
         uTr1m2EJtN0NT93ZQCjKBvc6TH5QeXIqishw5x0VGttk4oONdB1OPDFwP2eOWzDHe9FV
         M1WPn2pN0XQ07HZQgaU9Z9KgzoMoDBIJxEkJIyRCROO2Be4Qz3NiPLlXJKsCnvCdlYRW
         fTpQ==
X-Gm-Message-State: APuU4Z9HvkVA90gEnPHc39MO8dLTVpOVyWrkosetj3B6l/JjBEaXegjh
	DcfrHCqLe12w0owUuicnZz9spTFw5ectKQR0sfnwSx7tPgXzsbyw/v/aFQV/kK4n320=
X-Gm-Gg: AZFdTZeGQAR1HIgMlEiQzIVEupEqhHXe8JXB12wQDXpkq/GQqjx7UI2FbwbBDQYU5Oy
	H4p1wsNkRDJ8SAGB4x8TktiNuD3qNskZIFyH1FVMZRKnXmi6I+FfLR/fKj3/3yBfov+Tys4tM2U
	YntPjzG1LaeEH1xoWK83nd8rvUEMwJxn1f22IJ/nfPJWMp6Fr9MGvv4bqsBKv07/iip6V//Xhv1
	Ed5zBk1aFsAibEWNH9zz4l4vmPrYBiw2RwcT5AFk7KcRmfkx1YqdzmAKh9wvDMlVP1u0tx7ESka
	8DkcSveMCU4qvIt9qwXFXXyYCSA97u/55EghMT6Q5qKEOI7KP4kc8nuP0/7urYsJaxB8WBjulgz
	jI9rjM9+jn8z88jttSjUgAzUQJknoeOe0F5asaJScIiEsAw/3DtiZotKV76eMaETYNRPZ2f7tq4
	3dgZzlm9kFw1h7R+DLS2BRK1Wt7JrvD3XkQ5OIf19Hog4YRo6US2xJZ8rqQEE7EQO1wdWc2aP0e
	/diPPHmmDBbsqvIoYWwRNq/jL6hV1B9cnqjFB81DN/EgwjQNIjKFj8IAygouFfI2iBAoSRbUAN9
	xLoHxBMmSnrNl5N7PvJkkcUdgiuBRCFgJu1rJ/BTKFB603MHEpkc
X-Received: by 2002:a05:6a00:2ea5:b0:873:e3b4:5d4 with SMTP id d2e1a72fcca58-8c8793b8d04mr6434190b3a.2.1795293989190;
        Sat, 21 Nov 2026 12:46:29 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm3091141b3a.11.2026.11.21.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:28 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jongsung Kim <neidhard.kim@lge.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: sp805: re-enable the clock in the restart handler
Date: Sun, 22 Nov 2026 04:45:25 +0800
Message-ID: <20261121204528.2435533-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

wdt_restart() fail to reboot the system if the watchdog counter clock
was previously disabled: If userspace cleanly stops the watchdog, the
core calls wdt_disable() which disables wdt->clk. No reset comes.

Re-enable the clock in it as in npcm_wdt. The watchdog .restart()
callback runs in atomic context: get the clock with
devm_clk_get_optional_prepared() at probe time and keep it prepared for
the lifetime of the driver, so the restart handler only needs
clk_enable(), which is safe in atomic context.

Link: https://lore.kernel.org/r/20260911031916.A8E051F000FF@smtp.kernel.org
Fixes: 6c5c0d48b686 ("watchdog: sp805: add restart handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
 - include a Fixes tag
 - use clk_enable() in the restart handler
v1: https://lore.kernel.org/r/20261120201029.1685193-1-mmyangfl@gmail.com
 drivers/watchdog/sp805_wdt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index a14ff7ac0db4..4e4febc52853 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -138,6 +138,13 @@ wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 
+	/*
+	 * For reset, we start the WDT clock and leave it running.
+	 * The clock was prepared at probe time; only clk_enable() is
+	 * safe in this atomic (restart notifier) context.
+	 */
+	clk_enable(wdt->clk);
+
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(0, wdt->base + WDTCONTROL);
 	writel_relaxed(0, wdt->base + WDTLOAD);
@@ -156,7 +163,7 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 
 	if (!ping) {
 
-		ret = clk_prepare_enable(wdt->clk);
+		ret = clk_enable(wdt->clk);
 		if (ret) {
 			dev_err(&wdt->adev->dev, "clock enable fail");
 			return ret;
@@ -208,7 +215,7 @@ static int wdt_disable(struct watchdog_device *wdd)
 	readl_relaxed(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 
-	clk_disable_unprepare(wdt->clk);
+	clk_disable(wdt->clk);
 
 	return 0;
 }
@@ -253,7 +260,11 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	 */
 	device_property_read_u64(&adev->dev, "clock-frequency", &rate);
 
-	wdt->clk = devm_clk_get_optional(&adev->dev, NULL);
+	/*
+	 * Keep the clock prepared for the lifetime of the driver:
+	 * wdt_restart() runs in atomic context and may only call clk_enable().
+	 */
+	wdt->clk = devm_clk_get_optional_prepared(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return dev_err_probe(&adev->dev, PTR_ERR(wdt->clk), "Clock not found\n");
 
-- 
2.53.0

