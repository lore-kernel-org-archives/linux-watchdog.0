Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086E3A5E89
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352697; cv=none; b=J37RIKvpJbdDu1Plu1Cgw04M6GS0bX4eb5Qst/A0/tlVn/6T620JB0EKUBW9JZH/VKiMb5ubYLnYQn3dCE/xsOSVE9aW/UdjbgP3Jrx/lNd6ouBycYZY5R2i+gMHiv3dpJlaHID5AIBZ9dbieYeI4UNCfitUGZLhzajQoXUk98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352697; c=relaxed/simple;
	bh=HQH2om/aqDi97b6ridrVYpd0RFWgqcr+zx4N5yX+nmo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KUslYV/+ss+Z6RzZ7CDbYLp975e9BGUJHvKU+SrG+OxhxEmlxsq+7tkjz5O6zcnRcb49mQux6QgBj5dZUCqi+cr/KuS2UfojdJGf8r96NZ29DiYSMbMIDdd1pzpKw8bN9R3Lkhbf0qVh8W8FWKKobu1X9mU0yR+hb2k7JzO8+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FHCWxskk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FHCWxskk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6B5411A0E8E
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 15:44:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28DCA601A2;
	Mon,  6 Jul 2026 15:44:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C11CF11BBA532;
	Mon,  6 Jul 2026 17:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783352691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UkuVV5M4R8ZU39303kHo9e67+dxuyLskOMETBK3C3dw=;
	b=FHCWxskkpZo1ogVAMK9iHMiyJeLHfs7kjSuEhpdZhOGEP96SwmA122OoPaqilyj/wpHjwO
	4p3go2bBHnb0VN6o00noQvCvHSkpg7qQIHTIj/h3zOO0ytAHLkJPn12Bk741rABJxi6JRr
	rolkBL3rAjZ2Qj8UdBf0N/pDWr6JF/Ku1PXPRspodvS2k9wSi/TNEvZP4WOV94b+1mOgms
	UxFNgHagxtIXCZnWkAGVPUGRB2HIF8VI66ZWuOuQ0POzq5aR5TmjL8BZat4bZ2JtdTAq+g
	/1R0BDQG+W2YlJ7pNX+yn1lC0WkzwB4RHAfnxnhL5oUuhZTlrsRpiV5gScjM/A==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 17:44:50 +0200
Message-Id: <DJRLRNRML483.3ZTW07FZBRFW@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Paul Louvel"
 <paul.louvel@bootlin.com>, <sashiko-reviews@lists.linux.dev>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
From: "Paul Louvel" <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
 <20260706104010.A345B1F000E9@smtp.kernel.org>
 <DJRG1B5OZRQF.3TGMTYKZF4XL8@bootlin.com>
 <f598a05b-5d91-484d-a637-e092950a6f47@roeck-us.net>
In-Reply-To: <f598a05b-5d91-484d-a637-e092950a6f47@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
> On 7/6/26 04:15, Paul Louvel wrote:
>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
>>> - [High] Removing the manual hardware timeout refresh while still uncon=
ditionally switching the hardware timer base from minutes to seconds drasti=
cally truncates the remaining timeout if the BIOS originally configured it =
in minutes, risking unexpected system reboots.
>>> --
>>>
>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>
>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>>>
>>> This patch updates the w83627hf watchdog driver to rely on the watchdog
>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during boo=
t.
>>> It replaces the previous behavior of manually issuing a single keepaliv=
e
>>> during initialization.
>>>
>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627=
hf_wdt.c
>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>> [ ... ]
>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *w=
dog, enum chips chip)
>>>>   			pr_warn("Stopping previously enabled watchdog until userland kick=
s in\n");
>>>>   			superio_outb(cr_wdt_timeout, 0);
>>>>   		} else {
>>>> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
>>>> -				wdog->timeout);
>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>> +			pr_info("Watchdog already running.\n");
>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>   		}
>>>>   	}
>>>>  =20
>>>
>>> [Severity: High]
>>> Does removing this explicit timeout reset create a risk of unexpected r=
eboots?
>>>
>>> If the BIOS originally configured the watchdog with a timeout in minute=
s
>>> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_time=
out
>>> will hold the value 5.
>>=20
>> First of all, the driver does not support minute mode for now.
>
> The above feedback doesn't claim otherwise. The BIOS may still have confi=
gured
> the timeout to 5 minutes.
>
>>=20
>>>
>>> Because this patch removes the explicit write of wdog->timeout (which i=
s
>>> typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
>>> Just after this block in w83627hf_init(), the driver unconditionally
>>> switches the timebase to seconds:
>>>
>>> w83627hf_init() {
>>>      ...
>>>      /* set second mode & disable keyboard turning off watchdog */
>>>      t =3D superio_inb(cr_wdt_control) & ~0x0C;
>>>      superio_outb(cr_wdt_control, t);
>>>      ...
>>> }
>>>
>>> This immediately shrinks the remaining timeout from 5 minutes to 5 seco=
nds.
>>=20
>> True, but in those 5 seconds, the watchdog core will kick the watchdog
>> immediately. by calling start(), and thus refreshing the watchdog to 60 =
seconds.
>
> ... unless below.
>
>>=20
>>>
>>> If the watchdog core's kworker is delayed, or if the system is configur=
ed



>>> not to ping the watchdog before user space takes over, could this unusu=
ally
>>> short timeout cause the system to reboot unexpectedly during early boot=
?
>>=20
>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT_ENA=
BLED is
>> enabled by default unless explicitly disabled when configuring the kerne=
l.
>>=20
>
> It is still an unexpected and undocumented change in behavior. Previously
> in that situation the watchdog timeout would happen much later and give
> user space time to start the watchdog daemon. This is no longer the case.

Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabled, the
driver now doesn't refresh the watchdog, this is unexpected ? I was relying=
 on
the fact that this entry is enabled by default.
In this case, should the driver refresh the watchdog itself, and set the
WDOG_HW_RUNNING bit (for the added feature that it does it repeatedly) ?
Or document the fact that the driver will not refresh the watchdog if
WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?

>
> Guenter

Thanks,
Paul.



--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

