Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF54411FAC;
	Thu, 24 Sep 2026 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232652; cv=none; b=Ixc3n/hzKzvK0uwNbeVZpYe7GLmwVkw1BBnvXCXZ7UMBSSl8tYH5gybkeT/FbiUzrb6bp3UPvia1PATXy4EcnxrtqFOP73VBWMnXDLN6MmeWckt0vDQv2SaBQxHxMoRHhRhrv/av7O19HX4Jxqqglvsodzj4qe9rle/YjDvqdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232652; c=relaxed/simple;
	bh=VAssve3PrfAAG3EhGtRjj3exPDr9coiMiYXI1czZ7JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgH6WYZK/NkI4hHTHw9q7sqPoI7/TrzF5kvtV4WAOK+O3QmK+RIdDytaz3BPqKhC1elFA+jOQ0QOpKoVkqN8GFPhuCzvzOGVLKtl5AeLXHf8UANFK1unofn6Eakh7S3UIfM+j/s3Uv81M0i3wnEUL2HpecvIuOeS8N4OtuTAAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=UOjFOpKE; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="UOjFOpKE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9ZaxtIVw95JAxaRv9UwSz3asSm2541k4BLL0sYxSi9o=; b=UOjFOpKEPE4JoX0UMXRiaxA4K8
	ygqaG9iDrm4A9QWnHH61fqmHOGq+YcPvpWePXqP/A1psOzq+IAORLo1xPJtoa/MH87WI4Oa6cWGVF
	G5cgtj+/o7ZkQzxOSBm237gVMfQoBsOOLuNMtP3Xlz7y8XeXV4WkicRp0XAImkfsdNwN6QysCdwLY
	awqgyRKl5NsQd5eC04DFzDhZpBGlxi95EQDxtRYu5zlq5s7nYDbPwVMOzoZWufchh59wKHfTDF264
	WHieaIS4kMTSporpblrmNdfgCaF/nM2RbY44djipicQYXROESjBeARbZRV0Mckf8/amagISJBPwMd
	c1qP41DQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54176 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9dI7-0000000AyGs-2WE8;
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
Subject: [PATCH v2 1/4] mfd: da9062: Make register CONFIG_I writable
Date: Thu, 24 Sep 2026 08:50:41 +0200
Message-Id: <20260924065044.368341-2-primoz.fiser@norik.com>
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

From: Stefan Christ <s.christ@phytec.de>

Make the config register CONFIG_I writable to change the watchdog mode.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- capitalize subject description

 drivers/mfd/da9062-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index ad198183aff7..32dd24483ee0 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -531,7 +531,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
 	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
-	regmap_reg_range(DA9062AA_CONFIG_J, DA9062AA_CONFIG_J),
+	regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_J),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
-- 
2.34.1

