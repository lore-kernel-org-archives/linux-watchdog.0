Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F02357A25
	for <linux-watchdog@vger.kernel.org>; Fri,  3 Apr 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191563; cv=pass; b=VRrvsyNCWfpQPBv1pm1ApESJWkqorz/IFAFsUuEZPoA8TtZo9O5Jte5vdnK8laS8qK8TIMh+ch48uyHWdGzQnfvt/KZpOf5j1UKek3buNAJYnKGwow8I9jKP9darvUUrP36+N6/EINZuD3fISRgmXBosAMjMLj0aDdfO/aOyOOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191563; c=relaxed/simple;
	bh=groc3VAnH15CVUVhNhE5OtlEsDNXM/uA7VeW8vaOMTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACKaTnYAYBS/uu9YyUTU+ecdfLe7YBKDq3PjSyb2EROa0xzcLAq3phmJ13Nq6Pxux0f45eHXaOf3kHY3vG/nauUOxQ5vrO9PmQzMHvDfTPFboLV+v9GxpMopFBdHxozB+H5EvvWu/whn4l+13uYk2nLQeF7pB7ejVcEXaej8I5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DidQGWOK; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DidQGWOK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a46260385so14859677b3.3
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Apr 2026 21:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775191561; cv=none;
        d=google.com; s=arc-20240605;
        b=f95ry9rgq5JDwDL03XHuckyi8+vBbqxSUUqnuszu9gQsX4isCzvDp+TjTfFLMVqoRf
         GC6Qagv21IXB6Af56kWmrToWGYcemM4eIQFOgi9xpV9NvzjtjHLcNauXsejZfv7K1TPc
         oUc+0dWdmgsRTYXwEqFyYMxclZJ5YJgnpU0RJqxLb67oDWfXoTVF8uWrx1uaGSh89Ncl
         oKTiMVWTCzy9afpkyt1s0znCgp8ZetEp/Fs1DVe58IcZHfhakKFjG72yPelnkKUWtwzU
         vJgUT0swfbL36ugBGhqKDJk6I/lc+urA78Qm2B4tfNwJBeFGkIsDuwETy79lTXLoLqHv
         f5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        fh=fuvUBhg+h0O5EyaomzxjQeF/H/AqXDnayAwMeA88VKw=;
        b=CRoQoA4X5ILo3/e6UAcSFuHGeZoRCKy6FrMqE4SkZnTg6OX8L7VMt1K31RLcopBlg0
         jbVLloXrzPlTf7lzSxMabIKZB/4avWE8eFM/Zurb9JjXwqw1tf7wfPR34R19WE+NOhGN
         KNyJH4RsBpE+tRUuf9j7zbxZC0mnpJzG2eTwAgvekA8MOdwcOqX1ROOpko6eYbhZMEla
         soFTNCGvUI5LMLXDlC4ualLoQjm2ftbZbV7Ui0fJUOsb9+bUsrM3o0oLOSIaQmYi/5zh
         gkicbBrI6bvIGc9/r9Mj6fit8ZMGbRETwKYuUWepmGKkUmahJIXxqzGgEesczQoK5Ngi
         XeDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775191561; x=1775796361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=DidQGWOKrm72zYGNfTnKQ9IcnJWZNioKN73o236MElVFzyQKQ8qb/l+soctZqFpFYR
         KhdKkKO4KWfPBZssLoFqJJaoQDXfr0ubxMRtcYnbkp4Aw6n+hEGhzMD/e6M1vs9Vctn7
         F7uzUA9y1Hc8Am0AiyTcsudzX2bQmqDVaIRAHRwR1H1Mdwqeulzb+nkNolrXNE6n+lnA
         5zZ6mhLg+931xo6+ZY56HBf57G3FpKAkbPbK1guAlEH/oool84UFse8KKG4/MulU3zjW
         kOZ0D+JZfXdmrH7t4ojZVoyu6NPL6R7//xVc/4ow33xoSCayriKVfXDNF+A2xeU4fM2L
         OvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775191561; x=1775796361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=RUnlP/D6t3C2USiHaabUXtjgVUwe1HXVPbRwDngqNZOica5LlTO8pSJJGmABCoHPrp
         aJOKa7QbFhrnxPlTkw7w7Iuwy7QAhc4rsZLYkUZy/KCHBpb8MPz958o6uD7VFaI/nuIi
         avdGkhE7yeDillq6P8J4sz5D61PO18iVR9IT3uhzg/uebpO+inQmASYRgotemZaMUYxe
         u3TC42eTMZIWngZbJq5b58mVzyiLXJk0d673gznVliqO47gAv5iEjPtWF1CnQkwRfG4R
         7ZuOgTLrN2LZGwANn23T5RvIp74bDhiqS3ylABeIwX2KkCT7SrZCZwU5OFavzqlRKcW+
         3Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCVUdQyOHzJUR/xKwKx5RddSMprTasRzGykDDGYYuan8kEwchf1cicCCOg1VO/jfFz88WtHBpjQyZWYjLhgVmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRQRx3BrulU3jz3e2gNankI2senEYuc+vFx8Mrwd8e85RZvoF
	s/GRtK3TXllD66SYStwzKPPNy7v6drbiYSsFFJk6jVvXndkLWHT1GuSzGpE7tJe/X0YuzyQVBfo
	oNTCE041v/HJ/mdncx0QCL1x5HxNOQuo=
