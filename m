Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529A2F6920;
	Tue, 14 Jul 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045687; cv=none; b=CouUORMyH950O2SaZMvBtYWpk8/QQLuRINhkKuP9tHTar2ryho6C2TYdRhqgv0ENSKkHj+unQwG0UQ0oPXjm9CuXCH3ETCFhfn0uCuVKo61/q/bkkd5WhXqOF7/VfdxpoFywM8vuGseDjFMccCBzrPlZ3Uexi+ItOcYsMK56aUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045687; c=relaxed/simple;
	bh=zIY2aMUEOiopzWsgQEWZGxfuk3w7gXKJKNyDmur8U8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jSge5Xybpb5L615IvkNgkmglaMnfea49gjllRZWHhL3CQ5NgPtn/8Q5t9zRNzXMvE9XEzvRTNg0e1I+8H6fiGw5DE18bMetJ3IR9JPa9LC13TWtKanBGImWcsMT8JaV0owxesj/bQDMM/SG9DbMGNxYkzdY3rrHxlWGtTq7mswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+wUyMc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+wUyMc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72751F000E9;
	Tue, 14 Jul 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784045686;
	bh=n6fpDDchRl+qTg8OO7QXdYt/sgsAvifY2+jx9NRSV4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+wUyMc4eIE7HHVn2QsheBZWQDtxw81r5IlOfhtJSWa1qsGXIsZHAIw7o4hMfCXyf
	 WgEKlBx94zUkkhowkncSl9AyUzT9/8wVPYdg0SxcoqGppI3V+VQYzIMpQaeN1LZzNf
	 kcNCsEI/kv9wIQWO0D+6gSyQdK8nFRgf4wda/pM8Od1k49qM2j/A61NjHtk2Fe4BcS
	 vraLJKlrL/qav0A7LDCd0Ab6Y9eAxobnPnpnc1i6OTNonm6wXXi+dyULu1uryKRGQD
	 saw7SV8bEMONQwyK6n0GSaiKQezIdFKMhZb60Jyjvf88VdQePCmKUp122Su0X2bibg
	 AryqMegkqt3cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] Add Advantech EIO Fan driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260714-upstream-v2-v2-8-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-8-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:14:45 +0000
Message-Id: <20260714161445.C72751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing `.remove` callback and incomplete probe error unwinding le=
ads to thermal zone leaks and use-after-free vulnerabilities.
- [High] Array index out-of-bounds when accessing the `fan_name` array usin=
g an unvalidated hardware index.
- [High] `eio_fan_should_bind` casts `cdev->devdata` to `struct eio_fan_dev=
 *` without verifying the cooling device type.
- [Medium] `eio_fan_set_trip_temp` constantly fails because it incorrectly =
double-adds the `CTRL_THERM_HIGH` offset.
- [Medium] Passing pointers to 32-bit `int` variables for 1- or 2-byte hard=
ware reads results in endianness corruption on big-endian architectures.
- [Medium] Violation of MFD subsystem rules by using a custom parent-child =
accessor function.
--

--- Patch [8]: [PATCH v2 8/8] Add Advantech EIO Fan driver ---
commit 0e6353f2bcc96ca0d70e6ec50a52311c0213d5ad
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Add Advantech EIO Fan driver

This commit adds the driver to control the Advantech EIO Fan block,
which is included in the Advantech EIO Embedded Controller.

> diff --git a/drivers/thermal/eio_fan.c b/drivers/thermal/eio_fan.c
> new file mode 100644
> index 0000000000000..e07b18c2ec44a
> --- /dev/null
> +++ b/drivers/thermal/eio_fan.c

[ ... ]

