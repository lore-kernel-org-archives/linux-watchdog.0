Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722D196C7C
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034919; cv=pass; b=PnOO/Wwc1lwX4z1+Kez4dYnLr7LOOfKc1pyymRdY8KPdRw1q/qrJLMSS16wpH5P5m46rXE3Umi3kcwVuXwfiVP6RAU7TTNcCWj+9j0htyUBTO04C1CGG0X6fLT71J6dUH2BTs6clXpM8KeEbi4k55y4Gw77SNA8dLqdAj1A1x7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034919; c=relaxed/simple;
	bh=XEp4xPrufFEiSkrjh9AXuD4jVVMbyf5wsJtN2q7RBEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnglJ2J2tze2CdvQxfwzF5Rlqs53ddtnSLA3DsVnu2zFDU27cVsY1nQS4aO57i57ApmdpdwFPjL2gMbVHQwbwgJvzQ1BJEsU7IDGD+6D5qAFUTzibxtfESnnJs8Q2y7K9GOp8ZquB6NiXl7Ee/LTslj6xkqX9NSoMgT8weQIGEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaGz3NUB; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaGz3NUB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so17527945e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 06:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784034916; cv=none;
        d=google.com; s=arc-20260327;
        b=LDdytd4VYr4bkyjHRcsgElWkp8wREPVpm97t2/Ck/ypD+D6vyzbN//tdgsKf3dkEIZ
         XCVdKgOQGQBduSDt8Pr7jBjoFif9pLfGNetB6bVHcPTWFUJT+L2UlFmQTrB9nv4ipcMe
         G3tob413/0vC4UG/CPDnS7Uk/L7zp8gxmOHu47yZ1uBBdUrMhg60POzpu9jvOySA47UA
         t090F8CTe0tX51jo5vKEwNd8CQ/5b00hE07itBEehHu4T+u065KtEjF/S384Eg6KIghy
         dsTnbXrluGKlLfHiSNcH6mzxVS2If9W5kyqeaJo4tSGoyN0qQZ6M/RfrdVS+RKenGBBl
         miBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zYR8riHhwHFuYojsg/ml0oqHNKKCoDuF/KqtRlzn4Dg=;
        fh=QZviRO2CJ2biFpfneW1vWxAZSTWgrE5HhrHVu+9MRbo=;
        b=p+aTy0z6wAnZ0V16q31fUtANDazjej4D2wLSAU+lSLkoxJ0FaqJO6jVUpKhDEl4o60
         eZ96M8sWeB3Cq7V/5qvZU+ZCw4Rcukb9cR9clKofx8HmXNrF2Euyuo5uWfqgFZnX/XGw
         fwBqv5N0yWoxhRW4MoKL5AEqeBwTtdjdpcJZU7wjk+jhylVw2xwMlN/I7+h05W0gVB2Z
         SOjpaK/8M5vWZ5dx5hQ5UqnO3izQyvrzvJBPsZUGYM6HzSlTv/rpDhBAstQMcPjl8Utw
         ayAy7vbCBx/EYUUyLsrP5c+Tk3/wnVkz0mRGd3YyzKPYRTId6gj4+NOQrnp1ShLM/ixc
         ia7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034916; x=1784639716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zYR8riHhwHFuYojsg/ml0oqHNKKCoDuF/KqtRlzn4Dg=;
        b=SaGz3NUBQ2GHG8xCmhlhOvvjGUghtG3Ipcsm6tfITrC8ZZnP7nTePufsvZ6cflZpod
         QUizEVUcGU6d3lZddyIMOIv9O1IQh8dsIRjpP9mwPudguyeCdMMrrclFFNEtEBl+AVAx
         gNKfvAEXdo0joezZNbM5vjDxpubz55O09Hq7NJ3t4sGR08aZSdMHP/c/inb9myiKPSdm
         17NC6765bfaG2+JZuS+rXZOQ4WVUICc3rxVqNp+xviP/1lpldG66Be9oCvjI5yzHjtn3
         0rAOq9sF66RKv2BkT/+ls8+LNyuEvHybhO6ch5QhudaEIvhozGg2zYqQfsnytjIhsH/C
         mBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034916; x=1784639716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zYR8riHhwHFuYojsg/ml0oqHNKKCoDuF/KqtRlzn4Dg=;
        b=nsX00Us1A3E5AK6RBZ6pCERBn0+NLMwE2K6cY7LaPUopMaVh21U6ED80rRkH6OiWls
         kWUI2y0UG5m5FCF5O8QK5E95Xopyo6aBpTujBCU3pHwNQcANr5MZtKYvSyuyWxJcxYjq
         dYU/ssizUaJrGYYg3Rj6T74Hd8pHxiJ9wI5ipxeTy7PfsxyztlSY0VCUh+7H9W1IUpNo
         XX8L4XANX+bWrUgm41W5JUd57zxeCaF+YTQiEseojWpk481287L2qkY+m9VWiC3nNCXE
         l4IgQYbFp4qtfvSyDRBhFxZPcEPktE4IBdGp+xXfih8ybLld4NPBMK9yqX8xXuAUgO2h
         9v3A==
