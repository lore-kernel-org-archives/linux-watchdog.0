Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FC4266A5;
	Mon, 14 Sep 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378521; cv=none; b=m1kSvjmbs4Yz932YiLfynnzzteZBL85PkpzS3QJZPz3pM459g1n9HhU5jXWPQZCJgKoBcq56SjiRlW/NTGOGoiEdTmO4iPT0yNcHPt6zerEYm8BFywvecdPZRdEGs8FgPHbxr8SqtOCesmTwNED5k8vCksZ6VjyCrGS6pkvShrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378521; c=relaxed/simple;
	bh=QPiJfU/OMLzDqKtWS2SWeZ7PcBiz4JvRfPI2rHIbGwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiI9tkOFyMyG0WpQtgZzDa69kYuXe75Qgh+x4oNjO5Qes3qDt5jNEOPWg3shaO7uaskaqYp3zRTaJ2Od5wAc0Zn+R9KaVDlXaH8idlGZRnyabr5QD8z3KzoOblzs3paKfeg2pT9cTjpqN8UZKRX50K6zNpN/TfmDyNSrkY6+f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYvvIAN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYvvIAN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6111F000FF;
	Mon, 14 Sep 2026 09:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378520;
	bh=EeaR3GIQpXn6RwKldN4BtmDp0Ty8666Myk97Wyde61s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYvvIAN0U6EArUu3ST8JNoSnsz5rpmGaFMea/f//+hvk4j6sFvlK3jsnnXFxStxdV
	 Uja7ZQMeTny7PxJVnWVlMXblZlKi6dhG7ghesr+KZVuNUv0T9cIUSb857E8ZA/KwHT
	 CMTwi7opFzes9PIbUZPflxVT+7eBGx/03zUFEfB/rgbnAaWqdezjcWwjVGjVUolw9C
	 izcm7+ee4AAVYC0tGfskl3HQa1D1NsROESGs2mqXMaeodtOmvUwfIoGuvf738cbbOJ
	 dQf37jktu+FyxmXQ/5zRsg5e3R+17m0NNn3Vlh4sHBR1K2FtFgzYB1AW/oLwz0x//r
	 CGRZ5xwPBh2wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] rtc: pcf85363: add timestamp support with
 configurable timestamp mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260914092126.3757418-3-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
 <20260914092126.3757418-3-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:35:19 +0000
Message-Id: <20260914093519.AE6111F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An I2C read error during event collection causes an early return, =
bypassing hardware flag clearance. Combined with returning IRQ_HANDLED, thi=
s leads to an infinite interrupt storm.
--

commit 71137d386eeb017385125a0418e12cdc1cafbbf2
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add timestamp support with configurable timestamp mode

Add support for the timestamp capture registers on PCF85263/PCF85363,
which latch the time on selected events (TS pin or battery switch-over).
The capture source is selected via the nxp,timestamp-mode device tree
property and latched values are exported through read-only sysfs
attributes, refreshed on read so poll-only boards still latch events.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index c8c04312bc583..5cc854d617f3a 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c

[ ... ]

> +static int pcf85363_collect_events(struct pcf85363 *pcf85363)
>  {
>  	unsigned int flags;
>  	int handled =3D 0;
> -	int ret;
> +	int i, ret;
> =20
>  	ret =3D regmap_read(pcf85363->regmap, CTRL_FLAGS, &flags);
>  	if (ret)
>  		return ret;
> =20
> +	for (i =3D 0; i < PCF85363_NUM_TS; i++) {
> +		if (!(flags & pcf85363_ts_flag[i]))
> +			continue;
> +
> +		if (pcf85363->ts_last_event[i]) {
> +			ret =3D pcf85363_clear_flags(pcf85363,
> +						   pcf85363_ts_flag[i]);

[ ... ]

> +		} else {
> +			ret =3D regmap_bulk_read(pcf85363->regmap,
> +					       pcf85363_ts_base[i],
> +					       pcf85363->ts[i].regs,
> +					       PCF85363_TS_LEN);
> +			if (ret)
> +				return ret;

[Severity: High]
If this bulk read fails, the function returns early, bypassing the call to
pcf85363_clear_flags() below and leaving the interrupt asserted in the
hardware. Is it possible for this early return to create a persistent
interrupt condition?

> +
> +			pcf85363->ts[i].valid =3D true;
> +
> +			ret =3D pcf85363_clear_flags(pcf85363,
> +						   pcf85363_ts_flag[i]);
> +			if (ret)
> +				return ret;
> +
> +			handled |=3D pcf85363_ts_flag[i];
> +		}
> +	}
> +

[ ... ]

> @@ -359,7 +488,7 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, v=
oid *dev_id)
>  		handled =3D true;
>  	}
> =20
> -	if (flags & FLAGS_BSF) {
> +	if (flags & (FLAGS_TSR1F | FLAGS_TSR2F | FLAGS_TSR3F | FLAGS_BSF)) {
>  		guard(mutex)(&pcf85363->lock);
> =20
>  		err =3D pcf85363_collect_events(pcf85363);
> @@ -368,8 +497,8 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, v=
oid *dev_id)
>  					    "failed to collect events: %d\n",
>  					    err);
>  		/*
> -		 * This is our interrupt source even if servicing it hit an
> -		 * I/O error, so acknowledge the interrupt either way.
> +		 * These are our interrupt sources even if servicing them hit
> +		 * an I/O error, so acknowledge the interrupt either way.
>  		 */
>  		handled =3D true;
>  	}

[Severity: High]
By unconditionally setting handled =3D true even after an I/O error, the
handler returns IRQ_HANDLED while the hardware interrupt line might still be
asserted (since pcf85363_collect_events() bails out early on a read error
without clearing the flags).

For a level-triggered interrupt, doesn't returning IRQ_HANDLED without clea=
ring
the source circumvent the kernel's spurious IRQ detector (which relies on
IRQ_NONE to mask stuck interrupts)?

Could this result in an infinite interrupt storm that will peg a CPU core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092126.3757=
418-1-lakshay.piplani@nxp.com?part=3D3
