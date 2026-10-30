Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359133;
	b=4O+Xodxmra3zLJoor4PrbhgtmZKp0cE6ObXLBNJ4iVacSzs9XEWb0MzUp/Rjxzjr5utO
	 3Kbk0wGNdzxzL4RgZIhyfmBSqQyS0X/+iqbEvSC1lG5M2U5XrVzL7+gUzSfBRrDlk3WGY
	 7FOhwLinI4Yawx6+OfXLacIGm6BG/w8nChVJi22vN+7BCYIgdTZ25YFKUQMfEF4rY+P5f
	 wSdTBvSeo4LWscHyMDMAXnE97E9MwgxbXB0u2sZOESQy1pZx6w5uQoS0OL4y5b7sKggOd
	 j5Q0XAClL5QO53DDPKEzCqWadSCwXly912G/c3BgbzC15KRvdevvwgws7LYkJZw6TEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sRmYKYjSmWk7Nl790Fm/bMnbeSVi6GVFQznUHAKCxew=;
	b=GTx+tx2urLBSGcN2jSOEsdgDa5rnaU3kQpae7iuY79SyTvtIvRVCMlgyb2pTr5gzu7Dr
	 +JTjSbE0urjHlBehhcuA7XPCzmlZJjvQV5yN12jLFxeM+fihQf+FMnT65c1Hb5hn0bkko
	 fFpy3LF+wVUuzIgbKgDMGjlVuV7Oc1BwgED7tanoZeuOX68m1nGDj6a9M1iCBBEEuYi3F
	 M/rLvir14h6oYj58/q31J7hcGH1+glTH/F3FRe3hpnB6O+GWld9HA60RccAUX+AzIsY6a
	 +46NMFoqdVS6gGG1GjJ1M3NyQbqLFPJ+q6LKkg8zutd2b/tVuoNT3BHtZ9RsDjO8puw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu8PVfnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B859606A327;
	Fri, 30 Oct 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu8PVfnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76581F000C1;
	Fri, 30 Oct 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359132;
	bh=sRmYKYjSmWk7Nl790Fm/bMnbeSVi6GVFQznUHAKCxew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bu8PVfnfJykJ3S2pea/bNJ3Phmq+VOxbgyTOsZudRPk8zqrX0gmETNW/bHjvWibgK
	 BS4MTJz7a2FfA3FRGpnlXpFA5cwCUtyQyPDwRUzPWc0RD+VMN7Yu2t0AFrlTdSu1o/
	 WYn/6JJy6UZvQNSalJJt+P7RxAQV1Df+mp1Ygr8z7AgB9WIQDbXxDYcHI/r2xOFWcX
	 KDiS73VV/81JLTz3fzVdku70EapA+chhh/xTDuX3tVea4W8rlwFpAqqbufSFvgX5ZK
	 bXwlSEqRbxMsFgnNCGfP3u7TiSPxiDNbDjktzs4ZPLxd6J7N4Mlqp1QIWxCIi545pC
	 XPTG2BKSo2mZA==
Message-ID: <sashiko-outbox-190932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261030110139.1929109-3-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
 <20261030110139.1929109-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 11:18:51 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] rtc: pcf8525: duplicate wake IRQ registration in pcf8525_probe()
- [High] rtc: pcf8525: stuck IRQ and skipped alarm in pcf8525_irq() on TS1 =
read error
- [Medium] rtc: pcf8525: cross-clobbering and -EINVAL in timestamp_store_co=
mmon()
- [Medium] rtc: pcf8525: undrained pending flags and unmasked IRQs in pcf85=
25_probe()
- [Medium] rtc: pcf8525: alarm updated while AIE is enabled in pcf8525_set_=
alarm()
- [Medium] rtc: pcf8525: year range shift and timestamp offset mismatch in =
pcf8525_ts_read()
- [Medium] rtc: pcf8525: missing ts_mutex serialization in sysfs timestamp =
callbacks
- [Medium] rtc: pcf8525: clearing TSF after CTS in timestamp_store_common()=
 drops events
--

commit e0078479b8adc02e333509cd27a01c1bdef9f20e
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add NXP PCF8525 RTC driver

