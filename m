Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE0264A97
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143452; cv=none; b=GWPMban32qlqP/kxX2I7TCSfKTP+aQjObot+rmnkMhYfbuFNce2NmCHVefdikAzLs/JO1Rkr66fOtR68zr+QDS7PonMRFXJQfSW++t23zgRZ9iUlaZ0UEa9s5bP+Nu07Qtw9r2oVHKVV8VMT5z/KjcDtMaE7i1de2ZucGVAUJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143452; c=relaxed/simple;
	bh=KClrGh4Dug9FXrOIRBzdtd0J2XwzUAP61KLKJbVKYI4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K5mn5zE0QYhltPDvB4Wa7IvPb3Ud1pd3iJd6AlEY3rpajwjpXkc3tGbpZrJz/NiwzlFLr/JGrB9ME1jXnFXuFMXcvuNCmcbop9LaT0+i9ep9JwK3wZ5dZtu+lOSd/kYVqFx45vnPzZpP1hHWCO0GIa0JIdLXJHBQM+IQ7EO5/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Ej8lwo0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEEOXs7b; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Ej8lwo0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEEOXs7b"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B4567A0111;
	Mon, 22 Jun 2026 11:50:50 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 11:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782143450;
	 x=1782229850; bh=IFclBJrZMl0j05zztAZ4GvueODuYVD34Cu6isvvS5pM=; b=
	Ej8lwo0XOVVH4YvSWdjE06vU5x3AB64c+6sOfeXeZhCdKLfTqQiAGnR1L1IGxuSt
	1uGLPYd0nDiQWYKO2wfVBAvaWCLbTthOEiKDAvSvirQjXIrwcx4dO8ctQgIlP02o
	1SHL93ir+zsIwAFNX4dIG+n6NDicr3GPZDKX04xie5TjS/ahI4Jx39lRtkBNrINi
	Yu3U4ClFcK+eloB8B5qMqUYPVK1UdJcyDectYvms7JIQGBNva1tjoXvzzLnj9YYV
	mtj2j7CZdI2HnnzHL/qBgUBmGu2k4KQyfhAUY9UjjyFdDLcRCI9+zDTL5kyA8oG0
	4KXCxV6oiCB0gObtQRoK7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782143450; x=
	1782229850; bh=IFclBJrZMl0j05zztAZ4GvueODuYVD34Cu6isvvS5pM=; b=V
	EEOXs7b5R8W/+LsV+Aa9Xiezj55kq90RvPz3q4e332rY8DPHs2uBpaufJaJ1p/94
	/j5P/+mCuBpAmM6E29XfOsbRTWq+5z5KFv+h56WJwxDJM3Y9FWUhDu4j40qNXruB
	iOva4oYXfNq4UFODIye7EvwSy5/dVtARseTODmKVK7YBmjVwIWlD4lBOiZZ1rDBt
	zNvQydHPZTBAGgxXbGc7kd20vDnMzxcAWDWkg3pOfhPxZY3lKzSckx1j8uW284aH
	LxrlXauIxIp+AopkR+jsvQRcb1bGEUkt4/cFdxxsEphsoWZJs/wWHB222NXA4m3v
	JIOzmddMkb60UtbPoS/5g==
X-ME-Sender: <xms:2Vk5ama2wMle4oyJXd8Us0rHsmrgegJgtVt8zcpXZUju5M-0mneUmg>
    <xme:2Vk5akMhhIAJNSJUgK57FpJeDUi5WMlAzV5qWu_mF_IW6wKfBttHKs5tlY8F0QBtf
    vQRiMhxzD-B0vgP_XTPqE73mvNYBOIM0bGX7buR-yIpI3OXRFeX3oI>
