Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74830272E56
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410439; cv=none; b=R5cgt9RRe1wllq9uwu/ECErXp1mdQmoRfHrwPUscuAOZKO1/7OXBiLW2IeHR9EOgGlf+/B8HxiuT95CrKeKJE8xpgpDeu5KQNqOTsQ15u8VS7FbhHnITulceGhZxn4SCZ72VcSv+rL6bvQqdYwmKUBdgPHly+wWSiIqNGbDdH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410439; c=relaxed/simple;
	bh=8BAw/gwUV4DPqTc1XlhdDBC6YMrGTmgu0NFo7yRcK+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Llb390Y/Y9cCRy4vKtTtNcUF5P4QKj9gbTXnAZFmxHkGseCfysA9J68otAhs88EtWBdKG0MhRvIoKO2T6Uwb1lVa4T0OyqRL3LAv3LiLoullIXNMHmikLwJX+yvTJEeOAdgQBZjKkIhammfDhOdO4YBRSnW6YtcQEtcF+6GEy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lxj6CTdE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lxj6CTdE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B66AD1A0EAD;
	Tue,  7 Jul 2026 07:47:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86587601A3;
	Tue,  7 Jul 2026 07:47:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5189011BC0E18;
	Tue,  7 Jul 2026 09:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783410433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RkkUyRvFUdSKgRxtxaFUaPgXRl4J0MzoQoofSpJyXgs=;
	b=Lxj6CTdEufZvjWVUr44XlOh7YyMNvpouWAR34YiJhQjBNE7cEC6rsjXr0dwBDPEO4p75T5
	hhRIqGwTlfG0gfYbWCeAUK2z49ugIk3Ey9KHGFF8Y7QA3p9x5kmk9uHddq3FlZh2MoZ73g
	p8MKgxYU1+B+u9wXXwmk9UcZm5bQkfixQ4gdaDIspLX6Vw3yYBUUYXMs4fwsbLc1iMfbqD
	41xf/9rte4fp0tEMkvnPQJxZsoM9mLuJSkvhT0Qei1FeGkbxbHfnyEStCyYF8p1GZjymVX
	X/E89GjCSWKtmeY9Gt8bosr8HR+a+yIEMOY0ZoCYjK4vZM62FGmeFifvtbtYYw==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 09:47:11 +0200
Message-Id: <DJS68HQS83G4.38Z406G5WD8NQ@bootlin.com>
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
In-Reply-To: <a20d8c37-0d46-489b-aa8c-af927a2c552c@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 11:48 PM CEST, Guenter Roeck wrote:
> On 7/6/26 14:42, Paul Louvel wrote:
>> On Mon Jul 6, 2026 at 6:12 PM CEST, Guenter Roeck wrote:
>>> On 7/6/26 08:44, Paul Louvel wrote:
>>>> On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
>>>>> On 7/6/26 04:15, Paul Louvel wrote:
>>>>>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>>>>>> Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
>>>>>>> - [High] Removing the manual hardware timeout refresh while still u=
nconditionally switching the hardware timer base from minutes to seconds dr=
astically truncates the remaining timeout if the BIOS originally configured=
 it in minutes, risking unexpected system reboots.
>>>>>>> --
>>>>>>>
>>>>>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>>>>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>>>>>
>>>>>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boo=
t
>>>>>>>
>>>>>>> This patch updates the w83627hf watchdog driver to rely on the watc=
hdog
>>>>>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during=
 boot.
