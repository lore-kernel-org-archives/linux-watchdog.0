Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8403AAF7E;
	Wed, 12 Aug 2026 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521606; cv=none; b=YTIdRXwpZrXV2PbrUuR+zhMEpB8y9MJQMDS5CVmcfZP/SrQSey0medkMoV/znkQl/doHkBf588Yu1issXdzisKtYwTMfmkjgGEE7skHQzbRhl6QwhrYZlnVayuHfpFehmM4gAx/mmNLx61MyKQlpNrMH4G5iXUtL00Cml+O2nbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521606; c=relaxed/simple;
	bh=V1bR+lv9vHR4uWey7+t2FdSvzlHBRifMFz2tVuzCNr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evVmcRlqFiWCEM2ZE90B3sOq7N94qsxu004uLKW77Azeu+fk4uLxJsblnap8PT+4jLHtPbZMRMCxNzUj44WAKQjnKcSLSFCtKUUaFHleGvpYEaCX80XjYflg0l4W3BCSDdvngXWrKiHxYhKg+8kxznoiiqQlDb7T/gkLstD+7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtCtV3k5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtCtV3k5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDBC1F00A3A;
	Wed, 12 Aug 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521604;
	bh=RueXxDO8rpcYTaWieb0wx+9yFfdBJhk0TVUeLnH8Cc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtCtV3k5pcvMtIIBm8IvyUIYS+K603m0CNv4dJW04slofSvbpPD5Sq+Ilre25TzFN
	 Jnvh+xB30heXucHdVpOXc/52OPlz4PFF/pFbsHNI3TTkhwsS5eaYXQN8mI/Iciij1v
	 bKu3TDJoXXKNOSAAQsfZjesBiI+IuTjyksUFbSJS9z0px9NhTac2MdV1RsTYkzi0nv
	 YVauk4nfI6/7xdey84RhV8fIlKAWNFk6P9HXr7gXrsNwMyYEQ/+0hDMVFydiwQa8Fs
	 wJeBdCKM2BXIaE4met0Oe/AKA+c9q0m4a39QWkXBQjWbYCBZplNa1BQwkt1tcu6LGd
	 dJffVGHxDiCtg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v4 4/5] rtc: pcf85363: add oscillator offset
 calibration support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260812074533.3545058-4-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
 <20260812074533.3545058-4-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:00:03 +0000
Message-Id: <20260812080004.4DDBC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The offset callbacks operate in raw register steps instead of part=
s per billion (ppb), violating the RTC subsystem API.
- [High] The offset value is wrongly treated as an 8-bit signed integer, wh=
ich stomps on the OFFM (mode) bit and silently triggers Fast Mode.
- [High] The IRQ handler clears the timestamp interrupt flags before the ti=
mestamp data is read, creating a hardware race condition.
- [Low] User space can trigger unratelimited dev_warn() by writing out-of-b=
ounds offset values.
- [Low] The `ts_valid_flags` variable is modified and read concurrently wit=
hout appropriate lockless access annotations.

Pre-existing issues:
- [High] The static `nvmem_cfg` array is modified concurrently during devic=
e probe, risking corruption of private data pointers.
--

--- Patch [4]: [RESEND v4 4/5] rtc: pcf85363: add oscillator offset calibra=
tion support ---
commit cf1f1a013f4f67e8c4a20b8646213cc7ca971733
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add oscillator offset calibration support

This commit adds oscillator offset calibration support to the PCF85363 RTC
driver. It exposes the read_offset and set_offset callbacks, allowing
userspace to apply frequency correction for drift compensation.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index e10e58f690127..665bbbb169b05 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -123,6 +123,11 @@
>  #define TSR2_SHIFT      2
>  #define TSR3_SHIFT      6
> =20
> +#define OFFSET_SIGN_BIT 7
> +#define OFFSET_MINIMUM  -128
> +#define OFFSET_MAXIMUM  127
> +#define OFFSET_MASK     0xFF

[Severity: High]
Does treating this as an 8-bit signed integer stomp on the OFFM (mode) bit?

The PCF85363 CTRL_OFFSET register uses bit 7 as the OFFM (mode) bit and bits
6-0 as a 7-bit two's complement offset (range -64 to +63). Writing a negati=
ve
8-bit integer sets bit 7 to 1, silently reconfiguring the chip into Fast Mo=
de,
while a positive integer switches it to Normal Mode.

