Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1947D94F;
	Tue, 14 Jul 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045224; cv=none; b=Iy/ML3lnUPN0O/ZCbCyTuQEBXSfCCEjPG/bJZOI+nfkpwaLJL8DK++KT+WZYx13IhfxY4z8Bc4tIluY6tnj2Zaly8Wlref7MUruFhH8wnMsaX6w0+DzaYh3k43dWXLQa0zhCndMKA4RQmBwPNd8huKlQ5J5vt7CA7pBlchxDdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045224; c=relaxed/simple;
	bh=bGI0Gpbt8Ll/QcGGM/ze4eXJBX31bSV8ku+GQggvE94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqw92L1r72g6AlcyIlirdUfSu0n54EkBwNE3PdSo3jC+9yUDeWRYqLK/YTGCe949swss4fIrLCZIUBTm/rE/rg0FZ/is1n+T7Z4oYJuxy7J2/rNuMHlDFU41vRhYOO9AfL142Dtd0TaxTOHBTQBMGQrQGcgyQ+TtpUYoWmDV03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBiD1/Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBiD1/Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83F1F000E9;
	Tue, 14 Jul 2026 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784045223;
	bh=Kh6dtHW8D132EDrP03CbLAKukL3W1CBbIBPBvNU8G+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBiD1/DhFrcSrw59SN6+z03LWhHKIOJG/X5Ftiw+ZeTTezUuaFV/6BJtYH9NnLeX5
	 GMz5kclC6QXyfdtLzwbKabKpl2LcWpcIVkX8IrykRPF1RXt5e78vzXTi9NE5ZkJhlL
	 NN0rsx83f0oOr/rMgCsgiVjBLUbfyh8vH67J9rBDN4YJbaUwN+s3QHEnjhB4emIgZp
	 Khi7/cANH8CKOoBXfB+KdjpyfEFdktXPwNwHfnwGmGACeEY+hBX8ZpIBQu6VglVgbL
	 702vVa8Fypbl5KYSspBxwhufPAYS6/GmcDPF0ohmF41ODrasSCTNC1yu4EB/2G40nv
	 MMBtDjuu50cnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] Add Advantech EIO Watchdog driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: linux-hwmon@vger.kernel.org, mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org
In-Reply-To: <20260714-upstream-v2-v2-6-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-6-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:07:02 +0000
Message-Id: <20260714160702.AD83F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] The `set_timeout` and `set_pretimeout` operations update software =
structures but fail to configure hardware registers when active.
- [High] Bypassing core IRQ safety checks for shared interrupts with a dumm=
y primary handler, causing severe system stalls.
- [High] Hardware system reset is entirely disabled if configured for an al=
ternate event without a pretimeout.
- [High] Incorrect bitmask check for IRQ support causes probe failure.
- [High] Driver illegally passes a raw hardware IRQ line number to the IRQ =
subsystem instead of a mapped virtual IRQ.
- [Medium] Error paths bypass the IOREG_LOCK command, leaving the EC config=
uration space permanently unlocked.
- [Medium] Accumulating negative error codes with bitwise OR and blindly co=
ntinuing I/O operations.
- [Medium] Endianness bug when reading single-byte hardware registers into =
an `int` pointer.
--

--- Patch [6]: [PATCH v2 6/8] Add Advantech EIO Watchdog driver ---
commit a7197d0a8b335e3355964cf7322548e44ad2700e
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Add Advantech EIO Watchdog driver
   =20
This commit adds the driver to control the Advantech EIO Watchdog block,
this block is included in the Advantech EIO Embedded Controller.

> diff --git a/drivers/watchdog/eio_wdt.c b/drivers/watchdog/eio_wdt.c
> new file mode 100644
> index 0000000000000..b3c036a004b30
> --- /dev/null
> +++ b/drivers/watchdog/eio_wdt.c
> @@ -0,0 +1,641 @@
[ ... ]
> +static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int tim=
eout)
> +{
> +	wdd->timeout =3D timeout;
> +	return 0;
> +}

[Severity: High]
Does this code apply the new timeout to the hardware? It updates the softwa=
re
structure, but it appears to omit updating the hardware registers. When
userspace calls WDIOC_SETTIMEOUT, the core updates the structures and pings
the watchdog, but without calling wdt_set_config() here, the new timeout mi=
ght
never be applied to the hardware unless explicitly stopped and started.

> +
> +static int wdt_set_pretimeout(struct watchdog_device *wdd, unsigned int =
pretimeout)
> +{
> +	wdd->pretimeout =3D pretimeout;
> +	return 0;
> +}

[Severity: High]
Similarly to the set_timeout callback, does this code omit configuring the
hardware registers with the new pretimeout value?

