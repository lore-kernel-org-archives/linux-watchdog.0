Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384752ED4A
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913959; cv=none; b=A8g9l21n/N9oLq/Yg0Pyy50gO1YLE2fEqt4VtKPeH+kxtuOWj16MyqL7q6+Au6ZJxBtxkGHmZdHCW1A+n0X71PVVj2fKngLHYicXmbmNbe/TopF2fk4L9HLlSDNReUVlGtAfFBWg21QawPpXSrtItxXosGukvXRyZJPZaarRkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913959; c=relaxed/simple;
	bh=3iPhFZhvlCn8+yKy6y4wycQJQ70ekxfd/USphcr2lgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oLtibc/gvSlXetl8QikeuWqD21zfxcnxmgKj7gV9BuEFmpkxdLkakSSDnnx1mm7E1cLqR7WAWSj9e/MN8s2y5eKG5P21MFGJk2LW+jEr2NuSsPrffQFHcz+ro8sDWo2q4MagIloWWxnLKB5foi8rabWrVyKExKi+lqnFoOXGzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X/K++eQ6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/K++eQ6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E2B4C653F9
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:53:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDCA060362
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:52:35 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id D707D11D7189F; Tue, 13 Oct 2026 19:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IyWSJY+seVHMkOzaArjFmLZdH/eMiDWaUYF7kGG5sn4=;
	b=X/K++eQ6QvrQyvXtyxSEDVfVqQG60QF673Z+zV1iS1QgbntXN+vDc/DN18QMDzf/712zlx
	H4GxJgIRuVe4nbTY+x5g5i9IVxpFXiRNpJjDIprN5/HGzBR/xkw8DVUEMBRUATG3zireLf
	/hH065w+uJ+zN3Ygd1jKQHsy/141YWOePiVGBBxOBpfRAuuHttviUfkBUH+5NgOHayLR5y
	oJdRGpIaqOXTtELj2jtHC33UWVxjNFCs8ncykHQlTukkh6Ni1A8nNcaNAQcu0cwBUMPaLw
	rfqevYRiq1R0IDwn5zNgD1IwqOIvGhrB7o/mtt8OCFShVYr0WChn0KX0psQvyA==
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
Date: Fri, 09 Oct 2026 16:15:22 +0200
Message-Id: <DM0DCX5F9J1R.14Y6VAGZK7B5I@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/6] watchdog: w83627hf_wdt: Replace magic numbers
 with descriptive macros
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-1-8e27b518595e@bootlin.com> <asUEgunBdF6N9LCA@google.com>
In-Reply-To: <asUEgunBdF6N9LCA@google.com>
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: D707D11D7189F
X-Spamd-Result: default: False [0.39 / 30.00];
	BAYES_HAM(-1.01)[80.89%];
	DATE_IN_PAST(1.00)[99];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
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
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,galae.net:url,bootlin.com:email,bootlin.com:mid,bootlin.com:url,linux-watchdog.org:email,roeck-us.net:email];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]

On Tue Oct 6, 2026 at 4:24 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:49PM +0200, Paul Louvel wrote:
>> @@ -71,6 +72,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at =
boot time (default=3D0)");
>>   *	Kernel methods.
>>   */
>> =20
>> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
>> +#define SIO_REG_DEVID		0x20	/* Device ID (1 or 2 bytes) */
>> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */
>> +#define SIO_REG_CONF_ADDR0	0x2E
>> +#define SIO_REG_CONF_ADDR1	0x4E
>
> They are actually I/O ports rather than SIO registers.  SIO_PORT_2E and
> SIO_PORT_4E (or SIO_CONF_PORT_*) would be better names to distinguish the=
m
> from SIO_REG_*.
>
>> @@ -248,16 +258,17 @@ static int w83627hf_init(struct watchdog_device *w=
dog, enum chips chip)
>>  		}
>>  	}
>> =20
>> -	/* set second mode & disable keyboard turning off watchdog */
>> -	t =3D superio_inb(cr_wdt_control) & ~0x0C;
>> +	/* set second mode & disable keyboard reset turning off watchdog */
>
> This is confusing.  How about:
>
>     /* set second mode & disable watchdog reload on keyboard reset */
>
>> +	t =3D superio_inb(cr_wdt_control) &
>> +	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
>>  	superio_outb(cr_wdt_control, t);
>> =20
>>  	t =3D superio_inb(cr_wdt_csr);
>>  	if (t & WDT_CSR_STATUS)
>>  		wdog->bootstatus |=3D WDIOF_CARDRESET;
>> =20
>> -	/* reset status, disable keyboard & mouse turning off watchdog */
>> -	t &=3D ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>> +	/* reset status, disable keyboard & mouse interrupt turning off watchd=
og */
>
> Same here.  How about:
>
>     /* reset status & disable watchdog reload on keyboard/mouse interrupt=
s */
>

Maybe I can just drop these comments, they are not really useful.

