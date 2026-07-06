Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB547DF8F
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374161; cv=none; b=UaMp2bNmF+fp5ub+71J/X/sU6QSq8M8yfuTOgs8ZS+S7cKHj4AP98Y267xkJh6yxfWaflANiKSTr2h0r4mquI177awrs6twIoX7pcogcFFLsJ5FKs7pdrEWzIh3xgKJZaUjlpINgiMCNzIaVZbhvSr8yVX/y/h3KhcnVF0H+v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374161; c=relaxed/simple;
	bh=WxpSPahH+cYVsmyts8TX458UH+YrV+zhjC+lsyllOI0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YDVBVS5RPNLu4QkFZruKSmKVGqCxoOCYzNlecU2Snp5/dzZsGaGvmp/5Pq363qYwXpzgAWPRYZXgj2zgssPD0X9Dc4J0aLJcDtS7UzF7MKD8Hn01pYf5CuOY/6A0r70hDgciUakTkuatH6P5cahhgXV3+qmLq+s148RRx89w798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zUu5scHa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zUu5scHa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CCB85C8F1CD;
	Mon,  6 Jul 2026 21:42:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E219601A2;
	Mon,  6 Jul 2026 21:42:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C26F611BC0782;
	Mon,  6 Jul 2026 23:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783374155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lcyjbuneSrjtjUpsvQ+AVff1hQcQoorIeT6bA1oTpM4=;
	b=zUu5scHaxhMDklLr3CxINlVQTnaAFhXbQ21quU6rtJtWwJjZMLF0b77K+XbBqLCtmcex6Q
	VQ5TChNEDvNtx9LDD/S+wWHDq68EJ0aylbcHdGO3dmnLhnngG+w+ny/PONA4gG+tvc+bmY
	JX9PBFATumzpwrmzTk6tos3X+RzbcP5u4yV6U1LFDmkgJMfFGBjV6zfdDmjL9FgfEDg903
	49vjje5awf5XclRaj+5Pk8vcMSfgQMGG+BC/dnCmOLgE5B7JAfGCkDnkUHmN8OS33XC5so
	W936SOISE1zyNxldBtl+5hyRtUVvldCWz5pEOb18pEvZ+GK0Al/Cyq5izKrSRQ==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 23:42:33 +0200
Message-Id: <DJRTDK0H5R1Q.32FU59ADLZD6E@bootlin.com>
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Paul Louvel"
 <paul.louvel@bootlin.com>, <sashiko-reviews@lists.linux.dev>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
 <20260706104010.A345B1F000E9@smtp.kernel.org>
 <DJRG1B5OZRQF.3TGMTYKZF4XL8@bootlin.com>
 <f598a05b-5d91-484d-a637-e092950a6f47@roeck-us.net>
 <DJRLRNRML483.3ZTW07FZBRFW@bootlin.com>
 <5e441e3a-27ce-4f46-abf4-fd6246727cb6@roeck-us.net>
In-Reply-To: <5e441e3a-27ce-4f46-abf4-fd6246727cb6@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 6:12 PM CEST, Guenter Roeck wrote:
> On 7/6/26 08:44, Paul Louvel wrote:
>> On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
>>> On 7/6/26 04:15, Paul Louvel wrote:
>>>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>>>> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
>>>>> - [High] Removing the manual hardware timeout refresh while still unc=
onditionally switching the hardware timer base from minutes to seconds dras=
tically truncates the remaining timeout if the BIOS originally configured i=
t in minutes, risking unexpected system reboots.
>>>>> --
>>>>>
>>>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>>>
>>>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>>>>>
>>>>> This patch updates the w83627hf watchdog driver to rely on the watchd=
og
>>>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during b=
oot.
>>>>> It replaces the previous behavior of manually issuing a single keepal=
ive
>>>>> during initialization.
>>>>>
>>>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w836=
27hf_wdt.c
>>>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>>>> [ ... ]
>>>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device =
*wdog, enum chips chip)
>>>>>>    			pr_warn("Stopping previously enabled watchdog until userland k=
icks in\n");
>>>>>>    			superio_outb(cr_wdt_timeout, 0);
>>>>>>    		} else {
>>>>>> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n=
",
>>>>>> -				wdog->timeout);
>>>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>>>> +			pr_info("Watchdog already running.\n");
>>>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>>>    		}
>>>>>>    	}
>>>>>>   =20
>>>>>
>>>>> [Severity: High]
>>>>> Does removing this explicit timeout reset create a risk of unexpected=
 reboots?
