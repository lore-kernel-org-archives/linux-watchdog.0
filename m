Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBA33ADAF;
	Wed,  6 May 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059490; cv=none; b=FGRm1xeS0kUwJquKkfBvPOW994qnchCrdD0P2aH9/80INufGk6K4xELcDSAALLG6QDAeJyM6VTiCVtMzb/vQdS0/Wm/2lnK9YYAkQsLH8qS0oJQv6Pb75FQWMgRgaK9PmHyyssMToPm/c7IEWoMzVb9z4bbY4R5nONQ0ql6aoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059490; c=relaxed/simple;
	bh=j+OKmsFL/JotOyweP6504xDjQkf9oQY1pYSSHSoUZ1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t25joo3ydvrz8MS4PpQOg2YZjtF/NXrAhDUrItvizn8owugO36aCRXaxB2i7yR2YBZPlt3PjJtib7No1ziEaQEP59x1hP4rQglAGsysBmTZgl1CaKlM2OSj9WQB0N28twXjWP576dZ4Jtm323nthCJsU/wGFxn2HjWaZUDMFHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HFXfYB8Q; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HFXfYB8Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=Lj0xUKXRifp/RhCmIiTNJQhayVisMI4pFmpAqEssGiA=; b=HFXfYB8QnzIwgGB+I8Y1OVj2wl
	VdM8JrjwSsa/YN/d6JcYcIEl4UKqoBV9Nm05ohVzV9S+F6//tQwbz8v6C928zFgO6IrlEKAtEk+bG
	t+pU8h2vlnwk+wMRMfGrrV2y/rnoNJ4sUhocm50YWQA2jmzTcaicgu8mV9A82bUPjR/D6SEpZN3aj
	UraC3DgnmgmrLE8WdxXMImaXjd7ylLnOF0cZhy81weXyxwHPPPwq8x+sAHdcAscY6Bv9pDHL38INZ
	UG3PFLeZeDS01XYwKuRAYYl4Wc21U/gIEEAQRCC9kbqRDObZlp9Kch8pASPQ+t0MyulX8v2Rt2Jdc
	0FZcp1oQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] dt-bindings: watchdog: Add watchdog compatible for RK3528
Date: Wed,  6 May 2026 11:24:20 +0200
Message-ID: <20260506092420.3320031-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Karlman <jonas@kwiboo.se>

The RK3528 uses the same watchdog block as all previous Rockchip SoCs.
So add a compatible for it to the soc-list.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index 609e98cdaaff..731794dccd4a 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - rockchip,rk3368-wdt
               - rockchip,rk3399-wdt
               - rockchip,rk3506-wdt
+              - rockchip,rk3528-wdt
               - rockchip,rk3562-wdt
               - rockchip,rk3568-wdt
               - rockchip,rk3576-wdt
-- 
2.47.3

