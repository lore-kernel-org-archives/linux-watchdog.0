Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565174;
	b=rytzJrq2yPmwvmE0g7SXUlqjsMqXJvg+/LC0jObgn+2qcbAPAXVlmLPXQjbopo8w9+Go
	 linG+RW52aHaPquxaIRTrIVtbyQ/j58AM3rhcCI0sg54ltObgWrR3dv/Zx/SRKwYQDSwn
	 xWl0r862oulHkjH0juRcWvGVS+1uQ6iDQ4VgfPXb61X8r+ci0vl9IE98ZWyHfi0eByCuS
	 Ovz994l3D5EBbwk1LgdntafBByb8oHgIfkg3QFxHmNVv+CKZz9IdSF4rAMgsmw8b0aqMD
	 d/iXBuPeI0Id6lNUNIlVOKPlnhokvEaU2RiX0WCfTAGoe7dZePE6a1X6RT1QhAl4nrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
	b=4Wg6InIxz7gcIFVtAj+tc2TAjDMARj2WRhoFpB7NCOn4f1FbeSX/LelLn1CRawGqFdFK
	 iroJh1DkilYfL/GeDT8CuUHxSc0y4qq32v+RkQiM1QSLdglfQogMCIO+56g2RuMhY2MNV
	 /OzbHEkZo6VBGtdaPGov4yR/V4vLuMqDIVuI5G5LjtpZewbsl6Kyv2xIRMp/HRnJcyXLK
	 FsApvJKJMHZIknaAYM9ZLUs9c8M7j6beCoHSYZD25OvpT3xTzyNrWnqYCm/Hz57KCWIjq
	 xElOAF/mu5K0fMtumib0Mg8fk2FySm8aGRwI7g3/MZdiE4YU2jnJIc8I4Gr+C29wH/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B87606A31C
	for <linux-watchdog@vger.kernel.org>; Wed, 21 Oct 2026 06:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B87606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917aca1aee5so4754066d6.2
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 23:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565173; cv=none;
        d=google.com; s=arc-20260327;
        b=RHcuyFf/nqYpbrBYisFk05SqQ7Z+QJYztTIj3/YdKMz3XivNuW1iT8tztQhhgav8z/
         Sk19fbFWFS6jPan9uVbCQS2HS9RydM+f/xoSRdcW1uxdd17+z0r4Gm2XXJSCGNDSGDc1
         wEmoF6ZHfxNI943/0Ja1ux0GDXbGLrwSNLAj+AYFA6NT9SwG1ebzMwTo4hLACNOYu+xn
         5wt8Gn7b7u9Cs6jwRjBj4GmJS1hx9FJh+oCxvSd1+PNCR+T2xBG5IwUzNoGXp/9vAwr8
         ImpCvPIuEV762L7ITO0Q5AfYQCRsQ61vqOjOv3v2dojB0+Qtt0ACWT3CL3YybWek8zdF
         yyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        fh=tKGGsElWHE8+5EgCqDy77Dke1zqH3iEKqOXksFCUNvE=;
        b=omIs/4UJtOY4Bi4KIAq7KPYNO+yvJWfZ0tNtwsO+rRmjBUSX/fvd7S6f5KQ+oMBfMT
         WBpjwlZsI4pXogCoBs51yi5qVjwfAywiikppH7fGjUbrIamZSPOWd0XLWApa1LAt+O8G
         zgV8Qv82+gjW4/J1jy6j72IhCjhw9FXyuG7o9mI44eCbl5i8hkbjPhj5WvVQdwmSQg+L
         zzeXbZ6s+xZ9K/hnqEJIrO0Gx5vNbB9kxchd2G/TEGUuZqpvxpyCVyV5Byu7hZwLPR26
         gE1OsVGMZ1kmsDwlbGD1sFqVOkOe9s4Ci8BoebGe8noWLiHQNg6izFPSWWsLtd2pcVZh
         /CKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565173; x=1793169973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=N3K8Bbb9tNmHLFt6ZXFDabkPNwYz0MlgUzh0K/zfhr2yAjtdkvQ+atM46OurewOaR1
         5GpHZ1w3HZLexrrVA23itcwJ6z/A3tv78GFsLEvhUonkAC/73dFWQMqQxs4AzcszUoAg
         QywB+6q06BHod6vzHnLg7lTEveFPsMcBeMrLr3fmzfBfZu7SyUZlS+rtU0CFP/tt5s8g
         rXTl04SHDbrB/z7e3KtddFWqAgqZuw1vN7ipKBmLQJ+HhmthCk+mdogVDq20OH2zdFz9
         er4Y6laPpOvP7dFZUifXCwXVCDWoAe8f6eCGE6CSv2DC0EwRrBbnT+ttWzNfLh3PEE/8
         ufzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565173; x=1793169973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=m9ZfSyItzq4WrDr7DJ6YdhEZueRW4nlq5zmGue0wQDUa86CObhwWo9SX5CmSFkr3wi
         1k+aGwD1Aok3VYQlI65KvXlwci5K9iwn5PPxyC9GE/76SBw0RuZMVPnjo7ySoZZR8YOX
         zeTxeiKZr8ilJ8zasK+hVLsz6N/n0gt75L3QhQLlzIKYyY+YRUwT1w02/wtIRt7IeELp
         6fiXzZ53dUciJRGubS4kvhPrJNyCp0Mo20JviKggo85L4HQFQdYP4uXAvFm+mzVrbr8i
         k4DuJxObWlkZoOL5nk+CtpxplM62G+dGuKxKKnoaonjFax71IkAg4B0zPF+tJAaAKSeU
         9WBA==
