Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753913803CC;
	Wed, 17 Jun 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693791; cv=none; b=d5+DbyldhkjdIrtaZvQwoTOyHj5k7/gDiv9wWulWF21HKCZMyAaj0Fy6/wGNmHjrn9dNISVYGWJu9ZuoWR0IYOqoY6LdXQ33EkB+OxwRNuDa5RndXZgIT0if3f9e/j+MxnTnLD8t4gCkCgQeLPHVbGtw3pK1ZYAuJWGbUEhX6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693791; c=relaxed/simple;
	bh=XOlwZzaMvyWrJewpWNS5z0GhZTpDQKyVmMhu3NfOG6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrrVhX8GJX0jTOVJsWmu1IkJljipV5z5IEBoDl6Oki8XFbzT42IxLfzpP29GMoN/N6JJtisutWa5xfDqoRk46RRmf9yVm6eg7dOervFXnsM3xWfDh8DTlHTMWu58w4HAxhCOG0vVGNHOB21UsgfuUKaQmlzszDYCR+I+MEbWKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz2iFM52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz2iFM52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1631F000E9;
	Wed, 17 Jun 2026 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781693790;
	bh=1pXP4cxEHLyE7XxRo4PsonDuXCdibzvY8RtS3Yi4bK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cz2iFM520u61ioRCwPffl+mmm0Pv0J5Z/gzXCkwB5Fu40Kj3BxSkWqNms5y6yzvxJ
	 dyHkrRmkxxBbfWHvYbRilncRrZtJptVyokJFf+qqBNafLdvBgkcmKUG7ekqe+fIjT4
	 /0JuIVJNAl31NLbbnCopZ/swBoNWpA5Z6YiYa2sr0Nei/DnvaJ29FzVVdP5RXcLfHf
	 abk1u+/mIKs98PTMTh3budMXVnCGEhkdwoqWa4FjC2SdB+EBCG3IVeiYK00sR48zVH
	 xSwjzqam+A0qqSEOF9w3Wi/x4jNk4g5IJrGy7/niXe8NSV0YHmtcC5BN6HVV0AhAeD
	 8fWVvKM2mLG3g==
Date: Wed, 17 Jun 2026 12:56:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zakariya Hadrami <zkh1@proton.me>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: watchdog: mediatek: Add MT8127
Message-ID: <20260617-fascinating-hasty-dragon-e92b4b@quoll>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
 <20260617-mt8127-amazon-ford-basic-v1-5-d02ad15ac359@proton.me>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-5-d02ad15ac359@proton.me>

On Wed, Jun 17, 2026 at 11:20:14AM +0900, Zakariya Hadrami wrote:
> Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
> one.
> 
> Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof

