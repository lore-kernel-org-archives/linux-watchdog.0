Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EA3AC0DD;
	Mon, 20 Jul 2026 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528804; cv=none; b=TZWKvkGTZIbI4+aLAKZxPi3b/DEAaJla0/Jja5kcjB+MU+owmXYvy/bWSbAVIKyHD42xxnZFNCPrJf8GSE90oRLBcEW4KdnMvcSHLErmxLCmnUjyIfXWV7lXi0tnGlgM6ZfU2c7SsQOC7rmFYTFuzAqkqZ8blkTHFCBnZx63F0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528804; c=relaxed/simple;
	bh=R6T5Ib/IdzEDDavjRlO5UsKrCZk4c48j6Zvk+LVg8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyrXvdc6IwmCVoilNQGNOwJYty3guWK0pFF7UweMWeFwH/vnkEIpr/MQMUFovWL4B16bSu1oK3aRsg2M9HuhRMdOulHx0720ZMXct2fGgeF7PsjzuBU8cSt8jDW7IpV2a/TtmUjeD8n4HJtOgU2672EICPDVO8Ee3xwTJe90of0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL/fzfBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL/fzfBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD81F000E9;
	Mon, 20 Jul 2026 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784528801;
	bh=JRm/Fdbz7pUYBW94F8pp9/aSXKWPzOkYgLTec1f/CJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OL/fzfBeZH8DI7O2+evGoTGr7GgE47bREZZLc/c70ELp9q+CQ9+yUm0py6108vYxY
	 pMEZq0KjZ6EcXdqS88UzzvMQsVXTxX2XabCFXlFeGwvisk7SVCND6rRnH+bCU1BRPF
	 6FcV8VVnmEDaeA/f7of9WhP0L7iqwT2fgOze1NJiUIzScYclnSgLwtBnIXTP+iHJLH
	 6HBCUJcLY7jGpx2ntkSDnz+EgC3sekN0wKxj2qLPXBLm+OkX+uqxunZxsGm7JSTEqf
	 N4GxnRpWeGVgPsB846F0hSsFPYMV2ZANui63pfuqwtKeFj/4nMCdywuPILzgw9HuWq
	 vymynse4PvBFw==
Date: Mon, 20 Jul 2026 08:26:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/7] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Message-ID: <20260720-fast-daft-coua-dbd8ab@quoll>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717163959.714561-4-l.scorcia@gmail.com>

On Fri, Jul 17, 2026 at 06:39:14PM +0200, Luca Leonardo Scorcia wrote:
> Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
> which in turn falls back on mt6589-wdt. However according to the data
> sheet mt8167 has 15 sw resets instead of 12, and their order is different

Does 15 over 12 make it incompatible?

And how does the order matter? Order where? Binding does not have even a
single reset.

> from mt6589. Update the wdt binding to add a dedicated compatible for
> mt8167.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 953629cb9558..f514be8a5851 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
>            - mediatek,mt7988-wdt
> +          - mediatek,mt8167-wdt
>            - mediatek,mt8183-wdt
>            - mediatek,mt8186-wdt
>            - mediatek,mt8188-wdt
> -- 
> 2.43.0
> 