Should the driver explicitly preserve the OFFM bit and restrict the offset =
to
a 7-bit value?

[ ... ]
> @@ -359,6 +364,45 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, =
void *dev_id)
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
> =20
> +/*
> + * Read the current RTC offset from the CTRL_OFFSET
> + * register. This value is an 8-bit signed 2's complement
> + * value that corrects osciallator drift.
> + */
> +static int pcf85363_read_offset(struct device *dev, long *offset)
> +{
> +	struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(pcf85363->regmap, CTRL_OFFSET, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	*offset =3D sign_extend32(val & OFFSET_MASK, OFFSET_SIGN_BIT);
> +
> +	return 0;
> +}
> +
> +/*
> + * Write an oscillator offset correction value to
> + * the CTRL_OFFSET register. The valid range is
> + * -128 to 127 (8-bit signed), typically used to fine
> + * tune accuracy.
> + */
> +static int pcf85363_set_offset(struct device *dev, long offset)
> +{
> +	struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev);
> +
> +	if (offset < OFFSET_MINIMUM || offset > OFFSET_MAXIMUM) {

[Severity: High]
Does this code reject valid ppb offsets from userspace?

The rtc_read_offset and rtc_set_offset kernel API expects offset values in
parts per billion (ppb), but this implementation appears to operate directly
in raw register values.

Consequently, if userspace passes a valid offset like 4340 ppb, wouldn't it=
 be
bounds-checked against [-128, 127] and rejected with -ERANGE, rendering the
API unusable?

> +		dev_warn(dev, "Offset out of range: %ld\n", offset);

[Severity: Low]
Can this unratelimited warning log be triggered directly by userspace?

It appears an out-of-bounds write to the sysfs offset node will spam the
kernel log, which could be avoided by simply returning -ERANGE.

> +		return -ERANGE;
> +	}
> +
> +	return regmap_write(pcf85363->regmap, CTRL_OFFSET, offset & OFFSET_MASK=
);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the timestamp
interrupt flags before reading the timestamp data create a hardware race
condition?

In pcf85363_rtc_handle_irq():

    if (flags & FLAGS_TSR1F) {
        regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_TSR1F, 0);
        pcf85363->ts_valid_flags |=3D FLAGS_TSR1F;
        handled =3D true;
    }

The driver exposes timestamp registers via sysfs which performs a lockless
regmap_bulk_read over I2C in pcf85363_read_timestamp(). According to the
PCF85363 behavior, clearing FLAGS_TSR1F rearms the hardware latch.

If a new timestamp event occurs while userspace is in the middle of reading
the timestamp registers, couldn't the hardware update the registers
concurrently and result in a torn read?

[Severity: Low]
This is a pre-existing issue, but is the lockless access to ts_valid_flags
missing necessary concurrency annotations?

The flag is modified in the threaded IRQ handler:

drivers/rtc/rtc-pcf85363.c:pcf85363_rtc_handle_irq() {
...
    pcf85363->ts_valid_flags |=3D FLAGS_TSR1F;
...
}

And read locklessly in sysfs:

drivers/rtc/rtc-pcf85363.c:pcf85363_timestamp_show() {
...
    if (!(pcf85363->ts_valid_flags & timestamp_flag))
...
}

While it's a 1-byte read/write that won't practically tear on supported
architectures, missing READ_ONCE() and WRITE_ONCE() annotations violates
kernel concurrency standards and could trigger KCSAN warnings.

[Severity: High]
This is a pre-existing issue, but does modifying the static nvmem_cfg array
during device probe risk corrupting private data pointers?

drivers/rtc/rtc-pcf85363.c:pcf85363_probe() {
...
    static struct nvmem_config nvmem_cfg[] =3D {
...
    for (i =3D 0; i < config->num_nvram; i++) {
        nvmem_cfg[i].priv =3D pcf85363;
        devm_rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
    }
...
}

If multiple PCF85363 instances are probed on the system, wouldn't the later
probe overwrite the priv pointer of the earlier instances in the shared
static array? This would cause subsequent NVRAM reads/writes for the first
RTC device to incorrectly target the last probed device's regmap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812074533.3545=
058-1-lakshay.piplani@nxp.com?part=3D4
