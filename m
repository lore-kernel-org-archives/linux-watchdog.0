Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792850947;
	b=YRAI91AAQakg/G0of6qvWfef3XWjL5QGR/j38IPqH3mQAy8OaoIgy+9hhOJOvdKVv5wc
	 dZRj8wA1l0DE+FTP2Yt+dRTAJh0yq9BAgok556qgDQuaW11fZthrWcTngeu9w+kHod6rK
	 rpZVI6S1WafifN3vfx9TfOCWdjyVtYGjY5T8PZj6m3/++FV4MXUVh1v1SkLzEbrvFcnqI
	 kny1FZYJ6HfcvfYlhCNXdCeP2sMzJFSd+4Ur+HpIcFJNjfBU6/sUi52jh/LxVAgNjd5h1
	 BhZxeqEFQzI6qpbn6Hd7vU5sXG3ePmUja+z/1X2mhyCAxpxpvYK0ji/OEd2Aps0V6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792850947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LWiD1yjT+YEVwaexWWeTMFMBt0QDUN6UoMpULATc+5Y=;
	b=HpeePWSf77oe11FVZjDXLP8heqo4whqeDIbh0Yfx+/yZkf1OTo5adR0tKNRchCthbsTs
	 o/f9KmHDdD4Xb3xFELodJEPwPVi/wfQc744yXaste4LdENVa+dT9PNIHY7Pv/JucrmXbc
	 KniDFOW/3ymppsLwU/MmKfbaHHEzPD3r+xi+moH6fZQYXRv8rf21tK0+SSnYHCuLlLnSt
	 dvaS3BsvCeRGnX+X1pJV/YirtPDRbCqQ/bNJUJWONQ2jSZT1kbMQB88EHf804EjxelTEB
	 VVBLZd1DKxw3n3CPQN2WhvYU4Sm8CPxD4ZWBhzeWdHckWnLADaT350oWDtMmi6xsqRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoM4KrtO;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BB606A326
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoM4KrtO
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso17309885e9.3
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792850945; x=1793455745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWiD1yjT+YEVwaexWWeTMFMBt0QDUN6UoMpULATc+5Y=;
        b=OoM4KrtOF29pHVx3Socm2Hh3G06RinOowrkG3/SkZ7hsqoyd5Xgz/HptTMy8rBPmoZ
         rlO8mc7eVj7f9LXbTkUCQCHKf6HeorxWqcXF9TBoNeB1O6Yq2PmYefkrCqQQzfcUjdvM
         5E42iec1lyHTBeyCuBvX2qIIcTZfSykOSWgUyz+Lc3yAzbFttjIbhlE9PHiQx4/f/U/i
         lEGUUj5ozRi8TlqAlnxZH8YU7DOo+4gFken2kCd6QRryc2W/Tpt1ca8ozGn7fY/BvIKv
         XY41BsCyN7qiOT/kcvMiGpE+dgC5lzV6743gOusiwvD4iQbF+ROHUU6TgpEplAeY2FZa
         7oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792850945; x=1793455745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LWiD1yjT+YEVwaexWWeTMFMBt0QDUN6UoMpULATc+5Y=;
        b=14SemET1aiP8lqkt4dwif08GNvvIc3datoSMj5xcWJzSR/PqgG2Qh/lyeuPg8LV6oB
         KeSDJ1ooy4vE1HEwsqPWjG2QxdJG6r11RcVb3e1NZfG5op8wLFF5ROn07ISAvKn07io2
         KcCWIiGkrwsswf7do8JbrZKabCp3unGnj7CVFUsDPcy05uCtdGwPYLit3RLuuGsB3Xdw
         u8/rp/OBpieXO08D0necp8aT9dW9lsrFJGp8KcvJz0HQFFtL2DxZrC5O+hAhe27Wy9mK
         NAAnJGOov7fUjXyuqk52nTBnnpNQiXbslIncm2aSDHQ+lQL3ZUh9TNRgoIwGUsgYZ2CC
         6JuA==
