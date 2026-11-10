Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338555;
	b=JK30mtVS2y91FFOcDZOdw6uhjm1cEvWVA3toSRv8c8HQPlScbgJXAytXU+jidkW2UQyA
	 7NA4Zjj7a2rumt9U7Snjm4hxmDyB5Yy77IOn4Ni6AQmQYSRQ2cCzclIgcTG6yMEkJZkdY
	 nNw5czNH0xr7u2IfEsf/Sb/y6i1csjwP6J1Dop49wlJnbIYgdSbnFgmlFGKDCBk7WHMM1
	 z0Em0Ka9QD2vTnwyrN0zPsz6ZC75/Hn3gRDhoW2Q0ZbgyFGzL2FSpWvCNlYOuBteT7wB4
	 F0IYxq0u7Yr7cFj8zpH5Wn6VHUbplfXBW5jbigQLXmBGgkvP5Oh9A2BAiw6/jkbHHbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338555;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tYBRSyEfnv5cMd7rhyV1pLhfI+yoANtLDE25nt17o90=;
	b=5kndcHy5vtrlAOm6a+0rOjk0PkLdp6JKg1DsGgjFEdFUU/eY8v9AbdRCjU9WP3Yk3sDK
	 ISI556JpZJGRogD98DQVjBw4uSccCWybIS5P223g4TLNsoB+itTl37GWlb4KM5fWNq2dR
	 d1ZR+M+Wsjls92hafp9Kpq8AoraM6ekSl57cdUMhbj3rSlwnXBUb1vyI4qIXB525k9xF4
	 BOvK0QN2kQA1Zr8R9165F80gnZl5KyyIOLRn8Tcrhoi3h2sOJUBD1yA2YzVJ3tjb+p++l
	 K0ap/tEcMdMdwRcW2y0W03zPwXZTW/zwBj91mNaRoJ+/123qn8v1xv8Wznvoq42iYsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANuP8qVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E5606A33B;
	Tue, 10 Nov 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANuP8qVG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794338555;
	b=Y4csWWUXiqt3PQGnP9X8ogVTSgdatNVQFYGZkNT2mlqHuGFnTZ1DVrXrrCMH7H96Ssgn
	 F4Xz5GMDqQ1qG01vMEyeFOolHKMz31qGJBUYiyz8JZzugmt8Sv1AapcaJzBEQsrkqPx8h
	 W1GiHoRBJ6ap2qSofpX2pwOY3M74iktqXPIVTClkpwX3Qw1PYPPIbUAS1VLQjkUeeGOk/
	 Cgyw5k7psJvdncwb3lwtBQU9RvmEtItDnjc0VPmIgM86C1qrCbODNOzliDQLP3Nhk673y
	 axkc9zYOeOlDyboUQeLMmH9S8jcg7+nA68onCnsLVLUih4WWFDtyivsVUKLtQhyHHxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794338555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tYBRSyEfnv5cMd7rhyV1pLhfI+yoANtLDE25nt17o90=;
	b=P8l8ZzWhZ6fAwmKS7hQonWm5r92PIRPHAvBLe/4125BTRPtX492Pp+nmKfOEz0Kyep7V
	 qb8TZUnBPpBWWM5XMoRlXxpd8XWLq5P2xHbDbSvBtZMRfI4oplMCiRvtRK+ViWg37vNGt
	 SaKoMo93wpH+Z8TB0inH1o44izTj4E9VoxpG4OEfKV/6YmBGO0oewXK94rAbRiD1BXAoB
	 4fOYxOWCpAA/CUoIsuV3lW/Rk/UNBsXjUHQrJmzAx1s39I8XpENRQMt1O7rAFx8wM+VjD
	 OBBaSb938wtODXTw0/KUEennWTNJfuCFnNqFix60sjroZbLvi29oyri26BhRdB949Yg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4EB451F008A3;
	Tue, 10 Nov 2026 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338555;
	bh=tYBRSyEfnv5cMd7rhyV1pLhfI+yoANtLDE25nt17o90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ANuP8qVGWvHs6OayUW3YYmxqzzYKQwVW4FyaajrRc8lu8VVEJNFIas6f/dKKYAynX
	 12RGvdVv+DBPqCCrf3wEBzHb6oZgynYoD208FsFWtzIXotvs2I9NgWQGs3QZQoLkUi
	 zxaJj/AvE0pQR4kgdaiJfPCSdlJGRiuJVbAuQbVAR9Z5UH/GPmQ0ryS9emfsAnkDWb
	 rQ1LR36joOb2jn49ccizuY11s7cR5D3qKWa8FCFWQjjD47JdGUcGJ+3VbPbAj3nXVe
	 Y7iSWf+PlDhktaZYT3LG83uwgx1ZNAjbRorG7eMH9vHRLcWHKJbrtDCNDZ1RqxXIPb
	 AbF3+tcNAGmMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CCC8A48C61;
	Tue, 10 Nov 2026 19:22:32 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 21:22:23 +0200
Subject: [PATCH 3/3] arm64: dts: mediatek: mt6797: fix wdt compatible and
 add reset-cells
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
Message-Id: <20261110-6797-wdt-v1-3-7f07755b6074@protonmail.com>
References: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
In-Reply-To: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794338551; l=1078;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=VuN0jtuD+HtYuy89pzuqnoMMbe8NyfZawjbjHy4rttU=;
 b=1dFuWL6ecSyhlJelauX7l708ej5nhN7koHbW5djy5P8rSYePuhYRr7HCqCh+s52bA/JpOHFCA
 tl2bQs0rJAWCiOmmz8br6jzFXPhadD5abjHTpCstLYM6xwkzO7Tr6+B
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

The TOPRGU reset bits on the mt6797 SoC do not match that of mt6589,
therefore they are not compatible [1].

Remove the deprecated mt6589 fallback for mt6797 and add reset-cells to
enable other peripherals to use the TOPRGU resets.

Link: https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf [1]
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 8ac98a378fd6..c0f98ae132dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -218,8 +218,9 @@ scpsys: power-controller@10006000 {
 	};
 
 	watchdog: watchdog@10007000 {
-		compatible = "mediatek,mt6797-wdt", "mediatek,mt6589-wdt";
+		compatible = "mediatek,mt6797-wdt";
 		reg = <0 0x10007000 0 0x100>;
+		#reset-cells = <1>;
 	};
 
 	apmixedsys: apmixed@1000c000 {

-- 
2.56.0


