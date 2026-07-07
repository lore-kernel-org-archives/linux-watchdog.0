Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DD227EB9;
	Tue,  7 Jul 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411833; cv=none; b=pF22wgfx0XHDjMeCoXdFXvYn6Ops5ETDfZJo0VbFPvXXPReCDwf5sdygdK2ogcv2vlqHutsesn5TkqgZk8jHpkKFwZxqRYPHqshH0gd7ilTqJ3b7BY47nGpGei6Pz/MmIev+kBJsad7mZgIBS9+BApgpdS5s/SBmdGzI50PzbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411833; c=relaxed/simple;
	bh=nVYb2+nBtiuytc+LkxXGC+63os7aPvI3+kij90BmetA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHOc2pGUJu+jP/yUYadw7Uwe2FUb2bwQeimBVKp9q8qgJTFkG17xGaGbaWV5D3laeJCCcMplTz9054hbE9LTKgCW/bePbrlth6sdNWMjydcVQGN0YdW1v8ADqkN2f5oDa0DyOOlIfLlPW8Gg5p4vQFGaJltmAXrbJmTbKjWujLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZtaFM0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZtaFM0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6BA1F000E9;
	Tue,  7 Jul 2026 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411832;
	bh=b3BdD5Q8kv67zW+Wnu+SQeSBsfoWAzrUn5MZtl/spz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZtaFM0KGFUi4M8YM8WAQ+2JG3bwdCvideMvk7N8+YNurSo16RnK32FQBOCbH91dZ
	 TKEAQO4EGVWzLhAiXsDrMsWfKZTJksqV3RJVr8p49krSVis8bLhf2ICg44ki/gnMbV
	 EJ1tcbfnYSwLgkG8hxXahVHxFZkoe2kYpZYCuWdxbjOysQB5AyQu0+pLNRiLu8+qdO
	 DtbO8JnTXpw+1TW5efqabU66D2zPRhL6e1UW0rI0LLsmxCKhWqUYcJrgeB7KbVNgUw
	 TOdqRoJZvtaBRS28lZRR0u0WIwtekSouVx3eX+qwIFx88+F2Gdow9vjLXqmJ7M/3Rm
	 6DQURAA1nkJXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260707-dev-b4-aaeon-mcu-driver-v7-4-ca6c59abd672@bootlin.com>
References: <20260707-dev-b4-aaeon-mcu-driver-v7-0-ca6c59abd672@bootlin.com>
 <20260707-dev-b4-aaeon-mcu-driver-v7-4-ca6c59abd672@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:10:31 +0000
Message-Id: <20260707081032.1A6BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Destructive hardware initialization of GPIOs during probe
--

--- Patch [4]: [PATCH v7 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MC=
U ---
commit e6765071ae5a9056f6fe12662ec59273ff8b1ac7
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU

Add GPIO driver for the Aaeon SRG-IMX8P embedded controller. This driver
supports 7 GPO pins and 12 GPIO pins and implements state management.
During probe, all pins are reset to a known state.

> diff --git a/drivers/gpio/gpio-aaeon-mcu.c b/drivers/gpio/gpio-aaeon-mcu.c
> new file mode 100644
> index 0000000000000..a9e048c865f5c
> --- /dev/null
> +++ b/drivers/gpio/gpio-aaeon-mcu.c
[ ... ]
> +static int aaeon_mcu_gpio_probe(struct platform_device *pdev)
> +{
> +	struct aaeon_mcu_gpio *data;
[ ... ]
> +	/*
> +	 * Reset all GPIO states to a known configuration. The MCU does not
> +	 * reset GPIO state on soft reboot, only on power cycle (hard reboot).
> +	 * Without this reset, GPIOs would retain their previous state across
> +	 * reboots, which could lead to unexpected behavior.
> +	 */
> +	aaeon_mcu_gpio_reset(data, &pdev->dev);

[Severity: Medium]
Could this unconditional reset during probe abruptly disable critical system
resources like power regulators or displays that were initialized earlier by
the bootloader?

While the comment explains this is an intentional design choice to prevent
undefined behavior across soft reboots, unconditionally resetting all GPOs
to low and GPIOs to inputs in aaeon_mcu_gpio_reset() overrides any existing
hardware setup.

Does this bypass the usual GPIO subsystem convention of safely inheriting
the existing hardware state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dev-b4-aae=
on-mcu-driver-v7-0-ca6c59abd672@bootlin.com?part=3D4
