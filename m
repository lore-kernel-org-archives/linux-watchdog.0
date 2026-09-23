Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53055383C8
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172219; cv=none; b=bo6lY+sg9pColqr5Dse8zTmxJNIYOi0glAR+MhHg6Ex+brqPOLcfpRMhkfSIt7d2+1wz8ZiBQToIYjinGWCSVsUu5c/ssoZE/pzdDsogN3WrTIQ7rUb4YwAdsaGtw7iqL8i+4EwVdhxMgwoMvs9QH70iNCxBEiY/aUciuPKA30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172219; c=relaxed/simple;
	bh=xqf0mQQ/HukQymQ5kRyEEJMzRd1cXTrt93NP+wMpoC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bqq9fmz5NTic7pAfGb/1QgA/3XsEvCk6OYNeeuPvdNkCP9v0mzRTv746DofBD64etyhgKKrsQZ2au4jWKFLnB3TcJvINLxTTygOlOzRx2FLa4U8cal6nS6hK8zi/qWckRoZHqAxqbZupY0dNYJSXWpUPKOMFVacXyRK10+IgWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AyKrPuv7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AyKrPuv7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1824B4E4102D;
	Wed, 23 Sep 2026 14:03:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D99DF60580;
	Wed, 23 Sep 2026 14:03:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 066D2103293F2;
	Wed, 23 Sep 2026 16:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790172208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6cfbg+DAzthoS5akP4It9Pe+3zz48iZBqgkxD/CrVZI=;
	b=AyKrPuv7w+PVG7aCNFW1G0hTAsEI6725oWspiqlrT6PaDVEV4uwT2vMPseRkW5yDRqVkUu
	eutmY+M7gyaPR/IZTM1FUTFa6lePh7zm5gFDlCbZ8PJ8czs9j7KTEYf9undow1kzXGNTPV
	d7v5WVkU3diSj4YM/Lp2Ed5Cp7wDeL1zSLgypHWm/H7ldII1+B4wMio0AiAvpKBgZxX+T8
	DaSP05JZIM6makWopMVUPtCOEJdsUKorANP3laJRNNQA11yT27SpjZcWpSJkjiu7X6Fe07
	eepa/PiD3zd6MDrjG165ASxjBVQgzElgBhlZt66oqspVCnXgcF7ihS96ysRmOg==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 16:03:25 +0200
Message-Id: <DLMR324EQEUG.2G5RGH1X4B6PY@bootlin.com>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] watchdog: w83627hf_wdt: Add Super I/O
 configuration port as a platform device resource
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, <sashiko-reviews@lists.linux.dev>,
 "Paul Louvel" <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com> <20260726-w83627hf_wdt-improvements-v2-5-3645a2a6c022@bootlin.com> <20260726185636.31D4C1F000E9@smtp.kernel.org> <2368bc26-634e-4691-a369-25090913ec50@roeck-us.net>
In-Reply-To: <2368bc26-634e-4691-a369-25090913ec50@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

Hi Guenter,

Sorry for not responding to your email earlier.

On Mon Jul 27, 2026 at 3:08 AM CEST, Guenter Roeck wrote:
> On 7/26/26 11:56, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Critical] Claiming the shared Super I/O configuration port as a stati=
c platform device resource causes a Use-After-Free and breaks global mutual=
 exclusion upon module unload.
>> --
>>=20
>> --- Patch [5]: [PATCH v2 5/8] watchdog: w83627hf_wdt: Add Super I/O conf=
iguration port as a platform device resource ---
>> commit 7147d011852b779a7e376729ecb29c06b86e9282
>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>=20
>> watchdog: w83627hf_wdt: Add Super I/O configuration port as a platform d=
evice resource
>>=20
>> This commit changes the Super I/O configuration port address from a
>> global variable to a platform device resource. It uses
>> platform_device_register_resndata() to assign the IO resource during
>> module initialization.
>>=20
>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627h=
f_wdt.c
>>> index 69d4230d8f6cc..a067b8ea6b289 100644
>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>> [ ... ]
>>> @@ -594,8 +597,14 @@ static int __init wdt_init(void)
>>>   	if (ret)
>>>   		return ret;
>>>  =20
>>> -	wdt_pdev =3D platform_device_register_data(NULL, wdt_ids[chip].name,
>>> -						 PLATFORM_DEVID_NONE, NULL, 0);
>>> +	res.name =3D "Super I/O port";
>>> +	res.flags =3D IORESOURCE_IO;
>>> +	res.start =3D sioaddr;
>>> +	res.end =3D sioaddr + 1;
>>> +
>>> +	wdt_pdev =3D platform_device_register_resndata(NULL, wdt_ids[chip].na=
me,
>>> +						     PLATFORM_DEVID_NONE, &res,
>>> +						     1, NULL, 0);
>>=20
>> [Severity: Critical]
>> Does claiming the shared Super I/O configuration port as a static platfo=
rm
>> device resource cause a use-after-free regression and break mutual exclu=
sion
>> on module unload?
>>=20
>> If this port is registered as a non-busy I/O resource, it becomes a
>> container node in the global ioport_resource tree. When another driver
>> calls request_muxed_region() for the same port, it might sleep on
>> muxed_resource_wait while holding a parent pointer to this container nod=
e.
>>=20
>> If the wdt module is unloaded while that thread is sleeping,
>> platform_device_del() unlinks the container node and
>> platform_device_release() frees its memory. When the sleeping thread
>> wakes up, will it dereference the freed parent pointer in
>> __request_resource()?
>>=20
>> Additionally, it appears that unlinking the container node orphans any
>> active child reservations from the tree. Could this allow concurrent
>> hardware access to the shared Super I/O port?
>>=20
>
> That makes me wonder: Under which authority can the watchdog driver claim
> ownership of this resource ? What is the rationale ?
>
> Why should the owner not be, for example, the hardware monitoring driver =
?
> Or the Bluetooth driver, if the chip has one ? Or some other driver ?
> Or some non-existent Super-IO core ?

Yes, it should not.
Was a misunderstanding of my part. Did not know that adding a resource in d=
river
registration would cause resource contention if other drivers try to access=
 the
SIO extended function mode.

>
> On a higher level, why even risk the problem outlined by Sashiko above ?
> What is the benefit of doing this ? The patch description fails to
> explain _why_ this change is made. Actually, that is true for many
> of the patches. Quite often the description explain what is done,
> but not the reason for it. The reason may be obvious for you, but not
> or not always for me - and very much so for this patch.
>
> Please explain why you are making those changes.

My bad if it was not clear.
This series is an attempt of modernizing this driver to a platform driver s=
o
that it can use modern kernel APIs, expose sysfs interface, and clean the
driver.

And also add minute mode counting that is a feature that is just missing fr=
om
the driver. Maybe it should be a subject for another patch, outside of this
series ?

>
> Also, I notice that at least in some cases it looks like you did not
> address the feedback from Sashiko. Partially that is because problems
> in one patch are addressed in a later patch of the series, but I am quite
> sure I have seen Sashiko's feedback about the missing parent device
> initialization before. Please ensure to address its feedback.

Sashiko reviews will be taken into account for the next iteration.

>
> Thanks,
> Guenter

Thanks,
Paul.




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

