Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915409;
	b=hq6hKQghA6ZJOfKWm/PqN5K71SiX4YiyroqZlPosNhIyoq97WVfI0g8Wn+VMQz7FqRQc
	 /uhzSQvHeFPQBi0rzISU4oAVCzmc9rp2Mgm2uFGv/NL5Rlpb1JhViM0fBQyw1/ZZ+GuT2
	 AKuk/VnHGLp1uFfPOe7vOZZtLH5swaM0CiAxNuTmXeXENiiGsLWJlcjr25VfDIZb+ZpCY
	 o5piM9HsSTxLcGugKaxBBBQgnGRGOhoODSJOUy6TZGlK0oxMRnv828J+3bcrsA3sWlH0s
	 G75TlZLPPEz2aqmS6lUs+AB/DBnii6IW3J/sijAqvFPKZB52uWluXIdZjl1upRU3fog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915409;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DFh6Lj85QvvS03e5lkAUZeehfvdaN+YlDcZdEO2rzoY=;
	b=UHssrIkvlHa2U5ffUXhwpRfqweQngFSs2e12Sdmgw+9moLvu+B5fzFEq4tu8c+J0tC6T
	 ZyhEiaKpdZHT6kXmSVI7t7QFq5w8X7fCTwDTAHMxnTafvAlAzTC4yXpMYA1bj5/NxHFUD
	 izYOPH2nnAdXk62lf3ww4tszmwsXtVGVf6ihesNoJ4+vXJbqZnB258SLjGNOf6ANEXIOC
	 SCJETWzObrl32j0D2VcY4HJVhOBPq3JoEnycUx0oRJAPCwzE7uGn8RGZazYEYtC8EmzW9
	 WWLJmqqp38TxfDx0cgH8cbiBxg5ToUMlBFueERFzBjbZYECqckaKZCzfQ/3yXqpCxsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Xu5t+edz;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03335606A326
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 21:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03335606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Xu5t+edz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793915406; x=1794174606;
	bh=DFh6Lj85QvvS03e5lkAUZeehfvdaN+YlDcZdEO2rzoY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xu5t+edzpHH1ii6iY+YOkP3s12v9wYG+6RUUo4xUghG3HwMV1RVvVuaosx0ivZkxw
	 gsoeG/UX3mYspquSOZwvXmpuhLssM41TlkEvoTgxugsrkdpIYfndH3JJkHssGwqgL0
	 4T/Kp1YhKwgyahj0HLhyylZgjtYMBbj4iDvVnxwAaHIv0RxGO5RNeoP6gex+ZokGxO
	 f9Wpm0CNvOGPSxfQmHeq8LI6l8Hd4gc2umBGGNFKmdQCbZZNe/aAJT+Irh/1gTqvKa
	 /2JEARvnYyQwzXJ358HeriC353sjuNq7Mo2BjQWW/diFAXaMsKIXOR99j4Toy6ilvc
	 jWe1A0xH5ZaFw==
Date: Thu, 05 Nov 2026 21:50:00 +0000
To: Alexander Letuchiy <asalde.le1@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6895
Message-ID: <xUMh3NwVp4cBhFsWWFE2Xng4h8YH95iJM37_I158WAyVmsRCPbirWT1iU8eMFeiSFw8xco0X45o-2NOeB6Jc4_nWAg25pFPgDMwK3mKzm34=@protonmail.com>
In-Reply-To: <20261105210622.523747-4-asalde.le1@gmail.com>
References: <20261105210622.523747-1-asalde.le1@gmail.com> <20261105210622.523747-4-asalde.le1@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: e26518f322eb5f6161fc7a72d02b2c560e8b1a2c
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

Hi,

On Thursday, November 5th, 2026 at 11:07 PM, Alexander Letuchiy <asalde.le1=
@gmail.com> wrote:

> Add a compatible string for the watchdog of the MediaTek MT6895
> (Dimensity 8100) SoC, which uses mediatek,mt6589-wdt as its fallback.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Does mt6895 actually share the same reset layout as mt6589? Given the
generation leap between these, the former is very unlikely to use
the same resets.

Best regards,
Roman

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index f9b725592c27..cac7d9ae98dd 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt6572-wdt
>                - mediatek,mt6582-wdt
>                - mediatek,mt6797-wdt
> +              - mediatek,mt6895-wdt
>                - mediatek,mt7622-wdt
>                - mediatek,mt7623-wdt
>                - mediatek,mt7629-wdt
> --
> 2.56.0
>=20
>=20
> 
