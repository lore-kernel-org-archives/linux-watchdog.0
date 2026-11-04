Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758522;
	b=obn3O2PsPLTfbka1Kjx98qNn1ZgQDmLpYL53A6EeUpSYXbuGHjGGSv4LZfWZC5+lsF6s
	 dRTHVTisDK5t5PfAQ5eSTLWau8TzeeiS/gRq29torotcsSI+6X5Z6+qINBOaYH2Ji0WNU
	 2oqBe/+hwbCIqEac3O0WcALzHHhmuVF/iT5gHAsvA/7LO8NcflbMIPdUC96IuhXjCqxbU
	 naJs5o1bAXMQ5MiG1Xeg/ZRALUaChUdkX/82NOR2JxdeATt/vsXixzmLOXWm79GZIWocK
	 8H9ITbS+2ZWPw3g6NvQwgTHgGwaPSd2QmgApYZSIhcia79S9y8NUyiOxVtaV5t6TttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758522;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=VSK2RALpE1Rk5hr1RSTQLV69+kFMyUeW/uXdB5udrTQ=;
	b=ZaqYwaQsupvGVKx/9MjG5iTbnb96hnEkZBjqe7ZI97zUVpSqSZbBRejDvYVRsPQqW3fz
	 R2aaUIfPZ2gdjSgVNkfaxexi9AADju0Pbrtxs+VwA6am140cmMsbbrPxP0evYAVP9cdEY
	 PC6qn1s7lT7w3GzQkLq14X7oGud1DIGYUXbFoIpm8XKMw7f3YJGepe1HaYpjPZBsi4QML
	 bc1UgtWf6F/Apgr6AtZlgYKOQ49AyBIvIhdpgwxePGqut2S1nFmPoBD2bxbE+jTDe39+9
	 30gWVVwP6ZXiTL5oi3ol507yd0mv8GNbovgoXKWLn01Wj/6h4qgSGFhqbAwfGRjWiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F2606A332
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 02:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610F2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABHb_k2lepqenc+AA--.28922S2;
	Wed, 04 Nov 2026 10:15:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: starfive-wdt: drop the runtime PM reference when start fails
Date: Wed,  4 Nov 2026 02:15:27 +0000
Message-Id: <20261104021527.1468703-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABHb_k2lepqenc+AA--.28922S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DAw43WF17CF1fKFWxZwb_yoW8GrWDpr
	4j9r90yrW5Jr4xAwsrJ3ZrAa45C34xXrW3CFW8Kw1Svrn0kwn8Xw18tFyYgrZ7JFZ7G3Wj
	qr42yrWkWay3tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYbiStUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUBA2rqY-m42wAAsn

starfive_wdt_pm_start() takes a runtime PM reference before programming
the watchdog.  When starfive_wdt_start() then fails, for example because
the interrupt status never clears, the error is returned with the
reference still held.

The watchdog core only calls the stop callback for a watchdog that was
started successfully, so starfive_wdt_pm_stop() never runs for this
case and the usage counter stays elevated for the rest of the system
uptime.

Drop the reference before returning the error.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/watchdog/starfive-wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 044b4fdb7350..078328ff92f6 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -377,7 +377,11 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 	if (ret < 0)
 		return ret;
 
-	return starfive_wdt_start(wdt);
+	ret = starfive_wdt_start(wdt);
+	if (ret)
+		pm_runtime_put_sync(wdd->parent);
+
+	return ret;
 }
 
 static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
-- 
2.34.1

