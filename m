Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779887;
	b=uhDsVKLzMbeRXqYlkNZB68dPw47oBg9AS2OlKLxswUhflaH8Q3fXr0uf9GKFhH96KdPq
	 U/Vlif6RYyaQG3PIBVWrErYQ+2khNUv4zTEGPblZ/okNhF0g3npP91B/wmgeNNsvzwwfX
	 PD77RG3rIXUQ0a9CbGPFqzwYS2AaNU3rtPjMHcJIQWKhr05GeEc8pXffDug4Got6/qWT6
	 VsnqYKvH+w2DM4d0jHxzelSeX2r+DV0XYeSORNHl169//IKIbrFSb2MvKynetsKMqB7By
	 hJmSDmdG4WwFBk6/B7tJZ5FQehtvC1U1s6ibh5LKyBburPXig0fYyo4SeZ/es7woY2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zC0jEKFFiQwJqwDfM8bkisZ+K2Ui8bcK+/e64jpjSfk=;
	b=L+iQTbhWLzzaFbGGRAcnsUiEhP4eICIBG/+mIcdKGUaLPbx1OqP6UK/z3efYMm9d/G9D
	 mdJtu6ePlzVcrPvkZzIY2paDAek4D+af/IvDrPfkBcKt8poJnjAAcTgVaRXDprmTdKsQV
	 YmJ8+n6DUbM4pZuDdwZopiov6YqjCtTNjMItHcJgyvY8sURVw+pGMEPWQKrU1hc+S9YtW
	 SyCcCqjkNa0Tpvd20doLRpGg+GMjAzS1Eisjbbwh6rwfybSMQampLGNCXRG7dot0ePdKT
	 VtSUDIcg6+pYwbpOwWliEF/GhtOLMluQqmGKPqd3zmV1//I2qOYHrNNorj/hJ4wxwnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0DgfEqj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C0606A31F
	for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 21:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 223C0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0DgfEqj
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4743308a12.1
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 13:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779885; cv=none;
        d=google.com; s=arc-20260327;
        b=YVVFQms1VybYWCUdkjwo6LF9CwPAvIUYK9Zrj9kZec5TfQY5rMB99YbHaLv3frjGoj
         9g6oEfCJjRMlY+eKujo4aBgDu2y6nx9i0IDeYi0oOVDiqDAj2Bw33WG5lySGGx4GSTh4
         9ezBa9F4pTzNqQyJRuwFmMVdSu/7qVjrgGrJLREd5CnILkx9vqhSphmjYKIKwInVJ3IK
         6/vK6FU5aC1DiXtwOL0SCYGvEzTHz4x+3kyBKLwqwlHXa7MuxTe0t+D4SR/2EyrI4Tia
         W9D6cpbEyoks6ixMbkCsyIJ6IUXz0Jyn2sZjx2gusIvWHdHnwP6wRPAYeb5HbIgPoMau
         C/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zC0jEKFFiQwJqwDfM8bkisZ+K2Ui8bcK+/e64jpjSfk=;
        fh=L75cXEmr56GSooAZ6zbM2hza+O026VNN00ownku5m04=;
        b=dOJgVpDxfP6pZ9891wdDnUuqI9NHIXgrpmZuIw0HJ1vSh9Xvz9AHRh7K3bO0Jv8M1B
         BL2X84TBVaKhXj0V06MhqjdgE5IHIklO7gcOGmgr/qLTaKqhcU2AyfCgam7yBNnE/KeX
         BYcWxFzd4fxFKvo5UUPOnsSUgW7Y0ZlIiGwp8KShHKm1AZ+LsMi6HSGD7ZxGHfB6+NBW
         R2/18KA2omB3vcrsI8ygsHw2oE6YYo2ttfEEQl8qDVQg/bYcxDb8xBqqDipBFqETj8og
         XPUaRFy635CVBNcD7MGXX6SWiUZ9lrqM2DwcH03UbMFSgH8ETslGhDQOefozIowri/PU
         x+xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794779885; x=1795384685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zC0jEKFFiQwJqwDfM8bkisZ+K2Ui8bcK+/e64jpjSfk=;
        b=g0DgfEqjzMWXsftR44d0Dy0SYVoCd3xi8wR53WRE9xCsmnNa/C6jG4xVvyvuVJh8oo
         rcsHhhbRuZeOCqYpanhOnj9it6mtQo2GkZB4sNAC50q3+0KpIucc7z9OTSCspoG+qM9F
         LO+BNUvgFSlXHhgUBfufMFIgLCaqp8yGPtdIf29nKt5vgsgZBNg6L95A5RCo+VPOrhD4
         Ku774WyX9m63aOIv6RvPjPketj+JGD6VJ7vG/MmkJABEpZMv4O0EDiHQtawBKzMIPT+G
         i5sCfye4mrzHTC0xQ1zVpIjn9F/bCIHWkvcOxgha1pv1SPIk7uf/YlZ8WiPxxVCswJLK
         CwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779885; x=1795384685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zC0jEKFFiQwJqwDfM8bkisZ+K2Ui8bcK+/e64jpjSfk=;
        b=BB1GGoeCW+UbpYzxYfZf2CriioMEz++Wx8x/LfTPMUzTE7KQaDcZ54e/o+cMY+uHIk
         Ljy7dQTPum1ANwygZJNHaeCRTLtn/za3qudt1oyL5mVL7CnVZvp8LlGH3kBfsxs7sWT7
         3wq0VyjHXzYZ+UdJmIRSGDfAEmHkRB8l41ai0Jv0f76UUA/k3G/McZdBWXfsdtCA+Cxg
         wk8lZCANmHVDYAJEBZbrMfZJAx+IykyvtXVG/Xl4VbKAaq6LyykJYR2DIBqC5FcIQJFy
         2P8f1pfeTq7wjh8lElMefjUssZjJ1CbyXvKQaIvHFRv6hNQJPTRHzR5h7NXOvUUzYXnk
         5XbA==
