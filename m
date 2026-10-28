Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194410;
	b=rAeleVj5GKQGbE8Nf0Ecna90xQLFaKh3aXPPSuZErxbWHhIFVFEOl9AuIIi2JLZsi+KE
	 B6df4FW2jcWf+KyrZmWhRgF/0dOOxSJFljskdM46Xmw/Vvmk8xlQXmu61GDuar2g2NQmN
	 FZOUJLPEpGeovE7c+qv+CsQ9osDKDPF9zbSPV4uNoiLAw0K6ZdhWzGk0mZ3JVjgzipcoc
	 pobacZvxfC9OpC+h1jA+9F1MhtyFTLKB0QpoN/2LVrNqBnTIjSZQAitkWt3cILmeBvHy9
	 dvrQUWnYAB2pyVDeQDWfxgS+3IELPw1fpkAZ5EwTeJccb0fPNpxZYBmxrkI33UK/ZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194410;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DgrzhI5ozcui7/OQPr/YkjF7zwGD8GT5DcaYCKz+rys=;
	b=MbIFBzbU+10R+UA9PyEX1BTj6DA0T+6vpP7KQH8T7JnB6lzwm55PGhVRw2scy0FuGl46
	 6Blxk/FrtYVIyHCoATExi2t9tcKBH0KYM0Xvna++okyw10q0jTbM3ensSYnKHpV5xeAwA
	 8mznJhWLf5inDadQEFfF8NODnEn8EHDhi1s0C+d20zVpd94ZoVkolXsyKDcPU4kg+1/VU
	 nZ4rje4mD93I8oVmENw5a865wE2nVETM1PkIDJK5giKkDfexeXPimuvGzrCaOh0EooFu/
	 3o75hd3Awyb4tYkO+JPYvFMbkrE6mC8gWwFu/JqOMSrJnjDTnwoE11TyDIl9Uinvajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVIKNVwp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172F606A31A;
	Wed, 28 Oct 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVIKNVwp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6A51F01825;
	Wed, 28 Oct 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194409;
	bh=DgrzhI5ozcui7/OQPr/YkjF7zwGD8GT5DcaYCKz+rys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dVIKNVwpbUZijYgvZIMATDuv3dz1Tc3kLrMwDRXnpssSlSbR+EgOc9GtqCgLUGc54
	 5JlP0wq4vsdx/ysgxLQH0c34txlISjup7FyReIq0jaF3nWGthRoHIiZc3Se2PEseP0
	 46nmmuo2LhWyASTez0Uoj91fj4IYuYFn5KeEWwFrocGZ4nbgEgIswXNZpBqHDVziE+
	 Zs1AP0cSYGD+XeYteHUmvcVio7KRc8GL0QyWOqrGsYXUydt2/BGcoWZ0lwAQruTcPD
	 w0EqutbLEWJ8xeEGdIYqYCtD/+w54iMM3E2GeK7I3vyO7MYTLcLiYvQ8zSAeYeENuI
	 FFhnEwRc1JwSg==
Date: Wed, 28 Oct 2026 14:33:26 +0100
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
Subject: Re: [PATCH 08/10] dt-bindings: i2c: apple,i2c: Add t8142 compatible
Message-ID: <20261028-zircon-caribou-of-experiment-777f60@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-8-1356181bc50d@cyberchaos.dev>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-8-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:28AM +0100, Yureka Lilian wrote:
> The i2c block on the Apple Silicon T8142 (M5) SoC is compatible with
> t8103. Add "apple,t8142-i2c" as SoC specific compatible under
> "apple,t8103-i2c".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

