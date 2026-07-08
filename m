Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E6246784;
	Wed,  8 Jul 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499750; cv=none; b=P5jKFR0sX7rF7bEM00Ergi1p8UTk6ZUY8PFwwI+Y3Fa2OUp5LF8IA56DNZbM2XMUaJ6xvJkwxRQ7TtAWRySH9m4gvkc0/u+B3df5eb/hdUDFor00k8ENS1QRWL4NT2x5crCKDDuLGiuvNJphK2cTX7b4/O0iWoMlyifGJnEY8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499750; c=relaxed/simple;
	bh=LYxUhk+zoFm9glgOhgzKWVQ3YZdCe5fThrJg8xYG8c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5mse7dfbkXkbWMe/h4cCGVGauCRI+1iH7JHRGyej0qcZx8MOxZ2Buv3BbxH654XBpDLLfInQj7vACvl7ON3sNpv+zfA8FT72EBwDZW+qKEQG8dFqwESPjtlHZeeoQE11O/JcckjKuuxnL9825AQzlMgEGYmICNN2KxXfkDxUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9V1lVIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9V1lVIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD31F000E9;
	Wed,  8 Jul 2026 08:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499748;
	bh=0XJWRl+ddl7ZcLOVI4Dq6FDBTx5ez5QcB+HtudEUcog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9V1lVIeVVqdoTYSYzUAFYsmq6sqva2cYrU4298FXbIK74DeqLHRoM7vli1J/CYKS
	 3ndckJeK5jNmjDBdnVhpNVBG8OyuDSVNNhLY9xA8fC1r6tJEpYHnx+FDXqBMIhdHxd
	 UTF4/DlGeP2JTzUP0uC3MJ2SlNQ7LApKAwEHz30n8NUjyuK7NYG737EOa9iQlePy7h
	 llNw/6HjPi8FWOdkHV/NbsIF7z71va3QtkgyeLrWP6c5Fb16pdWJ+/YiT9SfNr44Fg
	 9AZQ5XAXrTUIPwKjWkHR+MRylh3lKMlQJ36Vnc/THNcpwGBgXHuZ/LTe0uSrSIJoRs
	 sPJlhqBsfINDw==
Date: Wed, 8 Jul 2026 10:35:44 +0200
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
Subject: Re: [PATCH 01/10] dt-bindings: arm: cpus: Add Apple M4 CPU core
 compatibles
Message-ID: <20260708-vigilant-agile-wombat-461a9a@quoll>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-1-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-1-e5655ee56523@cyberchaos.dev>

On Sun, Jul 05, 2026 at 03:17:20PM +0200, Yureka Lilian wrote:
> The core types of the M4 SoC no longer carry individual codenames.
> Apple's device trees re-use the 'everest' and 'sawtooth' codenames from
> the M3 generation for all later cores.
> 
> Instead, we use a combination of the SoC's codename ('Donan') and the
> type of core ('e' and 'p' for the efficiency and performance cores
> respectively) as compatible for these cores.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