X-Forwarded-Encrypted: i=1; AL+hErHs7YRCr5aK/H4HfuwBPHG9Bw1ntNoIqcyVjU9vURmuFdq/uno185LiUrsfdCuceiyjYmeJKWrWLNAftQH+5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pGFbTdA8pYWRku6PsCzLKB2dbUKtW1LlJfy21okyAMp8S9Wh2
	Zng09davZB1Ax1giNqs7qEpBp3ZjTNGWbP9n/5wMewdE2ll0Fv9F928lnYu2ykyYlutxuS0eBvS
	mlMYKHNZC0hLZs6yBakyYBogX1euxCQY=
X-Gm-Gg: AYBFou3lfPA7LbtvrK+OMSI2jgdPiayp3mEa5gcJHvhMs5yDIm2LH/8kUZTJN5hcfEX
	5DmrCcxSMtrRbWmqya7KpT3Lf304CQCvFdMhSdmrs2heXxQ0Fn8+aD46NMwFWg3Gy80Xi6ShtCa
	cRyi66UA8pmpbW07UE918EApKJ1tv0PQiuq51Cxl0OCct7cARIrQTfP07FsFOaZlSL5mimAcw5K
	vMZjJfwjNRCpYMrLyYFPVLE3Davkz5bEBhGAlfcSWQ+stMN0bpaFm7pSnJJSME+l9tXLDFeqGAb
	6UzW8zW2iisOlQ4F+kf4rZU9oEsxNm506a3J0dPE7Zr1lcpFTZauaVQxx3rlKZdRQs9Zz60lf73
	m3ccAUW7pGfQ0Sxr0nTt1Hqu1oCzd3k65sOJH86KjOqLPBnFGZP0IeR6pHRYenAFe
X-Received: by 2002:a17:907:60d3:b0:c40:b59:f with SMTP id a640c23a62f3a-c5096645662mr739948166b.47.1794779885499;
 Sun, 15 Nov 2026 13:58:05 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115205408.99849-1-vitorhg20080@gmail.com> <e0b7871e-5dae-438a-bde1-327fe450dc8d@roeck-us.net>
In-Reply-To: <e0b7871e-5dae-438a-bde1-327fe450dc8d@roeck-us.net>
From: =?UTF-8?B?VsOtdG9yIFNpbHZh?= <vitorhg20080@gmail.com>
Date: Sun, 15 Nov 2026 21:57:54 +0000
X-Gm-Features: AclHuK_I07mNuDxkTMjytS5O01bXoYI6oBnxDcDLkarMnqDVv93PfhL_twBznYk
Message-ID: <CAOhXrFe3PQy9j1cJQni8+JFSx79ByhMdP-CAgbOBrpp7Nj2-tA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: intel_oc_wdt: Add INTC109C ACPI ID
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Diogo Ivo <diogo.ivo@siemens.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are absolutely right. It made no sense to not test it.
I ran an expiry test and it worked:

I have set up a 60 seconds timeout, kept the watchdog
device open without sending keepalives.
It forced the reset right after it timed out.

Thanks for the quick reply,
V=C3=ADtor

Guenter Roeck <linux@roeck-us.net> escreveu (domingo, 15/11/2026 =C3=A0(s) =
21:29):
>
> On 11/15/26 12:54, V=C3=ADtor Hugo Silva wrote:
> > The Lenovo laptops with an Intel Core 7 240H (Raptor Lake)
> > exposes its OC watchdog as 'INTC109C', leaving the device
> > unbound, because this ID is not present from the driver's
> > ACPI intel_oc_wdt_match table.
> >
> > The firmware selects INTC109C or the already supported
> > INTC1099 from the same CWDT object's _HID method,
> > depending on the processor signature. Both paths share a
> > four-byte I/O resource at PMBS + 0x54.
> >
> > Add INTC109C to the match table to use the existing implementation.
> >
> > I have tested as a module on Fedora kernel 7.3.3-300.fc45.x86_64.
> > I did verify device binding, timeout configuration, start,
> > keepalive, explicit stop and magic close. Register reads
> > confirmed the enable and timeout fields. Expiry-triggered
> > reset was not tested.
> >
>
> Why not ? That means you don't know if the code actually works.
>
> Thanks,
> Guenter
>
> > AI assistance was used for development of the test harness
> > and 'peer-review' the patch.
> >
> > Signed-off-by: V=C3=ADtor Hugo Silva <vitorhg20080@gmail.com>
> > ---
> >   drivers/watchdog/intel_oc_wdt.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_o=
c_wdt.c
> > index 0b012aeb1..a78fe1e5f 100644
> > --- a/drivers/watchdog/intel_oc_wdt.c
> > +++ b/drivers/watchdog/intel_oc_wdt.c
> > @@ -215,6 +215,7 @@ static int intel_oc_wdt_probe(struct platform_devic=
e *pdev)
> >   static const struct acpi_device_id intel_oc_wdt_match[] =3D {
> >       { "INT3F0D" },
> >       { "INTC1099" },
> > +     { "INTC109C" },
> >       { },
> >   };
> >   MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
> >
> > base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
>
