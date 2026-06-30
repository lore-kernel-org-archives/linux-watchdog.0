Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F741416D09;
	Tue, 30 Jun 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825020; cv=none; b=WhDcG4mFZtujx92JoWrboXm9Bad05phQ/LG1aJW/42oqXE+v7tWwUcrsokxv01tURlJ4c4v8mvz7rsA0aWfARgRg1jDPqT5oJ0/eCo9zRVAmMzL3VRdMObmwrY+LW912Bsp1TxYnecwWNT/U4GOwQ1QfvhSwFuRx6uaaIdrTYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825020; c=relaxed/simple;
	bh=71FGi3GNfI8IifyPtlk3/LtXzoRwq27IZZc7qX9MH1M=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0bQkUI+ISKhf4NPVo5j3MIndrtrjpu2o2hzXh0I3/jh0er/1ZMf6+YBG9w6ernAeSYuHz1i5neA3ikdAL2DKWCiWtyxCArlF2O2IrXiHAZ9hzWztoBEPuEZWyuaN/bHK6MkOJ/cGxhHiTs0mV68S++lAso4Y1uVKJWHeqVEns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib5zBAa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib5zBAa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8C1F000E9;
	Tue, 30 Jun 2026 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825017;
	bh=dW5cnOiLDGaHAlToRbB9W33P9zj9uViAhwdub11Sofg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ib5zBAa98KrK+zI7PQPEclF6Tk/E1NXlO1S6r+8fkB8VlH+26nlhBGsOBDLuJsDaZ
	 AlR8KeC/fcWSWAqFRGFIp01zfpmqThkQvMVswAS0FbfSRE/bt8YEXwUdPdzho7IbH4
	 Wv6b+4latBzWqB7iixSEIbxu0zj06bAqk24o9HySS3zLuIBA5vEh0Y+nONYDCWoQcv
	 cxVd3MNW74HHiw3z6wW90xqBDHHpmhtK1KuqShVLnPUuzsbPjYv0Ku4/uVDI76+LXO
	 bC/Cv2ru88VYa+4YVuMks+53dajuidAgn5p7JH3cXu+apFL4VUD0npqxtsgQoe6GjD
	 FReNwYIZ69JAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260630-dev-b4-aaeon-mcu-driver-v6-4-d66b5fcbd2f0@bootlin.com>
References: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
 <20260630-dev-b4-aaeon-mcu-driver-v6-4-d66b5fcbd2f0@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:10:16 +0000
Message-Id: <20260630131017.60D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional resetting of all hardware pins in the `probe` functi=
on breaks bootloader hand-off and destroys firmware configuration.
- [Medium] Ignoring critical hardware errors during probe initialization le=
ads to inconsistent software state.
--

commit 73ee6d66b506331ac77e36c415e83febae316cf0
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU

This commit adds a GPIO driver for the Aaeon SRG-IMX8P embedded controller.
It supports 7 GPO pins and 12 GPIO pins, providing access to pins handled
by the microcontroller. During probe, all pins are reset to a known state.

> diff --git a/drivers/gpio/gpio-aaeon-mcu.c b/drivers/gpio/gpio-aaeon-mcu.c
> new file mode 100644
> index 0000000000000..a9e048c865f5c
> --- /dev/null
> +++ b/drivers/gpio/gpio-aaeon-mcu.c

[ ... ]

> +static void aaeon_mcu_gpio_reset(struct aaeon_mcu_gpio *data, struct dev=
ice *dev)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	/* Reset all GPOs */
> +	for (i =3D 0; i < MAX_GPOS; i++) {
> +		ret =3D aaeon_mcu_gpo_set_cmd(data, i, 0);
> +		if (ret < 0)
> +			dev_warn(dev, "Failed to reset GPO %u state: %d\n", i, ret);
> +		clear_bit(i, data->dir_in);

[Severity: Medium]
Is it safe to update the internal software state tracking when the hardware
command fails?

If aaeon_mcu_gpo_set_cmd() returns an error because the underlying bus is
temporarily inaccessible, clear_bit() is still executed. This could result
in the GPIO controller registering with a mismatched view of the hardware.

> +	}
> +
> +	/* Reset all GPIOs */
> +	for (i =3D MAX_GPOS; i < MAX_GPOS + MAX_GPIOS; i++) {
> +		ret =3D aaeon_mcu_gpio_config_input_cmd(data, i);
> +		if (ret < 0)
> +			dev_warn(dev, "Failed to reset GPIO %u state: %d\n", i, ret);
> +		set_bit(i, data->dir_in);

[Severity: Medium]
Similarly, does this code lead to an inconsistent state by blindly updating
data->dir_in even if aaeon_mcu_gpio_config_input_cmd() fails?

> +	}
> +}
> +
> +static int aaeon_mcu_gpio_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	/*
> +	 * Reset all GPIO states to a known configuration. The MCU does not
> +	 * reset GPIO state on soft reboot, only on power cycle (hard reboot).
> +	 * Without this reset, GPIOs would retain their previous state across
> +	 * reboots, which could lead to unexpected behavior.
> +	 */
> +	aaeon_mcu_gpio_reset(data, &pdev->dev);

[Severity: High]
Could forcing all output pins to low and resetting GPIO configurations to
inputs unconditionally during probe disrupt the state established by the
bootloader?

Overriding the hardware state on every boot could inadvertently cut power to
critical system components like regulators, eMMC, or displays that were left
on by the bootloader or previous kernel execution.

> +
> +	return devm_gpiochip_add_data(&pdev->dev, &data->gc, data);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-dev-b4-aae=
on-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com?part=3D4
