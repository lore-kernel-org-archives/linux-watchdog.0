Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823240;
	b=yeoPW6aMzV50zZPi/hi4K92BM+by0YJ04udjIKTulydPWTEqb+D/X0ISobOQxu7hslFp
	 mwHM+0/LAx7H1JXuBzQFF8kBd6qN9yGQ6ygCgXK3zKNi+TF7JHQM/F7ducW2nslLduVKE
	 mlbwI9ml6/6bw43yQOS7vTKVbVVWTutJ6Qfsanl+tU/rB3XLFTMtFM9GucVnLC7K2m4MJ
	 ubrWlWRLxrGpS+jtd09rUYZCQOeB2N4a7+z8BawWE+x2iGkYnc361Pf5VQcbvU0e5sEZP
	 vTRtPpE9/yQRTMwSWW78ZlnmOB65b6VJpQV6COvwj7qY03qkZgPGkCI9mQrgOwpsONg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zO1mthCUeUI7sxjtpBRWuN6hGRiK+7MjuWiOZt6OBig=;
	b=y7pnkbJvJT9iSCaFqwIeJbqmPXqzIWtXq9TzXOSfxIf8kul9/oi7gSLRvZCGXwfCz3YT
	 UBP6iCR3lsY1XbayntDEfSvvF/wLmvSCSUCWCsb12olUOfoHU8W4xHdguqwbrOtdZrLp5
	 o490TgOAOsQeJVEwtfZYmG7eqQwbkiI8Gs4FcXA+w8ENXkbAYWpEdS8gbzCG5wj4f7hLK
	 N6eQ9JdNMYQKqEweg+tQK9QmW/FHNaGHSvuAnkGhvsD8BxGDnvP70BRRbt5s+D18TwgtP
	 gbiHlgoFPc8g6fC5IS84Dijwi9GStT5Q7GyfhPLfquBxafCChbHbJUIUZBJzsScnEJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVZT4EIU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24F606A323
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 10:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD24F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVZT4EIU
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so4571432a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 02:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794823238; cv=none;
        d=google.com; s=arc-20260327;
        b=jjtTX0t6cqts2xTB1Zykerxi27aq4MXt8JbDckt8qqm2W3aP2uWw102PrntU4NXpHG
         xyBpLYXxQVVpb9ENGWu0XtoGOSkKHOBogpXmFao29edGa5QQafEB3ralOA4eWV7+dPTd
         8pc+Mk8EfDZJ3Jte4+nhfuiRzPUPlYgC9lFwZIMZqxe8py8YAN+R5WDj8GWOAoV/Dc1E
         ewOdeuqTSo5QGXEpH/eSylBiv17GD7T3HR1uoHbgg3fKOuHm3G/aGQ7sSElxghDfrGVQ
         51GKb7YYlluwY0pknw9g61tJYGFwvukOyzxDOSHSqRwqQUKwWAudlFREgqC2Lv24Rj3i
         N6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zO1mthCUeUI7sxjtpBRWuN6hGRiK+7MjuWiOZt6OBig=;
        fh=+olx+mlajwfMwiofjSoYymXYRTENsynxTiqXMhaPCCE=;
        b=BwlrJc9QXX83G0hO/lXL/QI1EWwVHabcud9Qop5hEIze2tT6NdnYbfY0LUF37w03Fu
         TJssM627RQT3lKZDKYfTNqXq/XFDAyHSB5P4tYxCYpnkYmO6Hj2RWTHCrAe5b8EDka1N
         RByGEnr6h53F/XId3vAEz68eCzQ2nzdHHdUBP+YNKlsrVcgbDb+oXf8C93vaShn2fLaB
         NXToHXMbcL/xsyYyIdlm/i4YtoolGJp0Tzr8PxO5IOMb0nPJ061x3m5Yy3T2Dpjpz5Ul
         w4hH7yZiec2P/YPER7za1UsTvp+ysyz58vcVaqqY1ROkgE/v/odRCRHwfQiiTPP9SRL8
         7HsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794823238; x=1795428038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zO1mthCUeUI7sxjtpBRWuN6hGRiK+7MjuWiOZt6OBig=;
        b=QVZT4EIUkONNa2Ln6k8aRDzfViAq/D8qVQNEY9OkEP5BvCzOTqBaMc4a6fiMArdzg4
         2n+86+bP3u8tvuBmTcdjgOBd7KVCk+DWaxWtkawa+lWTZdOMjWsPkYMaiKjLS3fx9fJH
         fTl5k8AvBGxr0tPINszFzHL9GykG5zASUebd+u6Z9+Gqd7xyYA2BKp0QVxRoDHlDUUx1
         0Ghsg5UE+kwAOZ2dZJylq+fn4wCrR52msYs2n56iBUcVvU8TKyY2myYeXsQSUD+OiCpd
         dUNagIDLx3Z9Z8ZJVPKHA9IqGDlY8KNbf7H9s39IasyuiLg7LLLVrYMXnh7vB20wqU8G
         cKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794823238; x=1795428038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zO1mthCUeUI7sxjtpBRWuN6hGRiK+7MjuWiOZt6OBig=;
        b=Sjh+nfBqGM6wJm7OpAdxu8tAMidyOMIuvPIxRhk93Atsm+TTqdNzoZCKWmJ1ZkL0sF
         MIW31/zaFk8w/XwV2v4qyXRY4jkyMTv4pHotuQCL6M4yVTjxSMIhomQbBMFHeAs0ro0q
         IsUAjm0NCtvLPKGu8Pu2HJMeYc9ejDNfGL712/lhR0gxnWitp0BSVcrebnE4M18cdwt7
         lqVdoOFdITAJ0H38esul1+WUcugSri/4qNl+B17RZANJYwTnR04VWH46+79YBtM5sWKY
         CqYC3fIlRW9/8K7eTEtfkQcs3MduGEiSmf4LifWObXkI18vEIkWf/5uUuECnP6WHuub3
         CtnA==
