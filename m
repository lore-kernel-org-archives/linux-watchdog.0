Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C452F299
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914150; cv=none; b=EFngb3isfBlk/eVA8/iq2B65EcL0327SAKM+npl2NTDpgUgwqJnu7da/gU/ke5NE+z+CDNHNVR9uyTlXlYxPHwzsdO7LY7ouKmVBU6hFqcxIisOiCRPF+MwiSJBZWbnqTEyTdqFG+DPq/qbKJMnnf+pXdPrKX4ewSJtYvhb0WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914150; c=relaxed/simple;
	bh=LBjNzDJBVNF/YTdSVSF9KmuSHoUMioYq63Mm6ENnOzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eh85PrywksCmP0C1HtMJYU8IuwahHLErwGFjZ8RJ2h8er+6Mp7MS/plY2hulSIPqKZ0u2kZgSeiOFyjPrXi4ybS3T1u99fNkxFXEAM7BrqfEkqaA5dHbymXSrWtJd9Ut4gT3s8QY+9OTB3wWp7Cg9s4o2VslFk/yJXDWpysqF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xLbLo+Lw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xLbLo+Lw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A703EC653FA
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:56:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E1E660362
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:55:47 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 70BDF11D718C2; Tue, 13 Oct 2026 19:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2d9JUQneoh1wD7kbtmfBojg6tgscCPMrtStnJHWns/Q=;
	b=xLbLo+LwwQHjLME7NvvXBGvjooK4nxoVs3Dx9FG1ghPYsg5oPtBs+HPD/Ns+XSiZUDuuWa
	tZzqLsC4tVRLPYhVWsNkeg2aX90ywhUBH/Sbha6+cwD30SWenHeHZYmDZWrKz2GjP12lmm
	M2tRavS1Nw9pbx0ncnUkXKoOn7gqEqHf5yT2RsY61Jgc5M3fqAdAjdBzs/NxK9gv9hbyhO
	jb5cI2UNhRQ3E9agWVbtjyebP2NW5F/N82Qo/4vR6DIQY4TkouGyFCA43w1i9f3m88rmez
	sDn/6nNWbMQOQjNjNxc42X2N5heOe2VGLiOF0gZOHBUoWN3cnUks/E8UJ3ktkA==
Authentication-Results: mail.galae.net;
	none
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:12:06 +0200
Message-Id: <DM0DAEXPSUES.3UOY3A0GN18C0@bootlin.com>
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com> <asUE3iFZBbl8fVcb@google.com>
In-Reply-To: <asUE3iFZBbl8fVcb@google.com>
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 70BDF11D718C2
X-Spamd-Result: default: False [1.40 / 30.00];
	DATE_IN_PAST(1.00)[99];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[24.15%];
	RCVD_COUNT_ZERO(0.00)[0];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	ARC_NA(0.00)[];
	BCC(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[roeck-us.net:email,localhost:rdns,localhost:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:url,galae.net:url,linux-watchdog.org:email];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]