>>>>>>> It replaces the previous behavior of manually issuing a single keep=
alive
>>>>>>> during initialization.
>>>>>>>
>>>>>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w8=
3627hf_wdt.c
>>>>>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>>>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>>>>>> [ ... ]
>>>>>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_devic=
e *wdog, enum chips chip)
>>>>>>>>     			pr_warn("Stopping previously enabled watchdog until userlan=
d kicks in\n");
>>>>>>>>     			superio_outb(cr_wdt_timeout, 0);
>>>>>>>>     		} else {
>>>>>>>> -			pr_info("Watchdog already running. Resetting timeout to %d sec=
\n",
>>>>>>>> -				wdog->timeout);
>>>>>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>>>>>> +			pr_info("Watchdog already running.\n");
>>>>>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>>>>>     		}
>>>>>>>>     	}
>>>>>>>>    =20
>>>>>>>
>>>>>>> [Severity: High]
>>>>>>> Does removing this explicit timeout reset create a risk of unexpect=
ed reboots?
>>>>>>>
>>>>>>> If the BIOS originally configured the watchdog with a timeout in mi=
nutes
>>>>>>> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_=
timeout
>>>>>>> will hold the value 5.
>>>>>>
>>>>>> First of all, the driver does not support minute mode for now.
>>>>>
>>>>> The above feedback doesn't claim otherwise. The BIOS may still have c=
onfigured
>>>>> the timeout to 5 minutes.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Because this patch removes the explicit write of wdog->timeout (whi=
ch is
>>>>>>> typically 60) to cr_wdt_timeout, the counter retains the raw value =
5.
>>>>>>> Just after this block in w83627hf_init(), the driver unconditionall=
y
>>>>>>> switches the timebase to seconds:
>>>>>>>
>>>>>>> w83627hf_init() {
>>>>>>>        ...
>>>>>>>        /* set second mode & disable keyboard turning off watchdog *=
/
>>>>>>>        t =3D superio_inb(cr_wdt_control) & ~0x0C;
>>>>>>>        superio_outb(cr_wdt_control, t);
>>>>>>>        ...
>>>>>>> }
>>>>>>>
>>>>>>> This immediately shrinks the remaining timeout from 5 minutes to 5 =
seconds.
>>>>>>
>>>>>> True, but in those 5 seconds, the watchdog core will kick the watchd=
og
>>>>>> immediately. by calling start(), and thus refreshing the watchdog to=
 60 seconds.
>>>>>
>>>>> ... unless below.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> If the watchdog core's kworker is delayed, or if the system is conf=
igured
>>>>
>>>>
>>>>
>>>>>>> not to ping the watchdog before user space takes over, could this u=
nusually
>>>>>>> short timeout cause the system to reboot unexpectedly during early =
boot?
>>>>>>
>>>>>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT=
_ENABLED is
>>>>>> enabled by default unless explicitly disabled when configuring the k=
ernel.
>>>>>>
>>>>>
>>>>> It is still an unexpected and undocumented change in behavior. Previo=
usly
>>>>> in that situation the watchdog timeout would happen much later and gi=
ve
>>>>> user space time to start the watchdog daemon. This is no longer the c=
ase.
>>>>
>>>> Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabled=
, the
>>>> driver now doesn't refresh the watchdog, this is unexpected ? I was re=
lying on
>>>> the fact that this entry is enabled by default.
>>>
>>> It can be disabled with a configuration option, and with a module param=
eter.
>>>
>>>> In this case, should the driver refresh the watchdog itself, and set t=
he
>>>> WDOG_HW_RUNNING bit (for the added feature that it does it repeatedly)=
 ?
>>>> Or document the fact that the driver will not refresh the watchdog if
>>>> WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?
>>>>
>>>
>>> The difference is that the timeout used to be 60 seconds, or whatever t=
he
>>> default driver timeout is set to. If the BIOS enables the hardware time=
out
>>> and sets it to <n> minutes, your patch changes that to <n> seconds. Tha=
t
>>> is unexpected.
>>=20
>> The default driver timeout is set to 60 seconds. I do not understand you=
r point.
>> If the BIOS enables the hardware timeout and sets it to <n> minutes, wit=
hout my
>> patch, the driver would still refresh the watchdog to <n> seconds (60 ac=
tually),
>> with "superio_outb(cr_wdt_timeout, wdog->timeout);". It forces second mo=
de in
>> the control register anyway, and the driver has no way to know the previ=
ously
>> set timeout.
>> The only difference I see is that it does it immediately and does not re=
ly on
>> the core to do it. It also do it only code.
>> Maybe I do not see something here.
>>=20
>
> Please provide the data path showing how the watchdog core sets the timeo=
ut
> to 60 seconds if WATCHDOG_HANDLE_BOOT_ENABLED is not enabled.

If WATCHDOG_HANDLE_BOOT_ENABLED is not enabled, then I understand the issue=
.
Would an additional check at compile time be sufficient ?

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wd=
t.c
index 27ef1cce3a14..c6d470be62a8 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -242,7 +242,11 @@ static int w83627hf_init(struct watchdog_device *wdog,=
 enum chips chip)
                        superio_outb(cr_wdt_timeout, 0);
                } else {
                        pr_info("Watchdog already running.\n");
+#ifdef CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
                        set_bit(WDOG_HW_RUNNING, &wdog->status);
+#else
+                       superio_outb(cr_wdt_timeout, wdog->timeout);
+#endif
                }
        }

>
> Thanks,
> Guenter
>

Thanks,
Paul.


--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

