Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298B48EC72;
	Thu, 15 Oct 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059761; cv=none; b=KXY8731r5N7l4MiGdF08+xKP/XuYz/nRQMoUWFrhohNScNv9LifmUgbxvoirw5LPL8oRSARotYEiO5BsYXWR9SAsbp6ZCTUO48ag3oXj6wpRGaw043RDJEvbnQzgEHayuVe3ONDgGSJ0w8T930id8X+R+AWlJh1A5NJfIqPF+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059761; c=relaxed/simple;
	bh=vWQ4BZFKiw4ZdpGykk0WvHR+ocy0cnjiKh0h0P0Foq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDWxdb2nS9aGHyhz3Je6bD9nZ5zFUp+GSoMJWIgqXlUh+OqMg3rss6J0oi10PobgDhL8nkKQKPR9LYklkoICzsYOr9hAYpgdQTAX0aR0HUpUkK6oCpYXRfVR/bOucsLTMr/7qCnhW7miGCsLO348pmfDpDz0P6qjz2lQsMb4Z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7hyC0PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7hyC0PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49321F000C4;
	Thu, 15 Oct 2026 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059758;
	bh=p7EZk+lzmJeE4LsSw3GX37rQBpfI6r8PK791dC690Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h7hyC0PSOMUerNNnkjhU/TJSkF39Piqr/V/PlCuAddZo8a5N8op1k8zN5aSMFQG4s
	 2x/FRnIKtf2E3E+Rz6yt/bS7TLMNWPvSq69DheZPEjBQzdgoX1AuiZ3cMXG5lfIwMQ
	 Tie17QNVvqnO8HSuwJtjRnjCQy51t0aEv3GsOgmaufyxj9dHOcio/e9kX64SpkhNqh
	 r6NCMvdbjTTFkpC8Ruqc71yEp5suyxmdvjBRlXco6hG+F69rh82BTrGannRzy/yXwb
	 g0acbs+f5wvA2FVbLe3UGElQIkSjTkyDdMKtZZwpWkaWgfyAAVvWDwUVpV1Ba8XQa5
	 HXCCFGkg6Tx1g==
Date: Thu, 15 Oct 2026 12:22:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: arm: apple: apple,pmgr: Add t6041
 compatible
Message-ID: <20261015-unselfish-camouflaged-ant-decc86@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-5-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-5-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:12AM +0200, Yureka Lilian wrote:
> The PMGR blocks on the Apple Silicon M4 Pro/Max SoCs (t604x) are
> compatible with the previous M1-M4 SoCs. Add "apple,t6041-pmgr" as M4
> Pro/Max specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

