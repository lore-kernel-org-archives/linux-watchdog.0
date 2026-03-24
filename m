Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD563F7E79;
	Tue, 24 Mar 2026 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352953; cv=none; b=fw9LdJFSmdf3PnhGrM+es/PUdubZKmffve46NzDszizVbqhIfFjI4d23O3MQspt7wpcNBqAJKqSB1OimNXmvzHVnrVOSb1aG9o3RK4xthhO/ifN3A9iRWmSbkRNm6/m9BnYCBmsHl4LDfIFWIrRf7uuI/mZzvxRIoUgSzF8ovPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352953; c=relaxed/simple;
	bh=e9l2eGLM8Fj9YUuxcB2nhRaay/6xOXbkDDgNcShoUO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hizD7o/y3x77l/Irt7ip0HgPWygeU7R1/btd3rRJIh6db3ZZygzwC9kC7F2ysKTrGGBzntu5cSjNvJ75V1mRyeo+aDMlfdIH41sp9j/nvALXD4d0TYpqA7ZLT60IyOytMfa4YrHh1Vfkiz2fqCf+/Mo0XzfXT889iI43ZLJKRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=POYcAUL/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="POYcAUL/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F23331A2FBF;
	Tue, 24 Mar 2026 11:49:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0B526011D;
	Tue, 24 Mar 2026 11:49:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9778E1045034F;
	Tue, 24 Mar 2026 12:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774352947; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6Htc16u0egxjTg5XK+PPzZYkeVZ6gvD699dGr/7ro+Y=;
	b=POYcAUL/2xSqy5yhME6CIrkE69/6C6EXrPfheRXNkczbWrQbKkG/DD81xAOKJTBa/AfrXD
	+TvM3g7c9l3/tlYbNlp9rLJKJhRwxQZ/SE+Rj/ZMi7lR/Cum8XlAVY3B+hRCQxWqyE+oQI
	GybYudx9VldscY3pX/vmE/GMeKIvWEXaxZ4iWmlShLNuavL+3KYb5YeIFzO5tflnhbJN26
	JLea7B43TgxYWZ1qZ1pgmlvB94ggble5SQNNsKL2BOqo4QxxgFIonsngVvzBZI0EOrJM39
	yu03PM/yf5x44X18pAm9/ITMn4Th8Ea3AtNv/2Kn8Ci6t52qvJFVtTAwc/FQrw==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH v3 1/2] watchdog: rzn1: Fix reverse xmas tree declaration
Date: Tue, 24 Mar 2026 12:48:44 +0100
Message-ID: <20260324114849.242755-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324114849.242755-1-herve.codina@bootlin.com>
References: <20260324114849.242755-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Variables declared in probe() don't follow the reverse xmas
tree convention.

Fix the declaration in order to follow the convention.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/rzn1_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
index 96fd04fbc2a2..b7034eac91d0 100644
--- a/drivers/watchdog/rzn1_wdt.c
+++ b/drivers/watchdog/rzn1_wdt.c
@@ -101,10 +101,10 @@ static const struct watchdog_ops rzn1_wdt_ops = {
 static int rzn1_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rzn1_watchdog *wdt;
 	struct device_node *np = dev->of_node;
-	struct clk *clk;
+	struct rzn1_watchdog *wdt;
 	unsigned long clk_rate;
+	struct clk *clk;
 	int ret;
 	int irq;
 
-- 
2.53.0