X-Forwarded-Encrypted: i=1; AHgh+Ro8MODxSR6X/Qk1lU82Xly+/HK69olVeo4Af/36HJ+lAdXBO4xH1s/0FReL97KY7PAHi9M/HzSQAtNs/6PVdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNLrENcneY5jPe43oDR4HxwlqtxRQWGT4Loaqmc3qvTxIVO9U
	CmgOWlVOgxs6Bq+OlQJM52ET6KGK3SQ/KSSHJTXqol4tPXzbBUz70XTaC8N8566IB7B69uXh48O
	wkJgVeV8Oef6zfyHZK7OzQkkW7Z8GsFk=
X-Gm-Gg: AfdE7cluYagwI6p5cr/JpGWgSqVPR797uPdEGSqIKemTWB3cv6fJ1VJ+g4dkosl/pTT
	6AUo5+jUzYDu4pJ/Vigemedontv1kxt9njwsuhxhrX6Oe1u+sqIo1LIJ8ZEuevnBLRDuFkWIXnf
	ejg/0SKQ/Tx+ufxxiahqzN2hn/hy/9CNNCjaryV3x8upKP3ylvXDWI4pokvph72BypoFPHj42zy
	KCquxUTyAQmhnvoeC6yFDYXHCRvPK5GCXDWUyLVP0CK9gCyMqhNQU/Q4mrN1qNUdO5wjQBwq7Lf
	70gUp/8pHdybNmmQ64tdf0fxMjyt+7QvdyzZPcdUgJqWfztLu0EBLBQ6Ej4=
X-Received: by 2002:a05:600d:6413:10b0:494:1cdd:4f9e with SMTP id
 5b1f17b1804b1-4941cdd5035mr50422985e9.31.1784034915742; Tue, 14 Jul 2026
 06:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXYpDfoRhgfhqeU4_acGQj7f4ivEdB3Ms6SKeeSwY5iLw@mail.gmail.com>
In-Reply-To: <CAMuHMdXYpDfoRhgfhqeU4_acGQj7f4ivEdB3Ms6SKeeSwY5iLw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 14:14:48 +0100
X-Gm-Features: AUfX_mxf9CoAWS1OaHlxkRnP3RC1vp9ZjYGgKTNfss75dU2ZLfsEhv632kdc6DM
Message-ID: <CA+V-a8t1TbnD14s-d=UVTL58jWA9Sxcyb6mt9tfgAMBUkoJmRA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/9] dt-bindings: watchdog: renesas,r9a09g057-wdt:
 Add SYS syscon support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Jul 13, 2026 at 4:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
> > resides within the System Controller (SYS) block rather than the WDT
> > address space itself.
> >
> > Previously, this was handled by including a second register range in th=
e
> > "reg" property. However, this is architecturally incorrect as the SYS
> > block consists of two distinct regions (0x80290000 and 0x81290000) that
> > contain registers for multiple peripheral blocks.
> >
> > Now that the SYS driver provides a unified syscon regmap, introduce the
> > "renesas,sys" phandle-array property to allow the WDT driver to
> > access its control register via the system controller.
> >
> > Mark the use of a second "reg" entry as deprecated in favor of the
> > new phandle-array approach for SoCs that require WDTDCR access.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - No change.
>
> Thanks for the update!
>
> > --- a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.=
yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.=
yaml
> > @@ -48,6 +48,17 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  renesas,sys:
>
> In Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml,
> the similar property is called "renesas,sysc".
>
Ok, I will rename this to "renesas,sysc".

> > +    description:
> > +      System controller registers control the start/stop of the WDT, a=
nd halt debug.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to system controller
> > +          - description: watchdog IP instance index
> > +            minimum: 0
> > +            maximum: 5
> > +
> >    timeout-sec: true
> >
> >  required:
> > @@ -73,15 +84,29 @@ allOf:
> >            minItems: 2
> >          clock-names:
> >            minItems: 2
> > +        renesas,sys: false
> >      else:
> >        properties:
> >          clocks:
> >            maxItems: 1
> >          clock-names:
> >            maxItems: 1
> > -        reg:
> > -          minItems: 2
> >          resets: false
> > +      allOf:
> > +        - if:
> > +            required:
> > +              - renesas,sys
> > +          then:
> > +            properties:
> > +              reg:
> > +                maxItems: 1
> > +          else:
> > +            properties:
> > +              reg:
> > +                description: Deprecated. Use renesas,sys to pass the o=
ffset
> > +                             of WDTDCR register instead.
>
> the index of the watchdog IP instance?
>
I will update the description to "Deprecated. Use the renesas,sysc
property along with the watchdog IP instance index instead."

Cheers,
Prabhakar
