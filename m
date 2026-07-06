Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC93FD13A
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336525; cv=none; b=Tg2/jL7KptCkfA6kDRF4ZbwE2tc0yGzqquF62cc9sDCBTAX9fAYpc9qQBFHm0hoPLAJvuxhTUiqD2+zGELPiBrTK6Sq83x9Ix1B+RRvAoctA4mgznEO3USIwBGoePMW68i0N7GmYCpnhMHxEkNUKojRVG8SAKfsw3ykT6HTAW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336525; c=relaxed/simple;
	bh=gRvz8XEQg+/kvEQusl5+vPE3gsFus2beEojihBJxJJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UD7RF8sZJ0+jkEwOUOuZyP8gcTgB+Wq7Q7LqCkUzIHEPPhg1q2sSb5A8yv0MAyskJC5su/pPM1opWEcLvSN8FhrdQGG+oJiSSrCmgEuljnfxH51p1fu/hg/CiW5yTm6lw863RsFzW90W+8Ql+PKnLbUN8ooiNRd9AQbUh4hACTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HM0OQ4Sx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HM0OQ4Sx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BAA494E40CAF;
	Mon,  6 Jul 2026 11:15:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81B39601A2;
	Mon,  6 Jul 2026 11:15:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A900611BBA0D0;
	Mon,  6 Jul 2026 13:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783336521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YPlBHx4NGFBjoGT2kx6AsavppKEmPm4qS+HcrAsLIgE=;
	b=HM0OQ4Sxd2W/yEImkNw3+2/4AD7JZLp6ge6Hggxko0fjVwCzw2PIMuLhmS6xJ5QzY6Prpy
	eALVJw5CzOrXZgB6yqQTeNjvSaX1rbFmdMNL+ZXfTlHr/JEAgbXhfLKhqXpizUxguGHQ8W
	k0XspBYETUT9GHj4Dbj8Wvy12SF/+aowvKDn0eQ/Sc4NcTJ92WMxNDFVDCYYON7cFEYCHk
	OQua8rk/BavG8E6FFjXqsnN735b3ZuR5GnAS/eqFmjLrbAWfNvBv99TEO7r7+idpKVGQuR
	fEMlDbVq4Zl8LHbsfuzP5Qaz7Np4gqATvAl6Y9cQwlgQvKCsRDeNweR1fN+G9g==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 13:15:19 +0200
Message-Id: <DJRG1B5OZRQF.3TGMTYKZF4XL8@bootlin.com>
Cc: <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
 <20260706104010.A345B1F000E9@smtp.kernel.org>
In-Reply-To: <20260706104010.A345B1F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Removing the manual hardware timeout refresh while still uncondi=
tionally switching the hardware timer base from minutes to seconds drastica=
lly truncates the remaining timeout if the BIOS originally configured it in=
 minutes, risking unexpected system reboots.
> --
>
> commit 0014048ec369e2a09098aa033aeb725449e2fd67
> Author: Paul Louvel <paul.louvel@bootlin.com>
>
> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>
> This patch updates the w83627hf watchdog driver to rely on the watchdog
> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during boot.
> It replaces the previous behavior of manually issuing a single keepalive
> during initialization.
>
>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf=
_wdt.c
>> --- a/drivers/watchdog/w83627hf_wdt.c
>> +++ b/drivers/watchdog/w83627hf_wdt.c
> [ ... ]
>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *wdo=
g, enum chips chip)
>>  			pr_warn("Stopping previously enabled watchdog until userland kicks i=
n\n");
>>  			superio_outb(cr_wdt_timeout, 0);
>>  		} else {
>> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
>> -				wdog->timeout);
>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>> +			pr_info("Watchdog already running.\n");
>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>  		}
>>  	}
>> =20
>
> [Severity: High]
> Does removing this explicit timeout reset create a risk of unexpected reb=
oots?
>
> If the BIOS originally configured the watchdog with a timeout in minutes
> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_timeou=
t
> will hold the value 5.

First of all, the driver does not support minute mode for now.

>
> Because this patch removes the explicit write of wdog->timeout (which is
> typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
> Just after this block in w83627hf_init(), the driver unconditionally
> switches the timebase to seconds:
>
> w83627hf_init() {
>     ...
>     /* set second mode & disable keyboard turning off watchdog */
>     t =3D superio_inb(cr_wdt_control) & ~0x0C;
>     superio_outb(cr_wdt_control, t);
>     ...
> }
>
> This immediately shrinks the remaining timeout from 5 minutes to 5 second=
s.

True, but in those 5 seconds, the watchdog core will kick the watchdog
immediately. by calling start(), and thus refreshing the watchdog to 60 sec=
onds.

>
> If the watchdog core's kworker is delayed, or if the system is configured
> not to ping the watchdog before user space takes over, could this unusual=
ly
> short timeout cause the system to reboot unexpectedly during early boot?

Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT_ENABLE=
D is
enabled by default unless explicitly disabled when configuring the kernel.




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

