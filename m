Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DC3FE369;
	Wed,  8 Jul 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499732; cv=none; b=KD3e2mqKxl8vBkQaOxoP85vpisxHShEHncsslWYOCs8D7QERx6CF4AAWzU3n/p8Yw2pBL96ALu+FxWmIa8/DQjPct6yJsbFoXefnitoIcOFFFTz/KaTVw3UXwlE3MlIagBRe1PaQEyZX+812DD40BirAeyCxi+98ohx/fVVBFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499732; c=relaxed/simple;
	bh=cdMZlEKgaBkmZ7as1tEhqS76PekiIrVy5DSTeC4EliE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5gobDMyYJdrwYn3PW8Oo/sCo+CCxixqmAAx1VY09mRPIHZQmolJsn5C2MxmKm1ld5troFUDXyB+zPBdTYpJitAoS8xEiYAR5gYYf24PHIY/I0KfEvN64LzzNavS6joRncOZ6DIA0vh0uEsoPfjV/zpLMDdowtqzj9HVzX99aFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwYQ5wlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwYQ5wlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42561F000E9;
	Wed,  8 Jul 2026 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499730;
	bh=OKsbeaL/EYCCjslIHscKdnfqt9TnC3LQo/o4fxsqdJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SwYQ5wlGAgqRjGWeZC+QJ2+/Lf4qkCA9L/NkByYOA6tyKvNukd/wH4AblpspyMfa6
	 ohztbXxM5V7q1DJid4+qC00xO6YK91jiFwvru0NG7+owxsPXFlZmTKVLWoFtyoF4Zg
	 6CfORrAihXEK6Sd7LW+TOwg2XyXc1h9NpUedmnXP/s/0AIKl+VNWphsts/mz6EGpf/
	 RIhZnn0pYAPqg3HrVwtETrjMeDkjY6ju+/kPYMQ4XKmzjnjUX7uvLKD8Jk1oPQ3IEa
	 jcfraojWbW8yc8K5bEFnrq/KOpSaIp/A3jZXvgul/W57DyWfK6JjOppgkLKwGztv7C
	 1/4ijKu+4HqXA==
Date: Wed, 8 Jul 2026 10:35:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8132 compatible
Message-ID: <20260708-hospitable-impressive-ibis-3db61a@quoll>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-2-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-2-e5655ee56523@cyberchaos.dev>

On Sun, Jul 05, 2026 at 03:17:21PM +0200, Yureka Lilian wrote:
> The Apple t8132 (M4) SoC uses an AIC3 as interrupt controller, same as
> the M3 predecessor.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

