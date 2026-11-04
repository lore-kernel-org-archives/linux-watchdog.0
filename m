Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758528;
	b=DsbPOwLxR1kNVQ9mJnuyx41ja942TU2njMdavhNAbybm8MvMyxJ+5p725vPE04Cee/gY
	 3STt3wZ9uTZEkjM8w/eAgvrlS9bKe+ZCXZiyegiab8HyImySW9h4Jzsz2RVyfSUEFlp+F
	 kBRE281j/LxtqBg0csAgIgr2hex6tDYz77np2ii1C0X2eN4kbu0Jimw+3m2KKJrwV9GrJ
	 bhbIg1mB8GfmoCXnFgc/bsRn70BoZ8cFlP94kizAjCA+tL8vhz8swNZFGJeEl6V0Xvdfp
	 7TM/NFcxfISnIkrIWQc2AEOa6TPPs4glyQ1Xn7KuZDT6bU41nHVi54akA/eyxUw5d4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758528;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=jGVXJUuDkXhBFgg5dwZXbym0uimFsNAihKFfLoiaQc0=;
	b=LzPK7eiu2C6QEC+qw7nBEGLkdyAVvD2v0QRwcZ6oNnTvR7nG9KK83Y8/VyBObTQSOtHu
	 gZQQ+RWI7VmfJb/zNUX3/8v5nkbS0y0Issbu6a7bqyfS2DffutHQ1BMjSFeGHZWeCsz1s
	 tB1Wemrr0T+0zJmQI69VAZR+e9f5qGesG4nLCoqARmvQf+5RRUVf0wmH74qNgjPEfsY+2
	 WPyggYIozj+GZ2/6IoRwTLODLb+XGfVOlRrxmlAmlgomLpiN78fykFg5W8dykoXRG9j+t
	 L4LFqKH2EKd+lwBuDWVFSRjO3z1UoIZdfzM7mJNJvKJ/2xZg7gEaiyi+w+fVqHdXVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17252606A31B
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17252606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAD3H_o+lepq3Hc+AA--.29004S2;
	Wed, 04 Nov 2026 10:15:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: omap_wdt: stop starting the watchdog twice in early_enable
Date: Wed,  4 Nov 2026 02:15:35 +0000
Message-Id: <20261104021535.1468760-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:qwCowAD3H_o+lepq3Hc+AA--.29004S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxZF4Dtry3tw4xXr47Jwb_yoW8Wr47pr
	ZavF1YkrW8tr4jvwsrXw1qgFyrW347KrW5GryDC3s3uan0yrySqrW8AF409ayDAF93GF1Y
	yw18trWxWay2yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5EQ6tUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIBA2rqY-m49wABsN

With the early_enable module parameter the watchdog is started before
watchdog_register_device() and the WDOG_HW_RUNNING bit is set, so the
watchdog core keeps pinging it.  The start that predates that code was
not removed, so omap_wdt_start() runs a second time right after the
registration.

Every omap_wdt_start() takes a runtime PM reference with
pm_runtime_get_sync(), and only the reference of the probe itself is
dropped at the end of omap_wdt_probe().  The second start therefore
leaves one extra reference behind: the device never runtime suspends
after probe, even when no user has the watchdog open, because the
usage count can never fall back to zero.

Drop the duplicate start.  The watchdog is already running at that
point and the remaining references are the ones that keep it clocked
while it is armed.

Fixes: cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/watchdog/omap_wdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2a6de73e6f0b..9279e50f1ebc 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -286,9 +286,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	if (early_enable)
-		omap_wdt_start(&wdev->wdog);
-
 	pm_runtime_put(wdev->dev);
 
 	return 0;
-- 
2.34.1

