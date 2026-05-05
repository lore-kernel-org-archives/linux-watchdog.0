Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C35224AF1
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777952598; cv=none; b=nBQaYKTRomdCoL+d8E96GpiEjUR9I2oN11qXbOzSDXmqGnYniXDxTAJq6lbnA+dYhlwmh/v0H80l+7xLuGVJ8cP5Ay/xyedLgMZ5zJXp3MUw6lDTajTu7NucvATI5HeA/PEpeGIHzsRBBqK2O3MvlTpSwRH7otvg3hHqolIDwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777952598; c=relaxed/simple;
	bh=wI+BdM3mxe1i4wxgatE+O8X5ySOo/FC9hW3qSR8i71c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bWs5pogoIY3+Pju4/Ok42XYUvBiswquuorMJ2y/BHaHGPdWsDmnqx3A86nN4BylgIpbKoklM8WrAmimOZQyTp2+rJl6y9DbAeJLOciK2vf1Eb1wWaj0hAv8wHKUMlbsYx4+CtVRv5IkVRBAwseOnn8Zb8ZOJrDpdpCl08vh+aNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9Mp+Irr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9Mp+Irr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CABC2BCB4;
	Tue,  5 May 2026 03:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777952597;
	bh=wI+BdM3mxe1i4wxgatE+O8X5ySOo/FC9hW3qSR8i71c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s9Mp+Irrq36To8g7nkVfqNcWxVBqQ7rPBz8mCYt07mcG97b0C3UxREh4ye2VWPk2C
	 6tQDdC0wqzGDelzFISY35Iwf1GNGiNPlePE6Bn65S8fBfYMQY9zZTyzBD9IP/o/QWi
	 Ege6ikpvTlXAci6F6/Q4qXATyf4WuO0Accr+YZzf+x6PG9A92SNyu94m9e2cz1UvCs
	 V6jOxTiBtqppEi/XQThSCK+Gii75Sgg1zU9q1/eLeprnGmaOk1TDORyHgSbKPWFgva
	 N8vkgtiFh1zzNphm1g0Fno0z8wQGigCuW39m0vOR0qYTilzNZSTYutge9/cgvwYsGO
	 5M7YqwhiRJobQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: it8712f_wdt: remove redundant driver
Reply-To: sashiko@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260505032145.66065-1-enelsonmoore@gmail.com>
References: <20260505032145.66065-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 03:43:16 +0000
Message-Id: <20260505034317.49CABC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The commit silently removes support for reading the watchdog r=
eset status (`WDIOF_CARDRESET`) and destroys the hardware status on initial=
ization.
- [High] The alias redirecting `it8712f_wdt` to `it87_wdt` causes module lo=
ading to fail if legacy parameters ('margin', 'wdt_control_reg') are provid=
ed, preventing the watchdog from being serviced.
- [High] Removing `CONFIG_IT8712F_WDT` without providing a transitional fal=
lback config will silently drop the built-in watchdog driver during kernel =
updates.
--

commit 7c9bf5495dff37192e527a7fb23eeefe02364661
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

watchdog: it8712f_wdt: remove redundant driver

This commit removes the it8712f_wdt driver in favor of the it87_wdt driver
which also supports the IT8712 hardware. It introduces a module alias to
redirect requests for it8712f_wdt to it87_wdt.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..a84fbf9d52b8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
[ ... ]
> -config IT8712F_WDT
> -	tristate "IT8712F (Smart Guardian) Watchdog Timer"
> -	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
> -	help
> -	  This is the driver for the built-in watchdog timer on the IT8712F
> -	  Super I/0 chipset used on many motherboards.
> -
> -	  If the driver does not work, then make sure that the game port in
> -	  the BIOS is enabled.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called it8712f_wdt.
> -

By completely removing CONFIG_IT8712F_WDT, will users updating their
kernels with make oldconfig silently lose watchdog support since there
is no transitional dummy config that selects IT87_WDT?=20

If the hardware timer is already armed by the firmware, could this lack
of driver support lead to uncontrolled reboots?

> diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wd=
t.c
> deleted file mode 100644
> index b776e6766c9d..000000000000
> --- a/drivers/watchdog/it8712f_wdt.c
> +++ /dev/null
[ ... ]
> -static int it8712f_wdt_get_status(void)
> -{
> -	if (superio_inb(WDT_CONTROL) & 0x01)
> -		return WDIOF_CARDRESET;
> -	else
> -		return 0;
> -}

The old driver reported WDIOF_CARDRESET by reading the WDT_CONTROL register.

The replacement it87_wdt driver does not appear to populate wdt_dev.bootsta=
tus
or report WDIOF_CARDRESET in its capabilities. Will userspace applications
relying on this reset reason fail to detect watchdog reboots?=20

Also, since it87_wdt_init() in the new driver unconditionally writes 0x00 to
WDTCTRL during probe, does this permanently clear the hardware reset status
bit before userspace can ever query it?

> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index 1d9f8591f38d..9da5ec544c8a 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
[ ... ]
> @@ -419,6 +419,11 @@ static void __exit it87_wdt_exit(void)
>  module_init(it87_wdt_init);
>  module_exit(it87_wdt_exit);
> =20
> +/*
> + * Load this driver when the separate IT8712F driver, which was removed,=
 is
> + * requested
> + */
> +MODULE_ALIAS("it8712f_wdt");

If existing user configurations in /etc/modprobe.d/ pass legacy parameters
like margin or wdt_control_reg when requesting it8712f_wdt, will the
module load fail completely because it87_wdt only defines timeout, testmode,
and nowayout?

If modprobe aborts with an unknown parameter error and the BIOS previously
armed the watchdog, could the system unexpectedly hard-reset due to the OS
failing to load the driver to service it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505032145.6606=
5-1-enelsonmoore@gmail.com?part=3D1
