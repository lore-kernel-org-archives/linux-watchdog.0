Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259741737A
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431214; cv=none; b=koePr+pYZ0afySmjjAb+Gut6SCt/AxjAjuUdlzXiwb+6WO0QRSBBmKQnezTgpHjhcj/f6xOu7Gdix7q44KWUP8JoUeTKKdBbRmtvyTOTGnB1FKcA/e0Cr4uQAC2aJC7KvOE+adG31Ex+wjoocYMrTx/AFAV9bWS3/7zNEL39yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431214; c=relaxed/simple;
	bh=GQfMYbnOxpcRY5c1TiAWzcpJrT65pDKSeYJfx3nHNFQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nRjhxTXqSGhalH5ZB5WyYeyLPdfofimadt4pdYQjTcdQH/EmY+v63JhDqGjFONCCoPHKrSuuoMosjklA14pKfDyFFBTVRA0qxqRHbBaw9fgcEZKECwOBzCpscQiD3lIaZcvTLUtczZxdkmWSJgij5ix6NEpwYh9Wvj4L4UkrinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XbupLp5W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XbupLp5W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 259C64E40CA1;
	Tue,  7 Jul 2026 13:33:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E82FB60333;
	Tue,  7 Jul 2026 13:33:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 704A311BC11B0;
	Tue,  7 Jul 2026 15:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783431208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eWe6D8M+Qv8n+twshu2746DOFdO/y2gPgEVI4Cbo08w=;
	b=XbupLp5Wsb/CiS3X3UV8DhvKfRSRrvxCp8GCf6Vf1/31wuhu3Qv1RZd2HzLpex/fM3LJV/
	Sk0AsrnPsZtRrRpEkPfFt5DjrDJ2Nx5IisVOiHtV2rJvq1aQnAxChGsnLrqbW3QaZeEcBi
	ciBpMd71ar+AdPNb7yIytYxm2uYP8PA3LSQ9xLP8thxx0q+Ek+iw0KZUWdjB9BfI5C90fr
	2GiTDAB/d/itHy4aHyVqXT42VfX+KqM97C/Wbq9/VeYzUxKtzTKVxNbExcTXGZMyfPhhzX
	gmzjew27X/jSxsK0bD4XiSZr8s/KlA8BcZAA64rKKzWkSrIbQ2C3q5K06e6EIA==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 15:33:26 +0200
Message-Id: <DJSDLLOEH1OE.1VSQGGM2GN768@bootlin.com>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Paul Louvel"
 <paul.louvel@bootlin.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
 <20260706104010.A345B1F000E9@smtp.kernel.org>
 <DJRG1B5OZRQF.3TGMTYKZF4XL8@bootlin.com>
 <f598a05b-5d91-484d-a637-e092950a6f47@roeck-us.net>
 <DJRLRNRML483.3ZTW07FZBRFW@bootlin.com>
 <5e441e3a-27ce-4f46-abf4-fd6246727cb6@roeck-us.net>
 <DJRTDK0H5R1Q.32FU59ADLZD6E@bootlin.com>
 <a20d8c37-0d46-489b-aa8c-af927a2c552c@roeck-us.net>
 <DJS68HQS83G4.38Z406G5WD8NQ@bootlin.com>
 <815d52b8-324f-4fa5-9470-d60f79546366@roeck-us.net>
In-Reply-To: <815d52b8-324f-4fa5-9470-d60f79546366@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Jul 7, 2026 at 3:28 PM CEST, Guenter Roeck wrote:
> On 7/7/26 00:47, Paul Louvel wrote:
>> On Mon Jul 6, 2026 at 11:48 PM CEST, Guenter Roeck wrote:
>>> On 7/6/26 14:42, Paul Louvel wrote:
>>>> On Mon Jul 6, 2026 at 6:12 PM CEST, Guenter Roeck wrote:
>>>>> On 7/6/26 08:44, Paul Louvel wrote:
>>>>>> On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
>>>>>>> On 7/6/26 04:15, Paul Louvel wrote:
>>>>>>>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>>>>>>>> Thank you for your contribution! Sashiko AI review found 1 potent=
ial issue(s) to consider:
>>>>>>>>> - [High] Removing the manual hardware timeout refresh while still=
 unconditionally switching the hardware timer base from minutes to seconds =
drastically truncates the remaining timeout if the BIOS originally configur=
ed it in minutes, risking unexpected system reboots.
>>>>>>>>> --
>>>>>>>>>
>>>>>>>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>>>>>>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>>>>>>>
>>>>>>>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on b=
oot
>>>>>>>>>
>>>>>>>>> This patch updates the w83627hf watchdog driver to rely on the wa=
tchdog
>>>>>>>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive duri=
ng boot.
>>>>>>>>> It replaces the previous behavior of manually issuing a single ke=
epalive
>>>>>>>>> during initialization.
>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/=
w83627hf_wdt.c
>>>>>>>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>>>>>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>>>>>>>> [ ... ]
>>>>>>>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_dev=
ice *wdog, enum chips chip)
>>>>>>>>>>      			pr_warn("Stopping previously enabled watchdog until user=
land kicks in\n");
>>>>>>>>>>      			superio_outb(cr_wdt_timeout, 0);
>>>>>>>>>>      		} else {
>>>>>>>>>> -			pr_info("Watchdog already running. Resetting timeout to %d s=
ec\n",
>>>>>>>>>> -				wdog->timeout);
>>>>>>>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>>>>>>>> +			pr_info("Watchdog already running.\n");
>>>>>>>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>>>>>>>      		}
>>>>>>>>>>      	}
>>>>>>>>>>     =20
>>>>>>>>>
>>>>>>>>> [Severity: High]
>>>>>>>>> Does removing this explicit timeout reset create a risk of unexpe=
cted reboots?
>>>>>>>>>
>>>>>>>>> If the BIOS originally configured the watchdog with a timeout in =
minutes
>>>>>>>>> (for example, a timeout of 5 minutes), the hardware counter cr_wd=
t_timeout
>>>>>>>>> will hold the value 5.
>>>>>>>>
>>>>>>>> First of all, the driver does not support minute mode for now.
>>>>>>>
>>>>>>> The above feedback doesn't claim otherwise. The BIOS may still have=
 configured
