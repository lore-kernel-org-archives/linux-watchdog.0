Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB643ECBC7
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976181; cv=none; b=PPPmgehFn5rD3sAcWQMe2wQ45f19OA17i8ikld776QPzlPAkaB5P2M6j8PnYBLjDH/VndGpGpF5J7CUnBkc5QYiMA+7vITEPapcnKl+HvKdLmEBTgR4apvLH7T0iNt/X0XxXW8euZj2P0l6F21dVAcGAO4bATNqrw+YSsPrAY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976181; c=relaxed/simple;
	bh=hArsqqXRL7BpIT8JZSH//IbnEw4EoBYqazMDaYyjb58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqYdbk5tD309/Td+Hq9yN72KRxTqIsxhgiiP8h8ovNNMTHPnuY6ekcVndPZnH6H4f3t1JLXQc8KYUVBtqORfZRCIqedimhEcu5yldBu3EiOrQRYiizUfA/iOH+lySctCDFuV9SJpz5JQDAF5wLTOZt2zBPCCU1GRH7JCVy3ZHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNkY1NDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNkY1NDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95931F000E9;
	Sat, 25 Jul 2026 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976179;
	bh=hRXbGTC2RidoJ4RgRs7W7sUUTPu8JFNEP5+iqmKJaNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNkY1NDkXvCyFTBU2mDCiuqvw502S2c1yi0OlULpxTZ2mgXAARwLYzB7vwkhgFttv
	 7QKkaeoujBuC9tUh2YRMVl4GDSbi9W1ASY40EUFFPi6EzUj21zMEu1dXq7SLhA8eJ/
	 OUXD6dY5xaLPPOtOMWabqOCRWkIWdDiayFt3nXqExBTAQbuYls9kwTGcdzBP1nDuYU
	 TkQRQnJEOGHGjeh6+ObKF+Acy+jufsS7oL0GOXmBT4S2VeidnCRy4A+kqQpPOrfOlY
	 OQj7H2j0boirXlXVv0byhO5s3kCGgx1LsdFuKEVL5iRWZdG8U7yC7xZs1fA2QTVQxW
	 Y6oP3W4iGRuoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] watchdog: w83627hf_wdt: Convert to platform driver
 model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-2-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-2-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:42:59 +0000
Message-Id: <20260725104259.B95931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Potential NULL pointer dereference in `wdt_probe()` when matching =
via `driver_override`.
- [High] State contamination across unbind/bind cycles due to the use of sh=
ared global device structures.
- [Medium] The watchdog device's parent is not set, resulting in an incompl=
ete sysfs topology and preventing property parsing.
- [Low] An uninitialized empty structure `struct wdt_pdata` is passed to `p=
latform_device_register_data()`.
--

--- Patch [2]: [PATCH 2/9] watchdog: w83627hf_wdt: Convert to platform driv=
er model ---
commit dfce32dc3eb2e74bc7730f263ff7f45b7b16d876
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Convert to platform driver model

This commit converts the w83627hf_wdt driver to use the Linux driver model
by registering it as a platform driver. It replaces direct device=20
initialization and registration with a probe function and standard
platform device structures.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 1529a4e168209..993e65ce4447c 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c

[ ... ]

> @@ -464,6 +467,37 @@ static int wdt_find(int addr)
>  	return ret;
>  }
> =20
> +static int wdt_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> +	enum chips chip =3D id->driver_data;

[Severity: High]
Could platform_get_device_id() return a NULL pointer here if a privileged
user manually forces the device to bind to this driver using the
driver_override sysfs interface?

If so, does id->driver_data trigger a NULL pointer dereference since the
platform bus matching logic bypasses the id_table?

> +	int ret;
> +
> +	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
> +
> +	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
> +		 id->name);
> +
> +	watchdog_init_timeout(&wdt_dev, timeout, NULL);

[Severity: High]
Does modifying statically allocated global structures like wdt_info and
wdt_dev instead of using dynamically allocated per-device state cause state
contamination across unbind/bind cycles?

If the driver is unbound and rebound via sysfs, the wdt_dev.status bitmask
retains accumulated state flags like WDOG_HW_RUNNING. If this flag is false=
ly
retained, wouldn't the watchdog core spawn a worker thread to automatically
ping the watchdog on behalf of the kernel, defeating the watchdog's purpose
if userspace hangs?

> +	watchdog_set_nowayout(&wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&wdt_dev);
> +
> +	ret =3D w83627hf_init(&wdt_dev, chip);
> +	if (ret) {
> +		pr_err("failed to initialize watchdog (err=3D%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_watchdog_register_device(&pdev->dev, &wdt_dev);

[Severity: Medium]
Is the sysfs topology broken here because the global wdt_dev struct lacks
a .parent =3D &pdev->dev assignment before registration?

Since the parent is not set and watchdog_init_timeout() earlier is passed a
NULL device pointer, won't the watchdog character device be created at the
root of the sysfs hierarchy instead of as a child of the platform device,
preventing standard properties like timeout-sec from being parsed?

> +	if (ret)
> +		return ret;
> +
> +	pr_info("initialized. timeout=3D%d sec (nowayout=3D%d)\n", wdt_dev.time=
out,
> +		nowayout);
> +
> +	return ret;
> +}

[ ... ]

> @@ -533,35 +580,25 @@ static int __init wdt_init(void)
>  			return chip;
>  	}
> =20
> -	pr_info("WDT driver for %s Super I/O chip initialising\n",
> -		chip_name[chip]);
> -
> -	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
> -		 chip_name[chip]);
> -
> -	watchdog_init_timeout(&wdt_dev, timeout, NULL);
> -	watchdog_set_nowayout(&wdt_dev, nowayout);
> -	watchdog_stop_on_reboot(&wdt_dev);
> -
> -	ret =3D w83627hf_init(&wdt_dev, chip);
> -	if (ret) {
> -		pr_err("failed to initialize watchdog (err=3D%d)\n", ret);
> -		return ret;
> -	}
> -
> -	ret =3D watchdog_register_device(&wdt_dev);
> +	ret =3D platform_driver_register(&wdt_driver);
>  	if (ret)
>  		return ret;
> =20
> -	pr_info("initialized. timeout=3D%d sec (nowayout=3D%d)\n",
> -		wdt_dev.timeout, nowayout);
> +	wdt_pdev =3D platform_device_register_data(NULL, wdt_ids[chip].name,
> +						 PLATFORM_DEVID_NONE, &pdata,
> +						 sizeof(pdata));

[Severity: Low]
Does passing the uninitialized stack variable pdata serve a purpose here?
Although sizeof(pdata) evaluating to 0 makes it currently safe, would it
be clearer to pass NULL and 0 for the size instead?

> +	if (IS_ERR(wdt_pdev)) {
> +		platform_driver_unregister(&wdt_driver);
> +		return PTR_ERR(wdt_pdev);
> +	}
> =20
> -	return ret;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-w83627hf_w=
dt-improvements-v1-0-4e9a1b4e8297@bootlin.com?part=3D2
