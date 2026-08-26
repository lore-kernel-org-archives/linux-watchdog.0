Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFC39182C
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724558; cv=none; b=ApFLDc/+kxUCASyDOzxCs4IwaRpJTWGc+TGhaManCt0dk0yCrDnNMr32qFCXHRoqwMDzxrzYH5fu1IjWtSmo0QdI/Fe7TusvAMbLQq/KrMLWBHBY3o1mOz+LSXj0q4vlnBg0ZF1xIqmva51wY26jd3UOvoDFCcAgt/OYvt5p8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724558; c=relaxed/simple;
	bh=qTCrLDXi/y2K4j1tL6P6e5VTEnzmwohyNo2q0NwCVe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn8IjjeRNMFBPUTUGz/NwtrMwkvoEqyH/eHh0RHKSpjwTRjZ9Ouf9STxMlgcLii5gIRRrMiKXFSqQoeRda2/IT8lEijIeDXEvJksDhttUfFimIYQiD4Eg/QYyHkbKh9q1xIKuzTZkV51eUAMB3DX10SwkJwFPec0gdmizonn0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcvjn4+c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcvjn4+c"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1166670a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724555; x=1788329355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfOrf+ifzLb8ZIkRSyp+IcOs/0ZzAeBHdwM9tnfmCPY=;
        b=Bcvjn4+c95ff+ZH7I2aKy1Ed5RUObA+3QYuvktsONydXtIM4IHhmuNpfQEbYcoHWrx
         Hwb9FH7ODTMw++sION7cEhinndOLNvpx0vk54zEkopcs71uCIsjuwGniu46C+LFTHQDn
         BpOjeL7ZVhBqZiGIBjFw3kOKWARXuZNpUD2pgRI4SbIbu7EERintVLAz0TBUM7jJA2hI
         R5A7XnYI4tbEI6P5dZwgOJ3tEB81SVQOvhQ3pfcx+96BZ6gEJxtFA5Je1EKUFRus27f9
         PP8If5ll28+afqL2+Uj+90vuNiUmOUO0EDNMf33O5vxz1vS40GvRxPH7iVN2p2P7AzIe
         APng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724555; x=1788329355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfOrf+ifzLb8ZIkRSyp+IcOs/0ZzAeBHdwM9tnfmCPY=;
        b=byNtb4jlRu34QFge38gIR41Jch9jI1vtegS+eNH6CeFQZIDPtA5JHYITSrKp3x7KSw
         e7CbdfUN39DfvFxkWao6gnfUdDXx/E1T4jero126tu1UXRGYuN8Mi9NJsTxXxX+NMRSq
         nYKT3rHAdhJkp8jFYRlWpAXhEG+9gzEBG1GTGRS2K/2S/N8H0jANQW3yKous/FEzH0uv
         hzbbKGdF8hiRulRJixfcmgK5Qizp5Yy7Am0HACry+8YW1r2Le4YILPSHma8F2ZNOZhZK
         qE8rYRGiC3LhO5lorF1y7O3wbH7XdwaF/GiOaxwN+K1EejR8ag7yFB65rf+DtTy64NEr
         cJvw==
X-Forwarded-Encrypted: i=1; AHgh+Rqh5E1CFNF3hlH4asBYk0s/8yhieo7A6NyLKcvCdZNOIeARSAmk5/Jo19qPNHb7LiZL05fI8/HEGcPApyyKvw==@vger.kernel.org
X-Gm-Message-State: AFuF++kEoRVOqhvkun52RA5XBUf/Bj47U2qV/IdzCeREtLlBax0x/q85
	l2xR+F0vag70CV5eFS8VpjqRPKBE5GsQRlit8z++8ihV34WplJnY09WSti8PYXM=
X-Gm-Gg: AR+sD10U+JfhKyTTwybhY3EB/mfdv10fifPkIEiSS7OcMD6Xg7nD3x6BLWi0uKGoH/t
	T8gfxzVEkgyGGktu3EeYVQGR70E/vYLRtlUnv//uBU3tVodLptZDZ4WgCBZB707QBMY843/PFVk
	CaCJXZC3vPi5GJ9C4hQ9X3JAoU4LC6Cob+k/SL0L3bXN5vT6FiBeh9SC9ySTT0wQYtIc05QcbzJ
	1G+rreNa59ai/gsXVn/n7ow8ZZE85kBE61vKAfK0b3PQb1zyQ3bjLB4mO36SUnKvprZe5oAEQ96
	xIdSpfV8AXxZ0WxRapsg45qKHlIoFa5Pu6Ba12kDFKZ18xWf0fLxnOXgdb5+bF4FsVjGGL9Kn6M
	pGd7Oz6lTOGsXeekab7bVKEjLH5onW2K/HOCDQ5nfJNlS64TjTw0g8XYtxJExxPaT0oBeJ6Y1kH
	UVw/IitPQl/dAoFtxfZ6/yoIgm9ezJ4GXVkjM0pxP6uyABMZ0y2Xa8tMQ9+3wh2uvVbhV6ESvz5
	g==
X-Received: by 2002:a17:90b:554c:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3966d1396famr10124848a91.1.1787724555283;
        Tue, 25 Aug 2026 23:09:15 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:15 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 5/8] watchdog: of_xilinx_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:36 +0700
Message-ID: <20260826060839.203297-6-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/of_xilinx_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 352853e6fe71..d6b1adfe31d1 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -251,7 +251,7 @@ static int xwdt_probe(struct platform_device *pdev)
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
-static int __maybe_unused xwdt_suspend(struct device *dev)
+static int xwdt_suspend(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 
@@ -267,7 +267,7 @@ static int __maybe_unused xwdt_suspend(struct device *dev)
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
  */
-static int __maybe_unused xwdt_resume(struct device *dev)
+static int xwdt_resume(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 	int ret = 0;
@@ -278,7 +278,7 @@ static int __maybe_unused xwdt_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
 
 /* Match table for of_platform binding */
 static const struct of_device_id xwdt_of_match[] = {
@@ -293,7 +293,7 @@ static struct platform_driver xwdt_driver = {
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
-		.pm = &xwdt_pm_ops,
+		.pm = pm_sleep_ptr(&xwdt_pm_ops),
 	},
 };
 
-- 
2.53.0

