Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C43AB276;
	Fri, 17 Jul 2026 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279822; cv=none; b=DDpO9gkydx+lB+hdCMI7oXjcZxnbDOskfaePNiWBZGkLQONJbibGhJtkcQhOBK5adDPZoIO/Vcp5BoINLjqxD6PtDCQ8w7v2Lz8iooOU3nzdw2mYWD9C09woJ1IyEK3ZrZpGsZbd2LiUP/xBk/3FUf3jBVVNbcR3l8DuRQAObNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279822; c=relaxed/simple;
	bh=SBBlU9d4X3MqXqNZ20P0uxNAlPU3+Ek5OXUU+9cPVUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZANDX8Dkbjk4fbF+gcK9EXW0dmo9LkpCNayj0hVUe7ADhsD7oYpAXkHqZ5k2SLh2kwM9jlpCkuE4I0qrIylR6Sf7ZyiNyDl9tg1p+WPaL8OJGk/lLZW0+BGmUB0MHVmHwU96XyD8f/YC+c9Qfj45jCwqscpA33UCZtZFw3Rkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDWNpb+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDWNpb+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8921F000E9;
	Fri, 17 Jul 2026 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279820;
	bh=SBBlU9d4X3MqXqNZ20P0uxNAlPU3+Ek5OXUU+9cPVUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jDWNpb+mktS7vC051liZ6JnIm+pNHzYDenLFHlwwn7vY+ETqyn78DC72GAofKC4ZG
	 Je5uuzj+g0ZoeH/x5T9RNiPgNaavYvx1TGhjIEJjB/yZhrCZT4SYeTc2I/UAlQgirb
	 3FdYzaOw4PLqSlQVJv+yPfPZzX3M+/tjLf/5jGnGRtNhGrkCYb81NZy5nm/shlnFwL
	 TzEuP58+3DdRsXtDD3B0Wku+7BCcKjtAPYv4pBilGp49smoKmDog7Abve0Lrfpcc52
	 r0UPN6sBZj+2zvYlWY9EuH4Nj7CwQmPQeqBjon34TYWmL96oZR+QLBMqIwRV4Q6hIF
	 Vw4LUVUCjkY5w==
Date: Fri, 17 Jul 2026 11:16:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: watchdog: mediatek,mtk-wdt: remove
 mt6589 fallback items
Message-ID: <20260717-turquoise-sponge-of-effort-bdec7e@quoll>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-5-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716161923.266315-5-akkun11.open@gmail.com>

On Fri, Jul 17, 2026 at 01:19:20AM +0900, Akari Tsuyukusa wrote:
> All DTS have been converted to standalone compatibles.
> Remove the items block that allowed the "mediatek,mt6589-wdt" fallback,
> keeping only the flat enum.

1. This is not a separate commit.
2. This lacks explanation WHY you are doing.

NAK.

Best regards,
Krzysztof

