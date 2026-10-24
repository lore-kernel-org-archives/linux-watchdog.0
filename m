Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844080;
	b=ZSfm55dhoADiEGweYyoWc437Vc8JhPi5hPTTnKAQjsSRbjkaQ7mXtV+5iV3dShJarDwQ
	 IpgKYl0EHRQh53f7CwhCZd9GVx6mzvjJiPZSmU64JbDG3yXi5k/btKSDlt+tn6scd/dDW
	 JUySmttQbIgBxyJUgdi0Rqpx3w4icch8zPtnSN9kOh/P8bLoQlguSth/e1mEL8RQX4kpb
	 ER5vyXgJGBTx3hRAV5Q31s/GHai7NAhOU4J3BJyFzWpD4WY17rPaxO8vrkEPYucNb0D92
	 OD700GO/sFaDjAc/idxmUJTGUH/jjYy4KNiWpDGPXn9R8O8gvJhURj12LX9jk3gdBFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H5L2oywAexEgARcVCe03Pw/60ikOC7LjYePVBuVC6U4=;
	b=B0kIdV6vtROcEigcGnI1lMIh02X8VEJun58vu7/r9iEiVyqo6MQDY1YY1Ujnm0UVBl/o
	 lAf8y6ZbJ04zvyL2pwSVCdiPQR9+ln6SJG1zn+UuisFAPpH9VeBIpIpVOZ2jfbrn/lTz4
	 Y5BMBPp9yes09qhcM0cPPEQgK/YMs/nRIVZ8zVKv2dfVU4n2382GyP5Htqo5rmytu1OeS
	 3ljWemFz3NqlyVVxnwas4RS9prVC13iZE8l4DUT51vMFVpF+/F+/MOgFk3ZszUtEQIJwF
	 ewpIUxnKnirCXzKF9vyABJBFQ3NBNWk5vQzN4wpZzgyQtBj76z0NC+nPyd5dehTmrzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kk9QGqNq;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0A606A32C
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 12:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A0A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kk9QGqNq
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1044995f8f.0
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844078; x=1793448878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5L2oywAexEgARcVCe03Pw/60ikOC7LjYePVBuVC6U4=;
        b=kk9QGqNqPm0wSvRaXOTRIxpQRw2ERMl1qZCUO1hO1D+r1xDHcZc2tncdiKL0G8a9G9
         pOG4h3w37r6iZfPL2AbgLa03L1aO3NeHF2MxT2VGkzme1TIqteUykHCx201tydvmr0js
         5I2cWOVMqxg97ks2kG4FDJvHY5RDgM/H3I+7Ws7ywsMSPGgFmMlwaJ6cIRfBWxcYT/Sk
         HqMXi7lZUVOeVJor4jBX6tV1IrtYCS1kKxVlOzHsb1gZ6vB8sRQ21Y9QzvIME9JrNNdx
         WIp6N1mUwBdNyqJzgurUpZtdapDi9wF/qSeD+fhAiGpp1aggcaYmxG6HRTbmuNkuNVRg
         IDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844078; x=1793448878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5L2oywAexEgARcVCe03Pw/60ikOC7LjYePVBuVC6U4=;
        b=eYpzVsBnhamCtZ9OLz/YMMWPgMiidtRyT4JK04I1uttoIWnSnETuMksJy8YH2Vg9xN
         VbB1510nv6NM16a5t8YF3LKFPvyi0uE1u/uYfqz5TxW/yIJBf9g3E3jLD6+JtOa4G2pj
         TaXjK337TvSlFdBSJcqZ9Lx8HQN1DVYlLfmrv5rMcv4EYsCpSMl1MbFloR54Bs2hTFdu
         ccX1ajUTOAi90DIhAzeikjwFQas829u0PFTgGxygR89Al/iTNZsRmRrG9AhuHypgxwsA
         q9pboPcgW3yT414rIUM1hjUAHCH5gnKWYNk2K86ky+OVCt/uXgDIF2YFDfE2e462cuNQ
         pyaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV3oNvzDfmGeviK5JjkoEhbhL10mxqsKPJu40ryh+Cq+eI80BOF0TCnuBC/UKL20QmpHFNRug+LNFCSf2zFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKh1aJmceAZbiMBdoF3nePO9kniPN5RYzi35SM2kHFuE8xFZ97r
	p8TsSkfgC7+hLn4Gk+H9GDSf8SECEyQSRYMPmC9wSg5i0SDRz96gidze
X-Gm-Gg: AYBFou3ZKtwmLrVksMeaEXSBa/V8Ev+QPtnZ4E3pFZV66FmmOrhZsWums4m/LLXdEq5
	8JleJpsCmVEIFRxI+331/A3OEODc/82Piytbcx32aH9GFN2aNmprGeNXrw6XLWIEnzi6QZiThpd
	GHGAu0MBLPCzX0IktuCDYkj3hhdO2GVVK3Jz7ZEAlNXSh6yhAq8vSLoOu/ahqJudNEmiK/TBcyj
	ccPQEm2umS96YVRqthrQVA0qla9x7xy7C1785MDao9qZ9TfDPXeW4VASfr+NX4BVmmCccpwYrSj
	JnTnBAqSlESwF6UdN/tYyDfeQ+NyCB8u2UbYh7UEBoxAemWrpetYgX3wyjzkpYRGGA1ubR0usVp
	wDjMBRDvolZbxFIpN7QdxyS+OFQxJaqxnRNvwWgRj8mXHEEgIgcVSdxwEIAJ21Fl0fjxP2AFVsg
	tE6exLRR943tCx3BNWppcKYqWMAdKC140ANAIDj9Gdg/pKB0xFyG/U7X88SJtB01Osp47cVcFBx
	+k41n45bYotd/itRdk8UCQH/lgsahT7uucqt3NMw6TsdmozfTzFZJw=
X-Received: by 2002:adf:f5ce:0:b0:487:930:8acc with SMTP id ffacd0b85a97d-48e3eb83fb7mr2248305f8f.16.1792844077924;
        Sat, 24 Oct 2026 05:14:37 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm3860411f8f.59.2026.10.24.05.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:14:37 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: tzungbi@kernel.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Sat, 24 Oct 2026 15:14:24 +0300
Message-ID: <20261024121428.18862-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024121428.18862-1-a.shimko.dev@gmail.com>
References: <y>
 <20261024121428.18862-1-a.shimko.dev@gmail.com>
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
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2cffe337b4ea..844a5f7738b6 100644
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

