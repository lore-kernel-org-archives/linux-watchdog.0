Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DB5172CF;
	Thu, 15 Oct 2026 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059778; cv=none; b=XHTFpLxYcNxR9r3qnNyhptvZwWpJ28z7TekVFb8P4De17z24gd5aSLcGLauN0Q4scceX06REBOFE4JPAx/7BwXQWkRO1YRC1FHhBEzsrVh7GvP+B00gjE3zzMY00+QA74+rs/Iov0bz3Q/oLI1yZnydNxS7HlgAaYbBhxtVTbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059778; c=relaxed/simple;
	bh=9u4FlikVlBJjq+v6peKh7xE2WY83Drc12L6QWiMZi1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+C9CHPQ7EiYv08wDFi9WhD8wT+9BeQS7y8o/vs6YBLtXkMSCIZ28Ov5a82TqVizffc0i6g3KwLB5ILzpspRdYwBMlaxLxj7jWeK+eb64OeJqsdQf/QjET4atCUuZkgpgSZGPJlhk5qK/4k6DlFVAkVwPJfNSpHiJlbLzM4RfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3xEnhKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3xEnhKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200D21F000C4;
	Thu, 15 Oct 2026 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059777;
	bh=mUFZIAlXrN+SUeHJd+l2YyIxO1PHasWkKZPT1D9Ys/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3xEnhKCMfgKw5bj7WPhmE8EAeiRldfY95HOojFjhttUpqB45btxUGPI0khzVqqtM
	 7Q+2DWjWmdQH36z60qgZQZjFAuP3ktvnZo06tdor1CTMB0+BqYBb0b+jS/xJXVD7f7
	 2G/7+RrCsGcWGslMQhOfXPR4ntK0/MLsEIY1bCFzBbCs6ah7ccwqlZog7pIYXSD80s
	 uU1rEokqL9q7jN/DikwMWfBpmeFRGPWz8TqX1pD+mWe8s0IN95YkVyJXvv4/zTx+Nq
	 /Hg00GWhobwdXfPw6lseQY1zl7/Cz+Dt7xwovVsKtHvxqgNxhKrnbuFKdr3CvsdCrL
	 ek25CkwJP3aeA==
Date: Thu, 15 Oct 2026 12:22:51 +0200
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
Subject: Re: [PATCH v2 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6041
 compatible
Message-ID: <20261015-remarkable-foxhound-of-finesse-d2dee2@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-6-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-6-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:13AM +0200, Yureka Lilian wrote:
> The PWM controller on Apple Silicon M4 Pro/Max SoCs is compatible with
> the t8103 (M1) one. Add "apple,t6041-fpwm"as per-SoC compatibles for M4
> Pro/Max.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

