Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E530C35F;
	Wed, 11 Mar 2026 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217182; cv=none; b=FHkzrOGfcqmiaS+dNKsnrNrezPnhUFZ6RvjNUY/b9r9KIVPiZZb8F92Ibslz6cwWLOR6AvuxkqlYxy8TlAAO9oiDeDI12qkP/bGLff8xRZo24ed0NBfdJthVjGl822N76yWZxaEcIAh+gIWiEG8S/q7n3dszPIlQ8VZefI825Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217182; c=relaxed/simple;
	bh=P/hUtHq2Vjn+UX3qqxGu9qF3gyaE/w/W3z5oMkjbGqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeddHgNzY9zIHNt0443q1qlyH1OvK1KvgbauuPxHcw93VnZsXs6UMTYV+MoBOQapNLErppJIoNJCzGfe8u2J7jqOYMAQv8NsKv2rb4KqOoK1Vxm5DVY2QZLTt0j8bn3ZIf9FOJDBkbJP8pWjLP1x/AwyyBhZmNiLC4aKEQJ6GWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBgtW0Qv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBgtW0Qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C1C2BC86;
	Wed, 11 Mar 2026 08:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773217182;
	bh=P/hUtHq2Vjn+UX3qqxGu9qF3gyaE/w/W3z5oMkjbGqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBgtW0QvKqVlpJy9xnmanVAvnMjK8n5VlUwU8W/Q3W8RNKKGQX/UZOJVbz+QqDlts
	 hGbFCQX1VTk4pWgl0nYfNNSBRxpFDUe7J2DP8SsL+8ftHJh1ureFGEdySpFCpiI1ou
	 MN5zrsfdP+M5mBBw4M8J32DjB2c3TYuaui0PV/i3Y4JgVMvAEuZgzzmed1tExqmVuP
	 mkjQYL/HlIc9jR2TUDY7hS1X9jewpxRu6HC7VwdD4RVcqjjQCWzL4eOpw0Ph/NU6uy
	 /RAOOPrtrDrwuf68+6QE51MKUFkCm43hVVQlsxqdkaIOqr5J9QjBYhL66DqGBpZBQx
	 JwjqxQfPpxPzQ==
Date: Wed, 11 Mar 2026 09:19:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux@roeck-us.net, wim@linux-watchdog.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de, 
	Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B
 compatible
Message-ID: <20260311-elastic-premium-gharial-eab832@quoll>
References: <20260310002040.417424-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310002040.417424-1-festevam@gmail.com>

On Mon, Mar 09, 2026 at 09:20:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The RV1103B watchdog is compatible with the existing DesignWare Watchdog
> binding. Add the rockchip,rv1103b-wdt compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Fixed a typo in the devicetree mailing list address.
> 
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

