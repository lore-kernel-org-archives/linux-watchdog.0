Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80C3D16FD;
	Thu, 10 Sep 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044638; cv=none; b=LY3Rl46uOq498s9IvqUtKhrBoMvimAyjvkQ5KY31sMptuKirVeWiOxfpgqU6K+2kkm50p30s9xKcLmGU6byjX/gMaX3yMzWpdal29lYIiLczfwUMMCOSvNq946xopQdoGoA50yeJ/x1Imf8Ab54ro7NP1+pgCCS65PZL9Mbo+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044638; c=relaxed/simple;
	bh=Q33+AgLJXzUWN5MXZvERDWEKpSvIZq//bTAFISCS+44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZMj1t/+WwWd59A0AbTfX96gsipLM/jrlrkY5QexYQmk5nPwZy/5tszmVvfY4Ct+kPTGqGlyC3n0i6DTe80f2Vm2cO/XUwdXP9auoU316iKWMPaM5vJ1ouRw1+0DT/UuMvrvMNddI6rUm8H0PY6EetWqO27UrwhqEvUv5o687sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7vHTB1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7vHTB1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172BE1F000FF;
	Thu, 10 Sep 2026 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044637;
	bh=4QSctDRSj6GRip8jzNuQeWHWqzGiG2EhaH/zilXWj/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7vHTB1gxjOuodiIQbKUrQQoipZtkwAy4MM+BXZnd4QqKuRc/szaDtmU/AqB8MlS1
	 WeQL2VBHTVeCSgQBA3tTWs8F0fqm0VM2nTu9Kt41vuAEEn1fQxpQ1ONNpy8oJ9rdEu
	 /ELbWjj1jtvD2xhQitN2zURh8dF1ef4hQAv/hd0k16Q4YYZf2DfMmTGHwTRsJIKVKj
	 GfWukCCEYathD5liSn2Et4xD+ybd6Is6tFAJ8OLf+SG6xgM42WXB7z3qT+ru0sakWL
	 QS4Qnmp/vvB9c9ORxFLoCic1YLk38vQFnX0LkAI509zjiGGYGQ2C3a1Ogs+0b8bCeG
	 AWwXfKz835tdw==
From: matthias.bgg@kernel.org
To: zkh@mailbox.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	zkh1@proton.me,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [v4,2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Date: Thu, 10 Sep 2026 14:50:24 +0200
Message-ID: <20260910125024.70078-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-2-e9af5c420ab1@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add entry for the MT8127 based Amazon ford tablet.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index cd4040ad3437..180e6e4948e7 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -122,6 +122,7 @@ properties:
>            - const: mediatek,mt7988a
>        - items:
>            - enum:
> +              - amazon,ford
>                - mediatek,mt8127-moose
>            - const: mediatek,mt8127
>        - items:
> 
