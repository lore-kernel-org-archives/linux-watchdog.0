Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5479433E6D
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005208; cv=pass; b=enil27SxNjDigdwTF7X4vAPDYU7b7LpiWiZAcnV/7+e3+tsUkhBB0Wgi4YSAoTO/LhULUH78b3k7dG6tD21DWMIs5vOv+otCWOcam+1d8ZyGvfqRfTU7UX/KxJSbwRyO2SYLbdbZdA81IAf7cKiCOsozZoYeFUG4FbyThf0SUos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005208; c=relaxed/simple;
	bh=/4egXjCN8R7F9xxzpwAYPp/3i0iFE+B6QSqkJayqSxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHeIFUCJWJNZt65ZyG7NhweIWEbg7iI8MOwvqsJ95o8QW6iQ/CMRLhXZOoQtC4KItX/z7oEv2yFuTFjvbOY1f78me3jmYQqygSouVFYClogxz0MF52q/EjunKAtaHHUyCMwEFb33nIZSz0LxiAdvh+JDunlsKNx+XZpdOkH9xfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxwtnWgX; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxwtnWgX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd464d51fso977970f8f.3
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 08:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783005205; cv=none;
        d=google.com; s=arc-20260327;
        b=eWgdJgDRNsyL3oW2hFiB7HApBftdtnnxvLVHs1dix2bljbYWaYFD3oQrQWZedQPzTQ
         eB/VsrlZ1dWnxa5vYvp+KVqYRKLO0blS24xucDDJ5MlbR3EwvkcySelewAPyaid7TNsc
         BOj9Om6YVU8CSYK98s3qY0kz/baEcw6tFojFT+tU8Xrtnj6kPAzNxC+1siTIY7FjrV77
         vuQlM63bkESLvwA6k8vfz/wgHOli4ttlMVLD6bGGWyNIWX8aX9BUKzrCnXcg6mFd61b6
         llnWdqWHBICSC8uCA8l/d3TFjClexVSNMWJyyMIBFr9N7PY1QyB00tB50q7+KK0Uzvzh
         tzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/4egXjCN8R7F9xxzpwAYPp/3i0iFE+B6QSqkJayqSxw=;
        fh=pHUXaBMD5eovjs3lxYkbbEo26uucKld9X+OzcUlYKME=;
        b=DRr9sdm+bprN+/Sx7uFKuTicPL3usJUPP71IdDkae6StScz9yKCEuvlf71dARMW0mm
         8vbWc5GtJD2lWS3oy6afzLkYRnoJEvVbxecy/m4PJGdZB6K3JUFbQoZ79w6o1zQsbB61
         2Y05A8l0kuLharTt6e2EpJZhzn5FQOBv5y8haz7uzDNxqqH7RIFOF+fciXGdyNOIKY5K
         rri8Xl27C8iQ28mL2VbxQZCERn3849RPzNJWh5VDPENQs2uwOxugYn4MBa62MjrqBw9R
         88E6LrM490Qf0DbJit0jIDemBiMXYoAJcbANmckjHAWMgQvP3vYDZpcs4HEk94qbCga8
         5XTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783005205; x=1783610005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4egXjCN8R7F9xxzpwAYPp/3i0iFE+B6QSqkJayqSxw=;
        b=mxwtnWgXSUJ2VTpxDgjhS7KhZUtoDgNgcYhnNevbp0k93vTeIRBovOxpbe5r1n55F7
         xgz4dC9vIg2GhR9kdP6BneN7wjbA6SE2DHVfqYBYMEeXqnwoAMZuxFFPm1LDoLmwYqHC
         XuYg+ywghF8myR54ikxzuuvjyJ+czHEqRHrlN15XDfqhqO5HTVvgxeCxfP3kpovvTQ7n
         hD1AwUBGhVSWrmu/JRUY7J7cRSgiCgJ2BTtLrCIgU3qiqiZyEu7YlJ1NxiGtsjaiSG2L
         pnKQFxVKoDksdl6k5lB5rvynD9icKEJgOqrzNslpia7bb7ryDROwsLjQmP2K/pijmFYi
         rrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005205; x=1783610005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4egXjCN8R7F9xxzpwAYPp/3i0iFE+B6QSqkJayqSxw=;
        b=OT8VY7YjCIG++lgBhYHFcmw/75iOk8eu44WEINL6kaFqosf53qR5tbEsMQj5I3jQGX
         zZNnKkjt86mupMyx111aue8sFm/vzCbAPlUlVh9WPy5ZAul7q/fWMIwmoiNWiyFeWVzr
         6FEhqpti5CVn2IRy6g8Q9h4tBOfu0nA2dhGq3VJ5HroH48IiCu/jCblPsd31LyU1g78o
         6fSi3mWia3eE2tk3qE8EiJ0KsHrSLpOYMokj3DGRCl1PoJ4BA1diqA28dI84VI1PlrQX
         R2K/c3x/74X4lNiooH9bGjjUVtIU/suM/juTF+/pEgJIW8+mgxNHlrqUbqkItjdAz+H7
         tITQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsWgR9GrphMwYtXSuBkvzXCZD0xDa+OXyUHTJUgRUaV+6BTDHzkOh9yril10ABX9VEXRZds6lIWBeIUspDiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gspDQzv/EQVsMcvlRGqhpc+x9PGQMBWZkeFZxhTgx4Lmadeg
	cR9NmDk8/gkd5bxvo5+zd+Co1CGsuHOTHVTlI2hoV3aT4sLhuP3nkbRcPAhN4Zg8nrMqyXXItKI
	2tnU2hLO5fXQ7k5FpgRboLk/T3uX8YNI=
