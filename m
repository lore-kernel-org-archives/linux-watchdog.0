Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3734041C;
	Wed,  7 Oct 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407818; cv=none; b=gU74eUJsQ1KyYWyA+RChVvZByMW5fKxPOEBp7gFzZZwV06ejbVp86e48bqtRXK8I7Aaxy7XddpOWC1s4uy7VKSN5Jpi60Ts55mkEjJKLApNwhVkGVopltixDfXFIa3GkRgChMZUTxMtRWOxOpNG5NvdY/EJhdxe/7BtghDe1u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407818; c=relaxed/simple;
	bh=BGkbjHbFIdqs4+KOUOigk4SJDMKX59o+cT2LuiTtahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZVFljpgWrx+fE+sEAE82D/6HqHY/1pHVI3vgR11Y6+l2DZgGrSn39K93OdoEKZTCU6aTsFZp+6Wd52HgSN58K42be5/KG/zaqQKEwwRlhCJ+5m5Q88O7JHNVeh3OPUD4O1yrUtm9I5BFwBxvAKgqtYb+uZpvKp6NERf1qcZLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me47hgyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me47hgyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C6E1F000FF;
	Wed,  7 Oct 2026 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407817;
	bh=YitjMsQtpWgJ49ALoTgzL7XoEIJ5d18PdiRpr3rLGfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Me47hgyKJk1aV1S8wWVLWR097Apon74PZCF0U26x+TiHBXq9fc4jX+hIBzx5hcQ3Q
	 ph22Or3QHnC9LeE/d/UKpNSoSPi3SlzEx/5E4+I64nfnghXFdxJapEIKDMCyS9Tjk9
	 MHhqrGHKQwr/9pW/Mztmd4xeHRFe4VrWracZe00WKuZNqqVdFqGcPQOdx8tavNZXC5
	 5VGzGAbSJNi6B25n5kb8eNZfR6zk5sQBn7br8pxO4Aly6b6maMufW1YpZIWkQdEAzJ
	 WaIvZL4AwK6VCMyA6DnV/1pcI2oXWmRuRHPKhkO9/Yz19FvzA3QyUO84oQDdUvR5+G
	 GhSzTZSQFydMw==
Date: Wed, 7 Oct 2026 16:16:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@lists.linux.dev,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 09/11] dt-bindings: watchdog: sun4i-a10-wdt: add
 Allwinner B288
Message-ID: <179140781657.375821.13519310768770397051.robh@kernel.org>
References: <20261005202731.153971-1-pmazzini@gmail.com>
 <20261005202731.153971-10-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005202731.153971-10-pmazzini@gmail.com>


On Mon, 05 Oct 2026 21:27:29 +0100, Pablo Mazzini wrote:
> Same watchdog as the A31, which it falls back to.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