This commit adds an I2C RTC driver for the NXP PCF8525, supporting calendar
timekeeping, alarms, external and last-write timestamp capture, crystal agi=
ng
offset correction, and backup power switchover.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> new file mode 100644
> index 0000000000000..3c5f15f95a9ed
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf8525.c
> @@ -0,0 +1,1112 @@

[ ... ]

> +static int pcf8525_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	u8 buf[7];
> +	int ret;
> +
> +	/*
> +	 * Clear AF (W0C). Use W0C_FLAGS as the mask and preserve MSF and WDTF
> +	 * by writing 1 to them: writing 0 to a W0C bit that has asserted
> +	 * between the read and write would silently drop the event.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_W0C_FLAGS,
> +				 PCF8525_CTRL2_MSF | PCF8525_CTRL2_WDTF);
> +	if (ret)
> +		return ret;
> +
> +	buf[0] =3D bin2bcd(alrm->time.tm_sec) & 0x7f;
> +	buf[1] =3D bin2bcd(alrm->time.tm_min) & 0x7f;
> +	buf[2] =3D bin2bcd(alrm->time.tm_hour) & 0x3f;
> +	buf[3] =3D bin2bcd(alrm->time.tm_mday) & 0x3f;
> +
> +	/* Disable match on weekday/month/year by setting AE bits */
> +	buf[4] =3D PCF8525_ALM_AE; /* weekday alarm ignored */
> +	buf[5] =3D PCF8525_ALM_AE_MONTH | PCF8525_ALM_AE_YEAR;  /* disable mont=
h + year alarm */
> +	buf[6] =3D 0x00; /* year alarm value (ignored if month/year disabled) */
> +
> +	ret =3D regmap_bulk_write(pcf8525->regmap, PCF8525_REG_ALM_SEC, buf, si=
zeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	return pcf8525_alarm_irq_enable(dev, alrm->enabled);
> +}

[Severity: Medium]
In pcf8525_set_alarm(), PCF8525_CTRL2_AF is cleared before writing the alarm
registers while PCF8525_CTRL2_AIE may still be enabled.

If the previous alarm register values or intermediate values during the
regmap_bulk_write() to PCF8525_REG_ALM_SEC match the current RTC time after
PCF8525_CTRL2_AF is cleared, can the hardware re-assert PCF8525_CTRL2_AF and
trigger a spurious interrupt (even when alrm->enabled is 0) or leave a stale
PCF8525_CTRL2_AF pending when pcf8525_alarm_irq_enable() enables AIE?

Should pcf8525_set_alarm() disable PCF8525_CTRL2_AIE first, write the new
alarm registers, and then clear PCF8525_CTRL2_AF when enabling AIE?

> +
> +/* ---- Timestamp handling (sysfs) ---- */
> +static int pcf8525_ts_read(struct device *dev, int id, time64_t *ts_out)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	struct rtc_time tm;
> +	u8 buf[6];
> +	int ret;
> +	u8 base;
> +
> +	/*
> +	 * TS0 maps to TS1 (0x17..0x1C)
> +	 * TS1 maps to TS2 (0x1E..0x23) (skip subsec at 0x1D)
> +	 */
> +	if (id =3D=3D 0)
> +		base =3D PCF8525_REG_TS1_SEC;
> +	else if (id =3D=3D 1)
> +		base =3D PCF8525_REG_TS2_SEC;
> +	else
> +		return -EINVAL;
> +
> +	ret =3D regmap_bulk_read(pcf8525->regmap, base, buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	tm.tm_sec =3D bcd2bin(buf[0] & 0x7f);
> +	tm.tm_min =3D bcd2bin(buf[1] & 0x7f);
> +	tm.tm_hour =3D bcd2bin(buf[2] & 0x3f);
> +	tm.tm_mday =3D bcd2bin(buf[3] & 0x3f);
> +	tm.tm_mon =3D bcd2bin(buf[4] & 0x1f) - 1;
> +	tm.tm_year =3D bcd2bin(buf[5]) + 100;
> +
> +	ret =3D rtc_valid_tm(&tm);
> +	if (ret)
> +		return ret;
> +
> +	*ts_out =3D rtc_tm_to_time64(&tm);
> +	return 0;
> +}

