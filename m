Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208A1A4F2F;
	Tue,  7 Apr 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578145; cv=none; b=R9u79gKKorNwG7iNZYVyCB9hX4WSX8KOVgm7keoUfF86YPzpDtywcULB28m4/SoRS32qHyB/9kd4f4wHzv6OnGmG3UYtpA2G9DS1zeO6jRWQ0YtyGUkb/qw6OrjhAFd5C+wxC5ZIEPjP5pRjQ06foZCo8zzzjqsNhFwf4qV5izo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578145; c=relaxed/simple;
	bh=B2VEEKnUZtT0OiN2Ngu8Tmj4uvxETDndnz4xu90eo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S07MWt3xJbV/tJwKC3RbIzvXV/gd+yRumcNoNasZzqmn2I+9cN1Wq0yu5NxeA57sxOVJ8RPEYAsTER2tkUuiJ6qIclsLJn3W+wXUjOL7YaeRv6S/AIK9wXSIR68bsI9g20y4cFdFOvBUB7ilAzLSaF5jPVV4HyOwPgTB+FVixk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3pRYXC9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3pRYXC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D250C2BC9E;
	Tue,  7 Apr 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578144;
	bh=B2VEEKnUZtT0OiN2Ngu8Tmj4uvxETDndnz4xu90eo1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3pRYXC9YIMF02RtzVzG/MJGRfH4hEa3cIeKhGdq2KgkefGHN6SK3cizCYBSuJSJ9
	 xaoqGxxB/yg7lFzCmgsd6iclQ5BWMJ7n/6gd+T26KO4RsMfUHOXpFgYTaSR/UylPFw
	 m5moSUAGmJsHxbLijvft2rVPjO19Zn/MW6uLwtwBpi0V8YJwKpAG1LxJKLl+J7AJfB
	 NHLRREeiv2JZzbW9JaF+zKTwALcUhQSkB1OUX8Y08jkju4nNIZTsaSyylHJOditEhe
	 4JN6zjS3ztpz7qeHC/4hVHYHKXM82ctKMrfDhwi24E2Cp0uh1A5WAuRgrKGeLQwl2m
	 dYjNqTo+EiUAw==
Date: Tue, 7 Apr 2026 11:09:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Linus Walleij <linusw@kernel.org>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8122
 compatible
Message-ID: <177557814106.2663832.10126964665811714800.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-7-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-7-5842e1e393a8@jannau.net>


On Fri, 20 Mar 2026 13:23:25 +0100, Janne Grunau wrote:
> The PWM controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-fpwm" as SoC specific
> compatible under "apple,s5l-fpwm" used by the driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

