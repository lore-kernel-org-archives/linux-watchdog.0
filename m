Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EC309DB5
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035347; cv=pass; b=bRDQXSudXcxe6hISZ6cWrsAqaJsNe72fCVnH5ckli8j9EFA8pxmee11e5FIWcKZukQhlr2zETwJpsaD26dG3JzqIUnwRrehw9G1z5yqF4UMdKQiS19UMbNZnsP2XADwAKt9MXl+BZhmeW0K7TjN5zJ7JoE4gK7BVPjcjzD9gCT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035347; c=relaxed/simple;
	bh=7EpWkjOIX2bvUj7bhrZlFgeAZ49Zdzo9NleFTDfsS0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Br4R0Lvrkpahe7aXwiiiFMpg7msD31PQ36s9s0t2WmPxB27xFA/L+EgXm7ZwwHM5+9E3FK8sVtqWie4B2eLXkCQQ86L87T/M305SbEIir8RShU3azC7LxgJHUwsfPhTydPB433QBWNf5Y8LfAKaf2f6m369eQkWQjD9Gcv47XTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4l90eyf; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4l90eyf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f36a122fdso1010247f8f.2
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 06:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035343; cv=none;
        d=google.com; s=arc-20260327;
        b=FaG6EylXXIVta9G6wxhGagXCQL5Cg5pqjsSMdDQ/9Ru76uIaYRWgG/nBDetqJauFny
         srKGJfKNG8Q/g6Ts2eqBAqAxvk8tNTaIZXoANd/Dh4NkYY3dcJmAgw7kAWYfp7fIMaI7
         8yBvOOq0d24Kck0/+cSQZjdIa3nT2mLfUsrKI8ESdS4uYcVdlHTcD+HfA2mQ71BNBdxY
         yloTDUo+MS+eUABdHUnkM62ZZHxCRu38bGIeNDjqtkgDuh9tQYdzRLPY68RQO17S+ox1
         AjI8ivaxnrzcs4kTk5ZammeXcwnam5da8qfmutyg0J7EcYsOs3fe0yE1Js9UQHxWCdjs
         tFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gd9QWw526oknp7pc7L5j5Qo1NtCYrA+LbHXHAVKWIIE=;
        fh=A5PSEo01YmRDQzKIw39ka8kPBS2s92T/YHo3B48csgg=;
        b=L9FF/WPx7d2pqxNNR6s9ENWp5aI2RR/y2QNpY8rC9CdFoMxm23p705atwVPDsDwGoS
         K11NpkDCOaTnBcR2bsTQgbVlWVOIbgWqrmDtMFgENXhsPlLSJbBHvuqxHl6ICkqHoKH+
         Z7c9crv9FfzZBARH7HDs464adEgPyANahCPBYfXm077vHJhvHYKlpJVj/4GC7s6TxRVr
         UAnGDL94bcheqbQfoIt0zinIxGd/9/JZu9zZ/aTNsqQ1Mv0wWlrne7eSwa6PtOtGMCzM
         E4G4PAXdzs3VJMtOdaKliqvGihmH8sJ+HS5o5ItwS59LF66aPCw96CZumtLJflF9GjO+
         XZ3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035343; x=1784640143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gd9QWw526oknp7pc7L5j5Qo1NtCYrA+LbHXHAVKWIIE=;
        b=B4l90eyfla2j6MFR41xOPXv7A4x1XRFSzPN0nowphIxuDh07m0WEWw0M2Sye1SgRy5
         Z7cGxEZTPj37pONqjgCqZ2CxMMSdgLvnZkXNya4mO4/NlD2iNFyuZPtAN7s5nHczZeYk
         hBcsI63u7ss99EzSNJBihvSHm2IERdi5suzh7ED1a35P448C6ldyms8MaCwskKGD0EC/
         SeJZLrdRxykA0fDTz8TJXSDys7cEaZQC9i4et2F9WEm5lcnkd7z0GBq0yJdBoaw4tIaJ
         bV33eXOaS9cnT+XJ8UipXMLXlrzd3Bqzn2tQT6JysybKRizKt1NPeiXkDwjZ4e5+PMAu
         4ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035343; x=1784640143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gd9QWw526oknp7pc7L5j5Qo1NtCYrA+LbHXHAVKWIIE=;
        b=SAjGGJpYCg3mcXPnLdU1ZNU8x7z98ZFGkFUHWFUqUm1kx7R1bbN9IQtQsqYQ8CcfYW
         FZ/jti81TxyixD1lcEcbCXWV73+1b/KfmhtAxLuWb9/Bcr5LoS2vRyH4xC7gxs/1rz6R
         dKyc6jHeyg1ljPVxea5YlK5FvPtoWhRDjVQTkF/3FzH0cpJIbWhGQEIK3rWeVz0huOPf
         IOojSgc4FN0AfGyIPtw9KYbvuCPT9XNN/aPbSdvLHM/HOwYlIo2LJsjzPa1gmL8ldNuX
         HRvVdd/kj5EabLgROIKjg383PWRx66zM1Mu71fuj018QnVq0U1bS2KDSqxpqSL68+rCE
         ZIrA==
