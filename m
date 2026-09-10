Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88A49BD9F;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047025; cv=none; b=ULoufGNRhXNsvhnxr3TMP7nt7D1lR75QJB597wnesHz0hHemJImOzV7zUTKPrRAMbew/yu0BVokoLaz6v6CfLAbafutLa2jUb4A63Q01JFNrY/0TuXJt6AoYdQaSF+n5OvtGEBvQ9wI7wJeGXg9T3d/ZjAt4fD6tVNgT15Z3ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047025; c=relaxed/simple;
	bh=4N1efCu5ZtlV4h/A83Fgt8jcju0DFf1l13o1JN2/L8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OqdMpbT+sleJrT7P0R4Tu1SS9qj4B85Zbpf8pQ0q6RzGv03XUTm7HyQHVBNb9DmNHTIT0lfaqEHqyTgkU/DmvmOJSKEQ8BnDTwSNIrICbltLxUNTarZuXsdw6KPsImGF85rgib48dfdv/oU0lnogkJoRQsoVcB+tEYPY1nGTiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2jhBx23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2jhBx23"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 583CBC2BCC7;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789047025;
	bh=4N1efCu5ZtlV4h/A83Fgt8jcju0DFf1l13o1JN2/L8Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R2jhBx23vSV3/J/q7bgjVRtPHgFfQ7RkGzaKNEoMKcaQVCRA7eW3H26avUrvaaVaD
	 uhCt/uMPI3lzBecNKQd35qChxVSUR5y1H8hVayF2pTwuM4P/d+yt6iJgRwe//OgjOt
	 w0S2/0MURQlp3Zw0bIs4R+l4aoa5VnxEhDp+6j4lhsijAsCQfc+ueaM+QWCruSG2E5
	 QqR//rxds/WIfjRqkDaCMyRj3ELeux8sNoRgv9MKNND5aNB04mLKEMIlJkhaxTkowg
	 wQ+4mP9hsCz8t7xZzqJNe+s5qpMqAM+L3z0dF1zuRcMh4hWFyEgjIO7SZXWLVbZOrB
	 cAxiukj8gskaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A172C79FBF;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Subject: [PATCH v5 0/4] ARM: Basic support for Amazon ford tablet (MT8127)
Date: Thu, 10 Sep 2026 15:29:11 +0200
Message-Id: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N3WoDIRCG4VsJHtegs6uuPcp9lB6MOiZCdw26L
 GnC3ntMSukPNPTw/WCeubBKJVFlz5sLK7SkmvLUQj1tmD/gtCeeQmsGArTQUvNxHiQYjiOe88R
 jLoE7rMlzqYQNRiiIhlg7PxaK6XSnX15bH1Kdc3m/f1rkbf1Ezd/oIrngQQAGqdB3yu6OJc952
 o7EbugC/4WgQXpQlsCSARx+Q90XZMXwAOoaFH2vXZROewe7EdOby6dtLvsPqv9O2QdU3yiyGJX
 vQaCTP6l1Xa8+oKtznwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789047024; l=1949;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=4N1efCu5ZtlV4h/A83Fgt8jcju0DFf1l13o1JN2/L8Y=;
 b=Fh5JXea12ls0o+Uis/B94T8muFwAgqfQepvZ/GXnF1UlWZSgbywDDwWXl6VlUxnD4Ci7N8orM
 FUSxVd4UqyBBjWfrYRPtoej32dt1Lz7Ws5hjdnXefgjZOtQu7hCWez0
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
Changes in v5:
- Fix model value in dts.
- Fix missing space in watchdog's compatible in dtsi.
- Link to v4: https://patch.msgid.link/20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org

Changes in v4:
- Add chassis-type property to dts.
- Add missing #address-cells, #size-cells and ranges properties to dts
  (sashiko report).
- Link to v3: https://patch.msgid.link/20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org

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
 arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts  | 54 ++++++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt8127.dtsi             |  7 +++
 5 files changed, 64 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260616-mt8127-amazon-ford-basic-1509d7052f7e

Best regards,
--  
Zakariya Hadrami <zkh@mailbox.org>


