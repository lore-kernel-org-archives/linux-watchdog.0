Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF7396B70
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951379; cv=pass; b=SIA8qkapv1HPMa39A1IuxH97WOzwNDMhDJ6Fd3YrNRDKx+Gl3QUlW+GukyinF5kJvAkDiVIX6TGNfZrBQ8sbq4TZN3TRi1CIqcS+ERLKDMgJGmvmjjcmNu+GI6BM1tC7+NNbNUvIA4ag0tTFtopZcw/ytS+icYbXio0Ay55Tcnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951379; c=relaxed/simple;
	bh=y3cQynKsqwdLpOOXWkINx5fLC4laA4KLxk69SPCWteI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG5fOqLOLG24bH1Lb+VCZozWObqm5uuDCwEt3UWEuAhRNTdyy4Mcv479Vt7tj1767cWjJGGEdEChcWtsrlQ21UJRPiK8aWYBXTeM2QcFbaanrSh2LndTodAqMWi8TbQc3fxzEgxtZwptIrgcPIRj74sVDM3SECPvbBQcG8J/OUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuSIQRJU; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuSIQRJU"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso751923466b.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951376; cv=none;
        d=google.com; s=arc-20240605;
        b=GJAJXKPo6uFBCxM79lJmTdSH+FjHOSWgxiQfIO3p2mPI/I0JV6D/3Y5Fkbsf6+nE12
         At0XqWkjl3p0Yb9GPaSq2tik3nQBUu1c7ajoNnSTXMvC+psc9KvaaRvtTNM6A5silHdg
         Ulfp0mxfWi8sVBulDJwqtM/2g1lA007Upxh6FdGOd+o5PnONSH9eIMJbRM5O6Bv/GrdV
         YcwUG6lTFRUl5oaq+rJUDAJfjDmKv+lZD5BlHwPUIAupIDKvDWxcAuq6V9TDcCLdlrh8
         v4EUz7p/a0gHe9rUpwqA0wq1xPmIq6+cTrR5QcRGxYCeJqrSMGOL3eWisTiJsT0I+Ow9
         9J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w3bGHFhpGLfnAz44t2195BtLKMUmpRbBq7DT8OQzDS4=;
        fh=0PFhO0s+VXwK3Dv7doGBImb7YQ3mBEwEEiigofmVm2Q=;
        b=TCecOEYT1/RnZbbxtYtjLsbpFsqvtORD1pY9P1WB6uygojUjGXh1tR2LFuBPrNQ/ma
         4j+olahu7D9/V7W5aDpl2skOk26f/lhInpg30UofMMBnFuc5XPbSrLfa9Fr8DX/8JtQd
         Ub96nrDmCd2ErDwNfz1CbLcUH3zEwtAfeB84/ffQnTj4pqNhN3r7Lweane4EUXh+Xzxu
         dbOhy2ObEK+44dulTIaoUo8HuwZorvRq5DzIFybXnsKDAtH7NufylVjxCUv2zvNEkgSe
         Ygspr3sSH3MTUUFclmb3nZvZxbsQ5SKNz6Ci+Kgy92TuugbMUzPHciE8CHKoeWDHrUzf
         OroA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951376; x=1781556176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3bGHFhpGLfnAz44t2195BtLKMUmpRbBq7DT8OQzDS4=;
        b=EuSIQRJUTjXt/Q/Plc6q0ncrEtUHvEiYRSI1g1O+w0DX5glEyAw4COSMmJo2taIy2W
         7NTdGVDI8/wXn0JncZqkbP4MJrWWWe4EP4KHar/f1yjMCCbOgQiqZ0ozsfljjlWNjw71
         7U8pTgOSqs+KUy4OfJOWyWbN3XFI4PYNG6eQTK33WMbGpuNz9hqxMw7flNyP6Ke0pgWH
         LHlpA1OYwqdK6Pc7X1+Rm0a6TOLICbQb3fkmRfwBWv1X5Lp+aSLQy5ujiegf4FA/whl4
         QiGHqEnRbq96lBnTUgymAH2XdmkmldGhsxWLF4fgoT4CADl4CLhBvY5UDBtPt0AKSYDa
         Mt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951376; x=1781556176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3bGHFhpGLfnAz44t2195BtLKMUmpRbBq7DT8OQzDS4=;
        b=j0MvBUvxUSwI+wbqMoCOJatcGREZCrsJue7SV5OowUzJSarvmWLPuEWkGTb95E41JO
         220GaJEB5ENAbQKqBM3BvAb7fFM2eAE+kh+0ysj2jODEK6oIMZBBlil63VW6p24+RhGL
         Xx2UvYW8z5QfHZqEeCWChR4Fp7rJ0DHRyWkS2WS9hX8t3+KEbKJWWqY4Na2Gf1SNXWt5
         quDcePfzTyhf+4Etb0KCLky7GGasRy+lIZmAwlqkY0wDdJATlYTZjDh74lG0fXhbV/kr
         Ib8/1Qb/QvaU4cjxn7pJPVXdaj3tBj4uPxBUHIWod8cGxE7uNogltXUTNGGAG2Rbwe9+
         Z/cQ==
