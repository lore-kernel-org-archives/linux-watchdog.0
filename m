Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F941F344;
	Mon, 14 Sep 2026 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378623; cv=none; b=fq9TK4TFGrlyvSUkPJCtY5BNh+I+MNzTJaBw+AHRAostjnbPLj0mZB2AfQfWmVa6ySCc/gsfRqfN/sXQFyaZCmFXy+ZX4kxF+drfprAGnpYWsk+on8I8ZmRC7p7ml9mI9IAxtp+YluGyIiREVBzWcGtzyLIioq8gTvsKmtz6vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378623; c=relaxed/simple;
	bh=hMldSWroWGP/S+eEz+iRvaMa9EjagfN9teuKYm2j7xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKwsOAgbAsMMYvRTc2Cua/kLZpSpF60uzIyxncsefFbPZYhY5rVJEXBSBcPcyKqSwGrW/uorEs3cA2leNF73PZZlPTG2NiWEmcVVIaFwRkyu3Bdv5IGQu5nM8rJq0h3sS4HGfTf/iK85Eb8XoL3hI0Ck13epgOF6RdW1KVkdlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivfswI2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivfswI2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09ED1F00898;
	Mon, 14 Sep 2026 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378621;
	bh=Fb3Gbu63WdRcm3l/BT5yDQ+d6ojJvsJYU6utwkkkNyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivfswI2jhPu3PsLCc2jLEhL+3TGjEiKZcUv193mZaPdq6wTS2tKwPWHkkQpSXozZx
	 Lr2Xt3geTW207OMwsaGMIUpERvvipzrxS3CoDWJvOYBku3bOqnL4qp+t/aANsldFFQ
	 ulB8PbGRiQ4sa7gUJIAPET/WpBNTNQzMKbzckOAWW7TCy+6+2II0PXneTZFAZsO9Cz
	 PK9VwfbsHtZA58vInJsVuc5fyp9ay4M1F1afdhoxDCqh2ECKHcC/y2zuzbbGRvo9Wk
	 prwTF6wHupWXeifPFkZOWojok3rDI29sWPPDihmFuJaeUXsTLeHJv011RGwkgxSljd
	 UnX2zayycrgug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] rtc: pcf85363: add watchdog support with
 configurable step size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260914092126.3757418-5-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
 <20260914092126.3757418-5-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:37:00 +0000
Message-Id: <20260914093700.C09ED1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The watchdog is left running on driver unbind without an IRQ handl=
er, leading to an unhandled interrupt storm.
- [High] The watchdog timer is left running during system suspend, which wi=
ll cause spurious wakeups.
- [Medium] Un-ratelimited dev_err() in the threaded IRQ handler can cause a=
 log storm and consume 100% of a CPU core if clearing the watchdog flag fai=
ls.
--

commit 5bad6cdbd177d2e1690c8afe67f641dfa821a364
Author: Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: rtc: pcf85363: add watchdog support with configurable step size

This commit adds watchdog support to PCF85263/PCF85363 using the watchdog=20
subsystem. The chip has no reset output, so expiry is only signalled via=20
the WDF flag routed to INTA as an alarm-only watchdog.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 22661abd9ebb5..aa45d71e6ab58 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -512,6 +539,15 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, =
void *dev_id)
>  		handled =3D true;
>  	}
> =20
> +	if (flags & FLAGS_WDF) {
> +		dev_warn_ratelimited(&pcf85363->rtc->dev,
> +				     "watchdog timer expired\n");
> +		if (pcf85363_clear_flags(pcf85363, FLAGS_WDF))
> +			dev_err(&pcf85363->rtc->dev,
> +				"failed to clear watchdog flag\n");
> +		handled =3D true;
> +	}
> +

[Severity: Medium]
If the I2C write inside pcf85363_clear_flags() fails (e.g., due to a=20
transient bus error), this path prints a non-ratelimited error and=20
returns IRQ_HANDLED.

Because the physical level-triggered INTA line would remain asserted in=20
hardware, won't the IRQ immediately re-fire and loop infinitely? Could=20
this result in a CPU lockup and a log storm from the un-ratelimited=20
dev_err()?=20

Should the error log be rate-limited, or the interrupt disabled if it=20
cannot be successfully cleared?

[ ... ]
> +static int pcf85363_watchdog_init(struct device *dev, struct pcf85363 *p=
cf85363)
> +{
> +	struct pcf85363_watchdog *wd;
[ ... ]
> +	watchdog_set_drvdata(&wd->wdd, wd);
> +
> +	return devm_watchdog_register_device(dev, &wd->wdd);
> +}

[Severity: High]
If a user unbinds the driver via sysfs while the watchdog is running,=20
will the devm-managed IRQ handler be freed while the hardware watchdog=20
continues to count down?=20

When the hardware timer subsequently expires and asserts the INTA line,=20
could this cause an unhandled interrupt storm that disables the shared=20
IRQ line?=20

Should WDOG_STOP_ON_UNREGISTER be set on the watchdog device, or a=20
custom devm cleanup action be registered to halt the hardware timer=20
on unbind?

[Severity: High]
Does the watchdog timer continue running during system suspend?=20

Since INTA is configured as a system wakeup source earlier in the driver,=20
if the watchdog is active when the system goes to sleep, won't it=20
eventually expire and cause an unexpected, spurious system wakeup?=20

Should dev_pm_ops be provided to halt the hardware timer during suspend=20
and resume it upon waking up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092126.3757=
418-1-lakshay.piplani@nxp.com?part=3D5