On Tue Oct 6, 2026 at 4:25 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:52PM +0200, Paul Louvel wrote:
>>  static int wdt_probe(struct platform_device *pdev)
>>  {
>>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
>> +	const struct wdt_pdata *pdata =3D pdev->dev.platform_data;
>
> Use dev_get_platdata().
>
>> @@ -522,12 +533,16 @@ static int wdt_probe(struct platform_device *pdev)
>>   */
>>  static int __init wdt_use_alt_key(const struct dmi_system_id *d)
>>  {
>> -	wdt_cfg_enter =3D 0x88;
>> -	wdt_cfg_leave =3D 0xBB;
>> +	struct wdt_pdata *pdata =3D d->driver_data;
>> +
>> +	pdata->siocfg_enter =3D 0x88;
>> +	pdata->siocfg_leave =3D 0xBB;
>> =20
>>  	return 0;
>>  }
>> =20
>> +static struct wdt_pdata pdata;
>> +
>>  static const struct dmi_system_id wdt_dmi_table[] __initconst =3D {
>>  	{
>>  		.matches =3D {
>> @@ -537,6 +552,7 @@ static const struct dmi_system_id wdt_dmi_table[] __=
initconst =3D {
>>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>>  		},
>>  		.callback =3D wdt_use_alt_key,
>> +		.driver_data =3D &pdata,
>>  	},
>>  	{}
>>  };
>> @@ -581,27 +597,33 @@ static struct platform_device *wdt_pdev;
>> =20
>>  static int __init wdt_init(void)
>>  {
>> +	int sioaddr;
>>  	int ret;
>>  	int chip;
>> =20
>> +	pdata.siocfg_enter =3D 0x87;
>> +	pdata.siocfg_leave =3D 0xAA;
>> +
>>  	/* Apply system-specific quirks */
>>  	dmi_check_system(wdt_dmi_table);
>> =20
>> -	wdt_io =3D SIO_REG_CONF_ADDR0;
>> -	chip =3D wdt_find(SIO_REG_CONF_ADDR0);
>> +	sioaddr =3D SIO_REG_CONF_ADDR0;
>> +	chip =3D wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>>  	if (chip < 0) {
>> -		wdt_io =3D SIO_REG_CONF_ADDR1;
>> -		chip =3D wdt_find(SIO_REG_CONF_ADDR1);
>> +		sioaddr =3D SIO_REG_CONF_ADDR1;
>> +		chip =3D wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>>  		if (chip < 0)
>>  			return chip;
>>  	}
>> =20
>> +	pdata.sioaddr =3D sioaddr;
>> +
>
> `pdata` is still global.  Given that there are only a few settings, maybe
> we can use the same method I proposed in [3/6] patch, and use
> `dmi_first_match()` to avoid the global variable.  E.g.:
>
>     struct w83627hf_sio_pdata {
>         u16 sioaddr;
>         u8 siocfg_enter;
>         u8 siocfg_leave;
>     };
>
>     static const struct w83627hf_sio_pdata default_pdata =3D {
>         .siocfg_enter =3D 0x87,
>         .siocfg_leave =3D 0xaa,
>     };
>
>     static const struct w83627hf_sio_pdata alt_pdata =3D {
>         .siocfg_enter =3D 0x88,
>         .siocfg_leave =3D 0xbb,
>     };
>
>     static const struct dmi_system_id wdt_dmi_table[] __initconst =3D {
>         {
>             .matches =3D {
>                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "INVENTEC"),
>                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Symphony"),
>                 DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>             },
>             .driver_data =3D (void *)&alt_pdata,
>         },
>         {}
>     };
>
> Then, in `wdt_init()`, it can define a local `pdata` and initialize it
> based on the DMI match:
>
>     const struct dmi_system_id *match;
>     struct w83627hf_sio_pdata pdata;
>
>     match =3D dmi_first_match(wdt_dmi_table);
>     if (match)
>         pdata =3D *(const struct w83627hf_sio_pdata *)match->driver_data;
>     else
>         pdata =3D default_pdata;
>
>     pdata.sioaddr =3D SIO_REG_CONF_ADDR0;
>     chip =3D wdt_find(pdata.sioaddr, pdata.siocfg_enter, pdata.siocfg_lea=
ve);

Yes, pdata was still global, but the scope is limited to the init function.
Your proposition looks better tho.



--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Return-Path: <paul.louvel@bootlin.com>
Delivered-To: paul.louvel@bootlin.com
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id oH2THD72yGpQfCkAtaWaaQ
	(envelope-from <paul.louvel@bootlin.com>)
	for <paul.louvel@bootlin.com>; Fri, 09 Oct 2026 16:12:14 +0200
X-Original-To: paul.louvel@bootlin.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C92A11D70841;
	Fri,  9 Oct 2026 16:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791555130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cdZYN8ntqvipg3FYRWOYxSDKsm2OOZGI6Qs5B7jTHyg=;
	b=OaV7x4LGSW6b2FnAKVdiks6LA9di0h6IEKNQVLYWnT0py3eLzLeIzaoC7AoA+fTFRaL/Xj
	4wWvkXky+Z5f3v295TFVfUFFM5B/QGXhLcwWFHT8e0sttThRh2jox1FXUrYz+mOUvGMzWQ
	IX9sSHcM08okc7CvmcRSP2LL+XSQsZIKXadnkCyBZZUYC6iglTZv1FT+GBnFhKSdWsr8mN
	Wy/XjjpTmUzHioiFShyML8FQ+hrgMjp2c+E8hkxv06qlu/+kQlpVsFzygTVU32jzs4rnho
	k1o0ohkJw8L3ZnpPckzPPlafRA5hkmeK/MkTpEMlqA8aaP+7lDQHVx9tgGkRiw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:12:06 +0200
Message-Id: <DM0DAEXPSUES.3UOY3A0GN18C0@bootlin.com>
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com> <asUE3iFZBbl8fVcb@google.com>
In-Reply-To: <asUE3iFZBbl8fVcb@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 6, 2026 at 4:25 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:52PM +0200, Paul Louvel wrote:
>>  static int wdt_probe(struct platform_device *pdev)
>>  {
>>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
>> +	const struct wdt_pdata *pdata =3D pdev->dev.platform_data;
>
> Use dev_get_platdata().
>
>> @@ -522,12 +533,16 @@ static int wdt_probe(struct platform_device *pdev)
>>   */
>>  static int __init wdt_use_alt_key(const struct dmi_system_id *d)
>>  {
>> -	wdt_cfg_enter =3D 0x88;
>> -	wdt_cfg_leave =3D 0xBB;
>> +	struct wdt_pdata *pdata =3D d->driver_data;
>> +
>> +	pdata->siocfg_enter =3D 0x88;
>> +	pdata->siocfg_leave =3D 0xBB;
>> =20
>>  	return 0;
>>  }
>> =20
>> +static struct wdt_pdata pdata;
>> +
>>  static const struct dmi_system_id wdt_dmi_table[] __initconst =3D {
>>  	{
>>  		.matches =3D {
>> @@ -537,6 +552,7 @@ static const struct dmi_system_id wdt_dmi_table[] __=
initconst =3D {
>>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>>  		},
>>  		.callback =3D wdt_use_alt_key,
>> +		.driver_data =3D &pdata,
>>  	},
>>  	{}
>>  };
>> @@ -581,27 +597,33 @@ static struct platform_device *wdt_pdev;
>> =20
>>  static int __init wdt_init(void)
>>  {
>> +	int sioaddr;
>>  	int ret;
>>  	int chip;
>> =20
>> +	pdata.siocfg_enter =3D 0x87;
>> +	pdata.siocfg_leave =3D 0xAA;
>> +
>>  	/* Apply system-specific quirks */
>>  	dmi_check_system(wdt_dmi_table);
>> =20
>> -	wdt_io =3D SIO_REG_CONF_ADDR0;
>> -	chip =3D wdt_find(SIO_REG_CONF_ADDR0);
>> +	sioaddr =3D SIO_REG_CONF_ADDR0;
>> +	chip =3D wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>>  	if (chip < 0) {
>> -		wdt_io =3D SIO_REG_CONF_ADDR1;
>> -		chip =3D wdt_find(SIO_REG_CONF_ADDR1);
>> +		sioaddr =3D SIO_REG_CONF_ADDR1;
>> +		chip =3D wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>>  		if (chip < 0)
>>  			return chip;
>>  	}
>> =20
>> +	pdata.sioaddr =3D sioaddr;
>> +
>
> `pdata` is still global.  Given that there are only a few settings, maybe
> we can use the same method I proposed in [3/6] patch, and use
> `dmi_first_match()` to avoid the global variable.  E.g.:
>
>     struct w83627hf_sio_pdata {
>         u16 sioaddr;
>         u8 siocfg_enter;
>         u8 siocfg_leave;
>     };
>
>     static const struct w83627hf_sio_pdata default_pdata =3D {
>         .siocfg_enter =3D 0x87,
>         .siocfg_leave =3D 0xaa,
>     };
>
>     static const struct w83627hf_sio_pdata alt_pdata =3D {
>         .siocfg_enter =3D 0x88,
>         .siocfg_leave =3D 0xbb,
>     };
>
>     static const struct dmi_system_id wdt_dmi_table[] __initconst =3D {
>         {
>             .matches =3D {
>                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "INVENTEC"),
>                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Symphony"),
>                 DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>             },
>             .driver_data =3D (void *)&alt_pdata,
>         },
>         {}
>     };
>
> Then, in `wdt_init()`, it can define a local `pdata` and initialize it
> based on the DMI match:
>
>     const struct dmi_system_id *match;
>     struct w83627hf_sio_pdata pdata;
>
>     match =3D dmi_first_match(wdt_dmi_table);
>     if (match)
>         pdata =3D *(const struct w83627hf_sio_pdata *)match->driver_data;
>     else
>         pdata =3D default_pdata;
>
>     pdata.sioaddr =3D SIO_REG_CONF_ADDR0;
>     chip =3D wdt_find(pdata.sioaddr, pdata.siocfg_enter, pdata.siocfg_lea=
ve);

Yes, pdata was still global, but the scope is limited to the init function.
Your proposition looks better tho.



--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