[Severity: Medium]
In pcf8525_probe(), the driver sets:

	pcf8525->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
	pcf8525->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
	pcf8525->rtc->set_start_time =3D true;

while leaving pcf8525->rtc->start_secs at 0 (1970-01-01). When start-year is
not specified in Device Tree, rtc_device_get_offset() in drivers/rtc/class.c
sees set_start_time =3D=3D true with start_secs =3D=3D 0, sets rtc->offset_=
secs to
-(range_max - range_min + 1), and shifts the valid RTC range from 2000..2099
to 1970..2069 (causing dates in 2070..2099 to be rejected with -ERANGE). No=
te
that rtc_device_get_offset() already sets set_start_time =3D true automatic=
ally
whenever the start-year property is present in firmware.

Furthermore, when rtc->offset_secs is non-zero, rtc_read_time() and
rtc_set_time() apply rtc_add_offset() and rtc_subtract_offset(), whereas
pcf8525_ts_read() decodes tm.tm_year =3D bcd2bin(buf[5]) + 100 directly wit=
hout
applying the RTC offset. Won't that cause a 100-year mismatch between
calendar reads/writes and timestamps read via pcf8525_ts_read()?

> +
> +static ssize_t timestamp_show_common(struct device *dev, char *buf, int =
id)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	unsigned int ctrl4;
> +	time64_t ts;
> +	int ret;
> +
> +	if (id < 0 || id > 1)
> +		return -EINVAL;
> +
> +	/*
> +	 * Timestamp2 (id=3D1) records the last calendar/date-time write.
> +	 * It is updated automatically by hardware on every set_time call
> +	 * and is not related to the external TS capture event (TSF).
> +	 * Always read it directly from the hardware registers.
> +	 */
> +	if (id =3D=3D 1) {
> +		ret =3D pcf8525_ts_read(dev->parent, 1, &ts);
> +		if (ret)
> +			return ret;
> +		return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
> +	}

[Severity: Medium]
There appear to be a couple of issues with how timestamp0 and timestamp1 are
handled across timestamp_show_common() and timestamp_store_common():

1. When the TS2 registers (0x1E..0x23) are zeroed (at power-on before
pcf8525_set_time() has been called, or after PCF8525_RESET_CTS_CMD is writt=
en
to PCF8525_REG_RESET), pcf8525_ts_read(dev->parent, 1, &ts) reads tm_mday =
=3D=3D 0
and tm_mon =3D=3D -1, so rtc_valid_tm() returns -EINVAL. Because
timestamp_show_common() returns ret directly for id =3D=3D 1, reading sysfs
timestamp1 when no timestamp is recorded fails with -EINVAL instead of
returning 0 (empty output) like timestamp0_show() does.

2. Both timestamp0_store() (id =3D 0) and timestamp1_store() (id =3D 1) call
timestamp_store_common(), which validates id but then ignores it and writes
PCF8525_RESET_CTS_CMD to PCF8525_REG_RESET, resets pcf8525->ts_valid[0] and
pcf8525->ts_valid[1], and clears PCF8525_CTRL4_TSF. Because
PCF8525_RESET_CTS_CMD zeroes both TS1 and TS2 hardware registers, writing to
timestamp0 erases the last-calendar-write timestamp in timestamp1, and
writing to timestamp1 erases any captured external event in timestamp0. Is
this cross-clobbering between the two sysfs attributes intended?

