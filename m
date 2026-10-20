Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483098;
	b=lGEupB8DycxZBF308DM+Kib70BRvm/TQtGz3gvUlNampYiQKiGC7B58SdI+qCPgroqFj
	 qT4J8V2ig1DGXgxYrz0qCTaf+dxdLm8bBRgPnSFW6uuYGQ8YVvUWoSCxgRp6kabhF2wFx
	 +uy/p78gopmqNfh8TWebvpPsOEhtaDtgHAr9ghiC5GLB+dv57JkJ0RgNEa70po0wzmM9C
	 NoLV7r4ZMP5RAI+SaOEK8BFOHYGaZbAUKm3LjS6G9aZ7AYJh2eNqUYw//zNjEpnaC8e+J
	 SBTwnAzI7b8Pl606BbP3u2i9b82DxEnxHLmG4KALzw8CgpfJPhmrqRgiUXY+m3SDZgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483098;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=x/N7tZYzK6xdleh7vPxCN7bmQeulM5jEjzJoYCwMLcU=;
	b=Q4vxvLgxcehoLYsVysZt4BIl8HzYlAGA7hGb9eXYbPwqfUB30cgVaZ7UjCslVf60Gx37
	 lJk6WWPvQWjRVZYfPF6P8k90aT34GL2hZGcNaPPPtJu/CmNNxHlt3bxG0XCketxEu1P79
	 sOgv9mooJpWO4oSLcezRFBJEz0fTXnRjbr575H7IdoYe+WIeZTyukAKt/IE3b4tcaWWjU
	 j8GLJf9aeLY0mOvmmfYLlGu18ZbL53WPYZF2vpMLVZPSZeEgk9XeX8k9Bg5JHiY5UPqQp
	 pMSxV2Ogu0+6SpHFlTwY7uSK3hqHCOroce/YZBxhg6PiQMg3/fJotvLKlL+t5JLcWSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PXlobn5Y;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B8606A319;
	Tue, 20 Oct 2026 07:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328B8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PXlobn5Y
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 793C81A1291;
	Tue, 20 Oct 2026 07:58:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45BD360393;
	Tue, 20 Oct 2026 07:58:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6B4A10328D55;
	Tue, 20 Oct 2026 09:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x/N7tZYzK6xdleh7vPxCN7bmQeulM5jEjzJoYCwMLcU=;
	b=PXlobn5YY91YrjYt4+HQWg66xLmCBHutXn0IOd/i+/MuQcz8tbl0e38i6224wew3wyUJka
	cUuC3agwcOiw1z70loEntLo7pgB9BQDEkLS9g/8nW0PuSqZJLO4Qf4PlQF8jZZXzWgyDzR
	J82fXErRqvSYWsaa4m37H6MMw0WcwDpORHoW9QP2rHsq3q2WQ22PwCePjm/01VTSs1NoTj
	TqjL2C+rv9mQs1pgUtX0z+acZK+w+FB4XdA8Hd9ujAaJXRJnBObOoaUxnNOhJ2NtNOO04j
	9LR9kcl18yoimbcR1K/MjfBVa/61isapOkdjJJRS7sw24AIFfBY1795KuUhElQ==
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 09:58:11 +0200
Message-Id: <DM9I84FGPQXP.15OTPO318B5N8@bootlin.com>
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 4/6] watchdog: w83627hf_wdt: Move register offsets
 into driver data
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com> <20261013-w83627hf_wdt-improvements-v4-4-b6f6b60a9566@bootlin.com> <atY15ssAjhTBz6kr@google.com>
In-Reply-To: <atY15ssAjhTBz6kr@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Oct 19, 2026 at 5:23 PM CEST, Tzung-Bi Shih wrote:
> On Tue, Oct 13, 2026 at 03:58:48PM +0200, Paul Louvel wrote:
>> @@ -42,9 +42,6 @@
>>  #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
>> =20
>>  static int wdt_io;
>> -static int cr_wdt_timeout;	/* WDT timeout register */
>> -static int cr_wdt_control;	/* WDT control register */
>> -static int cr_wdt_csr;		/* WDT control & status register */
> ...
>> +struct w83627hf_reg {
>> +	int control;
>> +	int timeout;
>> +	int csr;
>> +};
>> +
> ...
>> +static const struct w83627hf_reg w83627hf_default_regs =3D {
>> +	.control =3D W83627HF_WDT_CONTROL,
>> +	.timeout =3D W83627HF_WDT_TIMEOUT,
>> +	.csr =3D W836X7HF_WDT_CSR
>> +};
>> +
>> +static const struct w83627hf_reg w83627hf_nct61xx_regs =3D {
>> +	.timeout =3D NCT6102D_WDT_TIMEOUT,
>> +	.control =3D NCT6102D_WDT_CONTROL,
>> +	.csr =3D NCT6102D_WDT_CSR
>> +};
>> +
>> +static const struct w83627hf_reg w83627hf_w83697xx_regs =3D {
>> +	.timeout =3D W83697HF_WDT_TIMEOUT,
>> +	.control =3D W83697HF_WDT_CONTROL,
>> +	.csr =3D W836X7HF_WDT_CSR
>> +};
>
> Nit: the order is inconsistent.  It would be better to stick with
> the order timeout -> control -> csr.
>
>> @@ -489,6 +499,21 @@ static int wdt_probe(struct platform_device *pdev)
>>  	wdd->min_timeout =3D 1;
>>  	wdd->max_timeout =3D 255;
>> =20
>> +	switch (chip) {
>> +	case nct6102:
>> +	case nct6116:
>> +	case nct6126:
>> +		data->reg =3D &w83627hf_nct61xx_regs;
>> +		break;
>> +	case w83697hf:
>> +	case w83697ug:
>> +		data->reg =3D &w83627hf_w83697xx_regs;
>> +		break;
>> +	default:
>> +		data->reg =3D &w83627hf_default_regs;
>> +		break;
>> +	};
>          ^
> Please remove the extra ';'.

ACK.

Thanks,
--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

