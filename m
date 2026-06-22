Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753C23D281
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140193; cv=none; b=dCpAqHgrTK3yuLQ5JrsTQYWUmzyObSfh4OXs/fKfCev9K9amWLVMJuvHgVxx8Gj0rD/GbvmnAwiSvk/jHakCwttB4KebuzZH5FfOw2PA65Gasker4iVMutNdEqdCwd6kcHMdXGkmCMLB75N4q/jZbONtvDGd3i3OHHEcoafARs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140193; c=relaxed/simple;
	bh=2YbEWGyhWPzhztTmkAZDE0mXAJ6urtE4uPIotfShJMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JHa9nZUGMhyiIsLS27/nRSwGSROt4oPTRozYRmgUseY2eaVUFW8SL4PAkovrK5Pj1HZuOYh88b/mhXQqamtwS8ZTeP8ukfJvAK35AHSxIbRJskjyC/ucnz+ieVAvtn7Dpk8YyoxGJ2wifxCpTyySNXNbNINsgMN3cnn3vtEagq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP4c7tdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP4c7tdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7041F000E9;
	Mon, 22 Jun 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140192;
	bh=VnK2v0onU3pbCF+n2NxGYoLGGzkNdmlAIe00EQrnUCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mP4c7tdFbpR8vKVUhCrRQCoUZ6QjWOAV5yq8v8BZvWlOsO+iA2i3qQvVk6KO3nwpl
	 HqYE6zIqJuE+e80zKt0BnOHSrr9l46NhZJV6S3zxWzw60jxEs63y/H+PRAVzqgb/FS
	 CxaCW65O4Cwr0AcBDcG94RCwg97FzNAwu8jOIIKUSheYrfmnUDR4rYoSCjoWXCqiF9
	 HeY+KIcAUkIBUSw6i+4EyF7n4cM/dyH2dD8eeM4ec8b9h6pJg96MKo1jjHXFMMdLVj
	 Hy11/2mEiItnDs5R5j6GRgs37uguKI3g0UL/pKkosBPARx8b73hgHxxqnzwCEb24u1
	 r9t4moG4KJxzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo
 SE30G2 and SE60
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:56:31 +0000
Message-Id: <20260622145631.DD7041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The global `se_30g2_60_pdev` pointer is not cleared after being fr=
eed on the `platform_device_add()` error path, leading to a Use-After-Free =
and Double-Free during module exit.
- [High] SuperIO configuration mode is prematurely exited before reading `b=
ram_base`, causing the read to fail and the driver to map an invalid I/O po=
rt address.
- [Medium] The allocated and added platform device is permanently leaked if=
 `platform_driver_register()` fails.
- [Medium] The watchdog driver silently ignores hardware access failures if=
 the `bram_base` region cannot be claimed, falsely reporting success to the=
 watchdog core.
--

commit 9d10faee62683aacec801a77d1defa194acc32d0
Author: Mark Pearson <mpearson-lenovo@squebb.ca>

watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
   =20
Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.

> diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog=
/lenovo_se30g2_se60_wdt.c
> new file mode 100644
> index 0000000000000..56e0e9ef8462b
> --- /dev/null
> +++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
> @@ -0,0 +1,274 @@
[ ... ]
> +static unsigned short lpc_chip_id(void)
> +{
> +	unsigned char msb, lsb;
> +
> +	outb(0x87, CFG_PORT);
> +	outb(0x01, CFG_PORT);
> +	outb(0x55, CFG_PORT);
> +	outb(0x55, CFG_PORT);
> +	msb =3D lpc_read(0x20);
> +	lsb =3D lpc_read(0x21);
> +	lpc_write(0x2, 0x2);

[Severity: High]
Does this lpc_write() prematurely exit SuperIO configuration mode?

Later in se_30g2_60_wdt_probe(), the code attempts to select the BRAM
logical device and read the base address:

se_30g2_60_wdt_probe() {
    ...
    lpc_write(CFG_LDN, CFG_BRAM_LDN);
    bram_base =3D (lpc_read(0x60) << 8) | lpc_read(0x61);
    ...
}

If the configuration mode was already exited here, won't these subsequent
reads return 0xFF, causing bram_base to be set to an invalid address?

> +
> +	return (msb << 8 | lsb);
> +}

[ ... ]

> +static void wdt_write(unsigned short val)
> +{
> +	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
> +		return;
> +	bram_write(BRAM_WDT_REG, (val >> 8) & 0xFF);
> +	bram_write(BRAM_WDT_REG + 1, val & 0xFF);
> +	release_region(bram_base, BRAM_SIZE);
> +}
> +
> +static int wdt_start(struct watchdog_device *wdog)
> +{
> +	wdt_write(wdog->timeout);
> +	return 0;
> +}

[Severity: Medium]
If request_muxed_region() fails in wdt_write(), the function silently retur=
ns.

Since wdt_start() and wdt_ping() call wdt_write() and always return 0, won't
this falsely report success to the watchdog core even if the hardware write
failed?

[ ... ]

> +static int se_30g2_60_create_device(const struct dmi_system_id *id)
> +{
> +	int err;
> +
> +	se_30g2_60_pdev =3D platform_device_alloc("lenovo-se30g2-se60-wdt", -1);
> +	if (!se_30g2_60_pdev)
> +		return -ENOMEM;
> +
> +	err =3D platform_device_add(se_30g2_60_pdev);
> +	if (err)
> +		platform_device_put(se_30g2_60_pdev);

[Severity: High]
If platform_device_add() fails, platform_device_put() frees the device, but
the global se_30g2_60_pdev pointer is not set to NULL.

Since dmi_check_system() returns the number of matches regardless of callba=
ck
errors, module initialization will proceed. When the module is unloaded,
se_30g2_60_wdt_exit() will check if se_30g2_60_pdev is non-NULL and call
platform_device_unregister(), leading to a use-after-free and double-free.

Could se_30g2_60_pdev be explicitly set to NULL on the error path to avoid
this?

> +
> +	return err;
> +}

[ ... ]

> +static int __init se_30g2_60_wdt_init(void)
> +{
> +	if (!dmi_check_system(se_30g2_60))
> +		return -ENODEV;
> +
> +	return platform_driver_register(&se_30g2_60_wdt_driver);
> +}

[Severity: Medium]
If platform_driver_register() fails here, the platform device successfully
allocated and added by the DMI callback is never unregistered.

Will this permanently leak the platform device and cause subsequent module =
load
attempts to fail with -EEXIST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622144531.2413=
447-1-mpearson-lenovo@squebb.ca?part=3D1