> +
> +	/* id =3D=3D 0: Timestamp1 =3D external TS pin capture */
> +	if (pcf8525->irq_enabled) {
> +		bool valid;
> +
> +		mutex_lock(&pcf8525->ts_mutex);
> +		valid =3D pcf8525->ts_valid[0];
> +		if (valid)
> +			ts =3D pcf8525->ts[0];
> +		mutex_unlock(&pcf8525->ts_mutex);
> +
> +		if (!valid)
> +			return 0;
> +		return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
> +	}
> +
> +	/* polling mode: only report if TSF is currently set */
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
> +	if (ret)
> +		return ret;
> +
> +	if (!(ctrl4 & PCF8525_CTRL4_TSF))
> +		return 0;
> +
> +	ret =3D pcf8525_ts_read(dev->parent, 0, &ts);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
> +}
> +
> +static ssize_t timestamp_store_common(struct device *dev, const char *bu=
f,
> +				      size_t count, int id)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	if (id < 0 || id > 1)
> +		return -EINVAL;
> +
> +	if (pcf8525->irq_enabled) {
> +		/*
> +		 * Serialize CTS with the IRQ handler. CTS clears the timestamp
> +		 * registers and Timestp_ctl1, so invalidate the cache only after
> +		 * CTS succeeds, restore TSM, then clear TSF.
> +		 */
> +		mutex_lock(&pcf8525->ts_mutex);
> +
> +		ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_RESET,
> +				   PCF8525_RESET_CTS_CMD);
> +		if (ret) {
> +			mutex_unlock(&pcf8525->ts_mutex);
> +			return ret;
> +		}
> +
> +		/* CTS succeeded: hardware registers are now zeroed. */
> +		pcf8525->ts_valid[0] =3D false;
> +		pcf8525->ts_valid[1] =3D false;
> +
> +		/* Restore TSM=3D1, TSOFF=3D0 (CTS cleared 0x16). */
> +		ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
> +					 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
> +					 PCF8525_TS_CTL1_TSM);
> +		if (!ret)
> +			ret =3D regmap_update_bits(pcf8525->regmap,
> +						 PCF8525_REG_CTRL4,
> +						 PCF8525_CTRL4_TSF, 0);
> +		mutex_unlock(&pcf8525->ts_mutex);
> +		return ret ? ret : (ssize_t)count;
> +	}

[Severity: Medium]
In timestamp_store_common(), PCF8525_CTRL4_TSF is cleared after issuing
PCF8525_RESET_CTS_CMD and after restoring PCF8525_TS_CTL1_TSM in
PCF8525_REG_TS_CTL1.

If a new external timestamp event arrives on the TS pin after
PCF8525_RESET_CTS_CMD (or after PCF8525_TS_CTL1_TSM is restored) and before
the regmap_update_bits() on PCF8525_REG_CTRL4 completes, the hardware latch=
es
the new timestamp into TS1 and sets PCF8525_CTRL4_TSF =3D 1, which
timestamp_store_common() then immediately clears to 0. When pcf8525_irq()
acquires pcf8525->ts_mutex and re-reads PCF8525_REG_CTRL4 into ctrl4_now, it
sees PCF8525_CTRL4_TSF =3D=3D 0, assumes timestamp_store_common() zeroed the
registers after the event, and drops the newly captured timestamp.

Could PCF8525_CTRL4_TSF be cleared before issuing PCF8525_RESET_CTS_CMD and
re-enabling PCF8525_TS_CTL1_TSM so a new event arriving after CTS is not
wiped out?

> +
> +	/*
> +	 * Polling path: CTS first, then restore TSM=3D1/TSOFF=3D0, then clear =
TSF.
> +	 */
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_RESET, PCF8525_RESET_=
CTS_CMD);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore TSM=3D1, TSOFF=3D0 (CTS cleared 0x16). */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
> +				 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
> +				 PCF8525_TS_CTL1_TSM);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL4,
> +				 PCF8525_CTRL4_TSF, 0);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}

[Severity: Medium]
When pcf8525->irq_enabled is false, neither timestamp_show_common() nor
timestamp_store_common() acquires pcf8525->ts_mutex, and the CTS reset
sequence in timestamp_store_common() is duplicated across the two branches.

If one process reads timestamp0 in polling mode (observing PCF8525_CTRL4_TSF
set in PCF8525_REG_CTRL4) while another process concurrently writes to
timestamp0 or timestamp1, PCF8525_RESET_CTS_CMD can zero the TS1 registers
before PCF8525_CTRL4_TSF is cleared two I2C transactions later, causing
pcf8525_ts_read() in timestamp_show_common() to read zeroed registers and
return -EINVAL instead of 0.

Could pcf8525->ts_mutex be held unconditionally in timestamp_show_common()
and timestamp_store_common(), eliminating the duplicated polling branch in
timestamp_store_common()?