X-ME-Proxy-Cause: dmFkZTGD4pxu7A6s+42GRSrur1ZIpv2jJ2I5KhLzcttgWh91IOkFt/OWEHPwHalkUkTQSO
    PpU1oqzXUwCMz1eEV9t2D7aSbFDPJBRHCb/vGT5+mpTQM5vAe6dHuVYuhAmuRImXsSWLTC
    QbJc/NoX/80s2FAoWVuW4dEqRs4MIM/NUAPz83HKC7KXXpM7sVj2mx2lxzwr1uSI+aJ+Gw
    hGoqaKiPyFwA+d2HW1uhU0YsOTGdy6iLZslg3Sn482kbGr3uGCgHi0xS3vn1UZz3ZeWNEh
    YiJedP+Qi09PHZw4ojeQ7gPMvT5fON4f7nJ8L5/A3520F8az/q1opozAdNUf5JX/xz3Qri
    iWSijvCUVMBmsUEVyHbOA4N2MxFPZfMYxYkmIm2AQgEq7eHYeiZolpV68/5tnWB9+jkcyg
    kecB8P4qx4YDJQMclG4hEvskVvvmBNnuIlwL3CVafyBuEdmBcBaGHeQWMaEj15Lj5aZ0Gh
    jwWtj723HuZcrL1UjHcHLAQaSdkjNi0V0ICeGliTdYVFkuWQ+Bs9rKd6Jiqe3rdsuT9y5k
    TFUQbeA++mH5UprvgBBiGzdfZYB6bZ4iedD2Fq/gIwcGp4AaLq1ZrvxbZPlGQ8cvfOO2f2
    fRuV7L4hvBqOMrqod3wCr6aBYqJefIdOwrPs1DeFIR+XMlObgx6LysL7vzdw
X-ME-Proxy: <xmx:2Vk5aqtLIXxWScZouKz9YqV71ngJL73zIeJMoCFC7QWLUGIK6k1tKg>
    <xmx:2Vk5ajzFZG220nNbgJkWBTtHYwe2BxS-gYcWZcvNOO82PGkyUYscCg>
    <xmx:2Vk5ak6VANTLc_RDmsKSwuT4lU-tfwYAFFBzz5uODzcFyko7MDxicA>
    <xmx:2Vk5atWdHcShT6hvC7Bci0agryfy8p1K_lvfB0wM-buPB8Lak7_WZQ>
    <xmx:2lk5attTXdi-tPsHCk4Sl-BOhR8Gj_8k1RrC7jyKONQ-3nsCVbOAgnpc>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A55C02CE409A; Mon, 22 Jun 2026 11:50:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArMcrDYeUHoR
Date: Mon, 22 Jun 2026 11:50:29 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Message-Id: <9e76208e-6fb7-4d62-9a49-95fc03a06737@app.fastmail.com>
In-Reply-To: <20260622145631.DD7041F000E9@smtp.kernel.org>
References: <mpearson-lenovo@squebb.ca>
 <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
 <20260622145631.DD7041F000E9@smtp.kernel.org>
Subject: Re: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and
 SE60
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026, at 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential=20
> issue(s) to consider:
> - [High] The global `se_30g2_60_pdev` pointer is not cleared after=20
> being freed on the `platform_device_add()` error path, leading to a=20
> Use-After-Free and Double-Free during module exit.

I belive this is a valid issue - I'll fix in v2.

> - [High] SuperIO configuration mode is prematurely exited before=20
> reading `bram_base`, causing the read to fail and the driver to map an=20
> invalid I/O port address.

This one is I believe invalid and behaviour is correct. If someone wiser=
 than me disagree's please let me know.

> - [Medium] The allocated and added platform device is permanently=20
> leaked if `platform_driver_register()` fails.

I think this may be valid, I'll add a check in v2 if the device has been=
 allocated and release if there is a driver registration failure.

> - [Medium] The watchdog driver silently ignores hardware access=20
> failures if the `bram_base` region cannot be claimed, falsely reportin=
g=20
> success to the watchdog core.

I'll address this in v2

