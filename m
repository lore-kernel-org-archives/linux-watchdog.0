Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9044274B42;
	Tue, 10 Mar 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163994; cv=none; b=naKerUHGISvv0RbJ5T80NsAjSzzVmR+Dzw3IEFFrryofNkHFevyD3iB4rYE4X9FkGtdaWto4wBAjPJDz5fwts9S2MNb+e3NkE+rUUxjM49HqTNvZUFUHQa/Wi4W0VCqAPU2+85xJK2ayvJvQtRlZDr8IrqbAXj89lhSnBAi+e4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163994; c=relaxed/simple;
	bh=qkCssjwQ6xHfILIG/0YeecVw+n9kEcmrQqoPICmcohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgem768339BhQ2RgA/Sj/M5cKQ1d9cqKfsFsgW+6ZhpRcZjxNgUyfr73fqzDuGyXkkCBhELxIPonB4sZrE4adVHfQo5uerWNa1BDDC9gIuCe5XZCpXK10Jz6AsGTCCPgcfR14XbL3EpRG1j56rqgy6j2Sha/RYFe4CsNpkk2NZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Atm8u8oU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Atm8u8oU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 92B2D1A2E01;
	Tue, 10 Mar 2026 17:33:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68C0C60002;
	Tue, 10 Mar 2026 17:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 804231036891C;
	Tue, 10 Mar 2026 18:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773163990; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HeFNpkruOmIcHovjLW+aFCk9gvji8MHWFyaMG1utC/c=;
	b=Atm8u8oU2ud9vUuVBB2OuoRZEV62E6YjAb3YcmHkF71JQaiEj1jyetrHwdNV4iKJjw4Mv6
	+rMQ8q5rH69Vk65Ijze/WTnWIzSOfC836FtbP4Af6D3UfuZgjAfAoKa7VetIy+tTT9Rn71
	vI/9vcfqHhG1MlNZpyTYnbHWb8Ks/eU/EZ2MnYci8L4TbISGGcoMKK+jPGQDUFrT67w3sL
	5sDCA4fmocIZ5C6ZtVk7+mkEu501gs9gTob60IYFBBGRYZL50PE/LDhhN0J7f4wS4G8eXG
	SzfA5NbKF2HKcX6c7HH38/1grMnLjNVlLBJYXiTivmV1+ZLiiPlABZ2Lor45vg==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH 1/5] watchdog: rzn1: Fix reverse xmas tree declaration
Date: Tue, 10 Mar 2026 18:32:42 +0100
Message-ID: <20260310173249.161354-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310173249.161354-1-herve.codina@bootlin.com>
References: <20260310173249.161354-1-herve.codina@bootlin.com>
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