[ ... ]

> +static irqreturn_t pcf8525_irq(int irq, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	irqreturn_t handled =3D IRQ_NONE;
> +	unsigned int ctrl2, ctrl4;
> +	int ret;
> +
> +	/*
> +	 * Drain all pending INTA sources. Re-read the status registers
> +	 * because another source may assert while INTA is already low.
> +	 */
> +	for (;;) {

[ ... ]

> +			} else {
> +				/*
> +				 * TSM=3D1 retains the first event while TSF is set, so read TS1
> +				 * before clearing TSF.
> +				 */
> +				ok0 =3D !pcf8525_ts_read(dev, 0, &ts0);
> +				if (!ok0) {\
> +					/*
> +					 * TS1 read failed; leave TSF set
> +					 * so the event is not silently
> +					 * dropped and hardware can
> +					 * re-trigger.
> +					 */
> +					mutex_unlock(&pcf8525->ts_mutex);
> +					return handled;
> +				}

[Severity: High]
In pcf8525_irq(), if pcf8525_ts_read(dev, 0, &ts0) fails, the handler unloc=
ks
pcf8525->ts_mutex and returns handled immediately without clearing
PCF8525_CTRL4_TSF and before checking PCF8525_CTRL2_AF or PCF8525_CTRL2_MSF.

If an external transition occurs on the TS pin while the RTC calendar is not
yet initialized (so TS1 latches invalid BCD date fields and rtc_valid_tm() =
in
pcf8525_ts_read() returns -EINVAL), PCF8525_TS_CTL1_TSM =3D 1 freezes the T=
S1
registers as long as PCF8525_CTRL4_TSF remains 1. Won't leaving
PCF8525_CTRL4_TSF set cause pcf8525_ts_read() to fail on every subsequent
attempt, either triggering an unhandled IRQ_NONE storm on a level-triggered
IRQ line or holding the open-drain INTA line permanently low on an
edge-triggered IRQ line while starving any pending alarm interrupts?

[ ... ]

> +static int pcf8525_get_irqs(struct i2c_client *client, struct pcf8525 *p=
cf8525)
> +{
> +	struct device *dev =3D &client->dev;
> +	int irq;
> +
> +	irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "inta");
> +	if (irq =3D=3D -ENOENT || irq =3D=3D -EINVAL)
> +		irq =3D client->irq;
> +	else if (irq < 0)
> +		return irq;
> +	pcf8525->irq_inta =3D irq;
> +
> +	return 0;
> +}

[ ... ]

> +static int pcf8525_unmask_irqs_inta(struct pcf8525 *pcf8525)
> +{
> +	/*
> +	 * Mask registers: bit=3D1 means masked/disabled.
> +	 * We want alarm + timestamp unmasked on INTA by default:
> +	 * - AIE =3D> mask bit2 must be 0
> +	 * - TSIE =3D> mask2 bit3 must be 0
> +	 */
> +	unsigned int m1, m2;
> +	int ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK1, &m1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK2, &m2);
> +	if (ret)
> +		return ret;
> +
> +	m1 |=3D PCF8525_MASK1_WD_CD;	/* keep watchdog masked on INTA */
> +	m1 &=3D ~PCF8525_MASK1_AIE;	/* unmask alarm interrupt on INTA */
> +	m2 &=3D ~PCF8525_MASK2_TSIE;	/* unmask timestamp interrupt on INTA */
> +
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
> +}

[Severity: Medium]
There appear to be two issues with how INTA interrupts and pre-existing sta=
tus
flags are initialized during probe:

1. In pcf8525_unmask_irqs_inta(), only PCF8525_MASK1_WD_CD is masked in
PCF8525_REG_INTA_MASK1 while PCF8525_MASK1_BIE, PCF8525_MASK1_OSIE,
PCF8525_MASK1_SI, and PCF8525_MASK1_MI are left untouched. If any of those
bits were left unmasked by firmware or across a warm reset, pcf8525_irq() d=
oes
not clear PCF8525_CTRL3_BF or PCF8525_SC_OSF, which would leave INTA assert=
ed.
Should all unused interrupt sources in PCF8525_REG_INTA_MASK1 and
PCF8525_REG_INTA_MASK2 be explicitly masked?

