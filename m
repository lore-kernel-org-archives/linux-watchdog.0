Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808975;
	b=UV42ls1vwhSihVFkzehykfWn5VoDax+YAxH92OcXwrTokaHWk6U9FFQF/4D/xGLf0yzz
	 H/D57erXzS0RlF4jVKZQ1XZs5D1zw+o5ESkPJwug5M9clCGWUU0XvjS8AYOwIHlW3eeeN
	 8hrLuOmaYxuJ5ZeMRDgKSehKN56oauWH9pN5RGqYEjrIH0MpZU3Kl/KouyGtXk320VX3G
	 12vIDh/rPwkn9CPYdS2umslLtfdCGys1vx58L0Plrycr6Yd/JDuyipDpuy7PDrfDKxrTa
	 sI1kxKiRpVwJ22zhgSxQU5XJy60yB2dOGSY4KjK+31WhGKGqw+KMurhxWdm3dcoyobw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wIuWNWPmiP+GNfu0cVbxFPeeVlExF/grvtfoQgXSHo4=;
	b=vKBu63fazBGer0fvcDaKOlWQgwBanZWrnLWkC9ZzQEyTzDJQrvyZFJhVwZ3iiOmYjMrp
	 dnBC7JEy58x+x0mJ51W3HbuiA68KgniAZeXJbKYERltTCL1TU7IiKcZJK/MqpUMc4+HnL
	 Joa4GXjLH7Uq9lIz0DeX0tcn4iXh1e6xW5M9oeEe1hrDm6Pp5kCvtF8YW5TkG9xPf5Tvo
	 WxExbTFPScnr11jgDfWuzKyvc3vh/MzsdYXzsUbPgKVFsLkYS6NodOnQpPWKmyVMaCw1J
	 djGHONZTScxvjyEUSlHTiouDXlgF6nOGc3xVp37J5O4FeWVqdpa+Lw8HHg29h5VfcvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=R+eJCw6M;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA1606EE80
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CFA1606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=R+eJCw6M
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 54B21240028
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 17:16:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793808968;
	bh=wIuWNWPmiP+GNfu0cVbxFPeeVlExF/grvtfoQgXSHo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=R+eJCw6M8/Nw/75QDJVrXpSmBh7JLoqXQmQwg5FlV4XvdGikMIieCGB9+uEyNxLfw
	 NoTIAILP69+BjIB2oLlYJN/mUq29mZF1ylXqTnHmSdvC81InjxbaAK9bDXs1rZHfmM
	 K+DdKYbSOY/Up59my2KmKiZAA9mFmLCz5CgkRePs0RvTmHEd4Zgjtfhz9zNCYa1TJg
	 3CC+w22lpccNfmxzxean/pHLj3iouL0mFnGD62nYoBL6TI67ya2vL+39KG7XXxqGuP
	 W30GXah40hqOHCPK4mhkO926we1fsbISUzMJuZsrJTrU3nWylmqzcH2wx81NEOUc/l
	 ysxupYYZmuSDQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKVtD6Xh8z6v0j;
	Wed,  4 Nov 2026 17:16:04 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Julius Werner <jwerner@chromium.org>,
	Evan Benn <evanbenn@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Marek Vasut <marex@nabladev.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] watchdog: arm_smc_wdt: try every id of arm,smc-id
Date: Wed, 04 Nov 2026 16:16:06 +0000
Message-ID: <20261104161553.30115-3-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
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

The SMC function id of the watchdog service is not discoverable, and
firmware for the same SoC does not always use the same one: on the
STM32MP2 SoCs it is 0xbc000000 (the OP-TEE default for the platform) or
0xb200005a. With a single id in the SoC dtsi, every board whose firmware
uses the other id loses its watchdog.

Read arm,smc-id as a list and use the first id for which SMCWD_INIT
succeeds. Go to the next id on any error: OP-TEE answers an unknown
function id with 0xffffffff in a0, which smcwd_call() reports as -EIO,
not -ENODEV. A missing property still means 0x82003D06.

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 drivers/watchdog/arm_smc_wdt.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wdt.c
index c73ed1dcdfcb..993c8f92c871 100644
--- a/drivers/watchdog/arm_smc_wdt.c
+++ b/drivers/watchdog/arm_smc_wdt.c
@@ -113,8 +113,9 @@ static const struct watchdog_ops smcwd_timeleft_ops = {
 
 static int smcwd_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct watchdog_device *wdd;
-	int err;
+	int err, i, n;
 	struct arm_smccc_res res;
 	u32 smc_func_id;
 
@@ -123,12 +124,17 @@ static int smcwd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wdd);
 
-	if (of_property_read_u32(pdev->dev.of_node, "arm,smc-id",
-				 &smc_func_id))
-		smc_func_id = 0x82003D06;
-	watchdog_set_drvdata(wdd, (void *)(uintptr_t)smc_func_id);
+	/* The id is not discoverable: take the first one of the list the firmware accepts */
+	n = of_property_count_u32_elems(np, "arm,smc-id");
+	for (i = 0; i < max(n, 1); i++) {
+		if (of_property_read_u32_index(np, "arm,smc-id", i, &smc_func_id))
+			smc_func_id = 0x82003D06;
+		watchdog_set_drvdata(wdd, (void *)(uintptr_t)smc_func_id);
 
-	err = smcwd_call(wdd, SMCWD_INIT, 0, &res);
+		err = smcwd_call(wdd, SMCWD_INIT, 0, &res);
+		if (!err)
+			break;
+	}
 	if (err < 0)
 		return err;
 
-- 
2.56.0

