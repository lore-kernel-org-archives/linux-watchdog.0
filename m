Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1B3BE62A
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092259; cv=none; b=nGb3SM0zREEo0LqC/fqxW7UFhkqXAicPrfgBqSqKZlH2ecDWcKAEzIQ8oTT1g0A7X5XeVlYYiPQQsQyiljjqwJP91RIaDXRYy+LkNKiSJP8oM4JdS/iGl5N9SQV0jvJZAZjN8bRS1kDMTg+noU7Jli5sybZG4SVPRznC+BneaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092259; c=relaxed/simple;
	bh=N54N4zmVt2VNrSfV4Q97+7WSQSYJeXqUG60AG6QNN8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5PEhBVNOCXdaV+N7aYcQSu+0APT7UDL5h4HcsOD0uUhBm4++DDWQmbZ3qUTA1fPPCMmSBxXXzSf/+TlgCtqDfmofXF8uyQZGjTHH/bgP5kmfsrkCCJmVk+jVkS7PXAEuH54UWkHW97POz0SIBhExFyrja+6pZyfdPZw5Ho/y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iru220lz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iru220lz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD22D1F000E9;
	Sun, 26 Jul 2026 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092257;
	bh=KrZVt+549FTlWiauHIJE41A+zQpaM66IeexLj56YMiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iru220lzHFVIKlmM8/OUfitYk+Wt/L4Tc7miAyFhu5pWWB6bKrelXj0PbFi5OkDhr
	 K6emTew38mU21ArK8VoVgvErOi0oMVVS+ZzV4eGxgaKxh3EHMw7F6I17wr5WzMqibc
	 GUBGd1LSKlCHOH0vr2rI4sEyI+nLtbzQMYfJ66sysCXXD5ZMjnJIcYDXH5m7p3brWx
	 oC7TBvmVizFMa+qf6YNrrIu88zxAn23aOwCpFANAPumVVD1j9521ZrNjkW+A0yFvfb
	 e0zvf8BhTR7E3KcsTkl8CSYodjgtHbfln/hmgwV83RI+NpOWHoHp7nGuDrT2+wM2ir
	 a6fmyTpFGS1dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] watchdog: w83627hf_wdt: Convert to platform
 driver model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-2-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
 <20260726-w83627hf_wdt-improvements-v2-2-3645a2a6c022@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 18:57:37 +0000
Message-Id: <20260726185737.AD22D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Potential NULL pointer dereference in `wdt_probe()` when the devic=
e is bound via sysfs `driver_override`.
- [High] Unbinding and rebinding the platform driver leaks watchdog status =
state, permanently breaking the watchdog.
- [Medium] The watchdog device's parent pointer is not initialized before r=
egistration, breaking the sysfs device hierarchy.

Pre-existing issues:
- [High] Hardware watchdog is left running if `devm_watchdog_register_devic=
e()` fails, guaranteeing an unintended system reboot.
--

--- Patch [2]: [PATCH v2 2/8] watchdog: w83627hf_wdt: Convert to platform d=
river model ---
commit d9d8da674e5ddb501516445617ff593614dca863
Author: Paul Louvel <paul.louvel@bootlin.com>
watchdog: w83627hf_wdt: Convert to platform driver model

This commit converts the w83627hf_wdt driver to the Linux driver model by
using a platform driver and platform device instead of the legacy module
init registration.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 1529a4e168209..206ab91fdb2a9 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -464,6 +465,36 @@ static int wdt_find(int addr)
>  	return ret;
>  }
> =20
> +static int wdt_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> +	enum chips chip =3D id->driver_data;

[Severity: High]
Can platform_get_device_id() return NULL here if the device is bound via
sysfs driver_override? If the driver core's platform_match() succeeds by
matching the driver name and bypasses the id_table, id would be NULL,
causing a NULL pointer dereference when accessing id->driver_data.

> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	dev_info(dev, "WDT driver initialising\n");
> +
> +	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
> +		 id->name);
> +
> +	watchdog_init_timeout(&wdt_dev, timeout, NULL);
> +	watchdog_set_nowayout(&wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&wdt_dev);
> +
> +	ret =3D w83627hf_init(&wdt_dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
> +
> +	ret =3D devm_watchdog_register_device(&pdev->dev, &wdt_dev);

[Severity: Medium]
Should wdt_dev.parent be set to dev before calling
devm_watchdog_register_device()? Without this assignment, the watchdog
device is parented to the virtual sysfs root rather than the physical
platform device, which breaks udev hardware association rules.

[Severity: High]
Does unbinding and rebinding this platform driver leak watchdog status
state? Since wdt_dev is statically allocated and not zeroed during probe,
any state set during a previous bind (like the WDOG_ACTIVE bit) is
preserved. If an administrator unbinds and rebinds the driver, the core
will see WDOG_ACTIVE is already set and return success without calling
the hardware start routine, silently breaking the watchdog.

> +	if (ret)
> +		return ret;

[Severity: High]
This is a pre-existing issue, but does a failure in
devm_watchdog_register_device() leave the hardware watchdog running? If
the BIOS started the hardware watchdog before boot, w83627hf_init() resets
its timeout and leaves it ticking. Because probe returns an error and the
device node is never created, user-space has no way to ping the watchdog,
guaranteeing an unintended system reboot.

> +
> +	dev_info(dev, "initialized. timeout=3D%d sec (nowayout=3D%d)\n",
> +		 wdt_dev.timeout, nowayout);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-w83627hf_w=
dt-improvements-v2-0-3645a2a6c022@bootlin.com?part=3D2
