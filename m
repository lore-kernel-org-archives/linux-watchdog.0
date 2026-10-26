Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011950;
	b=n8aZlS0P6A1CAkQfIcFtutcGQZKDpBvzD7vv/qjswPosM+9uQjgVhJ+uwIzh2nwfXC3/
	 DnR7Z0OjAdzVXkgLTEavga3QLAIKe2g2Wcq0ZUAc1dWlB0QBU0KXEKuN+y7YjMSRFhl07
	 yv3QfOAVVnYBqmnbZjELgzu8Iy5ZtN3jm0mkddUswqCZaAQHNCve/xedoKcMsJllY/CRW
	 Ia1jhElBAX7vGqW1HVttFtTqwKuqQdsnErAtJPEtFImWOMzS9MocbSUC5rCZNOdr8I2Gg
	 VPQu3ZVk/vAPMhFpO88jKzxbqm2aB1elRS+p5kuH/9BfWkVB91WXVeTL/bx7oNec5cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011950;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EdqkhNIUFcUZ/f+8a4VgxpZB0JrsLbGY0cktm4hV6vg=;
	b=uPcm4CmAqXaNmw57Jm12wBQHRRqM7F8xJta8WGxdRr7g0xTCoDujSQPI033nibcPWhaK
	 pEa0G7w1xaD0th0qDFRZU0xE+f0JjgRAYkmJ2hqUNegdB/976NuoInqyS9FMH4MU0OV/g
	 qq6WG6V97M3JAePbcqPQaujvBZKHN9PSl4Hj8TxxvsQi+Hpycx8Q3fp3cpjO1824VOAHh
	 VQtje14GgLT91BonwIPUMto6fK3kzwFPaau4YSqvZifanN8kUpB8MBzbxxHqjT7NsgdIR
	 AA/AyA883Pz1ybuqBQuHQ6r7BKgatz+D/eHQVQPREN2iO/kc5GDia1GxI7664hvfAHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5A+Xg94;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738B606A31A;
	Mon, 26 Oct 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5A+Xg94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2031F01825;
	Mon, 26 Oct 2026 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011949;
	bh=EdqkhNIUFcUZ/f+8a4VgxpZB0JrsLbGY0cktm4hV6vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5A+Xg94Z/YatAPN9sgq5wOtTrdhSaXJG4FpIGcxEQ/JpiG71f+waGtNVJ+Hm1LcQ
	 Mosnxck+KDSxQm3mCFtLBN/gmM95IfdjJkfURQFqKjteQiCPhUBQ0IQiFpB1Lqz0ao
	 SAQs4h40zPD/ghxGM7NnW22kg3syBEsNrL07RdCIqxrIv3dICyALo311OAnFJ+yARl
	 LeRDc3fXO+OTER7+ltVUbZjD9oLeV05Mz3KXFPxOt13UCk0xCPk+HZegQ16PGyq/5v
	 /vS3ZO/RbsohOgDy78Kq+5N8wlQ4ARhJP5quWI4J4FEMI8axVw87cwihri7gtHPiWD
	 wjfw6+bxNeKZQ==
Message-ID: <sashiko-outbox-185021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] rtc: pcf85363: add timestamp support with
 configurable timestamp mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026094712.205214-3-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
 <20261026094712.205214-3-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:52:28 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rtc: pcf85363: lost event and swallowed read error in pcf85363_c=
ollect_events()
- [Medium] rtc: pcf85363: unmasked INT_BSIE and INT_TSRIE in pcf85363_probe=
() when no IRQ
--

commit f94f2e86fc8ade444598e079370c102ba8cc732b
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add timestamp support with configurable timestamp mode

This commit adds timestamp capture register support for PCF85263/PCF85363,
configuring the capture source via the nxp,timestamp-mode property and
exposing captured timestamps via sysfs attributes.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 00f37ffcca260..db832cad0b0b6 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -306,23 +345,131 @@ static int pcf85363_rtc_set_alarm(struct device *d=
ev, struct rtc_wkalrm *alrm)
[ ... ]
>  /*
> - * Latch a pending battery-switch event into the software cache. Runs fr=
om
> - * the IRQ handler and the RTC_VL_READ path, so it is seen with or witho=
ut
> - * an interrupt line. BSF is cached before it is cleared so it survives
> - * re-arming. Caller must hold pcf85363->lock. Returns a negative errno =
on
> - * a register-access failure, otherwise the handled flag mask.
> + * Latch pending events into the cache. First-event modes hold the value
> + * until the flag is cleared, so cache before clearing; last-event modes
> + * overwrite every event, so clear first then read until stable. Runs fr=
om
> + * the IRQ and sysfs paths; caller holds the lock. Returns a negative er=
rno
> + * on a register-access failure (including -EAGAIN for a torn last-event
> + * read), otherwise the handled flag mask.
>   */
>  static int pcf85363_collect_events(struct pcf85363 *pcf85363)
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
> +			/*
> +			 * Clearing the flag acknowledges the interrupt, so mark
> +			 * the source handled as soon as the clear succeeds. A
> +			 * later data-read failure is a data error, not an
> +			 * acknowledgment failure: log it and move on to the
> +			 * remaining flags instead of returning an error.
> +			 */
> +			ret =3D pcf85363_clear_flags(pcf85363,
> +						   pcf85363_ts_flag[i]);
> +			if (ret)
> +				return ret;
> +
> +			handled |=3D pcf85363_ts_flag[i];
> +
> +			ret =3D pcf85363_read_ts_stable(pcf85363, i);
> +			if (ret) {
> +				dev_warn_ratelimited(&pcf85363->rtc->dev,
> +						     "timestamp %d read failed: %d\n",
> +						     i + 1, ret);
> +				continue;
> +			}
> +
> +			pcf85363->ts[i].valid =3D true;

