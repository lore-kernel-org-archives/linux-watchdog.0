Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99F12F585;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=QnZocKPQtuGMVK9u5CYmBSYJfkjJTTaVcP7iC9gbf9jDuFbTGGO+9EeQ3yoVc4OUwpTQOinMHjAEyaNzH2w98GZoGxyI/lOZsirMRwZAx/nGE4rw52u0cfjXKaqv+H2gmgRfup9Mxh+qg2+fNIR6enQVYnHEzzv2UnpcASQBdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=Y0cWCT4yjqLtXogLm+JZvDjfNTCrMoqhAiZrJULbINw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuGywbjz44BGVhyu+mB7PiOAum2damKX4XCdoZUP1ZUcHsrZCgYQXGa1QuxujNFdOFLbAEAmV2SVuz/s4uxir7guNlItI6ZW9zbpOXB93g2/Pa6sDWmJ/b+6M3dYp8+R+BId8ja/2ng70jDDG2d4pmRioFyjLKz3XfwyviU7KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH+WQ72B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH+WQ72B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07961C4AF0D;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=Y0cWCT4yjqLtXogLm+JZvDjfNTCrMoqhAiZrJULbINw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rH+WQ72BFm05jT0b8f2f/AZ2CkF722FWJeCCL6PKEQj/sJ/mB++Gug89RylcC+944
	 nR8RLAQ6ky1g6PIcEyKWUErzPUri7KgwemEySi/qqiFgcPXty976lg2nktPe9BYyfh
	 EsNVh4DxR9cgdnDtHv52qIMgNQ/C+8HtwIX3hFc0NPhCPJ7l1AEqc9vwQ0D8PZ1oPr
	 MJlL6V6BLTZ+Vp5yXRBhBC4zjLNZF1ZLUahv3lN+DD3refEDToSR4eGiPhiOZcJKwZ
	 0Vn3F8dQhmRTk2kzlWNn1dPfmI7lCiF/SzuYT5ihlyGo0IQ3SDciF2685SJtsatkhQ
	 kustmxdAmBzEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA2CD98EE;
	Wed, 17 Jun 2026 02:21:11 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 11:20:10 +0900
Subject: [PATCH 1/5] ARM: dts: mediatek: mt8127: Fix indentation error
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-1-d02ad15ac359@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Zakariya Hadrami <zkh1@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=646;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=0uKY942SYdvjWSBpaLmMsTG1mV/4mbR327xAEav7Pe4=;
 b=xHx5Gn9Gq0Z0wUNlXF28Rbsz7c/kBJukg66Jk3CoI0EZFFvXDvRQeYwk4bHd3VItDoHk/9Nqz
 sx0ekvvZU4EBUsy1ACxn43jcD/VpRvGrJwkl6QRW6xOMLnMQr6xF603
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

Fix an indentation error caused by a space at the start of a line.

Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
 arch/arm/boot/dts/mediatek/mt8127.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
index aced173c2a52..bd61ec7e70c0 100644
--- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
@@ -75,7 +75,7 @@ uart_clk: dummy26m {
 			compatible = "fixed-clock";
 			clock-frequency = <26000000>;
 			#clock-cells = <0>;
-                };
+		};
 	};
 
 	timer {

-- 
2.54.0


