Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AF4078F4;
	Thu, 24 Sep 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232664; cv=none; b=HZ0nsYTf+uWv8Gw5hAX98rhgal6RmGidcWf1W5KWJKv1BgoO/iz+08KG60nNySyLib96tR7h6QgjZ+iKFzWkZ4fgMxtwz6Ja7F4SytrGYFhVKuwguokNHv7H1MlNoQ0E8s9Ahoq/04n16bO+zCTCXyLNkvyfBfdFvXrVX7mbvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232664; c=relaxed/simple;
	bh=MCNvcoTk5YjIM8nidulhpRODqz/2SeRFgaV2PQZnIB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=od3c8ukmhjpGRWaV8FFlhe1eFJz4Iu36BKWh4HEK75zJzdni9Odp4jnNSGxOwPTnL33FwHGfnkpJuOEV1F5x7UHbRYppYCQbxfudpr8bcV4eIYVrkqm0F8EVy5if/WhuS1L1ql4U/5HF/Iifp8rkJCxpGiX8mgh4m8v4WblmRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=UwYG+7Mf; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="UwYG+7Mf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rbBjtZiwvW3+ed65Dqj2P8+3DohWPWa2sAVoOy4X4uM=; b=UwYG+7MfwAnL+GwQoqLTRm3NiF
	RzXKfdW43ZehApaeECIGs/G2lSEjFUYL+yn2F7iKvWK8flpOdwFGIyGsS1ezuGcWrolciOZIk/0wY
	RVffowucdAhZL3QOATt2W9lKwMYtI0NTUvXq28hEHchEoZ7PcblOz5q7Z1DgNKx0s1FHnl2xVJI13
	xrlO53SEFyzDbhqPXuXdxTnfOnTSKhyeeHtqiPxTZtIaWnHHY05l5G+1APv3BSjdaU+uDvS+F6eqE
	xeyh0ol1IV3RccMb39ephvbjTMd1tzyz1euuBX9kF4+99VScTIA2EhpUOT/T1fpXnAeu6Eouh5Mlr
	UVcKltvA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54176 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9dI7-0000000AyGs-3vil;
	Thu, 24 Sep 2026 08:50:48 +0200
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
Subject: [PATCH v2 3/4] watchdog: da9062: Add support for dlg,wdt-sd property
Date: Thu, 24 Sep 2026 08:50:43 +0200
Message-Id: <20260924065044.368341-4-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924065044.368341-1-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
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

Implement a method to change watchdog timeout configuration based on the
"dlg,wdt-sd" devicetree property. Setting the WATCHDOG_SD bit enables
SHUTDOWN mode, and clearing it enables POWERDOWN mode on watchdog
timeout.

If no devicetree property is specified, the WATCHDOG_SD bit stays in the
default configuration, not breaking behaviour of devices which might
depend on default fuse configuration.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- implement Guenter's remarks (code refactor and update commit message)

 drivers/watchdog/da9062_wdt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 3d7bf2f351db..0c007847b7c4 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -206,6 +206,8 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	unsigned int timeout;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
+	int ret;
+	u32 val;
 
 	chip = dev_get_drvdata(dev->parent);
 	if (!chip)
@@ -245,6 +247,22 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
 	}
 
+	/*
+	 * Configure what happens on watchdog timeout. Can be specified with
+	 * the "dlg,wdt-sd" devicetree property (0 -> POWERDOWN, non-zero ->
+	 * SHUTDOWN). If the property is not set, leave the default in place.
+	 */
+	ret = device_property_read_u32(dev, "dlg,wdt-sd", &val);
+	if (!ret) {
+		ret = regmap_update_bits(wdt->hw->regmap,
+					 DA9062AA_CONFIG_I,
+					 DA9062AA_WATCHDOG_SD_MASK,
+					 val ? DA9062AA_WATCHDOG_SD_MASK : 0);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to set wdt reset mode\n");
+	}
+
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-- 
2.34.1

