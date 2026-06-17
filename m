Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA922E975E;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=DXQXPbyo0prJC0o3Jl5Lo1mr1NvpuEH+08+bi2gM/e36xLGBcbw4KWxENEZObNGuisllsOVsOy9CHBKwGx6AMkn1aW1J1Q/j5G7XM9LoH32Y4BjqXucezIux1A7toaz71gl4EZCqHkD1x+Yo6rIPACNIkd/z2/O13lMjYP7PruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=GFQoPV3WSoQdmzXdEnr9RQpM8gwotYzPgFgNyL8Njlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jcXQLfGlEiQ0qxEXZS5oOISDKSUuq6ds1Ll2RB30FtqUb+IV5Ff8On4+g+9yEplkgyWxviJIEtraYqo2rMLBCANO+NZfzxz1ZGBpnyvGwvnDZKA0tYP4YpRhzXwrvIHtd1ZgoVwswEYImXzOm7Wkij+RrpZhvH4UMv6ax3NSQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaQK9fZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaQK9fZa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAECCC2BCB7;
	Wed, 17 Jun 2026 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=GFQoPV3WSoQdmzXdEnr9RQpM8gwotYzPgFgNyL8Njlg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BaQK9fZaFmJE2OjjOLm4+VByg39mrYEs9yyoCTwXXKrbqZBKw/f5hBSlAEFnoVMdr
	 HOx7IIDn8jm50JpLoezW6Sj3pGuP6dEWIfDcIJB2I+ujhOZBN7a9ttYMnWnLfQcwi7
	 IAGAp/hhXLi4gQaQPadZFaxazwdPM5Hxfao3BOGe2Fv0jC8QJnTW3JLbhUUfq+OecU
	 tNBor4x9TDdTDNniND7ADg3BdHhuxAB9wE1upAYehIaKFp2gwJWVxfMUBJpmuBlfNX
	 oN+BJkeS1vi6Ji1OPXg4Q8GkHPm/szadrg3b2YNgANJ2VwenqjNAkkPzdENHNWwmvQ
	 uhg8zUDq6NB2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A7DCD98F0;
	Wed, 17 Jun 2026 02:21:11 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Subject: [PATCH 0/5] ARM: Basic support for Amazon ford tablet (MT8127)
Date: Wed, 17 Jun 2026 11:20:09 +0900
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQIa2uEi0sx5pFGhoRRXdPW
 r7F/w9kSkwZ+uqBRCdnjqFA1hXMqw0LIbtiUEJpoaXG7WilMmg3e8eAPiaHk808o2xE54xolDc
 EJd8Teb7+9TC+7wekhZpNagAAAA==
X-Change-ID: 20260616-mt8127-amazon-ford-basic-1509d7052f7e
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=1062;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=GFQoPV3WSoQdmzXdEnr9RQpM8gwotYzPgFgNyL8Njlg=;
 b=Lnn0C+XMaDV70G3zD+InDGE4e36gL4nUCacmUuRTqeWQ759q9hdycCmbbi/Bn4/ihasRdRfq/
 H/uL66rDQj8D8WO1ljPLaBjdd5oU40qoLdSsUmCuPD1JLcNh22QZ0zf
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

This series of patches adds basic support for MT8127 SoC based Amazon ford
tablet and fixes a small indentation error in the dtsi file.

Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
Zakariya Hadrami (5):
      ARM: dts: mediatek: mt8127: Fix indentation error
      ARM: dts: mediatek: mt8127: Add watchdog support
      ARM: dts: mediatek: Add basic support for Amazon ford board
      dt-bindings: arm: mediatek: Add MT8127 Amazon ford
      dt-bindings: watchdog: mediatek: Add MT8127

 .../devicetree/bindings/arm/mediatek.yaml          |  4 ++
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  1 +
 arch/arm/boot/dts/mediatek/Makefile                |  1 +
 arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts  | 46 ++++++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt8127.dtsi             |  9 ++++-
 5 files changed, 60 insertions(+), 1 deletion(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260616-mt8127-amazon-ford-basic-1509d7052f7e

Best regards,
-- 
Zakariya Hadrami <zkh1@proton.me>


