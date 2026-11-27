Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785047;
	b=Oz/mncfCc3PQ1fvlcPz0xLUtZF2Qk3k4BhPR4SSi1NWfVbmGecFLdpOUTLFmjdxpqWzR
	 bv4jby5SUcO2QvIirThHiaqSPvYvDlHX1Nlcpz/u5l4O9WKlyxNxN5PLx1yklUcRb497c
	 39YAsD85+TCsNTYb339hDTopjm9+Yej64wsqU7jKMkZmQ+YKog5pdxi9/SvZ+bPvSAxBI
	 XfJQf9FVeicYsFtfPNvvOw6Hav3Myh3j8gsXv/ZkT3NoceiYIoR1a2wFLS/SxN6VyGpqo
	 c0MIDPDX8qY0IUimrO28i/fSSpeMnmvisWBmjdAb4iDJSlZVgCbojGdxYTtlapGJn/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785047;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZFxfAAA6GwTz51RC5rJw8wfbBqlOQRlWMUcxU0I/V0E=;
	b=o+8V67lbP434gupLyjFBeRv37FnQgbcw0lsAZUsKF+XyxMgGR71aqXEvC+0Y3HZFDw9X
	 lF+HE9GXn6berBEYAAbSFlMAyJpMAW0T3DNfaYj9Bk0yTjCoV7t2Ke0fy69ZQ1Kt0M2s0
	 WO16/J9L0ufgB2dWq3lct51hSoL2RMF3DeDP53oroAV8kSF9k+YssH/H8gxqAfd6VyD8U
	 PRCRH/9EdWSdupArhen6+FnON0ClEIVmHcOQ7TmncurzbCmdsRo4hEExzw3v5PkNJurV7
	 Rl70iy6J6VoPcy96mLt8TjvOvQHaisdR0lMPXxt/tBJEp8IIVktCTcFElR047X+YFiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.ch;
	spf=pass smtp.mailfrom=protonmail.ch;
	dkim=pass header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b=grn3HwCD;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF0606A31F;
	Fri, 27 Nov 2026 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DF0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b=grn3HwCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1795785043; x=1796044243;
	bh=ZFxfAAA6GwTz51RC5rJw8wfbBqlOQRlWMUcxU0I/V0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=grn3HwCDTOorQ5DALp09B0V9rgT7HOcv09Ofyb9FXml+uMHqwhYYArjSOQMVzhiKS
	 nSD6DHlU4jffGsj6H48yMf8lRqAxTsfI9khmN69QNMoGU+uBuMdkSAKOTWzCCSLvyE
	 96BNClbPVfSAqHyYxohYacXF9qYwgKWc6PHCJYHktHHIIVePz72+RhM+EXQbIg15oo
	 M20FCW1jcvEDPKzKFmtdO+Se3BaooawElpyxhKuBTk2RSj0oMTjc5SALYS+O3I3/UJ
	 8sEBjNFW6yUY+KUpgxUA9tfBwuFfGCQpta0G6CTUL+EuBW47NtP1Ye3ykXnwACiaY+
	 UWiZNY6WQ05TQ==
Date: Fri, 27 Nov 2026 13:10:35 +0000
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
From: Ben Grisdale <bengris32@protonmail.ch>
Cc: rva333@protonmail.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: mediatek: initial support for mt6768
Message-ID: <20261127131027.6af2d515@ben-desktop>
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
Feedback-ID: 27291966:user:proton
X-Pm-Message-ID: edd5e5751e2e69693495bd2942b0edb1496e65e7
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 14:39:53 +0200
"Roman Vivchar via B4 Relay" <devnull+rva333.protonmail.com@kernel.org> wro=
te:

> This series adds basic support for the MediaTek mt6768 SoC and Xiaomi
> Redmi Note 9 smartphone (codenamed "merlin").
>=20
> The mt6768 is a 64-bit SoC featuring six Cortex-A55 and two Cortex-A75
> cores, typically paired with LPDDR4X memory and found in low to mid range
> phones.
>=20
> This series requires custom TF-A and U-Boot forks, because the device
> shipped with broken PSCI implementation and bootloader that pollutes dtb.
> TF-A: https://github.com/mt6768-mainline/arm-trusted-firmware
> U-Boot: https://github.com/mt6768-mainline/u-boot
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Whole series,

Reviewed-by: Ben Grisdale <bengris32@protonmail.ch>

Best regards,
Ben Grisdale