X-Forwarded-Encrypted: i=1; AL+hErHfXTY/rmgfHuBzKt3YpbXIUW79jLTAQECFlNxzIknGj3cGZb3Tv0t4v4bgVcbT9lcmiWWTzdTjzSvAapfi6w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9lfO1LMPFufCcGyavttAMZ7D7DGcm2+KNqoNZ3ThM88nDUKmgZ
	e9jlovPLzL7XnQajlEfXY6k1c3Am9HoAYsjRRqysnAmOBSNR48mnfCkz0KX5e9HXzk+yc+PNIhV
	0+IMHtvY9XCl45ItS0zO9VHsoHYLaotuOFtYZPb0=
X-Gm-Gg: AYBFou2XON1IFKOr9IFNRkfVTT4LyXKeF9J7IPEd/Lk02gYsq4rWFBmjX9rbiugywsy
	1WaZgqHWFxIlIi6DpleBkO2kEm/Az2lM2vU/6PchCFzZ5H0g6oPjdszy6PioygFnozlNN3oQ/Wv
	g+4xWtMb3HZmoAdoEa8gTeiMXBkz1xqPgzPpAZXAn2Ru2OKY9esANhjbrf9Na7HSomLSQSqWLL0
	/wTaDvnarjeBnJ58tcb7ktLGOOks2oJvoj/8gjys+yPxltseJ+Il8+RCJqdVcHsSYkNMWbtJG6A
	+fMKMEeMfJVRtOQrTq66AS+ndNH6AUBv6Ae+c3BZrPSChAHRGHr62dp4nCQX/nC7h1QDaz0qjq1
	LlDRTIK06B7TljBVmq1+62vRKrJ2WqOfq7AXVEThuH306c3u8Qg==
X-Received: by 2002:a05:6402:28ca:b0:6b4:16fb:b9ba with SMTP id
 4fb4d7f45d1cf-6b7c0c4c21emr6648394a12.36.1794823237140; Mon, 16 Nov 2026
 02:00:37 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115205408.99849-1-vitorhg20080@gmail.com> <8df779d7-eaa9-44c4-a0d8-e9187fd8819e@roeck-us.net>
In-Reply-To: <8df779d7-eaa9-44c4-a0d8-e9187fd8819e@roeck-us.net>
From: =?UTF-8?B?VsOtdG9yIFNpbHZh?= <vitorhg20080@gmail.com>
Date: Mon, 16 Nov 2026 10:00:24 +0000
X-Gm-Features: AclHuK_TnfPqus-jqI3eh4T6thU-sLqYrsYSrMSfCIt7QocN7bjxeDrmmxB1TXE
Message-ID: <CAOhXrFdg41Rwepx-YN0i2z+tmRCTppKV2sdGTMCNOeuuB4RC3w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: intel_oc_wdt: Add INTC109C ACPI ID
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Diogo Ivo <diogo.ivo@siemens.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

V=C3=ADtor

Guenter Roeck <linux@roeck-us.net> escreveu (domingo, 15/11/2026 =C3=A0(s) =
22:39):
>
> On Sun, Nov 15, 2026 at 08:54:08PM +0000, V=C3=ADtor Hugo Silva wrote:
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
> > AI assistance was used for development of the test harness
> > and 'peer-review' the patch.
> >
> > Signed-off-by: V=C3=ADtor Hugo Silva <vitorhg20080@gmail.com>
>
> Applied.
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/watchdog/intel_oc_wdt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >
> > base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
> >
> > diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_o=
c_wdt.c
> > index 0b012aeb1..a78fe1e5f 100644
> > --- a/drivers/watchdog/intel_oc_wdt.c
> > +++ b/drivers/watchdog/intel_oc_wdt.c
> > @@ -215,6 +215,7 @@ static int intel_oc_wdt_probe(struct platform_devic=
e *pdev)
> >  static const struct acpi_device_id intel_oc_wdt_match[] =3D {
> >       { "INT3F0D" },
> >       { "INTC1099" },
> > +     { "INTC109C" },
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
