Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5143F4BF
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352238; cv=none; b=dd3hiWGl399Uaw/Xp1CyFft1F6iSBOaSfdnfRH/A19JkXV+3Sl8SeQuuNY/H9Zzuu292Qtp2Cdj8eR5ddvz7Fb+iJRgmpuxI4vpLuvpg29Yx0dgIK4apIrBnQZfSzgLSOig6mdquUXejDuJ3+yXC5gFpyk0KPA4zs5Tcb0xr5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352238; c=relaxed/simple;
	bh=wbEjkHsquzQwNJEdKeLiD6qRngxKTd3yWcLvJNETGH4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RtMVsmzm533YpUf6zZL+qp+aFsWgLk0SFMLoIiI0w+UPhRRkMhy1D5jBF7TohPQQXvddhDFydBVspr+zi1VlNZKww1+ix8QMDMaZ1GxAzQ1CgnZ4R7MiyNVm+Fczi6OoQnRgmB/F3YmsRRsXPqcqwiL0gfOf0DftoI5DlpLdeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YjVmM1rP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YjVmM1rP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E1094E40CBD
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 15:37:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 029DE601A2;
	Mon,  6 Jul 2026 15:37:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B38DD11BBA6F6;
	Mon,  6 Jul 2026 17:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783352233; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IBgA9aGQ8NwdiIZTXzSOCKH5G/33iYWZplvWzkcvgC0=;
	b=YjVmM1rPwYJGmhlAv4RGBp1e4ZzKxS6C7cnDWaDgCfgING5ymiOhY6cdCX4pmtuxz82qH6
	GVFY+137jkDzh5CsL0i1PlJlgPOvf2RYspX9Bh8W1e0rnkFsRWFJGA7NxBTIvZ3gGlBh1y
	M90EmnT1ffayXNwh9ylxkZQFlEqliflTDZRuVNsnCdKyX/WXWCEGwlszXqgCfAd4JAhj25
	uhyQeKw52dVuR77OfGGbQpOyMb5ybT7D+pxS/hMoNnP046zmf/Rs3sZJZCDTfp1nV7TriS
	hBmW8fNj/ckJ9LrLharavGJRvD1mDwzeCIBI41/utKBpyDPMoA0EK5U+YhnweA==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 17:37:11 +0200
Message-Id: <DJRLLTA2T6NG.2WD00RJ8IECW9@bootlin.com>
Cc: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Paul Louvel"
 <paul.louvel@bootlin.com>, "Wim Van Sebroeck" <wim@linux-watchdog.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-1-fa5ad8d486bc@bootlin.com>
 <22a92049-0ff2-4ebf-b286-1e1e7ae9b3cb@roeck-us.net>
In-Reply-To: <22a92049-0ff2-4ebf-b286-1e1e7ae9b3cb@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 4:14 PM CEST, Guenter Roeck wrote:
> On 7/6/26 03:29, Paul Louvel wrote:
>> Add support for the hardware watchdog integrated in the Nuvoton NCT6126
>> Super I/O chip. This device is used on a number of x86 single-board
>> computers and is compatible with the w83627hf_wdt driver.
>>=20
>> Unlike most supported chips, the NCT6126 shares the same high-byte chip
>> ID as the NCT6116. Read the low byte of the chip ID as well to
>> distinguish between the two devices and identify the NCT6126 correctly.
>>=20
>
> Doesn't that (and the code below) mean that the driver already supports
> the chip, only it identifies it as NCT6116 instead of NCT6126 ?

Yes, because they have the same high-byte chip ID.

>
> This means that the commit message is misleading: It should say that
> the chip is already supported but misidentified, and that the added
> code helps to correctly identify the chip.

Indeed. My bad !

>
> Guenter
>
>> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
>> ---
>>   drivers/watchdog/w83627hf_wdt.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf=
_wdt.c
>> index bc33b63c5a5d..a6dfa9d01702 100644
>> --- a/drivers/watchdog/w83627hf_wdt.c
>> +++ b/drivers/watchdog/w83627hf_wdt.c
>> @@ -49,7 +49,7 @@ static int wdt_cfg_leave =3D 0xAA;/* key to lock confi=
guration space */
>>   enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627th=
f,
>>   	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_=
p,
>>   	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793=
,
>> -	     nct6795, nct6796, nct6102, nct6116 };
>> +	     nct6795, nct6796, nct6102, nct6116, nct6126 };
>>  =20
>>   static int timeout;			/* in seconds */
>>   module_param(timeout, int, 0);
>> @@ -94,7 +94,9 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at b=
oot time (default=3D0)");
>>   #define NCT6775_ID		0xb4
>>   #define NCT6776_ID		0xc3
>>   #define NCT6102_ID		0xc4
>> -#define NCT6116_ID		0xd2
>> +#define NCT6116_ID		0xd2	/* also NCT6126D */
>> +#define NCT6126_VER_A_LOW_ID	0x83	/* ... version A */
>> +#define NCT6126_VER_B_LOW_ID	0x84	/* ... version B */
>>   #define NCT6779_ID		0xc5
>>   #define NCT6791_ID		0xc8
>>   #define NCT6792_ID		0xc9
>> @@ -217,6 +219,7 @@ static int w83627hf_init(struct watchdog_device *wdo=
g, enum chips chip)
>>   	case nct6796:
>>   	case nct6102:
>>   	case nct6116:
>> +	case nct6126:
>>   		/*
>>   		 * These chips have a fixed WDTO# output pin (W83627UHG),
>>   		 * or support more than one WDTO# output pin.
>> @@ -428,7 +431,12 @@ static int wdt_find(int addr)
>>   		cr_wdt_csr =3D NCT6102D_WDT_CSR;
>>   		break;
>>   	case NCT6116_ID:
>> -		ret =3D nct6116;
>> +		val =3D superio_inb(0x21);
>> +		if (val =3D=3D NCT6126_VER_A_LOW_ID || val =3D=3D NCT6126_VER_B_LOW_I=
D)
>> +			ret =3D nct6126;
>> +		else
>> +			ret =3D nct6116;
>> +
>>   		cr_wdt_timeout =3D NCT6102D_WDT_TIMEOUT;
>>   		cr_wdt_control =3D NCT6102D_WDT_CONTROL;
>>   		cr_wdt_csr =3D NCT6102D_WDT_CSR;
>> @@ -499,6 +507,7 @@ static int __init wdt_init(void)
>>   		"NCT6796",
>>   		"NCT6102",
>>   		"NCT6116",
>> +		"NCT6126"
>>   	};
>>  =20
>>   	/* Apply system-specific quirks */
>>=20

Paul.




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

