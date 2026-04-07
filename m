Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69C234973;
	Tue,  7 Apr 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578048; cv=none; b=LAcSGBBnWgYDZccFhytdygNFv7vumrQJ+dhFRUP8TlG+C/vxV0m1lsuCLVDoY0b4WCKOOpMSOVgLM1zWRMPjtgDFwqnvnq/3UnbE8wyIzC2s0vmSTlDbDeKNAqJUd2daM7SbZRASnR34wHVMcOcZsBZj4mujEyBdAghKyLOSOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578048; c=relaxed/simple;
	bh=PeC5naBBK1FeWu9bbU5Wh9SWJPCNfdcAAENIH6WbzAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvMBg7vmsP+2/mQ10eC/fq2Fc6w8Pr1KWYS+b0Z3bxnFbDKtFI0H3kHGpmLSaqKMtakc80NBPq/asjOL8RDHZY7k9T6i+5XyIrwzzK/CyFp60e5jvJnkJftbu1ZVG+SjrbX5ksHlSJ0x7fOJhBJPjM/RAMDLa9RZ8nu4+ILtUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgUdQPKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgUdQPKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C401C116C6;
	Tue,  7 Apr 2026 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578047;
	bh=PeC5naBBK1FeWu9bbU5Wh9SWJPCNfdcAAENIH6WbzAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgUdQPKiI7+sUGUYqoVbVSoQJwGUCcM+skVp99Ax7Y6CHnI3QY0QuZ7QUP0kEz5Zr
	 NmpSCseM3p6BQu4dXM2pnPTDnSXsV6fggo4YsrHNv53xc7CAndXTN5zx+nzEoL+rp8
	 IRHA/XryRhKtEhrRk9KtCt0yPLwISGHXDwe3dmbz9LD984cwsos/ii+MXujyUfzHW1
	 kxIuio9dIwIWiSRiS6Xr4KV9vRqiIiTZVcDSv8blGw3UxPQYKjMAyI7M2ON36nAzh9
	 YOdTMIEaE2xDXW0lhsJ5U6PGFKEtq9boshHS1jX/AgAU4zvKGtbSY6K1Pg6ab8VUji
	 /bV2K6UakFnXw==
Date: Tue, 7 Apr 2026 11:07:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, asahi@lists.linux.dev,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-pwm@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-watchdog@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: arm: apple: apple,pmgr: Add t8122
 compatible
Message-ID: <177557804504.2661217.32030940173770569.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-2-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-2-5842e1e393a8@jannau.net>


On Fri, 20 Mar 2026 13:23:20 +0100, Janne Grunau wrote:
> The PMGR blocks on Apple silicon M3 SoCs (t8122) are compatible with the
> M1 and M2 predecessors. Add "apple,t8122-pmgr" as M3 specific
> compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