X-Forwarded-Encrypted: i=1; AKwUvBxRffzGO09ozOVbCENDS01OsO0R9L35y3ZtaL4xjxlKXj/KZa3HtNXeM4D026E496DRfKBvzllhXyLgYk/EfA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmkEmTf2FcYKXhnW/wmJLWJdCeOADUdLx3R53eH3RDWEtE32Yq
	H9swsSOeh7TRyA9EZWHYI/ckbT5sry/5Mqjo4Aa/gY3vYYkkn96vCORW
X-Gm-Gg: AYBFou0LGBbs1+Tk1fLn2x2gvtNlqrPQFLMmpf61x85UWkWw63yJYljOtEUjd3idwFz
	NiDioSPwiTOfpD6bykbbeFI9IymhIqWLsQFrOD+eueycjlQYK54AqgwVw9+ihO3DqNJQhoqeycD
	OZ2wED3ueqsSpFTGago5HGIgyUH/kzuGSYdXwLwydelg4zoh/WWwYPa0uVHTqD0cVUXwYit9QZO
	Caz426Fc+MB8gpxPCmMXhLyEUE+qs9bfGIuqjG491PM6EJbu+6qfWdFRFqYmkbf+O3Be1IOnS9l
	eoSvnaEz4wK1Rx3R8s6U+FQzaHI5eIztzzZCv7/fVBHAKdOYrlOvFzML79pH6wA8yPPkU2J4zCh
	7mTDqiktoAHN8TyM8Za9gYeWmqnBuER1B4nj4mL8BFqvfhF4K6W290DDxnK8LSHGEyT7CDZy3hu
	+vBQNi/yaR9Dv3mknpiQTSlXRl9vD4pnI9JRY40uykDguIy/ij5qw+PqUFAYKSuwcJo7iR00/DS
	WQHhu30aC5YDWOCZubEzBfTS6fFcmqKIRNFVkyz9H2GmP0j1ZGUtMt5TqP6t+J/pK1ZBwcvYH/i
X-Received: by 2002:a05:600c:8286:b0:4a2:bef:ae5f with SMTP id 5b1f17b1804b1-4a35ace0b88mr26302695e9.29.1792850945354;
        Sat, 24 Oct 2026 07:09:05 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm46716525e9.4.2026.10.24.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:09:05 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv,
	tzungbi@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Sat, 24 Oct 2026 17:08:51 +0300
Message-ID: <20261024140854.25664-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024140854.25664-1-a.shimko.dev@gmail.com>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
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

The watchdog controller reset line is not currently managed during system
suspend/resume. This can lead to an inconsistent hardware state when
resuming from suspend, as the controller may not be properly reinitialized.

Assert the reset line before disabling clocks during suspend to ensure
the controller is held in reset while power is gated. During resume,
deassert the reset after clocks are enabled and before restoring register
state to guarantee the controller is properly initialized.

Tested-by: Igor Velkov <iav@iav.lv>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index ebd27ee684d1..684e0cb104c3 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -378,10 +378,15 @@ static irqreturn_t dw_wdt_irq(int irq, void *devid)
 static int dw_wdt_suspend(struct device *dev)
 {
 	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
+	int err;
 
 	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 
+	err = reset_control_assert(dw_wdt->rst);
+	if (err)
+		return err;
+
 	clk_disable_unprepare(dw_wdt->pclk);
 	clk_disable_unprepare(dw_wdt->clk);
 
@@ -391,16 +396,19 @@ static int dw_wdt_suspend(struct device *dev)
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
+
+	err = reset_control_deassert(dw_wdt->rst);
+	if (err)
+		goto unprepare_pclk;
 
 	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
@@ -408,6 +416,13 @@ static int dw_wdt_resume(struct device *dev)
 	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
+
+unprepare_pclk:
+	clk_disable_unprepare(dw_wdt->pclk);
+unprepare_clk:
+	clk_disable_unprepare(dw_wdt->clk);
+
+	return err;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
-- 
2.43.0

