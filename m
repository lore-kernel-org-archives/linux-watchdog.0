Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272549C4C2;
	Wed, 23 Sep 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162250; cv=none; b=ncwBhD5cpDGt8HZcCOlITEBJ6In5J4FGLc6ElFIYGVvQSVK1Rlw67ixUHPsMWbi5JuiBSsLpBuVWQs4bQzMu3Whr8BokgPayqNtPP1wljiYUoVEUJTp9SU1zJz8rrjvqStopyuFyK9L9T0775wZv6vtujZtYjehcN+RM4ortINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162250; c=relaxed/simple;
	bh=xj2dmk0nSM5pdkltO/XUJ0KJviOhCLmqbLQYn8RvNFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9tDcV9xwSbw6LN/64MRBQo3TH+pyaXtrgtGXZsSSL6AoyecThMoO4mVAsTrh6zXKexGrCfwodCEBDCzE3mqxW3F+De/11VoM3wepB7V4LAgqQZaOpKhjPUu723TKB8801RtStwQZ3XuUG1ySXsUG3b6SEmpyOxkScaWE5g0LRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=RciFyTWS; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="RciFyTWS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4gf0080cc1bOdD46SM4BmeA8Qe0JG/1hnNjmI0f6zac=; b=RciFyTWS/TVrx3erMW9iTP3nFZ
	FLKH0CkPdXhNFOuDATa84r3SH1PWFKwGO0pmBlR3tcnADyBt6PH2RbAmnO0FlKUlvepxBXPWLx3YB
	mm59KWcW3cGsclU662MNmwyJJjroGRtwXn6H+7M97GNxQOFwTUgfs2MX4IeUH+hgHN0IWoPxaRmPz
	RRrDC4rJBerKKI/OvwUxftDRpgy4gBFMEGE96Xl5PNdW6/ncuESIWM1DG8leyf4W5BC7G6KCTzWD1
	EETSmokDYNpCNmHOMeGgPctddHhd7ytgof7NI+IUsqk+sW8bcv30p7srl/cBax848VJRFNXM+8LNT
	NYw0QXCQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:43182 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9KyZ-0000000A1qw-3FP3;
	Wed, 23 Sep 2026 13:17:22 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-watchdog@vger.kernel.org,
	upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: [PATCH 3/4] watchdog: da9062: reset board on watchdog timeout
Date: Wed, 23 Sep 2026 13:17:18 +0200
Message-Id: <20260923111719.2032012-4-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923111719.2032012-1-primoz.fiser@norik.com>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Andrej Picej <andrej.picej@norik.com>

Implement a method to change watchdog timeout configuration based on DT
binding ("dlg,wdt-sd"). There is a possibility to change the behaviour
of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
clearing it enables POWERDOWN mode on watchdog timeout.

If no DT binding is specified the WATCHDOG_SD bit stays in default
configuration, not breaking behaviour of devices which might depend on
default fuse configuration.

Note: This patch requires that the config register CONFIG_I is
configured as writable in the da9061/2 multi function device.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/watchdog/da9062_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 3d7bf2f351db..7ceef8cd7425 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -204,8 +204,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	unsigned int timeout;
+	unsigned int mask;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
+	int ret;
+	u32 val;
 
 	chip = dev_get_drvdata(dev->parent);
 	if (!chip)
@@ -245,6 +248,30 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
 	}
 
+	/*
+	 * Configure what happens on watchdog timeout. Can be specified with
+	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
+	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
+	 */
+	ret = device_property_read_u32(dev, "dlg,wdt-sd", &val);
+	if (!ret) {
+		if (val)
+			/* Use da9062's SHUTDOWN mode */
+			mask = DA9062AA_WATCHDOG_SD_MASK;
+		else
+			/* Use da9062's POWERDOWN mode. */
+			mask = 0x0;
+
+		ret = regmap_update_bits(wdt->hw->regmap,
+						DA9062AA_CONFIG_I,
+						DA9062AA_WATCHDOG_SD_MASK,
+						mask);
+
+		if (ret)
+			dev_err(dev, "failed to set wdt reset mode: %d\n",
+				ret);
+	}
+
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-- 
2.34.1