X-Forwarded-Encrypted: i=1; AKwUvBye8jkzRrYErj6dE+pIWhCrzZMPHfjjWho7LLDo58Ro/lrIVmDajJHBYmW0p4hfHaIa02u2rSyQ2e7rDumNqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJn8g9/um7X+JhjoipCxyrEZLK527Qh9/lJtRQL21YLKyDlFqlc
	EeCryb58oRLioc+hPb7CYoz1kX4Q/OI6qfIg8OjoYNwt+q32DOER+q+f5PXCNeDZVXfAQ96iUnf
	c5PbOUW2Y48Enh11mMSHZZ1Nfm0PFiKg=
X-Gm-Gg: AYBFou3EkTUSFczOxjTJ1eujmJJm46vllx9hcUtdXEB/zjkGPUylDAhjHBc8PCJ1XVG
	Vkql6de31qUMia3KYMtkzhqGv9Dc85EoB7lNV05X2EriDyolfxzsUb5TcWFKV0qhDfDAtQiaty/
	2x6vUCXLQLylI1YS29ExBAaqx8vIVaze7q1RDnGQFwxkJqDOp8phazPQSL/d51ghxEHGt9uy8tN
	n62Jn8r+AiWicYITn0B3k9jRvCSGnzKkCk3srO5iVSmIX//3DKsj87kQmMKYJg8u1csbRFXNc0p
	DNaidyS5geGezdqXEyUIEgMDzmAyU2VNtBUxJYbE17z+kCe9Xj6XVUBpkc5O9nLniWrDVTblqIb
	fptJM3n1tK24n95MgooIVlgULfVXDTBjp5ON92+RYALBlqPbq4uTCYrRixaI=
X-Received: by 2002:a05:6214:487:b0:91b:cafe:58e2 with SMTP id
 6a1803df08f44-91c12eb7b30mr18765456d6.14.1792565172936; Tue, 20 Oct 2026
 23:46:12 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013063259.2734757-1-a0282524688@gmail.com>
 <20261013063259.2734757-6-a0282524688@gmail.com> <sashiko-outbox-169117@kernel.org>
In-Reply-To: <sashiko-outbox-169117@kernel.org>
From: Ming Yu <a0282524688@gmail.com>
Date: Wed, 21 Oct 2026 14:46:01 +0800
X-Gm-Features: AclHuK_sk3N3reGEV1vFqkhXmWhSRT0CO9e7SvF9FhuKig6lX9RUqvijqALmuJY
Message-ID: <CAOoeyxWNsBt6nDn82bCv0DUpar3c_K19su87UEbjm4CfCJbbHA@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] mfd: nct6694: Move module type macros to shared header
To: sashiko-reviews@lists.linux.dev
Cc: linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<sashiko-bot@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=8813=E6=97=A5=E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] mfd: driver-specific header modified in global include/linux/mfd/
> --
...
> > --- a/include/linux/mfd/nct6694.h
> > +++ b/include/linux/mfd/nct6694.h
> > @@ -8,6 +8,15 @@
> >  #ifndef __MFD_NCT6694_H
> >  #define __MFD_NCT6694_H
> >
> > +#define NCT6694_HWMON_MOD    0x00
> > +#define NCT6694_PWM_MOD              0x01
> > +#define NCT6694_I2C_MOD              0x03
> > +#define NCT6694_CANFD_MOD    0x05
> > +#define NCT6694_WDT_MOD              0x07
> > +#define NCT6694_RTC_MOD              0x08
> > +#define NCT6694_RPT_MOD              0xFF
> > +#define NCT6694_GPIO_MOD     NCT6694_RPT_MOD
> > +
>
> [Severity: Low]
> Are these driver-specific module type macros only used by the parent and =
its
> immediate children?
>
> According to MFD subsystem guidelines, driver-specific header files shoul=
d not
> be placed in the global include/linux/mfd/ directory if they are only use=
d
> by the parent and its immediate children. They should be kept local to
> drivers/mfd/ instead.
>
> Does this addition of driver-specific macros to the global header violate
> the subsystem architecture guidelines?
>

The sub-device drivers under gpio, i2c, can, hwmon, rtc, watchdog and
pwm also use these definitions, so the header needs to stay in
include/linux/mfd/.
