Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771602;
	b=bF0fX4Ldoi13vE619Kjv5GSbrXV06A7gv75k0OJ8HZo8ovgNFHphiXAPFmHfEj9fZdWt
	 lJ3VUh2halu+99MOZ48juZVbGj3e+gnT6IgrZ/gaPFvFGv7ZSC2qZJQoy4hNZuTdCbvad
	 sLDb434LHulMfDKlx5es7ytFzFMi4YiYkfc71kBJmO3mGt+zPsEvbSz744m/q5lSzjYIo
	 mOOHedcWBIUsqdvNgXp7rAJpfPmV+6qyO8Hl5LR2dNwds7fk2oRL6FvFsJSTax5/eydwY
	 mHaY2BhseTGLwq8O036vaAey5yysRF9dqNbvaYBrjKdpQFU7NQfRRmt0wAXlidlc3PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771602;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UZ8b6FSjjztFRZRInOS21srAOCub1vYlaQEc7H442+0=;
	b=0AbcHeHF4fXliilna4uoGaX79LEVTD9ch8N6aa8uMKCVhSMVQlyCGJsGkYAXiQDAv7nw
	 Lxu7OKa5zWEVvY0fdwXEJJgqMGdk9DTkH4L7Qukj+GKGAdHf8RsvvwiEv5Mbuf0oPXyQu
	 kGWCrm5wZzK47qBU+asLMJVM41NtoEOawX3ojo03lLr9KbFUMu5z4U6f31RBd81jcSINx
	 nlHoK6PnG+lKaNYsHvgoJkJvMOHc75paHViCqwfT6++uwpKbrU57ChUFGZyn+aZclllYV
	 AwYRhLsiGMCU17H6ZRfCOyUTQUkVT0+M4AtVkCzEj3HCcK9494ezBIBlj2vZ7+NNWqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC+k17hM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A886606A682;
	Fri, 27 Nov 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC+k17hM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD311F0089B;
	Fri, 27 Nov 2026 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771602;
	bh=UZ8b6FSjjztFRZRInOS21srAOCub1vYlaQEc7H442+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bC+k17hMNjb1w1yolYbFgLSObI4G3G8VzkJiFWCKUKHDd6vAK/ElmmbDSU00uKI3i
	 ETMnHH3o1JOr3W+PUMHeS/SX0iruS9euKG0+FjkSCnkh4d2sHThvCM/3JQGBMviXfx
	 H5E+ImunTnB3ra+u1Ovjc4ramAYUUYxJ8Xf4mP4U6Y/ccpNELf77y28/SYo43gz6qM
	 EeNl0BePh/cL18Du2oX0g9Zt8G0o5kSdgiP6LRiaPcazNpLRwGFDFpH2MHnhF9/XpG
	 3+TAqP3Z0FR0u7unSCR4gXmtQ38uQciY6Z0H1hDEIbzfFd4PSgYZix/wHGpqVRMOa1
	 37n9mz3eTI8fQ==
Date: Fri, 27 Nov 2026 09:26:34 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Frank Li <Frank.Li@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v10 0/5] Add support for AAEON SRG-IMX8P MCU
Message-ID: <20261127092634.GO38590@joneslee-macbookpro.roam.internal>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
 <179577149953.44397.11685484329530619531.b4-ty@b4>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179577149953.44397.11685484329530619531.b4-ty@b4>

On Fri, 27 Nov 2026, Lee Jones wrote:

> On Fri, 20 Nov 2026 08:23:52 +0100, Thomas Perrot (Schneider Electric) wrote:
> > This patch series introduces support for the AAEON SRG-IMX8P embedded
> > controller (MCU). The MCU is connected via I2C and provides GPIO and
> > watchdog functionality for the SRG-IMX8P board.
> > 
> > The series includes:
> > - Device tree binding for the MFD driver
> > - MFD driver that serves as the core driver for the MCU
> > - GPIO driver implementing the GPIO functionality
> > - Watchdog driver for system monitoring
> > - MAINTAINERS entry for the new drivers
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: vendor-prefixes: Add AAEON vendor prefix
>       commit: 8754d4912daa776faa2525f5e6277a18d40fd939
> [2/5] dt-bindings: mfd: Add AAEON embedded controller
>       commit: 62eb7223813ba41684a22494de046e240f20240a
> [3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
>       commit: 001731afc45c1d8b2724346cd806c02064032ed5
> [4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
>       commit: 10237675f88d8b90eb958ab123f2cdd2c61705d4
> [5/5] watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU
>       commit: 7f99cacfe2793d19acdea392b46592b0c605845c

Pull-request to follow after build testing.

Note to self: ib-mfd-gpio-watchdog-7.5

-- 
Lee Jones