[ ... ]
> +static int wdt_set_config(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret, type;
> +	u32 event_time =3D 0;
> +	u32 reset_time =3D 0;
> +
> +	if (eio_wdt->event_type > EVENT_PIN)
> +		return -EFAULT;
> +
> +	/* Calculate event time and reset time */
> +	if (eio_wdt->wdd.pretimeout && eio_wdt->wdd.timeout) {
> +		if (eio_wdt->wdd.timeout < eio_wdt->wdd.pretimeout)
> +			return -EINVAL;
> +
> +		reset_time =3D eio_wdt->wdd.timeout;
> +		event_time =3D eio_wdt->wdd.timeout - eio_wdt->wdd.pretimeout;
> +
> +	} else if (eio_wdt->wdd.timeout) {
> +		reset_time =3D eio_wdt->event_type ?	0 : eio_wdt->wdd.timeout;
> +		event_time =3D eio_wdt->event_type ? eio_wdt->wdd.timeout : 0;
> +	}

[Severity: High]
If configured for an alternate event without a pretimeout, does this disable
the hardware fallback reset? Setting reset_time to 0 means the hardware res=
et
is entirely disabled, and the driver relies exclusively on the software ISR=
 to
call emergency_restart(). If the kernel hangs with interrupts disabled, the=
 ISR
will never run, which might leave the system permanently deadlocked.

[ ... ]
> +static int wdt_get_irq_io(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret  =3D 0;
> +	int idx  =3D EIO_PNP_INDEX;
> +	int data =3D EIO_PNP_DATA;
> +	struct regmap *map =3D eio_wdt->iomap;
> +
> +	mutex_lock(&eio_wdt->core->mutex);
> +
> +	/* Unlock EC IO port */
> +	ret |=3D regmap_write(map, idx, IOREG_UNLOCK);
> +	ret |=3D regmap_write(map, idx, IOREG_UNLOCK);
> +
> +	/* Select logical device to PMC */
> +	ret |=3D regmap_write(map, idx,  IOREG_LDN);
> +	ret |=3D regmap_write(map, data, IOREG_LDN_PMCIO);
> +
> +	/* Get IRQ number */
> +	ret |=3D regmap_write(map, idx,  IOREG_IRQ);
> +	ret |=3D regmap_read(map, data, &eio_wdt->irq);

[Severity: Medium]
Can accumulating the results of regmap_write() and regmap_read() with a
bitwise OR cause issues with negative error codes?=20

Furthermore, if a critical step like selecting the logical device fails, th=
is
code doesn't appear to halt, proceeding to write to whatever logical device
was already selected.

> +
> +	/* Lock back */
> +	ret |=3D regmap_write(map, idx, IOREG_LOCK);
> +
> +	mutex_unlock(&eio_wdt->core->mutex);
> +
> +	return ret ? -EIO : 0;
> +}
> +
> +static int wdt_get_irq_pmc(struct eio_wdt_dev *eio_wdt)
> +{
> +	return pmc_read(eio_wdt->mfd, REG_IRQ_NUMBER, &eio_wdt->irq);
> +}

[Severity: Medium]
Will this corrupt the integer on big-endian systems?

pmc_read() receives a void pointer and, based on the size (1 byte for
REG_IRQ_NUMBER), copies a single byte into the lowest memory address of the
pointer. Since eio_wdt->irq is an int, a big-endian system would put this b=
yte
in the most significant byte location, leaving the integer value corrupted.

> +
> +static int wdt_get_irq(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret;
> +
> +	if (!(eio_wdt->support & BIT(EVENT_IRQ)))

[Severity: High]
Does this check for the incorrect bitmask? EVENT_IRQ is 2, so this checks
BIT(2), but the support flags define SUPPORT_IRQ as BIT(4). This typo could
force the initialization to fail if the hardware supports IRQs but doesn't
set BIT(2).

[ ... ]
> +static int wdt_set_irq_io(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret  =3D 0;
> +	int idx  =3D EIO_PNP_INDEX;
> +	int data =3D EIO_PNP_DATA;
> +	struct regmap *map =3D eio_wdt->iomap;
> +
> +	mutex_lock(&eio_wdt->core->mutex);
> +
> +	/* Unlock EC IO port */
> +	ret =3D regmap_write(map, idx, IOREG_UNLOCK);
> +	if (ret)
> +		goto unlock;
> +	ret =3D regmap_write(map, idx, IOREG_UNLOCK);
> +	if (ret)
> +		goto unlock;
[ ... ]
> +	/* Lock back */
> +	ret =3D regmap_write(map, idx, IOREG_LOCK);
> +
> +unlock:
> +	mutex_unlock(&eio_wdt->core->mutex);
> +	return ret;
> +}

[Severity: Medium]
Does the error path here bypass the IOREG_LOCK command? If any regmap_write=
()
fails after the initial unlock, the jump to unlock only releases the softwa=
re
mutex, skipping the IOREG_LOCK command (0xAA) and leaving the EC IO port op=
en.

[ ... ]
> +static int wdt_set_irq(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret;
> +
> +	if (!(eio_wdt->support & BIT(EVENT_IRQ)))

[Severity: High]
Similar to wdt_get_irq(), does this check BIT(2) instead of BIT(4)?

[ ... ]
> +static irqreturn_t wdt_isr(int irq, void *arg)
> +{
> +	return IRQ_WAKE_THREAD;
> +}

[Severity: High]
Could unconditionally returning IRQ_WAKE_THREAD from a dummy handler cause
severe system stalls for shared interrupts?

The kernel generally forbids requesting an IRQF_SHARED | IRQF_ONESHOT
interrupt without a custom primary handler that checks if its device actual=
ly
triggered the interrupt. When any device on the shared line fires, this
handler will blindly wake the thread and mask the IRQ line for the duration
of the slow reads in the threaded handler, which could cripple other devices
sharing the line.

[ ... ]
> +	if (eio_wdt->event_type =3D=3D EVENT_IRQ) {
> +		ret =3D devm_request_threaded_irq(dev, eio_wdt->irq,
> +						wdt_isr, wdt_threaded_isr,
> +						IRQF_SHARED | IRQF_ONESHOT, pdev->name,
> +						eio_wdt);

[Severity: High]
Does this pass a raw hardware IRQ line number directly to the IRQ subsystem?

The driver reads the IRQ number directly from the EC into eio_wdt->irq and
passes it here. The Linux IRQ subsystem requires a mapped virtual IRQ (virq=
).
Without mapping it via an irqdomain or ACPI, the raw hardware number is
unlikely to trigger correctly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D6
