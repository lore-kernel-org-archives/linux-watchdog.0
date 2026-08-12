Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5935AC33;
	Wed, 12 Aug 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521433; cv=none; b=ia9KsdiyLwaEnuWGFdqlMFma057T7NyO5/zD+u/dfpxd9Mt4CCu/j6mMJEWMCz+C+zY99CuQOofoO3gyW0LmXngJOHKoFG7+gl7bFynUsvLXrQ/IfiEDEkZNSPdnwAxCbci87ot4KVYM4mObEvgw1bVqC6GdCTG72211aT1mb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521433; c=relaxed/simple;
	bh=XoMEMfXu1M7KQBIC1/2gwIfYdIodvs/pRUiBF8CFTto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zpc3JgFP1WypmdTaZB9lo6ewX4zzPZUpSVhWTO69NrX7f7n4cGdjTIMxiX9BMhhh766YTu6mLdpNFIt4pFilq5vMr7/ay92X6wk+ZeURtub5P/Zoi9Rltt74dX8Vjh71C0YdptzI2Ncy7ydhKtQeniGrd1b1rCVCISdFEZc6lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9p+9kiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9p+9kiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6271F000E9;
	Wed, 12 Aug 2026 07:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521431;
	bh=gqPSfQDvWk58b78qJLJlh4i3WO7TQGw5UjBqu8qTDgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9p+9kiUBZixsBttTOMmCC07i5kMwzkNRjEryyFFjSl6UrEVAox7tjNMkk4VYlbX2
	 F4ZL3W8MG4UMZnGzDhVtx2MrCncwSdn7Pnonkyg/GOF3n6WlI+7g5VGx9xr2uHaeYd
	 A0nJF47bx4dTumQ5snxBLGKXVZ1NG+wdKeGgd/p73e7Rkpg95IoZg79Vb+/ILwWwrK
	 VesZvJDfsfD+TsOxzVtXVT6ci81KW1npqDH1jqk2vHmTSwWCLAgounuXd0DBtwUgkN
	 G3eZZ8nGieD4A0GEKn6TCvy9gd/883S8GpbtRQhOgxROe35irBKOwyz0/bcYZGeeYo
	 DpKq1QXBCEKgA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v4 5/5] rtc: pcf85363: add watchdog support with
 configurable step size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260812074533.3545058-5-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
 <20260812074533.3545058-5-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:57:10 +0000
Message-Id: <20260812075711.0C6271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Hardware timer value is not scaled by the selected clock frequency=
, resulting in radically incorrect watchdog timeouts.
- [High] The watchdog initializes with a 0-second hardware timeout if the d=
evice tree lacks a timeout property.
- [High] Missing `return` statement ignores watchdog initialization failure=
s and breaks probe deferral.

Pre-existing issues:
- [High] Read-modify-write on the write-0-to-clear `CTRL_FLAGS` register si=
lently drops concurrent hardware interrupts.
--

--- Patch [5]: [RESEND v4 5/5] rtc: pcf85363: add watchdog support with con=
figurable step size ---
commit b334f1fe3594f36842ec186290e4071c7236a04d
Author: Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: rtc: pcf85363: add watchdog support with configurable step size

Add watchdog timer support to PCF85263/PCF85363 using the linux watchdog
subsystem. The driver programs the hardware watchdog timeout based on
the requested period.

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 665bbbb169b05..3eb87306c83c8 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c

[ ... ]

> +static int pcf85363_wdt_reload(struct pcf85363_watchdog *wd)
> +{
> +	u8 val;
> +
> +	val =3D ((wd->timeout_val & WD_TIMEOUT_MAX) << WD_TIMEOUT_SHIFT) |
> +	       (wd->clock_sel & WD_CLKSEL_MASK);
> +
> +	return regmap_write(wd->regmap, CTRL_WDOG, val);
> +}

[Severity: High]
Should the timeout value be scaled by the selected clock frequency (e.g., in
ticks) before it is written to the hardware?

It appears the raw seconds value assigned from pcf85363_wdt_set_timeout() is
written directly into the hardware register here. At frequencies higher than
1Hz, this would cause the timeout to expire significantly faster than
configured.

[ ... ]

> +static int pcf85363_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct pcf85363_watchdog *wd =3D watchdog_get_drvdata(wdd);
> +
> +	regmap_update_bits(wd->regmap, CTRL_FLAGS, FLAGS_WDF, 0);

[Severity: High]
This is a pre-existing issue, but since CTRL_FLAGS is a write-0-to-clear
register, can this read-modify-write cycle silently clear concurrent
hardware interrupts?

If an interrupt asserts immediately after the read step in
regmap_update_bits(), its flag will read as 0. The cycle will then write 0
back to that flag, potentially clearing the interrupt before it can be
handled. Pinging the watchdog in a background loop might exacerbate this.

[ ... ]

> +static int pcf85363_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int timeout)
> +{
> +	struct pcf85363_watchdog *wd =3D watchdog_get_drvdata(wdd);
> +
> +	wd->timeout_val =3D clamp(timeout, WD_TIMEOUT_MIN, WD_TIMEOUT_MAX);

[Severity: High]
Is the driver storing the unscaled timeout in seconds directly into the
hardware timer value here?

If this value is later used in pcf85363_wdt_reload() without being adjusted
for the selected clock frequency, the hardware timeout may be radically
incorrect.

[ ... ]

> +static int pcf85363_watchdog_init(struct device *dev, struct regmap *reg=
map)
> +{
[ ... ]
> +	wd->wdd.parent =3D dev;
> +	wd->wdd.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	ret =3D watchdog_init_timeout(&wd->wdd, 0, dev);
> +	if (ret)
> +		wd->wdd.timeout =3D WD_DEFAULT_TIMEOUT;

[Severity: High]
Does watchdog_init_timeout() return 0 when the device tree lacks a timeout
property?

If it returns 0 without modifying wdd.timeout, this check would be bypassed,
leaving the watchdog initialized with a 0-second timeout. Setting
wd->wdd.timeout =3D WD_DEFAULT_TIMEOUT before calling watchdog_init_timeout=
()
might be safer.

[ ... ]

> @@ -685,6 +833,10 @@ static int pcf85363_probe(struct i2c_client *client)
>  			   PIN_IO_TSPM | PIN_IO_TSIM,
>  			   PIN_IO_TSPM | PIN_IO_TSIM);
> =20
> +	ret =3D pcf85363_watchdog_init(dev, pcf85363->regmap);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Watchdog init failed\n");
> +

[Severity: High]
Is a return statement missing here?

Without it, probe failures from pcf85363_watchdog_init() such as -ENOMEM
or -EPROBE_DEFER will be discarded, allowing the device probe to falsely
succeed with a broken or uninitialized watchdog.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812074533.3545=
058-1-lakshay.piplani@nxp.com?part=3D5
