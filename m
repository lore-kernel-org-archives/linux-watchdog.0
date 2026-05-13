Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E23876DF
	for <linux-watchdog@vger.kernel.org>; Wed, 13 May 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714561; cv=none; b=UvihXR3c8wL8cApp+sBRp855+FDtFp40Zv5QRep9jkOb71N4anqMu1RDxPoKs+OL81wTyL8wKfrM9voAq9EQYqVR4qajMkf6DUdVpYVFcqKHP/o1SlEjopki1ial1uBWNX++oKElEYKU2cclRgsc+4fJePNk6w6kE0bjegFIWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714561; c=relaxed/simple;
	bh=x5MCr4cqtMn3oD9e8XUqbJzO2VEIKXTtudxi6Q5Ut30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZ17XotOPNdHF+OwJG/JJz2GN6bNhx/RIXm8OnJ/XmY3UTwMzovBpXi/cYfGKPNXfS9JGn9yIpGRPquYJqtxUP1m14iIcqEX+S5q4fbfUsvfTSekxMNDIfUfzv/W9ZxIUVbMwtCICF6lR3wNvGTPuvUYwXnitUolSHvMm1wDKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEc3AAFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEc3AAFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED050C19425;
	Wed, 13 May 2026 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714561;
	bh=x5MCr4cqtMn3oD9e8XUqbJzO2VEIKXTtudxi6Q5Ut30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nEc3AAFTVRlpBLkAryXCc7VfVpFfZlqYhq1D9siin39I5FBn7aabZn3YXqOiBR4JG
	 wdXoLTmXW01Mvly/5lyx6n21GfbgRiCvIX3QSD8CFFSYkJgwluPHVOa9YltON61Hkr
	 SeNy2Lj46fc9OOJ0/KyHO2F8aGMtgpG4JQoO7Xybb4fCe5kL0uOa64hSEKh1H8IbPd
	 pjgEmCVa5WNjAFLiQmeG1qAYC+fS7PjTTSb3arrEfc1Sa3GKzssPXlA+6nOoC7IKs6
	 9PWT5twNUwjZqQS3NknAyLhj04OLHgRua4AVPq5xdFU5r1rBWsF9LR+emYymOQIjHG
	 N9UBWt8LQa9Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Check ACPI_COMPANION() against
 NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <2280455.irdbgypaU6@rafael.j.wysocki>
References: <2280455.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:22:40 +0000
Message-Id: <20260513232240.ED050C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The watchdog device is exposed to userspace before its hardware in=
itialization is fully complete in `ni903x_acpi_probe`.
- [High] The driver's removal function races with the watchdog core worker =
and userspace, potentially leaving the hardware running after driver unload.
--

commit 6254d703c5994e457b8ddb7846a5094ab95cecda
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

watchdog: ni903x_wdt: Check ACPI_COMPANION() against NULL

This commit adds a check to ensure the ACPI companion object exists
before proceeding with the ni903x_wdt watchdog driver probe.

> diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
> --- a/drivers/watchdog/ni903x_wdt.c
> +++ b/drivers/watchdog/ni903x_wdt.c
> @@ -183,9 +183,14 @@ static int ni903x_acpi_probe(struct platform_device =
*pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct watchdog_device *wdd;
>  	struct ni903x_wdt *wdt;
> +	acpi_handle handle;
>  	acpi_status status;
>  	int ret;
> =20
> +	handle =3D ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -ENODEV;
> +

This isn't a regression introduced by this commit, but while reviewing the
probe function modified here, I noticed a potential race condition.

In ni903x_acpi_probe(), the watchdog device is registered before the
hardware initialization is fully complete:

ni903x_acpi_probe() {
    ...
    ret =3D watchdog_register_device(wdd);
    if (ret)
        return ret;

    outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
         wdt->io_base + NIWD_CONTROL);
    ...
}

Since the character device becomes visible to userspace immediately upon
registration, could a fast userspace process open the device and trigger
ni903x_wdd_start() before the hardware is initialized?

If ni903x_wdd_start() configures the watchdog by writing to the control
register, wouldn't the subsequent outb() in the probe thread clobber this
configuration without preserving the bits set by userspace?

This might leave the watchdog in an unpredictable state and prevent recovery
on a freeze.

There is also a similar pre-existing issue in the removal path.

If ni903x_acpi_remove() calls ni903x_wdd_stop() before
watchdog_unregister_device(), the device remains registered with the
watchdog core while stopping.

Could userspace or the watchdog core worker concurrently execute
ni903x_wdd_ping() during this time?

If ni903x_wdd_ping() performs a read-modify-write on the control register,
and ni903x_wdd_stop() writes a stop command to the same register, is it
possible for the ping operation to write back the active state and re-enable
the watchdog if the stop operation executes between the read and write?

If the driver then unloads while the hardware watchdog continues running
with no driver to pet it, will the system spuriously reboot?

Would it be safer to call watchdog_unregister_device() before stopping the
hardware, or perhaps use watchdog_stop_on_unregister()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2280455.irdbgypaU6@=
rafael.j.wysocki?part=3D1
