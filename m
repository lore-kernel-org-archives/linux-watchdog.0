Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D35540A3;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904774; cv=none; b=Y0+94iUiuLTu68ciMXY9TNozvASr9MpPWd0RKGKYlQX6UIAizES4wYvDwCxnwbFD0mOB5bddUqdx9RntqsvOKJI6O2kjYnCRj0tpia3idqZHu8VmRn5deunUY5T9L4NSL1iKoLRY13y7xYbVKLuAifaSR4xUYpgW/gT22yCZRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904774; c=relaxed/simple;
	bh=KnsYHCmJhO3Vb0bLFDF1cM26DZtWJ5D4q1xH4ulpGn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXXmcEmlc3nSsx2wChRayCXFSuNf8tuhIIBEB1n0VSHvBjvrsYeWxQcbyuMndSEe2qNNoff2tTbm9/kZ5HlCwMGTBbcu9fTkCmhfTuD2fYnn7Eey5gknllyFTK/bOWSpI5aOIswIie7Xf4gzQmtELjq05qNsDWuKdJvnc7ax3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOL02Iln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOL02Iln"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0383BC2BCB8;
	Tue,  8 Sep 2026 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788904774;
	bh=KnsYHCmJhO3Vb0bLFDF1cM26DZtWJ5D4q1xH4ulpGn0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QOL02IlnfHWD7jGXeQEASELSMujAXpwiJTTHcP/DqM0fI60llhoUXT1+upwn5Ky2P
	 tXa92RBQlknBdonNcJuqva+Y2QK/HyzRk80D6/0wXmbPU/MYNr7B95TySsAdl8FVPv
	 oFvOnA9j29ysAN4eVMwTuMHwz2iuouU68whdPedRKtDf0La/vGG9ct0qq9BqlD6LrD
	 N0iPyeFhaXrZVQia1QKpRCDR651QBhpSEwe1MPRxiIAjQCy3aYUNYv+styFw6SjsdL
	 aiys/iiJJGHu/GnuqZ/SQXTxI92XYGSk1naAoDtCdSaH5m2Ri17kVQg/2fGXN+KKlk
	 gpBLzuwbsySKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A2DC79F99;
	Tue,  8 Sep 2026 21:59:33 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Subject: [PATCH v3 0/4] ARM: Basic support for Amazon ford tablet (MT8127)
Date: Tue, 08 Sep 2026 23:59:13 +0200
Message-Id: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQrCMBCF4auUrB1JpiRpXHkPcRGbqc2iTUlKU
 EvvbloQ3Agu/wfzzcISRU+JnaqFRco++TCWqA8Va3s73gm8K82Qo+JKKBjmRqAGO9hXGKEL0cH
 NJt+CkNw4zSV2mlg5nyJ1/rHTl2vp3qc5xOf+KYtt/aD6N5oFcHAcrRPStrU05ymGOYzHgdiGZ
 vwXwgKpRhpCQxpt8w2t6/oGHgY0NwkBAAA=
X-Change-ID: 20260616-mt8127-amazon-ford-basic-1509d7052f7e
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, zkh1@proton.me, 
 Zakariya Hadrami <zkh@mailbox.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788904772; l=1494;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=KnsYHCmJhO3Vb0bLFDF1cM26DZtWJ5D4q1xH4ulpGn0=;
 b=wrrDEg/RMfwoGw7IQo/YXTUhAqbjbcfqBFbr/zOT7u3RChwi/3PRQxILrH055zw5uAUdY7mjA
 ZbasiXzxO5KDxEJ9qYEoQv2vVcwiE+MWi0qA5TCLd+qeeCBsqQkbRV0
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

This series of patches adds basic support for MT8127 SoC based Amazon ford
tablet.

Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
---
Changes in v3:
- Rebase onto v7.3-rc1.
- Drop [PATCH v2 3/5] as it was superseded by upstream changes.
- Link to v2: https://lore.kernel.org/r/20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me

Changes in v2:
- Move amazon ford compatible string to existing enum.
- Fix watchdog node not sorted in unit address ascending order (sashiko report).
- Move bindings documentation patches before patches implementing the bindings.
- Link to v1: https://lore.kernel.org/r/20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me

---
Zakariya Hadrami (4):
      dt-bindings: watchdog: mediatek: Add MT8127
      dt-bindings: arm: mediatek: Add MT8127 Amazon ford
      ARM: dts: mediatek: mt8127: Add watchdog support
      ARM: dts: mediatek: Add basic support for Amazon ford board

 .../devicetree/bindings/arm/mediatek.yaml          |  1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  1 +
 arch/arm/boot/dts/mediatek/Makefile                |  1 +
 arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts  | 46 ++++++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt8127.dtsi             |  7 ++++
 5 files changed, 56 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260616-mt8127-amazon-ford-basic-1509d7052f7e

Best regards,
--  
Zakariya Hadrami <zkh@mailbox.org>


