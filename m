Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892049CF20;
	Wed, 23 Sep 2026 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162250; cv=none; b=gvhjqP3JmD8s9GvzFuHG6AmF6kq7HWFdyGcIckWaCWgNXQA9VdiEJkaQ/5z6FxFb3Pnf8I72Ejk0BZ/8gitZkA+pYO8s+FnefeZ6CGcuPGfCZnwpTVkVlGIN3IOPDMlijX1s7Pye8pJKoxEodEgjYchiNvu4xwzBFbuzT0so3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162250; c=relaxed/simple;
	bh=m6OmDeEKThuVYMnuMObEmYVYa2qZpkZQKwQZCJG1xjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxcX5yN5vv4N9aaFBME+z/omRnRfGT4DTYDijiOFmf8vCF+bAZQB/uWE7NhiP55wc0CzZOXCdqsTrDq/6hJ4oDltAMuE+Br0s4xotu3a65q8G8ij/r7/nkK1pvgQd9/JxuUQc5L5iACl3Yvl1jTiMkz+uRiQ9gV7gEIA/IagfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=SEdAfE5s; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="SEdAfE5s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Zafjo+ztTbvBc+RhG0NNSdmfh9nfZ0UyW3dSK9brjw=; b=SEdAfE5sjTs3l5jRqPWHrjP57e
	AqxYekaGt2M6KfUc9/wi00VHZbE3gpzFCAyDOmOhzhjDxQ2tq4+wesiLgg7Fotr2wtqKM7RFp3JZX
	C3x3pJvv7tY76w3ZkcNXubCepdfLeDW+eZybDzwDplZO3YYgv9omKme/Ftmt/MW9BJUdNot2mIved
	aumvKgY9uPO2te0L+jCtJxUI7acoAD08iypVqF42r1u33bNCk2ho57vDYx8msNb7ZedLuaZdr5A5D
	lAltmysyZ1CW4mkDFDoQ7ysGVNFqHyyYGL1FYjnSYy5JSrrTGIiv/4QPmqRSwVG/r2XhkvnLrT9YU
	kk7NacJQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:43182 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9Kyf-0000000A1qw-05sF;
	Wed, 23 Sep 2026 13:17:27 +0200
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
Subject: [PATCH 4/4] ARM: dts: imx6: phycore-som: set watchdog timeout mode to shutdown
Date: Wed, 23 Sep 2026 13:17:19 +0200
Message-Id: <20260923111719.2032012-5-primoz.fiser@norik.com>
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

Enable system restart when the watchdog timeout occurs.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
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

