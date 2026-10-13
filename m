Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA023F164E
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901408; cv=none; b=TKq6KFYtvg2+gRhq9EfHL4NR9yHsI023UZI7w2mWstUBMi/RISGlG7qGgmKQJI0xxh5Jox58d6E1ERl9EHIyJ+nyMamAkpDBbYmC6VGAw7bdOY+/MSiS3Cbeuyx4PB/PrTsdG1McSSfS6lqCWcJQffnx/rk3V+Y/dqFH95Vv7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901408; c=relaxed/simple;
	bh=T3LOGqnIuq9qg7CHmKZNeYMwFTz2WME6HZEAvaRvonY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aH5qgn/jHEaEcvFcmyP0lc4hbKCpIX7Lo+I4KAWFzVJ0fA52Z25VZs67iv+6AVA3Wr2kPYFixGrTbFq/nH0bfEwAIQQ36iIsaxpi0eu4aCe3X/m4+mxz8J1dIeb1jmnzebQELL+wwDCLfzqGNE5Tz2Lgzsakz7G0WKB55fIml54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNzLvpq8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNzLvpq8"
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B8164C653ED;
	Tue, 13 Oct 2026 14:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C79F60362;
	Tue, 13 Oct 2026 14:23:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE2B011D716AB;
	Tue, 13 Oct 2026 16:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791901380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1O1CMeaVF0O6QiEOXdJPl9pRAjYM0rbbTpCftyMLR+8=;
	b=iNzLvpq8qFtCaQNeiDWgddlSA4nDFqAoNL0RFOe8h3yPQkuzi2l2g2FFhFZm9vjaTyaYdC
	WFMDxT+97ixfoRPL1L0RKakWhx1LXlgerjTCxHCrgFcdR2fFN6eObkzpnBT1okXBZnimzN
	4Xoz14kijrw4DOdRqmoM4+FUsUbCrpJT0R3qdjSSiUQ+sw45jNpYufS8zpiDKj5Z1A25Pc
	m4k9gTWeb8ZIYBOPbOTof3wkphQf4LkryXiafeBtoGhqY/4ZvLzmZkSthcDIVT892JFJ8Q
	x4RLka+1iuMoeKI9JZ1KcW5chsFmpJp5iI98u/y3MFpWKDHTFvrWlu+OIAw2BQ==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 16:22:59 +0200
Message-Id: <DM3S0X9T1346.1A2X1MLPGV9O6@bootlin.com>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] watchdog: w83627hf_wdt: Add minute mode counting
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com> <20261013-w83627hf_wdt-improvements-v4-6-b6f6b60a9566@bootlin.com> <sashiko-outbox-169886@kernel.org>
In-Reply-To: <sashiko-outbox-169886@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 13, 2026 at 4:08 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] watchdog: spurious hardware reboot during timeout mode transitio=
n
> --
>
> commit e9913194bed75434ff662763db21c93683fc01dc
> Author: Paul Louvel <paul.louvel@bootlin.com>
>
> watchdog: w83627hf_wdt: Add minute mode counting
>
> All of the chips supported by the driver can be set to minute mode,
> allowing timeout value up to 255 minutes. Add it to the driver.
>
>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf=
_wdt.c
>> index 0b9195e7e95ef..8f78fe64acde9 100644
>> --- a/drivers/watchdog/w83627hf_wdt.c
>> +++ b/drivers/watchdog/w83627hf_wdt.c
>
> [ ... ]
>
>> @@ -290,6 +284,7 @@ static int w83627hf_init(struct watchdog_device *wdo=
g, enum chips chip)
>>  static int wdt_set_time(struct watchdog_device *wdog, unsigned int time=
out)
>>  {
>>  	struct w83627hf_data *data =3D watchdog_get_drvdata(wdog);
>> +	unsigned char ctrl;
>>  	int ret;
>> =20
>>  	ret =3D superio_enter(data->sio->addr, data->sio->cfg_enter);
>> @@ -297,6 +292,15 @@ static int wdt_set_time(struct watchdog_device *wdo=
g, unsigned int timeout)
>>  		return ret;
>> =20
>>  	superio_select(data->sio->addr, W83627HF_LD_WDT);
>> +
>> +	ctrl =3D superio_inb(data->sio->addr, data->reg->control);
>> +
>> +	if (data->minute_mode)
>> +		ctrl |=3D WDT_CTRL_MINUTE_MODE;
>> +	else
>> +		ctrl &=3D ~WDT_CTRL_MINUTE_MODE;
>> +
>> +	superio_outb(data->sio->addr, data->reg->control, ctrl);
>>  	superio_outb(data->sio->addr, data->reg->timeout, timeout);
>
> [Severity: High]
> Can this sequence trigger a spurious hardware reboot during a timeout mod=
e
> transition?
>
> In wdt_set_time(), the hardware control register is updated first to chan=
ge
> between minute and second modes, immediately followed by the timeout regi=
ster:
>
> 	superio_outb(data->sio->addr, data->reg->control, ctrl);
> 	superio_outb(data->sio->addr, data->reg->timeout, timeout);
>
> When transitioning from minute mode to second mode (for example, from 1 m=
inute
> to 10 seconds), the hardware control register is updated first. The hardw=
are
> timer momentarily retains its old value (1) but interprets it under the n=
ew
> unit (seconds), meaning it evaluates that only 1 second is left.
>
> If the thread is preempted (e.g., by an SMI or a hypervisor) between thes=
e two
> superio_outb() calls for longer than this intermediate duration, will the
> hardware watchdog fire and spuriously reboot the system?

Yes it could happen if the hardware does not take measures to avoid this. A=
lso,
one second is a long time between those two writes, I doubt this ever happe=
ns in
practice.

>
> Would it be safer to temporarily disable the watchdog (by writing 0 to th=
e
> timeout register) before modifying the control register's mode bit?
>

Yes.

>>  	superio_exit(data->sio->addr, data->sio->cfg_leave);
>>

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