X-Gm-Gg: AfdE7cnjpw/lwEkURrBNcXDiIcNsNU7x+N+cHqkHciU6wbjozR9ZRZzXad1FnwzRZJQ
	J/TfC/IJ//TWvha3mgtjsZu884UORo/62qqovZqdumLH0uQKKWVHc56y2RcgF77OxsG3S4HPpQz
	xeAS/kENc4XvEqI+GPEFYWCuSk8NUV1hrCNa2oGDnGxrDVbkGiRltM9cwSCiion+bsyqr/rzefg
	WMRpLPyWodVGA6uTk60JS07nvvUJd7t5MpNT50z9ABKxQHf1334HdxSRkMggsjG/w88CQAseDDi
	ehsvhE03k8pz1+wUDiOKwnnoifsVu5+nzxzY5d0Y8DF/ZkN3RPnIrTVJTg==
X-Received: by 2002:a05:6000:310a:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-477573bbc08mr9500811f8f.9.1783005204503; Thu, 02 Jul 2026
 08:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net>
In-Reply-To: <c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 2 Jul 2026 16:12:58 +0100
X-Gm-Features: AVVi8Cc-s3hEJSawL1gEVp8kBOMXlVewT2dK4bhHbDClofCdIh5uSGgHTJrBYuY
Message-ID: <CA+V-a8tcFzoGBZ0NBE=612Py+E6gJ4MRqyT2QjxSN1s6Dv5CvQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 7/9] watchdog: rzv2h: Add syscon support for RZ/T2H
 and RZ/N2H WDT control register
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thank you for the review.

On Thu, Jul 2, 2026 at 2:27=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 7/2/26 05:31, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/T2H and RZ/N2H SoCs the WDTDCR register resides in the second
> > region of the System Controller (SYS) block at 0x81290000, which is
> > shared with other peripherals. A dedicated SYS driver now manages this
> > region and exposes it via a syscon regmap interface, making direct
> > mapping of the WDTDCR register by the WDT driver no longer viable.
> >
> > Update the WDT driver to support both access methods to maintain
> > backward compatibility with old device trees that use direct mapping:
> >
>
> WHy don't you convert the driver to use regmap first and then just
> update the regmap pointer for syscon support ? If that is not possible
> for some reason, I would expect to see a detailed explanation.
>
Good point. I will send patch 6/9 and the regmap conversion patch
separately, and I will send the syscon patch when the syscon changes
are accepted.

Cheers,
Prabhakar
