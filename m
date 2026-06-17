Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001738C41B;
	Wed, 17 Jun 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693725; cv=none; b=Np8bc6miVQB4tIyqSl2IvmhSwjFxS8SJWwOcXXyx9hAZxkn4M5qFu8JsiDepZ3t6uYPfUw+rd7w+iCnUSHyWusOspA+IHAW/xFAa/G0yWpcl8oIYeRc42Q4REVAKIfB0ccAne6eJVtpSH2a/xIIMd3Sk/WARLrm58jjLFW7v4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693725; c=relaxed/simple;
	bh=5prddQphzbTjCdDVfb1VN13CyHXMMI41dig9Zcn1Ikw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khMz+j0hAdjd00ACHm4F2gSc888EqxHf6/8Vv7tXXMcJhr1iGJ99EGfHO0ldGwxmrepgETxiP7tXjDrHI4veb+knJ0EEwyvlAO2CW9K7sb6ObdlZczeHKeLOY3CCGaM4+RhF4PBnCtIHzx43g9enxKvSjTxD6RMtEpoEgBEns7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/T+qRmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/T+qRmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E151F00A3A;
	Wed, 17 Jun 2026 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781693724;
	bh=CzmyMfOjUoqFSrudEqB/8Bk4sn/k1QYEewnBQo+Bwnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/T+qRmKeRe1xiQtXPb7xphBSvMbr2f/OBq7UwN5FbCxGgMLyE192XdQwWk+VEeM3
	 BaWFeI263quFZrVTRatYSxijDrOTQt66qQIRWQZoNLu8UL0G3DpqpQLjGrNbQUYjQT
	 bxhLVDPMR2g4yvldQtNO77w+9WQO7uaz9LXDPSkLp+Y6vprKOgP57sWbTEI3sACrgr
	 sVbDcE88lheO/X7gpoAfyByr/6hb3Y+OF89AMZcX8MRE1Q/7rQPr3esh3xzfyuUmlK
	 5Qkm44J7a4OrWhcBIJDPNCT76nb8mDQWNWQHlqQjLuR1uuLZ5o99xDQmS+YWY0NzOQ
	 3hg4dAC3PPdIQ==
Date: Wed, 17 Jun 2026 12:55:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zakariya Hadrami <zkh1@proton.me>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Message-ID: <20260617-rigorous-refined-lion-f36a29@quoll>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
 <20260617-mt8127-amazon-ford-basic-v1-4-d02ad15ac359@proton.me>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-4-d02ad15ac359@proton.me>

On Wed, Jun 17, 2026 at 11:20:13AM +0900, Zakariya Hadrami wrote:
> Add entry for the MT8127 based Amazon ford tablet.
> 
> Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 382d0eb4d0af..5ddc79689df9 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -124,6 +124,10 @@ properties:
>            - enum:
>                - mediatek,mt8127-moose
>            - const: mediatek,mt8127
> +      - items:
> +          - enum:
> +              - amazon,ford

And it is not part of existing enum because?

> +          - const: mediatek,mt8127

Best regards,
Krzysztof