X-Gm-Gg: AeBDieschD3DGyetpBFHXsWf22lYtHEDNA+L3G74q30EHceeX1a5FhrTquQCk+SR2/V
	lL93+eNaAQGhmdSwUGfF5InSohuIEHWP4fAwnqeJnjTw3MgUnv2UD6HOTh2afTj2B10aC9CcH7V
	WFqBuiZJAR3umBHckE7y1V6y4GhVI+71lGbWaCILi+J54SHpzQOVODMFvFKpnQahtk8hqJl6wR0
	sQMYVFEaIxrYEXaGR8s4mKWv7uVmizjCDIkM7m1RDvoOv/Yn6kcefrK13/PlnsmDvUjYu+02Viu
	zohZhw==
X-Received: by 2002:a05:690c:6987:b0:799:198d:8c5a with SMTP id
 00721157ae682-7a4d585f69dmr19958067b3.34.1775191561252; Thu, 02 Apr 2026
 21:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402051442.1426672-1-a0282524688@gmail.com>
 <20260402051442.1426672-3-a0282524688@gmail.com> <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
In-Reply-To: <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 3 Apr 2026 12:46:22 +0800
X-Gm-Features: AQROBzC_c6Pz91vTEwJZ5AXR_5dXzfojiP7V5Wmo6LnqG_6F9RBzJL09w08myjU
Message-ID: <CAOoeyxVp2dY=XrujkCbWHjX4bVu4-H2=k0JHxL6akC6KwY+rVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: Add Host Interface (HIF) support for Nuvoton NCT6694
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, brgl@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Marc,

Thanks for the review.

Marc Kleine-Budde <mkl@pengutronix.de> =E6=96=BC 2026=E5=B9=B44=E6=9C=882=
=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > +struct nct6694_sio_data {
> > +     enum nct6694_chips chip;
> > +     int sioreg;     /* Super-I/O index port */
> > +
> > +     /* Super-I/O access functions */
> > +     int (*sio_enter)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_exit)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_select)(struct nct6694_sio_data *sio_data, int ld);
> > +     int (*sio_inb)(struct nct6694_sio_data *sio_data, int reg);
> > +     int (*sio_inw)(struct nct6694_sio_data *sio_data, int reg);
> > +     void (*sio_outb)(struct nct6694_sio_data *sio_data, int reg, int =
val);
>
> The signatures of the function look a bit strange. I expect functions
> reading/writing bytes use u8 not int, register offsets should probably
> be an unsigned int.
>
> Why do you have pointers to the access functions? Why not use them
> directly?
>

These helpers were originally meant to be used by sub-drivers for SIO
access, but the implementation later converged so that all SIO access
is done in the MFD driver itself. In the next version, I will remove
the function pointers and simplify the interface accordingly.

I will also adjust the types as suggested.


Regards,
Ming
