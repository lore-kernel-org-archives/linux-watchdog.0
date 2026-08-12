Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4963A9DB6;
	Wed, 12 Aug 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521498; cv=none; b=PPo1zik5LqnIxnh7wDYuKIMlN6oTE+O/9gJ4nfLYChkKlGJHYuML8hOIcJ+GgU9VQtbT//CtGOsgIgKjWrexoIfumOIXxakdjjVcgXTxHDNTe1fCT5ekqpeHKJ0QtaRGCAr/zKL/qve00fIp+a4vg4XZcJizqrzwNgCTlxs7aAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521498; c=relaxed/simple;
	bh=uGzqvoXSx+p5/bio6+wGRzoXJuf4A43EFopE6IPwWS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnPlERJTjwjMAfLTgq+0r2/l1zZC0HbtaFNMu0EthaLk3vtk05k6gtnoDKgcZ9a4pJWnMnO3y/wMOZqS9GwC26fi8yRQDPPIWuvljOh0RcXzrAt/DKwwLdhjY2H4o718dUUIS/1DQvvowXKR7zk2Amz9c+VDu7u9TL+W4ciqt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW1Ga/bH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW1Ga/bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A11F000E9;
	Wed, 12 Aug 2026 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521492;
	bh=VtYFIvFPDFhOTtC+dbNBM82VGMLs9swgsDs/xM8yBAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YW1Ga/bHqJt7MntJdO/HbBO+srt5k531zeQuEP5IbUDoZDYiJThxVZb4vUCYllc6F
	 YTQc+VgGESt4XDS5R2znBKBIDn1zRR97GesG4MFk+gye0DfDz2lWVhqPYWFdXDQq5K
	 oOFzzP/dNeGnQKPUWlgKd/zbjbLWkWVMDYwJ1NPugaVvkg1gh1Gb/nKJoHSL4mFiqZ
	 CKq8tBUFezcYt4dU7NctSP3KbbcNIB0ZGz4zNyELYeIGNvROXk5sJVtBNsLjvcBQU0
	 m9FJLcaLIN+vUn0nNm4WcA8y6VBQQyCuzOQVOiUnjaAV3IWfvy4IqDTREAmnSQfczB
	 kZPzzzJ/hg/zw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v4 3/5] rtc: pcf85363: add timestamp support with
 configurable timestamp mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260812074533.3545058-3-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
 <20260812074533.3545058-3-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:58:11 +0000
Message-Id: <20260812075812.7A7A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The driver unconditionally hardcodes IRQF_TRIGGER_LOW, overriding =
firmware-specified IRQ trigger polarity.
- [High] Using regmap_write on CTRL_INTA_EN clobbers existing interrupt ena=
ble bits for alarms and watchdog.
- [High] Timestamp data tearing and loss due to immediate interrupt clearin=
g without caching.
- [Medium] Timestamp and battery switch-over events captured while powered =
off are permanently lost during probe.
- [Medium] RTC_FEATURE_ALARM is falsely advertised on devices lacking an in=
terrupt and wakeup source due to a removed cleanup path.
- [Medium] Timestamps are inaccessible on systems without an IRQ line (poll=
ing mode).
- [Medium] The OS (Oscillator Stop) flag is not masked when reading the tim=
estamp seconds, resulting in corrupted time values.

Pre-existing issues:
- [High] Lost interrupts due to Read-Modify-Write (RMW) on write-0-to-clear=
 hardware status register.
--

--- Patch [3]: [RESEND v4 3/5] rtc: pcf85363: add timestamp support with co=
nfigurable timestamp mode ---
commit 8204c1848e74a3f22f0093e4140b50cfeec66fb5
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add timestamp support with configurable timestamp mode

This commit adds support for the timestamp capture registers available on
PCF85263 and PCF85363 devices. The capture source is configured via the
device tree, and latched values are exported through read-only sysfs
attributes.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index c03d5a65c5f79..e10e58f690127 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -317,6 +333,24 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, =
void *dev_id)
>  		handled =3D true;
>  	}
> =20
> +	if (flags & FLAGS_TSR1F) {
> +		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_TSR1F, 0);

[Severity: High]
This is a pre-existing issue, but does using regmap_update_bits() here cause
lost interrupts?

The CTRL_FLAGS register uses a write-0-to-clear mechanism. Since
regmap_update_bits() performs a read-modify-write, any new hardware interru=
pt
asserted between the read and the write could be silently cleared when the
read value of 0 is written back.

[Severity: High]
Does clearing FLAGS_TSR1F immediately upon receiving the interrupt cause
timestamp data tearing?

By clearing the flag before caching the data, the hardware is re-armed. If
a new hardware event fires while sysfs is reading the 6 bytes via
regmap_bulk_read() in pcf85363_read_timestamp(), the data read could be
corrupted or lost.