>>>>>
>>>>> If the BIOS originally configured the watchdog with a timeout in minu=
tes
>>>>> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_ti=
meout
>>>>> will hold the value 5.
>>>>
>>>> First of all, the driver does not support minute mode for now.
>>>
>>> The above feedback doesn't claim otherwise. The BIOS may still have con=
figured
>>> the timeout to 5 minutes.
>>>
>>>>
>>>>>
>>>>> Because this patch removes the explicit write of wdog->timeout (which=
 is
>>>>> typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
>>>>> Just after this block in w83627hf_init(), the driver unconditionally
>>>>> switches the timebase to seconds:
>>>>>
>>>>> w83627hf_init() {
>>>>>       ...
>>>>>       /* set second mode & disable keyboard turning off watchdog */
>>>>>       t =3D superio_inb(cr_wdt_control) & ~0x0C;
>>>>>       superio_outb(cr_wdt_control, t);
>>>>>       ...
>>>>> }
>>>>>
>>>>> This immediately shrinks the remaining timeout from 5 minutes to 5 se=
conds.
>>>>
>>>> True, but in those 5 seconds, the watchdog core will kick the watchdog
>>>> immediately. by calling start(), and thus refreshing the watchdog to 6=
0 seconds.
>>>
>>> ... unless below.
>>>
>>>>
>>>>>
>>>>> If the watchdog core's kworker is delayed, or if the system is config=
ured
>>=20
>>=20
>>=20
>>>>> not to ping the watchdog before user space takes over, could this unu=
sually
>>>>> short timeout cause the system to reboot unexpectedly during early bo=
ot?
>>>>
>>>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT_E=
NABLED is
>>>> enabled by default unless explicitly disabled when configuring the ker=
nel.
>>>>
>>>
>>> It is still an unexpected and undocumented change in behavior. Previous=
ly
>>> in that situation the watchdog timeout would happen much later and give
>>> user space time to start the watchdog daemon. This is no longer the cas=
e.
>>=20
>> Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabled, =
the
>> driver now doesn't refresh the watchdog, this is unexpected ? I was rely=
ing on
>> the fact that this entry is enabled by default.
>
> It can be disabled with a configuration option, and with a module paramet=
er.
>
>> In this case, should the driver refresh the watchdog itself, and set the
>> WDOG_HW_RUNNING bit (for the added feature that it does it repeatedly) ?
>> Or document the fact that the driver will not refresh the watchdog if
>> WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?
>>=20
>
> The difference is that the timeout used to be 60 seconds, or whatever the
> default driver timeout is set to. If the BIOS enables the hardware timeou=
t
> and sets it to <n> minutes, your patch changes that to <n> seconds. That
> is unexpected.

The default driver timeout is set to 60 seconds. I do not understand your p=
oint.
If the BIOS enables the hardware timeout and sets it to <n> minutes, withou=
t my
patch, the driver would still refresh the watchdog to <n> seconds (60 actua=
lly),
with "superio_outb(cr_wdt_timeout, wdog->timeout);". It forces second mode =
in
the control register anyway, and the driver has no way to know the previous=
ly
set timeout.
The only difference I see is that it does it immediately and does not rely =
on
the core to do it. It also do it only code.
Maybe I do not see something here.

>
> I see no reason to drop "superio_outb(cr_wdt_timeout, wdog->timeout);"
> in your patch. Keeping it would retain existing behavior. Changing that
> is unacceptable unless you provide a really good reason for it that I
> currently can not see.
>
> Thanks,
> Guenter
>
>
> =09

Thanks,
Paul.




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

