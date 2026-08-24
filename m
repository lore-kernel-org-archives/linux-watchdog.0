Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FB352004;
	Mon, 24 Aug 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555251; cv=none; b=tLEBAQJjuMbZmbgYCoQPp0DOd0nD/hADULE1vojJgRI7NArgsGwtf4ygmXh2ls3xLf8QJtEKh6aLzVLrSfbOdQEIZxmERpcAcD/REnvCEZsg7T5+7mf4HA5voGGdKRG0saInA0AGQPq+drxE9px+E+ODYqdLS4f3obRaBhc7fMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555251; c=relaxed/simple;
	bh=OqKscuB5QUQqGiPK2OwVl8U8CiaKP7yPwcR7Kp/13ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HOpQXmjoNUM7Dca3kCpiOL6WwQUsGyFcUXZ/64VpkPvIN51zkhl7l3EybDcY7vMu5nuUnmZ1Iqj1U3QuuqvjLET5ovGkFZeUwLaoC7zqgWxR3eMnaSp7vpzEG+HWR5HwAGwLS0Wd7PzyllXe//+52v/suQ+yTOOMO0A2to0CiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUriH1pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUriH1pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03FA1F00A3A;
	Mon, 24 Aug 2026 07:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555250;
	bh=mQL70lN+4DJmsliSfCbU0mnuqTmsEU+WhqIe7jJR/8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUriH1pePhQutOFIjbpkvUHoMl+yznbpg6IhyZatgQJWvXNXffu/+nlpkxY2M4kgt
	 cu6Hw+qDwdf1cUL1RAqZb0RgIusVj1gHvkWsxrigc5X7orwlsd7lUMKpKYjzVTr+Py
	 PFUAyPksb57u8kv2HuXzfwd1QwbwHdKOSX7yCrPRk61/i8PXfj/5iXTd08S+EH40sE
	 10Wgi+1kmICIB0oepWzXd4hVKd4/PwRI04lw5gY6VxK4CVsX3cmoSP72kq5PA355n8
	 WLU3+e+okCpX6L8L+faNOeA8yIL1E+ZHJrs1rPViqtA3Wo6cr16zdgXo8qQieSIH/r
	 /YkSSdtjSTApg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260824065531.693701-3-shivprakash.gupta@nxp.com>
References: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
 <20260824065531.693701-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:07:29 +0000
Message-Id: <20260824070729.C03FA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Read-modify-write on registers containing multiple Write-0-to-Clea=
r (W0C) flags causes concurrent interrupt events to be silently dropped.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race between the threaded =
IRQ handler and sysfs store operations can resurrect a cleared timestamp an=
d drop a new one.
--

--- Patch [2]: [PATCH v2 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver ---
commit c245e33078f78e502aef6b16350b763f5d4857a7
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: rtc: pcf8525: Add NXP PCF8525 RTC driver

This commit adds a new I2C driver for the NXP PCF8525 RTC. It provides
support for reading and setting time, alarms, timestamp capture, backup
switch-over configuration, and crystal aging offset correction.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 0000000000000..843d4bb266847
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf8525.c

[ ... ]

> +static int pcf8525_param_set(struct device *dev, struct rtc_param *param)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	unsigned int mode;
> +
> +	switch (param->param) {
> +	case RTC_PARAM_BACKUP_SWITCH_MODE:
> +		switch (param->uvalue) {
> +		case RTC_BSM_LEVEL:
> +			mode =3D 0;
> +			break;
> +		case RTC_BSM_DIRECT:
> +			mode =3D 1;
> +			break;
> +		case RTC_BSM_DISABLED:
> +			mode =3D 2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	return regmap_update_bits(pcf8525->regmap,
> +				  PCF8525_REG_CTRL3,
> +				  PCF8525_CTRL3_PWRMNG_MASK,
> +				  FIELD_PREP(PCF8525_CTRL3_PWRMNG_MASK, mode));

[Severity: High]
Does this read-modify-write operation drop concurrent hardware events?

If CTRL3 contains Write-0-to-Clear (W0C) flags (like the Battery Flag BF),
regmap_update_bits() will read the register, modify the mask, and write it
back.=20

If a W0C flag is 0 when read, it writes 0 back. If that flag asserted in
hardware between the read and the write, writing 0 will unintentionally cle=
ar
it, causing the event to be silently dropped.

[ ... ]

> +static int pcf8525_alarm_irq_enable(struct device *dev, unsigned int ena=
ble)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_AIE,
> +				 enable ? PCF8525_CTRL2_AIE : 0);

[Severity: High]
Can this similarly drop concurrent alarm, minute/second, or watchdog events?

CTRL2 contains multiple Write-0-to-Clear flags (AF, MSF, WDTF). By using
regmap_update_bits() here and in other functions like pcf8525_set_alarm()
and pcf8525_irq(), writing back the original 0 will clear any newly asserted
flags, permanently dropping the hardware interrupt events.

[ ... ]

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
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&pcf8525->ts_lock, flags);
> +		pcf8525->ts_valid[id] =3D false;
> +		spin_unlock_irqrestore(&pcf8525->ts_lock, flags);
> +
> +		/* Also clear the hardware timestamp registers. */
> +		regmap_write(pcf8525->regmap, PCF8525_REG_RESET,
> +			     PCF8525_RESET_CTS_CMD);
> +		return count;
> +	}

[ ... ]

> +static irqreturn_t pcf8525_irq(int irq, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	unsigned int ctrl2, ctrl4;
> +	int ret;

[ ... ]

> +	/* Timestamp */
> +	if (ctrl4 & PCF8525_CTRL4_TSF) {
> +		time64_t ts0, ts1;
> +		bool ok0, ok1;
> +		unsigned long flags;
> +
> +		/*
> +		 * W0C: clear TSF before reading the timestamp registers so
> +		 * that a new event that fires during the I2C read is not lost.
> +		 */
> +		regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL4,
> +				   PCF8525_CTRL4_TSF, 0);
> +
> +		/* Read hardware outside the spinlock (I2C operations may sleep). */
> +		ok0 =3D !pcf8525_ts_read(dev, 0, &ts0);
> +		ok1 =3D !pcf8525_ts_read(dev, 1, &ts1);
> +
> +		spin_lock_irqsave(&pcf8525->ts_lock, flags);
> +		if (ok0 && !pcf8525->ts_valid[0]) {
> +			pcf8525->ts[0] =3D ts0;
> +			pcf8525->ts_valid[0] =3D true;
> +		}

[Severity: High]
Does this sequence have a TOCTOU race with timestamp_store_common()?

If a user clears the timestamp via sysfs while pcf8525_irq() is performing =
the
unlocked I2C read, timestamp_store_common() will set ts_valid =3D false and=
 clear
the hardware registers.

If a new hardware event fires immediately after, capturing a new timestamp,
pcf8525_irq() will finish its read, take the lock, and see !ts_valid[0] bec=
ause
it was cleared by sysfs. It will then resurrect the stale read timestamp and
mark it valid again.

When the second IRQ fires for the new hardware event, it will find ts_valid
already true and silently discard the newly captured timestamp.

Could a mutex be used to serialize the entire sequence of hardware I2C acce=
ss
and software state updates instead of using a spinlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824065531.6937=
01-1-shivprakash.gupta@nxp.com?part=3D2