>>>>>>> the timeout to 5 minutes.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Because this patch removes the explicit write of wdog->timeout (w=
hich is
>>>>>>>>> typically 60) to cr_wdt_timeout, the counter retains the raw valu=
e 5.
>>>>>>>>> Just after this block in w83627hf_init(), the driver unconditiona=
lly
>>>>>>>>> switches the timebase to seconds:
>>>>>>>>>
>>>>>>>>> w83627hf_init() {
>>>>>>>>>         ...
>>>>>>>>>         /* set second mode & disable keyboard turning off watchdo=
g */
>>>>>>>>>         t =3D superio_inb(cr_wdt_control) & ~0x0C;
>>>>>>>>>         superio_outb(cr_wdt_control, t);
>>>>>>>>>         ...
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> This immediately shrinks the remaining timeout from 5 minutes to =
5 seconds.
>>>>>>>>
>>>>>>>> True, but in those 5 seconds, the watchdog core will kick the watc=
hdog
>>>>>>>> immediately. by calling start(), and thus refreshing the watchdog =
to 60 seconds.
>>>>>>>
>>>>>>> ... unless below.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> If the watchdog core's kworker is delayed, or if the system is co=
nfigured
>>>>>>
>>>>>>
>>>>>>
>>>>>>>>> not to ping the watchdog before user space takes over, could this=
 unusually
>>>>>>>>> short timeout cause the system to reboot unexpectedly during earl=
y boot?
>>>>>>>>
>>>>>>>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BO=
OT_ENABLED is
>>>>>>>> enabled by default unless explicitly disabled when configuring the=
 kernel.
>>>>>>>>
>>>>>>>
>>>>>>> It is still an unexpected and undocumented change in behavior. Prev=
iously
>>>>>>> in that situation the watchdog timeout would happen much later and =
give
>>>>>>> user space time to start the watchdog daemon. This is no longer the=
 case.
>>>>>>
>>>>>> Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabl=
ed, the
>>>>>> driver now doesn't refresh the watchdog, this is unexpected ? I was =
relying on
>>>>>> the fact that this entry is enabled by default.
>>>>>
>>>>> It can be disabled with a configuration option, and with a module par=
ameter.
>>>>>
>>>>>> In this case, should the driver refresh the watchdog itself, and set=
 the
>>>>>> WDOG_HW_RUNNING bit (for the added feature that it does it repeatedl=
y) ?
>>>>>> Or document the fact that the driver will not refresh the watchdog i=
f
>>>>>> WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?
>>>>>>
>>>>>
>>>>> The difference is that the timeout used to be 60 seconds, or whatever=
 the
>>>>> default driver timeout is set to. If the BIOS enables the hardware ti=
meout
>>>>> and sets it to <n> minutes, your patch changes that to <n> seconds. T=
hat
>>>>> is unexpected.
>>>>
>>>> The default driver timeout is set to 60 seconds. I do not understand y=
our point.
>>>> If the BIOS enables the hardware timeout and sets it to <n> minutes, w=
ithout my
>>>> patch, the driver would still refresh the watchdog to <n> seconds (60 =
actually),
>>>> with "superio_outb(cr_wdt_timeout, wdog->timeout);". It forces second =
mode in
>>>> the control register anyway, and the driver has no way to know the pre=
viously
>>>> set timeout.
>>>> The only difference I see is that it does it immediately and does not =
rely on
>>>> the core to do it. It also do it only code.
>>>> Maybe I do not see something here.
>>>>
>>>
>>> Please provide the data path showing how the watchdog core sets the tim=
eout
>>> to 60 seconds if WATCHDOG_HANDLE_BOOT_ENABLED is not enabled.
>>=20
>> If WATCHDOG_HANDLE_BOOT_ENABLED is not enabled, then I understand the is=
sue.
>> Would an additional check at compile time be sufficient ?
>>=20
>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf=
_wdt.c
>> index 27ef1cce3a14..c6d470be62a8 100644
>> --- a/drivers/watchdog/w83627hf_wdt.c
>> +++ b/drivers/watchdog/w83627hf_wdt.c
>> @@ -242,7 +242,11 @@ static int w83627hf_init(struct watchdog_device *wd=
og, enum chips chip)
>>                          superio_outb(cr_wdt_timeout, 0);
>>                  } else {
>>                          pr_info("Watchdog already running.\n");
>> +#ifdef CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
>>                          set_bit(WDOG_HW_RUNNING, &wdog->status);
>> +#else
>> +                       superio_outb(cr_wdt_timeout, wdog->timeout);
>> +#endif
>>                  }
>>          }
>>=20
> No, because "handle boot enabled" can be disabled with a module parameter=
.

Ok.

>
> Why do you insist to dropping superio_outb() instead of just keeping it ?

I am not. I wanted to ask you if it was a possible solution, which is not.
I will keep it for v4.

>
> Guenter

Thanks,
Paul.



--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

