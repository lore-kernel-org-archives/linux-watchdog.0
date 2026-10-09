Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628E49E130
	for <linux-watchdog@vger.kernel.org>; Fri,  9 Oct 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555162; cv=none; b=UcXeOTKIyEYoX588+hcI/tq7kH0KANhXWVMRTZ9AouhXZqYL1zaQ4g/xAcI1vv3umOoINMZpc17Z4qy7H3r+G7ZV96LnO+uiI2Qacyqg8s81+q3EEEWjxJMLO0UDBL09iHabSUZUiDbntbTwWN8UE8pvh6qa02bZMfGLy8L8eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555162; c=relaxed/simple;
	bh=Iefc8O/hCPlJLKpCcWKCN81Nsndcf53dvYYy4RmSGQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bYk4CxwBHWnAt1ylGztnhKRXsGijeJb7R8v7LlqlmFsQQ/sso/QcDSvyWFeuiiSx3ubPk3lm9edvGVLYojmnVyM695ZOTcPTXg+Zd4b88dN5w/nu5MtIF0e6o1L0mothlTAjkR+SvN8/dc6zf7xp95AfaQ0bUNIRpHRrvgqr9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YjntZ4HY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YjntZ4HY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5EFB14E4111D
	for <linux-watchdog@vger.kernel.org>; Fri,  9 Oct 2026 14:12:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B36760754;
	Fri,  9 Oct 2026 14:12:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7997B11D706C9;
	Fri,  9 Oct 2026 16:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791555153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+QkGdOb5hJYuLsoiL1Xhm+UhbtxAbiflSBnzitxyMXQ=;
	b=YjntZ4HYocHyqZjcGfpSMQRiRZrq6H0FHK1WY6QvEjjRk++vo9o9ooLpuobjge0n7GduG9
	/xwbGozcjS8v6BkEQVCmoKBH3Xavl5ID4XgBdqQzi0zHw61ayu85y/v5e9qL60RF9pz8LT
	b1QkBsDPbgXR1+aLcP048r6i6XXPbrIWsZi5svraQp1AyqfxpXDxaV+l1K0n2aAiAA+b1e
	atn4aRMxTtayMIolnXXyASTsc8z3PRFbjpQ2vRCNKPilWGf/ZVguWL7+IAQ1wQjPPx8SMb
	VqOIKdQrObdNEbIE0Drm5YFnZW3bOonjfit7pz1O5+5JHOGtg2qLB7VGiZBJgA==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:12:31 +0200
Message-Id: <DM0DAQJ2I8F2.2W84OCQRVD0RE@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/6] watchdog: w83627hf_wdt: Move register offsets
 into driver data
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-3-8e27b518595e@bootlin.com> <asUExcRccUEkam6l@google.com>
In-Reply-To: <asUExcRccUEkam6l@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 6, 2026 at 4:25 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:51PM +0200, Paul Louvel wrote:
>> @@ -491,6 +481,21 @@ static int wdt_probe(struct platform_device *pdev)
>>  	wdd->min_timeout =3D 1;
>>  	wdd->max_timeout =3D 255;
>> =20
>> +	data->reg.timeout =3D W83627HF_WDT_TIMEOUT;
>> +	data->reg.control =3D W83627HF_WDT_CONTROL;
>> +	data->reg.csr =3D W836X7HF_WDT_CSR;
>> +
>> +	if (chip =3D=3D nct6102 || chip =3D=3D nct6116 || chip =3D=3D nct6126)=
 {
>> +		data->reg.timeout =3D NCT6102D_WDT_TIMEOUT;
>> +		data->reg.control =3D NCT6102D_WDT_CONTROL;
>> +		data->reg.csr =3D NCT6102D_WDT_CSR;
>> +	}
>> +
>> +	if (chip =3D=3D w83697hf || chip =3D=3D w83697ug) {
>> +		data->reg.timeout =3D W83697HF_WDT_TIMEOUT;
>> +		data->reg.control =3D W83697HF_WDT_CONTROL;
>> +	}
>> +
>
> A switch statement would be cleaner here.
>
> Also, there are only 3 distinct register configurations: default, nct61xx=
,
> and w83697xx.  Rather than storing and copying mutable integer fields in
> every driver data instance, consider defining static const register table=
s
> and holding a pointer to them, e.g.:
>
>     struct w83627hf_regs {
> 	u8 timeout;
> 	u8 control;
> 	u8 csr;
>     };
>
>     static const struct w83627hf_regs w83627hf_default_regs =3D {
> 	.timeout =3D W83627HF_WDT_TIMEOUT,
> 	.control =3D W83627HF_WDT_CONTROL,
> 	.csr =3D W836X7HF_WDT_CSR,
>     };
>
>     ...
>
>     struct w83627hf_data {
> 	...
> 	const struct w83627hf_regs *regs;
>     };

Agreed.

Thanks,
--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

