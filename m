Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DD414A0A;
	Thu, 24 Sep 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232658; cv=none; b=M3harMlcE28zMJSbrHaj2ptXSmZyUPHHVHHB7V4BTXFbgt65xLyBAGlR728z88N0wFHT3loAmHTKmx7sTc6dvMl8oPrV54hBnlTmu8TVQun8ZnYmifrRlFgKfxUFutEc5p5XeNIx8JTzjkOyqu3W9XwXECF+Du2wgmsVZdpL++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232658; c=relaxed/simple;
	bh=Ldy0dghHUspWo/aoWJHuHlbxNdPA6YLRheUKh+TIIIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AX8mFF0O1m9YJHoBYMENmNt0JJqe8JFid9Zv4SXU+R3oRT91pa8Kmh7PV3hJ7rpcBANqCDW6P4Cn/xx5M+t8XfRf9Hst+OHz38F8plpLqbd8Zv0C+sIun19mwcr/+tuBQo+l2iOplAl8DL1RwpQxN4l8BUKaG95ELQ2jb/r1rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ECp9ei6N; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ECp9ei6N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BgH9aXwvqgfqbqezs3KUQvOw/Zu0xUnKdvawEIlUNtQ=; b=ECp9ei6N6YRHLwj95m2VaDTIoO
	IdqjibPUVsmmX5uU8pHRbxnMhaqbu2O0XjNvqb/HzuffyThK/ecGy4EzkkbNGx78pbt9zGd2CFsx8
	dbKbXNnUAM1l22oQjBk1tlBYL9U0Ag01iy8bvlCUsAHwnCU0amB1ztjXdwPd9lprc6TovJ2orVCDo
	u/uYxP+VHPIMv2RsY3+aObMqBW/dxQFAxo8Y9V+Kyr0Vj56c8puwXj5ties3/HnWPKzF4xsX/fyNG
	n98iqWirfFEq/osG6hiLrkHC5FCjGoxABJMRJJXy/nj5cjnR4ejqbI/FqyL/yJJB/XrpsjyU6ZUHF
	gZrrAhdA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54176 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9dID-0000000AyGs-0pX7;
	Thu, 24 Sep 2026 08:50:53 +0200
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
Subject: [PATCH v2 4/4] ARM: dts: imx6: phycore-som: Set watchdog timeout mode to shutdown
Date: Thu, 24 Sep 2026 08:50:44 +0200
Message-Id: <20260924065044.368341-5-primoz.fiser@norik.com>
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

Enable system restart when the watchdog timeout occurs.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- capitalize subject description

 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
index 85e278eb2016..ddbfecd591f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
@@ -115,6 +115,7 @@ da9062_onkey: onkey {
 		watchdog {
 			compatible = "dlg,da9062-watchdog";
 			dlg,use-sw-pm;
+			dlg,wdt-sd = <1>;
 		};
 
 		thermal {
-- 
2.34.1