> --
>
> commit 9d10faee62683aacec801a77d1defa194acc32d0
> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
>   =20
> Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.
>
>> diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watc=
hdog/lenovo_se30g2_se60_wdt.c
>> new file mode 100644
>> index 0000000000000..56e0e9ef8462b
>> --- /dev/null
>> +++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
>> @@ -0,0 +1,274 @@
> [ ... ]
>> +static unsigned short lpc_chip_id(void)
>> +{
>> +	unsigned char msb, lsb;
>> +
>> +	outb(0x87, CFG_PORT);
>> +	outb(0x01, CFG_PORT);
>> +	outb(0x55, CFG_PORT);
>> +	outb(0x55, CFG_PORT);
>> +	msb =3D lpc_read(0x20);
>> +	lsb =3D lpc_read(0x21);
>> +	lpc_write(0x2, 0x2);
>
> [Severity: High]
> Does this lpc_write() prematurely exit SuperIO configuration mode?
>
> Later in se_30g2_60_wdt_probe(), the code attempts to select the BRAM
> logical device and read the base address:
>
> se_30g2_60_wdt_probe() {
>     ...
>     lpc_write(CFG_LDN, CFG_BRAM_LDN);
>     bram_base =3D (lpc_read(0x60) << 8) | lpc_read(0x61);
>     ...
> }
>
> If the configuration mode was already exited here, won't these subsequ=
ent
> reads return 0xFF, causing bram_base to be set to an invalid address?
>
>> +
>> +	return (msb << 8 | lsb);
>> +}
>
> [ ... ]
>
>> +static void wdt_write(unsigned short val)
>> +{
>> +	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
>> +		return;
>> +	bram_write(BRAM_WDT_REG, (val >> 8) & 0xFF);
>> +	bram_write(BRAM_WDT_REG + 1, val & 0xFF);
>> +	release_region(bram_base, BRAM_SIZE);
>> +}
>> +
>> +static int wdt_start(struct watchdog_device *wdog)
>> +{
>> +	wdt_write(wdog->timeout);
>> +	return 0;
>> +}
>
> [Severity: Medium]
> If request_muxed_region() fails in wdt_write(), the function silently =
returns.
>
> Since wdt_start() and wdt_ping() call wdt_write() and always return 0,=
 won't
> this falsely report success to the watchdog core even if the hardware =
write
> failed?
>
> [ ... ]
>
>> +static int se_30g2_60_create_device(const struct dmi_system_id *id)
>> +{
>> +	int err;
>> +
>> +	se_30g2_60_pdev =3D platform_device_alloc("lenovo-se30g2-se60-wdt",=
 -1);
>> +	if (!se_30g2_60_pdev)
>> +		return -ENOMEM;
>> +
>> +	err =3D platform_device_add(se_30g2_60_pdev);
>> +	if (err)
>> +		platform_device_put(se_30g2_60_pdev);
>
> [Severity: High]
> If platform_device_add() fails, platform_device_put() frees the device=
, but
> the global se_30g2_60_pdev pointer is not set to NULL.
>
> Since dmi_check_system() returns the number of matches regardless of c=
allback
> errors, module initialization will proceed. When the module is unloade=
d,
> se_30g2_60_wdt_exit() will check if se_30g2_60_pdev is non-NULL and ca=
ll
> platform_device_unregister(), leading to a use-after-free and double-f=
ree.
>
> Could se_30g2_60_pdev be explicitly set to NULL on the error path to a=
void
> this?
>
>> +
>> +	return err;
>> +}
>
> [ ... ]
>
>> +static int __init se_30g2_60_wdt_init(void)
>> +{
>> +	if (!dmi_check_system(se_30g2_60))
>> +		return -ENODEV;
>> +
>> +	return platform_driver_register(&se_30g2_60_wdt_driver);
>> +}
>
> [Severity: Medium]
> If platform_driver_register() fails here, the platform device successf=
ully
> allocated and added by the DMI callback is never unregistered.
>
> Will this permanently leak the platform device and cause subsequent mo=
dule load
> attempts to fail with -EEXIST?
>
> --=20
> Sashiko AI review =C2=B7=20
> https://sashiko.dev/#/patchset/20260622144531.2413447-1-mpearson-lenov=
o@squebb.ca?part=3D1

I'll hold off a couple of days on doing v2 in case there is any other fe=
edback from maintainers outside of the sashiko recommendations.

Mark