2. In pcf8525_probe(), PCF8525_CTRL5_TSIE is enabled before requesting the =
IRQ
(and even when pcf8525->irq_inta <=3D 0), and pcf8525_probe() never drains
pending status flags after unmasking INTA. If PCF8525_CTRL4_TSF or
PCF8525_CTRL2_AF was already latched prior to probe (for example, while
running on backup power or across a warm reboot) on an IRQ_TYPE_EDGE_FALLING
interrupt line, INTA is already held low so no falling edge will occur. That
leaves pcf8525->ts_valid[0] false (hiding the pre-boot timestamp from
timestamp0_show() in IRQ mode) and leaves INTA stuck low, blocking all futu=
re
falling-edge interrupts. Should pcf8525_probe() invoke pcf8525_irq() (or dr=
ain
pending flags) after unmasking INTA?

> +
> +static int pcf8525_probe(struct i2c_client *client)
> +{

[ ... ]

> +	/* Optional IRQ */
> +	if (pcf8525->irq_inta > 0) {
> +		ret =3D devm_request_threaded_irq(dev, pcf8525->irq_inta,
> +						NULL, pcf8525_irq,
> +						IRQF_ONESHOT,
> +						dev_name(dev), dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to request INTA IRQ\n");
> +
> +		pcf8525->irq_enabled =3D true;
> +
> +		/*
> +		 * Register the INTA cleanup action before unmasking hardware
> +		 * interrupt sources. If the unmask step fails, the devm
> +		 * unwinding will still re-mask INTA so the line is not left
> +		 * asserted on probe failure.
> +		 */
> +		ret =3D devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
> +		if (ret)
> +			return ret;
> +
> +		/* Route/unmask alarm + timestamp to INTA by default */
> +		ret =3D pcf8525_unmask_irqs_inta(pcf8525);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_device_init_wakeup(dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_pm_set_wake_irq(dev, pcf8525->irq_inta);
> +		if (ret)
> +			return ret;
> +
> +		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
> +	}

[Severity: High]
When a Device Tree node specifies both interrupts and wakeup-source,
of_i2c_get_board_info() sets I2C_CLIENT_WAKE on client->flags. Before calli=
ng
pcf8525_probe(), i2c_device_probe() in drivers/i2c/i2c-core-base.c already
calls device_init_wakeup(&client->dev, true) and dev_pm_set_wake_irq(dev,
client->irq):

drivers/i2c/i2c-core-base.c:i2c_device_probe() {
    ...
    device_init_wakeup(&client->dev, true);

    if (wakeirq > 0 && wakeirq !=3D client->irq)
        status =3D dev_pm_set_dedicated_wake_irq(dev, wakeirq);
    else if (client->irq > 0)
        status =3D dev_pm_set_wake_irq(dev, client->irq);
    ...
}

When pcf8525_probe() then calls devm_pm_set_wake_irq(dev, pcf8525->irq_inta)
with pcf8525->irq_inta =3D=3D client->irq, dev_pm_attach_wake_irq() hits
dev_WARN_ONCE(dev, dev->power.wakeirq, "wake irq already initialized\n") and
returns -EEXIST, causing pcf8525_probe() to fail.

Conversely, if wakeup-source is specified in Device Tree without interrupts
(for example, when INTA is wired to a PMIC or power-button wake pin),
pcf8525->irq_inta is 0, so pcf8525_probe() never unmasks AIE on INTA or sets
RTC_FEATURE_ALARM. In addition, in pcf8525_get_irqs(), fwnode_irq_get_bynam=
e()
returns -ENODATA if interrupt-names is present without an "inta" entry, whi=
ch
causes pcf8525_get_irqs() to fail instead of falling back to client->irq.

Should pcf8525_probe() check device_property_read_bool(dev, "wakeup-source")
for alarm/wakeup capability and avoid calling devm_pm_set_wake_irq() when
pcf8525->irq_inta =3D=3D client->irq and I2C_CLIENT_WAKE is already handled=
 by the
I2C core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030110139.1929=
109-1-shivprakash.gupta@nxp.com?part=3D2
