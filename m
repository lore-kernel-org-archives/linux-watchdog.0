Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178F39E191;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703439; cv=none; b=GAOb6754DGF8kZ/CeKD5QI6CHTaX1EJvt+Z9JpjM64sY89zK8Fy/b6rMwS6URFSbXq3EL98bjXjrLhYAAYRJV7V51uLTA4nOTUjDPVMcnd6WyLlUILU9oKzsQdoAG4Iet2YdM5stMDzac5V1VMJqp0YUF/MIlRZevCF97UQa3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703439; c=relaxed/simple;
	bh=Y0cWCT4yjqLtXogLm+JZvDjfNTCrMoqhAiZrJULbINw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxtWnVaC/LNTD0rU1YQAPfHXEBEB3KzPYNb0BrFMGghLthwFuVfVjzPIiY/DEeEcDBN+1ejgz2+Y7aYarZlzvEMghHmMLPRIfOY7eZsLFo7Rq+CsMp27OHrpa2fd22Rknpmq3dkr8Bp25VbQf/RZs1saPzH4ZiKvSzdayz4BMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNQOboHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNQOboHv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A028EC4AF15;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781703439;
	bh=Y0cWCT4yjqLtXogLm+JZvDjfNTCrMoqhAiZrJULbINw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QNQOboHv9ApLrlQupKPM6W4k0uezyUeEnvWzkg4tZANPaDkiCvTz1CATtwSBdu3ik
	 kuGyLKU9TDsWsYxE/3NeEYkTtBEko4Li82D4aixkl0H9+32PktiMIc3aK3W+SMm5U3
	 +oZFlgY28oQJKpmYniOXd7NlUN4v5/PBAb3xHmUVdDcsTn7WJm2AlNJSmxyqhauazo
	 M0aVg+3M36TkcXSjFrmDJMjTaOicblfPB9yoFBAF3Jp1OQPZGpd46nXduKCImBavZt
	 dMxlf8IM3Jz3WbxJGEtF8d0tE1W54DcHUhV+Lw/hkiy+tCAs/Re8abnXiha70BP4nQ
	 4HQhELiXReDXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946AECD98F2;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 22:37:01 +0900
Subject: [PATCH v2 3/5] ARM: dts: mediatek: mt8127: Fix indentation error
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v2-3-6859e29e72a8@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781703437; l=646;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=0uKY942SYdvjWSBpaLmMsTG1mV/4mbR327xAEav7Pe4=;
 b=hczPIBOrOps8IUGtgnPWx/iCDDqqPQE+srrW4PmFCIEjvSIKKlO+EckSCAY/VlThZEkTihr0m
 CWLwSLKo7CsA7neVAu7Wm13hiIgYiE1YGXp5onOoN/xIpMFKZhKSbjm
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


