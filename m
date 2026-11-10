Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338554;
	b=0PWDw4Ls6YK8yv6+3PcmHIuTf4KegTNs6+HpiQkc1zJCcOw4ubRlgOCAAHzKrJa66unQ
	 UynGIPORWnNJyqyruBuC5hWNLBG/aoLLuzGH5s5SoonD/ICKHPdXAxao23EGx0FxttRH/
	 c7HNkysutuO3AaZEtPYcndXoA8XjgOhPVuWna42pZ0b6ppWh+7i5WamjPxmhSzxDq7Voz
	 p2LOpbk/6HiBH6IC8SnEy2WPwvWaBBVPY/MfDjWMzO1N/U8Mx3CI0lnO3QziCVvDOhu3p
	 f6v1g7+8oFj02mGomPqJNv5cr4X60CQ9OyyaGVoe2oHdzHLbbXspkdFkPNhLHn8BVOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338554;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=L4VYNMQJjxkVQtRujzGGBXYJJspdXKkimKgznnscdQY=;
	b=FtmHCw/2rlbbG4SAcb6O/coSLmqrQbRlXjnSdankjXXm9C3czgJnTZ6X9hUDRlpm70Ie
	 oRc6v8bAXl0B9OuJhLf5LRIlpactVI0ZVk3q8R76yG76EDJtxJyFD9Xp4jqUsUI2iW2vX
	 Z+Fk2C6XJEFHZhj1ZA8gHbjZFCshKZyDZsUYggW4KgAPFDUhsqN0l3jL6Iq/oYm9JZc3J
	 CRIyl8fDy+Q9Vp7eAQhdFnvbXwr9a8GSV9tOuMHMltM9uCoDu+4qgZludPCiuLMamChsW
	 GCoICrkoptjTIzvyaXRBEf3TG44my/iX83G9eEkQETBiYA6SRIh2MSxNjxbMbNcYkeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SG3DouA8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D275606A332;
	Tue, 10 Nov 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SG3DouA8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794338554;
	b=GvbASUcpbhal2m0F75bNv2xG22LAF2DIS48SiabLfAGuPlg0Lw5MAvUxtZoBAigqyFl9
	 OIAvl303ZQlvWpiqlvvRw0AUbS0ffhPjKZCPqY45J51xxUABUPTVbHxWJdQtopSYCGEud
	 sm3praV0w6C/Nosx0AytYN1+9io82tvLckvhE87eNdrW3daWrBIfqgRewBTMTEN/o2WNR
	 2ALzBcFzq7Y5zppmwdv2DIk1+O1+N83sfEZ28ZoHX5MBk9+aABqqHEO2ZB5km1hV4gNdE
	 8kNWSPH9dpE+x+uPEHBR96xGIV6WWLEp5CGGVRGphGbBnpbkLRWNz1NmLyFl2sDDRXQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794338554;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=L4VYNMQJjxkVQtRujzGGBXYJJspdXKkimKgznnscdQY=;
	b=GBV9Nu3+ytYR7QbDLLU1/F0K0/wgUdmNfhj62f8ruDBQjuYV2tLOBaN765BZvdfxhfqE
	 74paKxJ0nZD1tgAiP2epOLlselECLxXDtHQrhm8c8HN6cpoB5z3aZeUqk63wtsQCzNv1M
	 2PddeV/iFLIZ1eayB7kx7TY6AslTsilzm+hDvCZ8by99Fs85775UyNzuMDSdx4dvKlw3/
	 nvDYngO3TNiFsD6yAnZHlTK0+gLbZj7NqomvXzPDm+qW42HXGO442Jg9vYu+hDPnwj7fD
	 N8aIrsNMiybzj2X8davS3MlDuQPLvUBf8ioaskFdsz4jde1PIrehVtEK1OJTHAqQgLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C4AD1F0089F;
	Tue, 10 Nov 2026 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338554;
	bh=L4VYNMQJjxkVQtRujzGGBXYJJspdXKkimKgznnscdQY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SG3DouA8GglzEjIYZKYfmLZWuXG4xOUiXErBIm+x/oHTkSQFXzzmXBnNxmuBFmwjL
	 swYNdaWRn1Xe19BQbf/QMzz4iqrR5a3MpxBUGqoje5FRpFQ12gEdIQ5JfizUK1v+6K
	 RIv/+tPKHHtRqAO0UW9iI3+U5TVTtPkIYTGFQVMvqdW9FyX29vCZKX1ubfnaAZ4nKA
	 +tQraBSsQoSOhicMjuhDtxpTRz9Zjgh2gJtTcvYO2/ZeoJVVhn7XU2we4kGXbKxhHz
	 OreLsZlicYXdLyZ8WiyD0843H3W9Vo9kVrynFSfN0g7otzm9qGPD1UMItR7VdyCfUq
	 rqiB2xFdceWBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8FCCC48C59;
	Tue, 10 Nov 2026 19:22:32 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/3] watchdog: mediatek: fix mt6797
Date: Tue, 10 Nov 2026 21:22:20 +0200
Message-Id: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MDXTNzS3Pd8pQS3dREAxNTCzOzZEtjMyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQA5GQiZbAAAAA==
X-Change-ID: 20261110-6797-wdt-ea045866c936
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ben Grisdale <bengris32@protonmail.ch>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794338551; l=979;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=YuCtHZXtAm427+WUFBsF2fwoSMRhW21Cd4n+6tsctgU=;
 b=X9izG8476fidywRoRhvuRH/2/lNsb1YV3dppMtAdUa7unbApAM95ag7j0PgxItcT54aiKLXln
 qDG8auL6RscAMxy95MMQx0tVRM9dMuUrrZQ9x4RfTPdUV61Y30HVmbB
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series fixes improper mt6797 watchdog compatible, since it's
actually different from the mt6589. It also adds own reset header for
the SoC and reset table in the driver to mapping IDs to bits.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (3):
      dt-bindings: watchdog: mediatek,mtk-wdt: fix mt6797 compatible
      watchdog: mediatek: add mt6797 support
      arm64: dts: mediatek: mt6797: fix wdt compatible and add reset-cells

 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  6 ++++-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi           |  3 ++-
 drivers/watchdog/mtk_wdt.c                         | 27 ++++++++++++++++++++++
 include/dt-bindings/reset/mediatek,mt6797-wdt.h    | 25 ++++++++++++++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-6797-wdt-ea045866c936

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