>> @@ -513,11 +524,11 @@ static int __init wdt_init(void)
>>  	/* Apply system-specific quirks */
>>  	dmi_check_system(wdt_dmi_table);
>> =20
>> -	wdt_io =3D 0x2e;
>> -	chip =3D wdt_find(0x2e);
>> +	wdt_io =3D SIO_REG_CONF_ADDR0;
>> +	chip =3D wdt_find(SIO_REG_CONF_ADDR0);
>>  	if (chip < 0) {
>> -		wdt_io =3D 0x4e;
>> -		chip =3D wdt_find(0x4e);
>> +		wdt_io =3D SIO_REG_CONF_ADDR1;
>> +		chip =3D wdt_find(SIO_REG_CONF_ADDR1);
>
> I noticed the 'addr' parameter in wdt_find() is unused.  We could conside=
r
> removing it in a later cleanup patch.

This is already done in the next patch.

Thanks,

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Return-Path: <paul.louvel@bootlin.com>
Delivered-To: paul.louvel@bootlin.com
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id 4PsCNQH3yGpTfCkAtaWaaQ
	(envelope-from <paul.louvel@bootlin.com>)
	for <paul.louvel@bootlin.com>; Fri, 09 Oct 2026 16:15:29 +0200
X-Original-To: paul.louvel@bootlin.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B260D11D70873;
	Fri,  9 Oct 2026 16:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791555325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=euGuxyrd+swQUG5B4OqhIZbljcl8vVDBXPj2QHZGoHg=;
	b=y97SGxVgz48Flshv7NS7LaztmydxJna2+erRYadw/CoNCG//bHlCTP7h+J8uNd9cOMdFQX
	jgGWt6bxAQDX11wiSzet3bmqI2Xwhbv3FymcQqmtKxPR+4xKSgbFMtGMqNWgjQLD6cFwFX
	/e+Mgo/kBoQ6OLrnSOdgMJcNlvknXKw7TabPeW7I9FUKraWPxJGVWHVOdNrRetoNDS43f5
	5vl3qzJAgFJuSugq73+Czn0ekxx0jeAV3RWix/uuuacUAGmtqgFRXqncDVzqgcUVqz8Qv5
	OzQfrxpP3EKwCjl/9PiKCveBpNYy4srExoLcHVibOwnM2OJgoKHk9ZuWJeyZZg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:15:22 +0200
Message-Id: <DM0DCX5F9J1R.14Y6VAGZK7B5I@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/6] watchdog: w83627hf_wdt: Replace magic numbers
 with descriptive macros
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-1-8e27b518595e@bootlin.com> <asUEgunBdF6N9LCA@google.com>
In-Reply-To: <asUEgunBdF6N9LCA@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 6, 2026 at 4:24 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:49PM +0200, Paul Louvel wrote:
>> @@ -71,6 +72,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at =
boot time (default=3D0)");
>>   *	Kernel methods.
>>   */
>> =20
>> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
>> +#define SIO_REG_DEVID		0x20	/* Device ID (1 or 2 bytes) */
>> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */
>> +#define SIO_REG_CONF_ADDR0	0x2E
>> +#define SIO_REG_CONF_ADDR1	0x4E
>
> They are actually I/O ports rather than SIO registers.  SIO_PORT_2E and
> SIO_PORT_4E (or SIO_CONF_PORT_*) would be better names to distinguish the=
m
> from SIO_REG_*.
>
>> @@ -248,16 +258,17 @@ static int w83627hf_init(struct watchdog_device *w=
dog, enum chips chip)
>>  		}
>>  	}
>> =20
>> -	/* set second mode & disable keyboard turning off watchdog */
>> -	t =3D superio_inb(cr_wdt_control) & ~0x0C;
>> +	/* set second mode & disable keyboard reset turning off watchdog */
>
> This is confusing.  How about:
>
>     /* set second mode & disable watchdog reload on keyboard reset */
>
>> +	t =3D superio_inb(cr_wdt_control) &
>> +	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
>>  	superio_outb(cr_wdt_control, t);
>> =20
>>  	t =3D superio_inb(cr_wdt_csr);
>>  	if (t & WDT_CSR_STATUS)
>>  		wdog->bootstatus |=3D WDIOF_CARDRESET;
>> =20
>> -	/* reset status, disable keyboard & mouse turning off watchdog */
>> -	t &=3D ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>> +	/* reset status, disable keyboard & mouse interrupt turning off watchd=
og */
>
> Same here.  How about:
>
>     /* reset status & disable watchdog reload on keyboard/mouse interrupt=
s */
>

Maybe I can just drop these comments, they are not really useful.

>> @@ -513,11 +524,11 @@ static int __init wdt_init(void)
>>  	/* Apply system-specific quirks */
>>  	dmi_check_system(wdt_dmi_table);
>> =20
>> -	wdt_io =3D 0x2e;
>> -	chip =3D wdt_find(0x2e);
>> +	wdt_io =3D SIO_REG_CONF_ADDR0;
>> +	chip =3D wdt_find(SIO_REG_CONF_ADDR0);
>>  	if (chip < 0) {
>> -		wdt_io =3D 0x4e;
>> -		chip =3D wdt_find(0x4e);
>> +		wdt_io =3D SIO_REG_CONF_ADDR1;
>> +		chip =3D wdt_find(SIO_REG_CONF_ADDR1);
>
> I noticed the 'addr' parameter in wdt_find() is unused.  We could conside=
r
> removing it in a later cleanup patch.

This is already done in the next patch.

Thanks,

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

