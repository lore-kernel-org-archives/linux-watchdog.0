Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557C17C203;
	Tue, 13 Oct 2026 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863611; cv=none; b=HFSh3goHN2KClV8C5F0c0YNI4yFiD1EelumEarY8t+0ZrRbchWY1NGtJy9ljBmB9ggJqnYqFYf1DqM6eW7FX7ErNBuUA6JeAcvRc3Josqo9NGwZbv6og/HxgZiPiGV+Rphtd/PaoPCECZcRbE4Jns5juX4q9que1bIi4/Cer9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863611; c=relaxed/simple;
	bh=TTRrJyvNRxboYSTveUZKgra85aWVgFBrgOzTrzAHxZA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gXc8dPNzzjgQvJHefgeoVW5ZXIoXzsm0lhoubbwYZaaf6Y+4LLr6ZVfnJN0lfm7882JTg1SAEWMHF2Uu7WPMmzINz+809/I9gralux93YTrgrBz230NiB3EkN6skDmiZqPuPUlkx+e3IJOUBKsT+iGiSOiXMc4D0pFPnTarFPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3a/OiHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3a/OiHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D861F000FF;
	Tue, 13 Oct 2026 03:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863609;
	bh=ZEsPUt9NUA1+6sDpR2dTcp1X1EqYf9fRn0HWRVGUbq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3a/OiHmf2Dd8M9vRzSJYS6ARiGMaOkSDq0Ph2DPDy7tqxtug3XLpPAAMLBe441DX
	 1eDCMmI8pkf/ulcPc19+1UeAkTrSswcBlKI1BBt/HY1Db6GPpGu+cwfZhgx77lR0XW
	 +37wpf6vP5Zfe6as6z6cbK9/1nCAqmsDj7O4RKGLgtJk5qrnQl/Fl9816/70RzXlmG
	 C1kMq3BXuf0OarwcRjs+QSYiUUzTI3uj0ONAY7SxNAgSF1KMt/M1Jeko/ihMAu42FH
	 NZc8XR9uWaK5qAOyO/Q9Y61EnBwIqG2LNhW3Tp07EhdnCgY4YMKoeMcCbFwL/ZKkue
	 HircDZnsS4vqQ==
Message-ID: <sashiko-outbox-168930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] dt-bindings: gpio: Add Cortina Systems CS7542
 GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v2-3-94f8c0a90cda@gmail.com>
References: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
 <20261013-b4-cs75xx-s2-v2-3-94f8c0a90cda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:53:29 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: gpio: direct mapping of shared global control block
--

commit f730ed90fa497531db852f78666a6a8d9be45f40
Author: Fil Dunsky <filipp.dunsky@gmail.com>

dt-bindings: gpio: Add Cortina Systems CS7542 GPIO controller

This commit introduces a device tree binding for the Cortina Systems CS75xx
GPIO controller. It specifies five banks of 32 GPIO lines, each with its
own interrupt. The pins are shared between GPIO and peripheral functions
configured via a multiplexing register within a global control block.

> diff --git a/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.y=
aml b/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
[ ... ]
> +properties:
> +  compatible:
> +    const: cortina,cs7542-gpio
> +
> +  reg:
> +    items:
> +      - description: GPIO bank registers
> +      - description: GPIO_MUX register of the bank

[Severity: Medium]
Does directly mapping the shared global control block in the reg property
risk resource request collisions at runtime?

If multiple drivers attempt to map the shared global control block, it can
lead to request_mem_region failures. Additionally, handling pin multiplexing
directly in the GPIO controller binding appears to bypass the pinctrl
subsystem.

Should the global control block be defined as a syscon node instead, with
the GPIO controller referencing it via a phandle (for example,
cortina,syscon =3D <&gcb>)? This would allow safe register modifications,
leaving pin multiplexing logic to be managed by the pinctrl subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v2-0-94f8c0a90cda@gmail.com?part=3D3