> +		pcf85363->ts_valid_flags |=3D FLAGS_TSR1F;
> +		handled =3D true;
> +	}
[ ... ]
> @@ -424,11 +458,94 @@ static const struct pcf85x63_config pcf_85363_confi=
g =3D {
> +static int pcf85363_read_timestamp(struct pcf85363 *pcf85363, u8 base_re=
g, char *buf)
> +{
[ ... ]
> +	ret =3D regmap_bulk_read(pcf85363->regmap, base_reg, regs, sizeof(regs)=
);
> +
> +	if (ret)
> +		return ret;
> +
> +	tm.tm_sec =3D bcd2bin(regs[0]);

[Severity: Medium]
Does this bcd2bin conversion fail to mask the OS (Oscillator Stop) flag?

The PCF85363 copies the OS flag into bit 7 of the timestamp seconds registe=
r.
If the OS flag is set, passing the unmasked regs[0] directly to bcd2bin()
might result in corrupted time values. Should this be masked with 0x7F firs=
t?

> +	tm.tm_min =3D bcd2bin(regs[1]);
[ ... ]
> +static ssize_t pcf85363_timestamp_show(struct device *dev, char *buf,
> +				       u8 timestamp_flag, u8 base_reg)
> +{
> +	struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev);
> +
> +	if (!(pcf85363->ts_valid_flags & timestamp_flag))
> +		return sysfs_emit(buf, "00-00-00 00:00:00\n");

[Severity: Medium]
Does this prevent timestamps from working on polling systems?

The ts_valid_flags variable is purely memory-backed and is only updated
inside the pcf85363_rtc_handle_irq() interrupt handler. On systems without =
an
IRQ line, this variable is never updated, which means timestamps will always
silently return "00-00-00 00:00:00".

> +
> +	return pcf85363_read_timestamp(pcf85363, base_reg, buf);
> +}
[ ... ]
> @@ -478,38 +613,44 @@ static int pcf85363_probe(struct i2c_client *client)
[ ... ]
> -	wakeup_source =3D device_property_read_bool(&client->dev,
> -						  "wakeup-source");
> -	if (client->irq > 0 || wakeup_source) {
> -		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> -		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> -				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
> -	}
> +	wakeup_source =3D device_property_read_bool(dev, "wakeup-source");
> =20
> -	if (client->irq > 0) {
> -		unsigned long irqflags =3D IRQF_TRIGGER_LOW;
> +	ret =3D regmap_write(pcf85363->regmap, CTRL_FLAGS, 0x00);

[Severity: Medium]
Does this unconditional write destroy timestamp and battery switch-over
events captured while the device was powered off?

Since CTRL_FLAGS is cleared during probe before reading the existing
timestamp flags, pre-boot timestamp indicators are permanently lost.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to clear CTRL_FLAGS\n");
> +
> +	if (irq_a > 0) {
> +		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO, PIN_IO_INTAPM, PIN_I=
O_INTA_OUT);
> +		ret =3D devm_request_threaded_irq(dev, irq_a, NULL,
> +						pcf85363_rtc_handle_irq,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"pcf85363-inta", client);

[Severity: High]
Does hardcoding IRQF_TRIGGER_LOW here break compatibility with systems that
specify a different IRQ polarity in firmware?

The baseline code gracefully degraded the flags to 0 if dev_fwnode() return=
ed
true, allowing device tree or ACPI to supply the correct trigger flags.
Overriding this with a hardcoded value could break interrupt delivery on
affected platforms.

> -		if (dev_fwnode(&client->dev))
> -			irqflags =3D 0;
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -						NULL, pcf85363_rtc_handle_irq,
> -						irqflags | IRQF_ONESHOT,
> -						"pcf85363", client);
>  		if (ret) {
> -			dev_warn(&client->dev,
> -				 "unable to request IRQ, alarms disabled\n");
> -			client->irq =3D 0;
> +			dev_err_probe(dev, ret, "INTA IRQ request failed\n");
> +			irq_a =3D 0;
> +		} else {
> +			regmap_write(pcf85363->regmap, CTRL_INTA_EN, INT_BSIE
> +				     | INT_TSRIE);

[Severity: High]
Does using regmap_write() here unintentionally clear other interrupt
enable bits?

This direct write overwrites the entire CTRL_INTA_EN register, which might
clobber previously configured interrupt enables like INT_A1IE for alarms,
breaking alarm capabilities.

>  		}
>  	}
> =20
> -	if (client->irq > 0 || wakeup_source) {
> -		device_init_wakeup(&client->dev, true);
> -		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> -	} else {
> -		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> -	}

[Severity: Medium]
Does removing this else block falsely advertise RTC_FEATURE_ALARM?

By dropping clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features), the RTC
core might automatically advertise alarm capabilities to userspace on devic=
es
that lack an interrupt and wakeup source.

> +	regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +			   PIN_IO_TSPM | PIN_IO_TSIM,
> +			   PIN_IO_TSPM | PIN_IO_TSIM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812074533.3545=
058-1-lakshay.piplani@nxp.com?part=3D3