[Severity: Medium]
When a timestamp register uses a last-event mode (such as PCF85363_TSR1_LE,
PCF85363_TSR2_LB, PCF85363_TSR2_LV, PCF85363_TSR2_LE, PCF85363_TSR3_LB, or
PCF85363_TSR3_LV) and pcf85363_read_ts_stable() fails with -EAGAIN on a torn
read or an I2C error from regmap_bulk_read(), does skipping the error via
continue lose the event and hide the failure from sysfs callers?

In pcf85363_timestamp_show():

	ret =3D pcf85363_collect_events(pcf85363);
	if (ret < 0)
		return ret;

	if (!pcf85363->ts[index].valid)
		return sysfs_emit(buf, "00-00-00 00:00:00\n");

	return pcf85363_format_timestamp(pcf85363->ts[index].regs, buf);

Because pcf85363_collect_events() swallows the error from
pcf85363_read_ts_stable() and returns the non-negative handled mask
(contrary to the function comment above it), a sysfs read in
pcf85363_timestamp_show() will not see a negative errno and will instead
return "00-00-00 00:00:00" or stale cached data from an earlier event.

Furthermore, because pcf85363_clear_flags() already cleared FLAGS_TSRnF in
CTRL_FLAGS before pcf85363_read_ts_stable() failed, if no further hardware
event arrives to re-assert FLAGS_TSRnF, subsequent calls to
pcf85363_collect_events() will see !(flags & pcf85363_ts_flag[i]) and never
retry reading DT_TIMESTAMPn, leaving the captured timestamp in hardware
unreachable.

[ ... ]
> @@ -575,80 +856,118 @@ static int pcf85363_probe(struct i2c_client *clien=
t)
[ ... ]
>  	ret =3D regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
>  				 INT_WDIE | INT_A2IE | INT_OIE | INT_PIE | INT_ILP,
>  				 0);
>  	if (ret)
> -		return dev_err_probe(&client->dev, ret,
> -				     "Failed to mask unused INTA sources\n");
> +		return dev_err_probe(dev, ret, "Failed to mask unused INTA sources\n");
[ ... ]
> -	if (client->irq > 0 || wakeup_source) {
> -		device_init_wakeup(&client->dev, true);
> +	if (irq_a > 0 || wakeup_source) {
> +		/*
> +		 * The alarm can be delivered either through our own IRQ line or
> +		 * via an external wakeup path (INTA routed to a PMIC), so route
> +		 * INTA to its interrupt output and keep the alarm feature in
> +		 * both cases; rtcwake relies on it for wakeup-source-only boards.
> +		 */
> +		ret =3D regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure INTA pin\n");
> +
> +		if (irq_a > 0) {
> +			u8 inta_en =3D INT_BSIE;
> +
> +			/*
> +			 * Enable the timestamp interrupt only when a capture
> +			 * mode is configured; always enable battery-switch.
> +			 * Only relevant when we service the IRQ ourselves.
> +			 */
> +			if (ts_mode_configured)
> +				inta_en |=3D INT_TSRIE;
> +
> +			ret =3D regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
> +						 INT_BSIE | INT_TSRIE, inta_en);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to enable INTA sources\n");
> +		}

[Severity: Medium]
What happens in pcf85363_probe() when irq_a <=3D 0 (for example on a
wakeup-source-only board where INTA is routed to a PMIC, or if
devm_request_threaded_irq() fails with a non-deferral error) and the
battery-backed CTRL_INTA_EN register already has INT_BSIE or INT_TSRIE set
from firmware or a previous boot?

The earlier CTRL_INTA_EN update only clears INT_WDIE | INT_A2IE | INT_OIE |
INT_PIE | INT_ILP, leaving INT_BSIE and INT_TSRIE untouched, and the block
above only updates INT_BSIE | INT_TSRIE when irq_a > 0. When wakeup_source
is true and irq_a <=3D 0, CTRL_PIN_IO is configured to PIN_IO_INTA_OUT while
stale INT_BSIE or INT_TSRIE bits remain enabled in CTRL_INTA_EN with no IRQ
handler registered to service and clear them, which could leave the INTA
wakeup line asserted if a battery switch-over or timestamp event occurs.
Should INT_BSIE | INT_TSRIE be cleared when irq_a <=3D 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026094712.2052=
14-1-lakshay.piplani@nxp.com?part=3D3
