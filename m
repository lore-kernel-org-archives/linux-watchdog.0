Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F4322B8F;
	Thu, 15 Oct 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058890; cv=none; b=W89SzAGYX8cJZT24sBXKLeXiGf1Y5BNFeydDpmGCMcbzqHdi8EKkHDAwHWcI7YyS7TbokzcZuB4gHrSNXFDo9fHX6nPLI+6L1QWUvZ/l011CXvscZws8JYnJQ9LJVMepF3XdNo6vJW1zCwfnqh1D3q2TYhIqIZcrnU+qSjeRWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058890; c=relaxed/simple;
	bh=nv5UR5jcuARkmx8zcjUmXFMlrsAzpnihX3C4jieLn1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpR6vUtz1/HnJL9qFtnRCg1KUyanrS4E1SQZt0a31P2OhDagaaVq9WTbWdS1/mQ97RIt+OcQjd1rJQt0E3/tOS+Fj1x8KepitMjt+Hn/ia8BUEFUe6blQjT8qMgXVE1ayZWx+J+t/9rTOAlm4sOVQxctIV8jot8CbrOt9LzkG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6D45R/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6D45R/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0145A1F000C4;
	Thu, 15 Oct 2026 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058889;
	bh=UgZrFqMIAdCiB4C4Y0lOCBcHe4KCtn30JJJoEvXzBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O6D45R/8JViR1CPmgUkxAZ+roCfzOCQyr2hlgmIwhGbuqb92AjuyZY9eDde2+pNgD
	 FPwtH50OEbhBMtMTtjydfsJFEohL2rIyg6ByJpblt4wEvU59dZACZQjez5JxZ/k9WZ
	 S+3e2usebuxlg2QMWGt830OOl0hsPrmKnuj1boyC+Oip9QJG9WdMJ+wBTo8nXIvkCb
	 zH5dFgeoruPbKCtCkXtyVGcbeS1HRZ4GbGS0MTSeOl2nFjmTcK5jw40A4YAD4CHqr1
	 PJnNTk1IwgsLcraWJKUcI/+igKSRV7cnM1jj7C9vFQUpzDv4EZm9A5rJXlqWIbuBAQ
	 A9yX/gbjFECwQ==
Date: Thu, 15 Oct 2026 12:08:04 +0200
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
Subject: Re: [PATCH v2 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Add t6041 compatible
Message-ID: <20261015-audacious-swine-of-fertility-e148d9@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-2-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-2-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:09AM +0200, Yureka Lilian wrote:
> The Apple t604x (M4 Pro/Max) SoCs use an AIC3 as interrupt controller,
> same as the previous M3-M4 SoCs.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