X-Gm-Message-State: AOJu0YwJKvLvU0rts+9y3fSNMr9tdif5dp7ks8y6eWCJsugRAKR37FSz
	z8YNjMsU0Btmxr4AOMXAVKyhs8/t6p6HCfv6URLylzML9B7jA1DDmT8S1tCpX5ZozkthisSUagS
	MofKh2/2OVwGq1ztT/2Fa+BVn7J0deq0=
X-Gm-Gg: Acq92OFn6v2ze+9GQ+1vwhKePPGLIp1NedcqwjDOnZVY4GEgeb/Pg1NGfOynwjX5SCH
	YWYVlMxZPUCNyrJFXywSR3H+6Re7fcRilGtu6EIYbChodD8g01yov/UyFKtXA9aYPUX3ngx31rP
	+8reJRPatHD60KkuYVUtEIpPfl7mu6wQOF/iY07GWYNHgcQEpEq7che1pKpSxFPM5LMg+kpluo6
	dDkHXtPX9Rn9X1+zlcykPKRo8fPZlYOyDZ7CpnE3QQ4KTiAawYvPXNa/ebzk5hJ3AdLiC7y9bvS
	5NQBA8CXbaPg7O7t2wrgWTcSyYZcVFwin2esknjG9bkY1igek2RgNutxDQ237RsW7F3CkATxkiL
	b2fOtP09mC5HDwKagF/qmcR7+k0VJPVIHk8WSsZhsnR+TKQlQibfLPVm2BLhoykcRTnC8
X-Received: by 2002:a17:907:971b:b0:bec:6c5c:ccea with SMTP id
 a640c23a62f3a-bf370c66034mr767931066b.19.1780951376036; Mon, 08 Jun 2026
 13:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608200933.18669-1-rosenp@gmail.com> <10b595d3-d44b-4fbb-a834-a94b154a0381@microchip.com>
In-Reply-To: <10b595d3-d44b-4fbb-a834-a94b154a0381@microchip.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 13:42:44 -0700
X-Gm-Features: AVVi8CdwMe9gWTnYb2abcAqrWRZzmpLGd7USbf1AK_7yOiRD9ZHMhsEYn-srq1g
Message-ID: <CAKxU2N8-kydmRRY8ry488t0s1dybp1oKgpPcuX-dU80UqYjfQg@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] watchdog: sama5d4: fix IRQ and timeout bugs, use platform_get_irq_optional
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: linux-watchdog@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:38=E2=80=AFPM Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
>
> On 08/06/2026 at 13:09, Rosen Penev wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > This series fixes three issues in the sama5d4 watchdog driver:
> >
> > Patch 1: Return IRQ_NONE when the status register indicates no watchdog
> > interrupt is pending, and pass the configured timeout (not the hardcode=
d
> > default) to sama5d4_wdt_init().
> >
> > Patch 2: Replace irq_of_parse_and_map() with platform_get_irq_optional(=
)
> > for simpler error handling and EPROBE_DEFER support.
> >
> > Patch 3: Move platform_set_drvdata() before devm_request_irq() to preve=
nt
> > a NULL pointer dereference in the interrupt handler if the shared Syste=
m
> > IRQ fires immediately after registration.
> >
> > v2: address sashiko review
>
> Rosen,
>
> I'd like to hear how these issues where found and how the patches were
> tested.
They were not. Maintainer has explicitly asked me to fix issues
discovered by https://sashiko.dev

I originally only had patch 2, which is true of multiple places.
>
> Best regards,
>    Nicolas
>
> > Rosen Penev (3):
> >    watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
> >    watchdog: sama5d4: use platform_get_irq_optional()
> >    watchdog: sama5d4: fix NULL deref in irq handler
> >
> >   drivers/watchdog/sama5d4_wdt.c | 32 +++++++++++++++++---------------
> >   1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > --
> > 2.54.0
> >
>