> +static int pmc_write(struct device *mfd, u8 ctrl, u8 id, void *data)
> +{
> +	if (ctrl >=3D ARRAY_SIZE(pmc_len))
> +		return -EINVAL;
> +
> +	struct pmc_op op =3D {
> +		.cmd       =3D CMD_FAN_WRITE,
> +		.control   =3D ctrl,
> +		.device_id =3D id,
> +		.size	   =3D pmc_len[ctrl],
> +		.payload   =3D (u8 *)data,
> +	};
> +	return eio_core_pmc_operation(mfd, &op);

[Severity: Medium]
Does using eio_core_pmc_operation() directly bypass standard kernel subsyst=
em
APIs like regmap? According to MFD guidelines, child drivers should retrieve
parent driver data using standard APIs rather than custom parent-child
accessors.

[ ... ]

> +static int eio_fan_get_temp(struct thermal_zone_device *tzd, int *temp)
> +{
> +	struct eio_fan_dev *fan =3D thermal_zone_device_priv(tzd);
> +	struct device *mfd =3D fan->mfd;
> +	u8 ch =3D fan->id;
> +	int sensor =3D 0;
> +	u16 val =3D 0;
> +	int ret;
> +
> +	ret =3D pmc_read(mfd, CTRL_CTRL, ch, &sensor);

[Severity: Medium]
Since pmc_read() seems to read a 1-byte value based on pmc_len[CTRL_CTRL],
does passing a pointer to a 32-bit integer write only to the most-significa=
nt
byte on big-endian platforms?

[ ... ]

> +static int eio_fan_set_trip_temp(struct thermal_zone_device *tzd,
> +				 const struct thermal_trip *trip, int temp)
> +{
> +	struct eio_fan_dev *fan =3D thermal_zone_device_priv(tzd);
> +	const struct eio_fan_trip *fan_trip =3D trip->priv;
> +	u8 ctl =3D CTRL_THERM_HIGH + fan_trip->trip_ctl;

[Severity: Medium]
Since fan_trip->trip_ctl was already initialized to CTRL_THERM_HIGH during
probe, does adding CTRL_THERM_HIGH again cause the offset to exceed the
ARRAY_SIZE(pmc_len) limit of 33, making pmc_write() always return -EINVAL?

[ ... ]

> +static bool eio_fan_should_bind(struct thermal_zone_device *tzd,
> +				const struct thermal_trip *trip,
> +				struct thermal_cooling_device *cdev,
> +				struct cooling_spec *spec)
> +{
> +	struct eio_fan_dev *tz_fan  =3D thermal_zone_device_priv(tzd);
> +	struct eio_fan_dev *cd_fan  =3D cdev->devdata;
> +
> +	if (!tz_fan || !cd_fan)
> +		return false;
> +
> +	if (tz_fan->mfd !=3D cd_fan->mfd || tz_fan->id !=3D cd_fan->id)

[Severity: High]
Is it safe to cast cdev->devdata to struct eio_fan_dev* here without first
verifying that the cooling device actually belongs to this driver (for
example, by checking cdev->ops)? Could this lead to out-of-bounds memory
access if the thermal framework invokes this for a cooling device belonging=
 to
another driver?

[ ... ]

> +static int eio_fan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	unsigned int fan_id;
> +	int ret;
> +
> +	if (!dev_get_drvdata(dev->parent)) {
> +		dev_err(dev, "eio_core not present\n");
> +		return -ENODEV;
> +	}
> +
> +	for (fan_id =3D 0; fan_id < FAN_MAX; fan_id++) {
> +		u8 state =3D 0, name =3D 0;
> +		int trip_hi =3D 0, trip_lo =3D 0, trip_stop =3D 0;
> +		int pwm_hi =3D 0, pwm_lo =3D 0;
> +		struct eio_fan_dev *fan;
> +		struct thermal_zone_device *tzd;
> +		struct thermal_cooling_device *cdev;
> +
> +		if (pmc_read(dev->parent, CTRL_STATE, fan_id, &state) ||
> +		    pmc_read(dev->parent, CTRL_TYPE, fan_id, &name) ||
> +		    pmc_read(dev->parent, CTRL_THERM_HIGH, fan_id, &trip_hi) ||

[Severity: Medium]
Similar to eio_fan_get_temp(), does passing pointers to 32-bit integers for
these hardware reads cause endianness corruption on big-endian architecture=
s?

[ ... ]

> +		if (!(state & 0x1)) {
> +			dev_info(dev, "fan%u: firmware reports disabled\n", fan_id);
> +			continue;
> +		}
> +
> +		if (!fan_name[name][0]) {

[Severity: High]
The 'name' index is read from hardware as a u8. Does this code need to check
if 'name' exceeds the 32-element bounds of the fan_name[] array to prevent =
an
out-of-bounds read?

[ ... ]

> +		cdev =3D thermal_cooling_device_register(fan_name[name], fan, &cooling=
_ops);
> +		if (IS_ERR(cdev)) {
> +			thermal_zone_device_unregister(tzd);
> +			dev_err(dev, "fan%u: cdev register failed: %ld\n",
> +				fan_id, PTR_ERR(cdev));
> +			return PTR_ERR(cdev);
> +		}

[Severity: High]
If this loop fails on a subsequent fan iteration, does returning directly
here leave previously registered thermal zones and cooling devices active?
Should this failure path unwind the already registered instances?

[ ... ]

> +static struct platform_driver eio_fan_driver =3D {
> +	.probe  =3D eio_fan_probe,
> +	.driver =3D {
> +		.name =3D "eio_fan",
> +	},
> +};

[Severity: High]
Does the lack of a .remove callback mean that unbinding the driver via sysfs
abandons the registered thermal zones and cooling devices? Because
devm_kzalloc() frees the memory on unbind, could this leave dangling pointe=
rs
in the thermal subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D8