X-Forwarded-Encrypted: i=1; AHgh+RqXa6D/vQsEtNPynw6uqt+WGmiO7FgTAUm7njK46n/iCPeokAJLnBrBpGy2rlyG63LUc+3JEpgSBF+ZJR0lgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7j3Zj+Sngpz9fkvjEZisAgsTJ0KOUVxDw+1vjxOHfF39Tlnw
	LYZKW5HuikaeLMeigcEWEp4EgElRF3XAF0NgSt/nKPOhjygnxzwVsEfuMjynP2qeY+125YiXJbf
	Q9M2ChzzLXIFVNiY6Y7m1rdNeUi4acYQ=
X-Gm-Gg: AfdE7ck8D2V3IHt0M5U8G3hCrzxXmCq8GJ2Xq6CvHrcvaiMHM9QRmR+Y0cbx/l6Dj0I
	D8eKeUtNUhiFprwjDHJo92Q8pMxOplPrihVE7dEK6+QMy/lSY86trL9StpLTioBm7vDg1etbcHm
	K2c5hgT/FAEpZInsq7fzATqKlB9yfPXzSRi59dLTNpZDpc+Dxtf/IXYQ3o+84KByMyrMu9vzR2b
	QAWhGQ0EC7ymvzAXCptMWYI+rdphO7yWDzRaQiL+j065VOaod7Cjns2I57eE1GKuB7PlscObISm
	HN8NqUcY/qkfiTckWvdrcEdTpbntCmDRFFGnzgTxZ7yhg892pLy45xT/VHI=
X-Received: by 2002:a05:6000:612:b0:478:65a8:262d with SMTP id
 ffacd0b85a97d-47f2dcd1a6cmr15559441f8f.9.1784035343221; Tue, 14 Jul 2026
 06:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU62updtKeBBk-vO3YP+qaWTGqHQnzKvFJbrz4J5eEPMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU62updtKeBBk-vO3YP+qaWTGqHQnzKvFJbrz4J5eEPMQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 14:21:56 +0100
X-Gm-Features: AUfX_mx629uzNMG8Nucw8hUhgYkDfx2F61U6edckb4KFpd8R3v5p5R-Ssz_7kJI
Message-ID: <CA+V-a8uWMJo8-WaFiXJQDs97gsrAEJG0-4PYgsp8J1LMjxd4-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/9] dt-bindings: clock: renesas,cpg-mssr: Support
 RZ/T2H system controllers
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

On Mon, Jul 13, 2026 at 4:50=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The RZ/T2H and RZ/N2H SoCs features system controller blocks for low-po=
wer
> > management and access control that reside within the CPG/MSSR address
> > space. To properly represent these hardware modules, allow them to be
> > defined as child nodes of the CPG/MSSR controller.
> >
> > Update the CPG/MSSR binding to support child nodes by adding
> > system-controller child nodes using a patternProperty, requiring a reg
> > property and a renesas,sys-block property to identify the controller
> > instance.
> >
> > Restrict these new properties to the RZ/T2H and RZ/N2H SoCs to ensure
> > existing bindings for other Renesas SoCs remain unaffected.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Updated commit message.
>
> Thanks for the update!
>
> > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> > @@ -99,6 +99,41 @@ properties:
> >        the datasheet.
> >      const: 1
> >
> > +  '#address-cells':
> > +    description:
> > +      Required for the RZ/T2H SoC to define the address space for chil=
d
> > +      system-controller nodes.
> > +    const: 2
> > +
> > +  '#size-cells':
> > +    description:
> > +      Required for the RZ/T2H SoC to define the size of the register
> > +      blocks for child system-controller nodes.
> > +    const: 2
> > +
> > +  ranges:
> > +    description:
> > +      Required for the RZ/T2H SoC to provide 1:1 address translation
> > +      from the child system-controller nodes to the CPU address space.
> > +
> > +patternProperties:
> > +  "^system-controller@[0-9a-f]+$":
> > +    type: object
> > +    description:
> > +      System controller child nodes representing sub-blocks for
> > +      Low Power Management (LPM) and Access Control.
>
> According to the documentation for the PRCi bit in Section 11.3.1
> ("PRCRN : Non_Safety Area Protect Register"), the low power consumption
> bits are in the xx28_xxxx blocks?
>
Yes the low power consumption (MSTPX) bits are in the xx28_xxxx blocks.

> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +      renesas,sys-block:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Index of the system controller instance.
> > +        enum: [0, 1]
>
> I am not so fond of such "index" properties.
> And of subnodes ;-)
>
The intention was to allow consumers to easily specify which sysblock to us=
e.

> > +    required:
> > +      - reg
> > +      - renesas,sys-block
> > +    additionalProperties: false
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -126,6 +161,10 @@ allOf:
> >        properties:
> >          reg:
> >            maxItems: 1
> > +        '#address-cells': false
> > +        '#size-cells': false
> > +      patternProperties:
> > +        "^system-controller@[0-9a-f]+$": false
> >    - if:
> >        not:
> >          properties:
>
> As RZ/T2H and RZ/N2H are rather different than the other (mostly
> R-Car) variants, perhaps it makes sense to spin them off to a separate
> bindings document?
>
Ok, I will split this up in the next version.

Cheers,
Prabhakar
