Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4743F0BC;
	Wed, 15 Jul 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144011; cv=none; b=DX6GdQU964I76gdaCfxGMT77az5P7L1JfehklO8vyOn9a8qoJP+/QCc+vTjB1KZe/jONKN/CtK03zyJ7RZoAxRejubbyStLDeKQ1BSadw8VtTumLJUyxtix4LDLqKe4+TqVJVthf0WNgQiq20TrIN6ZOXOxdPAjzk9mpHEozNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144011; c=relaxed/simple;
	bh=oye/OZ98tqRIZ6SA8+Meo/JTmJQmJT2k5ZD4i8GcFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR8nmvhgVsjhemuAdzA16QcPNx/6W82lTpY6YOjSDxfIMt17T/TaBBpEB7+pRy9yhA2ziRTxvcqvrs2pbwwJONWjp/QsJFR7MoeGwgPjqU2RNDeDjigRK+r/smg4a5dohfZxLu+9BgNCNzNVCCMmpCGBsVjFlfT1HlFlSlUD/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=a+ZV63U8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="a+ZV63U8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ENi8hJBzRE8JvriWtXhPZ9ZVhtE90LD36e7AByEnCf4=; b=a+ZV63U8WuOqoQ3yu+1/ONPnRh
	Di8rhROtW1YUP2SLJdPOCAUnMPVeznK3zanPyIualIBpdxK7c0rKBwXy2+iCGcIzOqkGA3FRcAEYV
	/zshvt3M8G1U7uwCxbOqf7g7eowWf7sstsiGB+BTbwQQuUJBNtk8g8pX+ElDNCVogWRwZo+t41GQ4
	aR3OI//ADBpYYIDMNB1NmG/QnMLWqzvxC8KN8hdGAG+4dpfY/1E5UKc5liNE+EsjJ/8bOTed8yDup
	6tFQ00SLDDB5ramSD3LixhZiOfOAUxRrHDkzsFpd2/szCG6dIA2mWVbvvTUTIeUk7xEN+W86Og+WA
	yGsLS3ow==;
From: Heiko Stuebner <heiko@sntech.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Simon Glass <sjg@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Jamie Iles <jamie@jamieiles.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] dt-bindings: watchdog: snps,dw-wdt: Add RV1106 compatible
Date: Wed, 15 Jul 2026 21:33:16 +0200
Message-ID: <2785624.BddDVKsqQX@phil>
In-Reply-To:
 <20260714131856.v2.1.b5339e64b3fe4338b3924ebd9dc0096904699744@changeid>
References:
 <20260714131856.v2.1.b5339e64b3fe4338b3924ebd9dc0096904699744@changeid>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 14. Juli 2026, 21:18:57 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Simon Glass:
> Add the compatible for the watchdog of the Rockchip RV1106, which is
> compatible with the Synopsys DesignWare watchdog.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>=20
> (no changes since v1)
>=20
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> index 9d25f5e497e2..2b16b7c2787b 100644
> --- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> @@ -35,6 +35,7 @@ properties:
>                - rockchip,rk3576-wdt
>                - rockchip,rk3588-wdt
>                - rockchip,rv1103b-wdt
> +              - rockchip,rv1106-wdt
>                - rockchip,rv1108-wdt
>                - rockchip,rv1126-wdt
>            - const: snps,dw-wdt
> ---
> base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
> branch: rv1106d2
>=20
>=20




