Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012986;
	b=ne0ComB6nMeIxxcRAczM9EG5AUoM/LugS5Di8fBRH3S3VVb3HnjHIIBbMTUCbYaqkuNj
	 1bmLlRsbb6e+BxkcYoZIhQpKjB1I8wx8IxprGj5EvG8C2KMEPR3Xn4PHCTFR4AskRY8Wm
	 Cd0s74IJFX3K1ge46ogmUpvLN8sFvFKILCsLCD0U8Epd/laSOIJuWpgshv7iCHAMEmKUw
	 HTkzA8v57Zp6eTHelAOL1fJLu8D+edFqB0NtdMe7Sxke+XzdQ9kNS7KUJ7r0ARVWB9oSs
	 tfUOv6OuHyBC0K2/KbQTf5M8FIuOaM87Vl3EuyPbkiTPY9jUVU1+4i915i4NglIjIcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g1aM7wiYf05GeMmErOn9gJUgMdfYPRR7Pr6pPLWq3hc=;
	b=z2d90w/h8KKYy8m9uGsPJt2HgM3BzX3GqSc/o841pbjTY+qfOjneaU1z5X3PGdYkDVh6
	 2BW9nwQlx/rQxRQUJZZlCctunMSsQ0iXnf6E/sXYgJMwnfr3ognCbhj1hKusEeuP0kpS3
	 x6O2Uq4xjeM704SapdepiJOtPhQ1q0LxC1c4bTggpx6mPI8ABnnhkzhBpNYvtHYOW5d87
	 bY3df25Hy/hqan3JB+f1ifhcA7RFkqukzzFp9xf9oIHZWEau4hep+Btg0KT8KpdstcU3z
	 U2CEoJ7r6Bt1giWKlEcCb92HW6P8hYHf4oLfbX2zpvDyKPcP0JcBkR5X65a1i2D1Bfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b501FKTf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E0606A31A;
	Mon, 26 Oct 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b501FKTf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A351F031E0;
	Mon, 26 Oct 2026 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012986;
	bh=g1aM7wiYf05GeMmErOn9gJUgMdfYPRR7Pr6pPLWq3hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b501FKTfHEoV7pO5pAg7zuCzuUtwq9zzFHgN51YK6e4ahHcDTJHZWBuj953yhfJut
	 oJyG8Smg0oNL9biF1VF91sJXxiWmCHFHUqqCrGk4F+0Bmg44Lw5uHidT84v3plm+FP
	 5ejko4yprdYWn6lovNsefUglV3Rbu2wlxdf085ZuDbJfAjsTeajQX1TxViJjAZ4KnI
	 uJJyx7rYYJMIcQpUploWRTwIeVPI3RpXPy7oZHCMcYoKMKiiSfOH9aqNCgnfki/1my
	 0cBZZINuZ3U2I5/7MTYISO+V+rbiy9HStAIdeYPlFK3xd5pIOVNGdh2tWEVJzLA7sb
	 1L4BeZr1NNd8A==
Message-ID: <sashiko-outbox-185064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] rtc: pcf85363: add watchdog support with
 configurable step size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026094712.205214-5-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
 <20261026094712.205214-5-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:09:45 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: pcf85363: spurious WDF handling in pcf85363_rtc_handle_irq()
--

commit 16cc51c19e1316f4895386e586c6d2ab87d77232
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add watchdog support with configurable step size

This commit adds alarm-only watchdog support to the PCF85263/PCF85363 RTC
driver using the watchdog subsystem, with dynamic 1 Hz and 0.25 Hz step
selection, interrupt handling via INTA, and suspend/resume support.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 71b82f92a0031..e5ebfad1a2cea 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c

[ ... ]

> @@ -540,6 +572,21 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, =
void *dev_id)
>  		}
>  	}
> =20
> +	if (flags & FLAGS_WDF) {
> +		dev_warn_ratelimited(&pcf85363->rtc->dev,
> +				     "watchdog timer expired\n");
> +
> +		err =3D pcf85363_clear_flags(pcf85363, FLAGS_WDF);
> +		if (err) {
> +			dev_err_ratelimited(&pcf85363->rtc->dev,
> +					    "failed to clear watchdog flag: %d\n",
> +					    err);
> +			ack_failed =3D true;
> +		} else {
> +			handled =3D true;
> +		}
> +	}

[Severity: Medium]
Can pcf85363_rtc_handle_irq() in drivers/rtc/rtc-pcf85363.c log false
"watchdog timer expired" warnings and return spurious IRQ_HANDLED on a
shared interrupt line when FLAGS_WDF is latched in CTRL_FLAGS while
INT_WDIE is masked in CTRL_INTA_EN?

On PCF85263/PCF85363, CTRL_FLAGS latches FLAGS_WDF whenever the CTRL_WDOG
counter reaches 0, regardless of whether INT_WDIE is set in CTRL_INTA_EN
(which only controls routing of WDF to the INTA pin).

In pcf85363_suspend(), INT_WDIE is masked while the CTRL_WDOG counter is
left running in repeat mode:

	/* Disconnect WDF from the wakeup-capable INTA line; keep counting. */
	ret =3D regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN, INT_WDIE, 0);
	if (ret)
		return ret;

	wd->suspended =3D true;

During any system sleep longer than the watchdog timeout, the counter
expires and latches FLAGS_WDF. On wakeup, resume_device_irqs() in
dpm_resume_noirq() re-enables device interrupts before dpm_resume() runs
pcf85363_resume(). If an RTC alarm (FLAGS_A1F), timestamp (FLAGS_TSR1F,
FLAGS_TSR2F, FLAGS_TSR3F), battery switch-over (FLAGS_BSF), or another
device on a shared IRQ line fires before pcf85363_resume() runs,
pcf85363_rtc_handle_irq() executes while wd->suspended is still true and
INT_WDIE is still masked, reporting a false watchdog expiry and setting
handled =3D true.

A similar state can also occur in two other paths:

1. In pcf85363_probe(), INT_WDIE is masked and only FLAGS_A2F | FLAGS_PIF
are cleared before devm_request_threaded_irq() is called. When
CONFIG_WATCHDOG=3Dn, pcf85363_watchdog_init() returns early without clearing
a stale FLAGS_WDF or halting a bootloader- or battery-backed CTRL_WDOG
counter.

2. In pcf85363_wdt_stop(), CTRL_WDOG is halted and INT_WDIE is masked
without clearing any FLAGS_WDF that latched concurrently (or that latches
later if writing CTRL_WDOG fails while masking INT_WDIE succeeds).

Should pcf85363_rtc_handle_irq() ignore (or silently clear without setting
handled =3D true or logging a warning) FLAGS_WDF when the watchdog interrupt
is not armed, and should pcf85363_probe() and pcf85363_wdt_stop() also
ensure FLAGS_WDF is cleared when masking INT_WDIE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026094712.2052=
14-1-lakshay.piplani@nxp.com?part=3D5
