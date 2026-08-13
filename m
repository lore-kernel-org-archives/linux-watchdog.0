Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC876423A85
	for <linux-watchdog@vger.kernel.org>; Thu, 13 Aug 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648200; cv=pass; b=QRCRSGXBDJIy9SLJgWFno0gwrxqjz/8A1l6JPl4JJkgiPlPi8AvNqkmt0rElgatNZOyVtJurXVHAFwZuIOMckVj4vWrSne6LOjHdVwOorq/yBCb+B56A42Iv3ZvMEUsgioAqwJJybCoJ0o7rK5scaZoaB0mRdP4pvk7gjyJ5UjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648200; c=relaxed/simple;
	bh=8gQdgSVDySn8ktm44gKnq8LHf9gNvcBUvegVvF9Z4eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcUa98M2/atsVgMW4KP8F0VnBOtxYajQ3fb5HinMzLykX2d0mb4y1yuBi7/5Xnz/Zz5HUHfvda673mUUGRqwJXlEf9KNWuB71pWzvxRjOrO2PFTknBA6UwTY0PodwCpGm/NS8Z2hQxAkCxykye6+3DG1Ejc9LcPHDoTc00jO2KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9ySuWDK; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9ySuWDK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47db714766aso801956f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 13 Aug 2026 12:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786648195; cv=none;
        d=google.com; s=arc-20260327;
        b=deg55/7RcZqVtI4echtXO7VRTdCxaEwKVrmzzbGcA8yx+4RPZ9gHJpZTopIB4AG5Ge
         sujrkjShFntZ0Whars3gCNcqFc0w7hPfIT/EHVXtDwvPPviyfuwRIRdf7D8Nh3WBtuSR
         6omlxISHnMZcA+zs5+WBw6oi7xL29Di5ERSWGzqD4USq4HreXJ/dVdfLSMilfcuaybnu
         KBD088bqVW1wAEUNEQnSyOzCfQ4tPalbGqhrCVz/pCYUVxFHgOZ5r0SrSe0nxvO0SLhe
         2Z4BtUyf1Rd5zbCNTWPdj3g4To1UaKijV+US52Q6liSzkvxTp4wl/rLGSlT4Iu0OK0Vz
         HoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rfq/RQGjXbZCotkkVhsJ/QhgbVblNS0MEiBSiyOaSpE=;
        fh=n4hMZlADl4JtjVDPaW2G1FzI9K9Z0uv61mYLDMSB/OE=;
        b=g7d8KDGaCQQbW7aMAul7IU1VkEjxPobzxduHbmNBhwA3bRZQ1ZPK1/t17mMj5A+Qar
         fU7M+Q8l1C1IDaNS9jT16e1QKhABXxQlrrcGkGR9LvatwsRkcF5IaVtJYov/DaUfgJDI
         FGwTOwH4XMoJltJeFfb/XJ8qdOS0v0R/onvSZaUuoUS1SPqHzovyEAWkfTAjmaq//L4R
         zsc6dF9S/M2AFKiP0dBLgCuafHJBdj3OGRZkgUL7fwtodY1FJE0Vld2neRiK9JXmUYee
         GrBnGXB81mF8PwC+H36MxKffcwGk+ZjGbqZ+4UY6TMki2Y+Bm+PspltZ/L1MlA8jxEkc
         QCGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648195; x=1787252995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rfq/RQGjXbZCotkkVhsJ/QhgbVblNS0MEiBSiyOaSpE=;
        b=M9ySuWDK2V7Pk/Gwe5If9shrFSv8R80xMLskcq53ssJPCCz7DOz7eIMb2wxhsJvebA
         wT/WXdxzaqE8MVZ2HNIohrimO/aBsEHM2Dnrf1k66LFSkejkf4Zz5WorPQ5kT1qRUDZo
         owP+yqvWyetWTfmrSdfA7m0ga0hu20arsgXLEozFSyTvdkP6PYUQUa68y/OrqhoWJdQc
         ReRtEFfzWbN+g/7vR9l/ZBD+d1Vd3LRPTumGqx4qBfEcGNZxVsKBmjxia0etvNMnha+B
         ZTpBS9BaE3YI+iMSoj3mtyuS+dwwR4YbkmswytJElnetBOqFGL/N0POc3Azu+8EPIzg1
         pqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648195; x=1787252995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rfq/RQGjXbZCotkkVhsJ/QhgbVblNS0MEiBSiyOaSpE=;
        b=VxsNB3r8sHvdU0Jt/avV3hRDBdLvVVyNU7snfVuUl3IvZTFgCPwalrJjTQXyVZ4VOu
         MMPLbDIz53ePTfLcVPrxDzkDnB4+vXpenSYqz40+n0vIGVFILjpuZ2JxcWUvBf6QgsSc
         I/R1YfilScL00sv01TkGdnNJ5k93yI3Udr14+gfJjpOGeA39slUlHKzo1v9oFJUEMSeb
         3XSp6zHd/yVUIx0G1hGFL6sqt/A9ghpNHS7vLiAsEacQM+jaki6VSmnxiWQiTNYMVJGQ
         Q34ufeOg+YeN6fTffy/bT7dnIZhEdKPPxSodGbRppYXMA1aVQiZLuSohBiM4uVfouSbz
         ciwg==
X-Forwarded-Encrypted: i=1; AHgh+RrWXooKlKihsFCMMu2mTb505H2r22nBcXLrPYlgKyO2G4JCKsjUzTpcfWEkls4gbCmz3wfFQ4pOwKrGfCf2iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBvRITJiRjaQLeNhq58mrOi22ztUxXT9G2FdjMbYh7PLJHyH0
	3tR/TWgFJ/oqRdhPKktvSED4piArNUezkhqJZi3L+bq7FtUkPhdJ/o6cfUe0T/T/C+SRLWivZ3z
	8bop8XZXOpXeTMdl725D0jjdLX+rw5x1VHqdr
X-Gm-Gg: AR+sD12WZI74njKfsdtVuu90FmD30zjqNUnLisKimqlaCS96HhQeIURCLMFZy2stVdk
	EQWRhun9oW3g3EIwQ8gSdibPMdUkbgMSVvO9sKPBKuocZpz1kr12WruLrIzabM57IcCDcV+GpvO
	n3kYlScTfF0uy4wnLyKNjoOgT/OgnFcTCA5kbN9zT/jhKMUIw13ezIIiKmOZTct+XR3N3N6wyaS
	HzorgbyIpSsZv+wDI0BW0PcbUoEx3x+pHFSTFsH+X0o1deaiVv5uILoWzU/IbzNAlZA/ZIpva28
	bzlFUsmtkzaCMJ6BpZ8ElnO7XdnkeodITsS5ia1eA4Sv30x+9SXU0V2e26gMY++SPM+oRnswhv4
	7zxIhcbXae2KXAyGx6Rui43iT9ilZfK50SDlhpSgQmx7HgG+g8bhqfPnaPEP3KA3R
X-Received: by 2002:a05:600c:8b84:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499879f5a03mr6178665e9.0.1786648195165; Thu, 13 Aug 2026
 12:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWEm4yjOH0ziVR3CVDsDJDyJWE7K3GNQpCEiWW5bxaJNw@mail.gmail.com>
In-Reply-To: <CAMuHMdWEm4yjOH0ziVR3CVDsDJDyJWE7K3GNQpCEiWW5bxaJNw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 13 Aug 2026 20:09:28 +0100
X-Gm-Features: AUfX_mxeU8Ha00rHzs8n1E-TWnr4oVrOzuAz2EGUlHCSm1LQSPamqHGEKbKcUlo
Message-ID: <CA+V-a8sbvrbVM+TDbhz=h8gAUkX8n7swARStZzZ3QbqpRLLxew@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] clk: renesas: r9a09g077: Register SYSC regmap
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Aug 10, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 16 Jul 2026 at 14:34, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Register a syscon regmap for the System Controller (SYSC) integrated in=
to
> > the RZ/T2H and RZ/N2H CPG block.
> >
> > Unlike traditional Renesas CPG/MSSR implementations, the RZ/T2H and RZ/=
N2H
> > CPG block also integrates the SYSC, which provides low-power management=
,
> > clock monitoring, write protection and peripheral configuration registe=
rs
> > shared by multiple drivers.
> >
> > Implement the RZ/T2H-specific .post_init() callback to create and regis=
ter
> > a syscon regmap covering the SYSC register space using the CPG device n=
ode.
> > For backward compatibility, return without registering the regmap when =
the
> > mapped resources correspond to older Device Trees that expose only the
> > legacy 64 KiB CPG register window.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Dropped dangerous registers from writeable_readable list.
> > - Renamed sysc_init to post_init and updated signature to take
> >   cpg_mssr_pub struct.
> > - Created a single regmap covering both SYSC register regions
> >   instead of two separate regmaps.
> > - Updated commit message
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/r9a09g077-cpg.c
> > +++ b/drivers/clk/renesas/r9a09g077-cpg.c
>
> > @@ -87,6 +90,19 @@ MODULE_IMPORT_NS("RZV2H_CPG");
> >  #define CPG_PLL_MON(x)         ((x) - 0x10)
> >  #define CPG_PLL_MON_LOCK       BIT(0)
> >
> > +#define RZT2H_SYSC_SIZE                        0x20000
>
> This is the size of the two SYSC regions combined (more below).
>
> > +#define RZT2H_SYSC_OFFSET              0x10000
> > +#define RZT2H_SYSC_BLOCK_MASK          BIT(16)
> > +#define RZT2H_SYSC_OFFSET_MASK         GENMASK(15, 0)
> > +#define RZT2H_SYSC_BLOCK(x)            FIELD_GET(RZT2H_SYSC_BLOCK_MASK=
, x)
> > +#define RZT2H_SYSC_REG_OFFSET(x)       FIELD_GET(RZT2H_SYSC_OFFSET_MAS=
K, x)
> > +#define RZT2H_SYSC_BASE(b0, b1, x)     (RZT2H_SYSC_BLOCK(x) ? (b1) : (=
b0))
>
> Passing the two bases looks a bit ugly to me...
>
> > +
> > +struct r9a09g077_sysc_reg {
> > +       void __iomem *base0;
> > +       void __iomem *base1;
>
> What about combining them into an array?
>
>     void __iomem base[2];
>
> The you can do
>
>     void __iomem *base =3D sysc->base[RZT2H_SYSC_BLOCK(reg)];
>
> below?
>
That would be elegant, thanks.

> > +};
> > +
> >  enum rzt2h_clk_types {
> >         CLK_TYPE_RZT2H_DIV =3D CLK_TYPE_CUSTOM,   /* Clock with divider=
 */
> >         CLK_TYPE_RZT2H_MUX,                     /* Clock with clock sou=
rce selector */
> > @@ -875,6 +891,118 @@ r9a09g077_cpg_clk_register(struct device *dev, co=
nst struct cpg_core_clk *core,
> >         }
> >  }
> >
> > +static int r9a09g077_regmap_read(void *context, unsigned int reg, unsi=
gned int *val)
> > +{
> > +       struct r9a09g077_sysc_reg *sysc =3D context;
> > +       void __iomem *base =3D RZT2H_SYSC_BASE(sysc->base0, sysc->base1=
, reg);
> > +
> > +       *val =3D readl(base + RZT2H_SYSC_REG_OFFSET(reg));
> > +
> > +       return 0;
> > +}
>
> > +static bool r9a09g077_writeable_readable_sysc0(struct device *dev, uns=
igned int reg)
> > +{
> > +       switch (reg) {
> > +       /* ELOPA/B and GTIOCSEL */
> > +       case 0x0000 ... 0x0008:
> > +       /* Encoder config */
> > +       case 0x1000 ... 0x1164:
> > +       /* PCIe config */
> > +       case 0x2000 ... 0x2024:
> > +       case 0x2030 ... 0x2054:
> > +       case 0x2060:
> > +       /* xSPI config */
> > +       case 0x3000 ... 0x300C:
> > +       case 0x3100 ... 0x310C:
> > +       /* MD_MON */
> > +       case 0x4100:
> > +       /* PRCRN */
> > +       case 0x4200:
> > +               return true;
> > +
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool r9a09g077_writeable_readable_sysc1(struct device *dev, uns=
igned int reg)
> > +{
> > +       switch (reg) {
> > +       /* WDTDCRm */
> > +       case 0x5100 ... 0x5114:
> > +       /* PRCRS */
> > +       case 0x6000:
> > +               return true;
> > +
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool r9a09g077_writeable_readable_sysc(struct device *dev, unsi=
gned int reg)
> > +{
> > +       if (RZT2H_SYSC_BLOCK(reg))
> > +               return r9a09g077_writeable_readable_sysc1(dev, RZT2H_SY=
SC_REG_OFFSET(reg));
> > +
> > +       return r9a09g077_writeable_readable_sysc0(dev, RZT2H_SYSC_REG_O=
FFSET(reg));
>
> I like symmetry, though ;-)
>
> IMO the separate sysc0 and sysc1 functions don't add much value.
> What about:
>
>     offset =3D RZT2H_SYSC_REG_OFFSET(reg);
>     switch (RZT2H_SYSC_BLOCK(reg)) {
>     case 0:
>             switch (offset) {
>                     ...
>             }
>
>     case 1:
>             switch (offset) {
>                     ...
>             }
>     }
>
>     return false;
>
Ok, I will move it in a single function.

> > +}
> > +
> > +static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub=
 *pub)
> > +{
> > +       struct regmap_config *regmap_cfg __free(kfree) =3D kzalloc_obj(=
*regmap_cfg);
> > +       struct r9a09g077_sysc_reg *sysc_reg;
> > +       struct regmap *regmap;
> > +
> > +       /*
> > +        * Return early if the SYSC sizes are not as expected for backw=
ards
> > +        * compatibility with older device trees.
> > +        */
> > +       if (pub->size0 !=3D RZT2H_SYSC_SIZE || pub->size1 !=3D RZT2H_SY=
SC_SIZE)
>
> While RZT2H_SYSC_SIZE is the correct value to use here, it is not
> correct from a semantic point of view.
>
Agreed, I will introduce a new macro for it.

/* Size of each mapped CPG/MSSR register region (base0, base1) */
#define RZT2H_CPG_REG_SIZE 0x20000


> > +               return 0;
> > +
> > +       if (!regmap_cfg)
> > +               return -ENOMEM;
> > +
> > +       sysc_reg =3D devm_kzalloc(dev, sizeof(*sysc_reg), GFP_KERNEL);
> > +       if (!sysc_reg)
> > +               return -ENOMEM;
> > +
> > +       /* Only allow access in the SYSC regions */
> > +       sysc_reg->base0 =3D pub->base0 + RZT2H_SYSC_OFFSET;
> > +       sysc_reg->base1 =3D pub->base1 + RZT2H_SYSC_OFFSET;
> > +
> > +       regmap_cfg->name =3D "rzt2h_sysc";
> > +       regmap_cfg->reg_bits =3D 32;
> > +       regmap_cfg->reg_stride =3D 4;
> > +       regmap_cfg->val_bits =3D 32;
> > +       regmap_cfg->fast_io =3D true;
> > +       regmap_cfg->max_register =3D RZT2H_SYSC_SIZE - 1;
>
> This is the size of the two blocks combined.
>
I will add this comment for the macro,

/* This is the size of two SYSC regions combined */
#define RZT2H_SYSC_SIZE 0x20000

> > +       regmap_cfg->readable_reg =3D r9a09g077_writeable_readable_sysc;
> > +       regmap_cfg->writeable_reg =3D r9a09g077_writeable_readable_sysc=
;
> > +
> > +       regmap =3D devm_regmap_init(dev, &r9a09g077_sys_regmap_bus, sys=
c_reg, regmap_cfg);
> > +       if (IS_ERR(regmap))
> > +               return PTR_ERR(regmap);
> > +
> > +       return of_syscon_register_regmap(dev->of_node, regmap);
> > +}
> > +
> >  const struct cpg_mssr_info r9a09g077_cpg_mssr_info =3D {
> >         /* Core Clocks */
> >         .core_clks =3D r9a09g077_core_clks,
> > @@ -889,4 +1017,6 @@ const struct cpg_mssr_info r9a09g077_cpg_mssr_info=
 =3D {
> >
> >         .reg_layout =3D CLK_REG_LAYOUT_RZ_T2H,
> >         .cpg_clk_register =3D r9a09g077_cpg_clk_register,
> > +
> > +       .post_init =3D r9a09g077_post_init,
> >  };
> > diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renes=
as/renesas-cpg-mssr.c
> > index 80f4403ea2ba..2987c34f2ba2 100644
> > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > @@ -1267,6 +1267,7 @@ static int __init cpg_mssr_common_init(struct dev=
ice *dev,
> >  {
> >         struct cpg_mssr_priv *priv;
> >         unsigned int nclks, i;
> > +       struct resource res;
> >         int error;
> >
> >         if (info->init) {
> > @@ -1285,13 +1286,23 @@ static int __init cpg_mssr_common_init(struct d=
evice *dev,
> >         priv->dev =3D dev;
> >         spin_lock_init(&priv->pub.rmw_lock);
> >
> > -       priv->pub.base0 =3D of_iomap(np, 0);
> > +       error =3D of_address_to_resource(np, 0, &res);
> > +       if (error)
> > +               return error;
> > +
> > +       priv->pub.size0 =3D resource_size(&res);
> > +       priv->pub.base0 =3D ioremap(res.start, priv->pub.size0);
> >         if (!priv->pub.base0) {
> >                 error =3D -ENOMEM;
> >                 goto out_err;
> >         }
> >         if (info->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H) {
> > -               priv->pub.base1 =3D of_iomap(np, 1);
> > +               error =3D of_address_to_resource(np, 1, &res);
> > +               if (error)
> > +                       goto out_err;
> > +
> > +               priv->pub.size1 =3D resource_size(&res);
> > +               priv->pub.base1 =3D ioremap(res.start, priv->pub.size1)=
;
>
> Instead of complicating the code here, r9a09g077_post_init() might as
> well call of_address_to_resource(dev->of_node) itself.
>
Ok, I will move this to post_init.

> >                 if (!priv->pub.base1) {
> >                         error =3D -ENOMEM;
> >                         goto out_err;
> > @@ -1414,6 +1425,9 @@ static int __init cpg_mssr_probe(struct platform_=
device *pdev)
> >
> >         error =3D cpg_mssr_reset_controller_register(priv);
> >
> > +       if (!error && info->post_init)
> > +               error =3D info->post_init(priv->dev, &priv->pub);
>
> No cleanup in case of error, so the regmap is considered optional, right?
>
regmap is registered with devm_regmap_init() which on failure will
call regmap_exit. For of_syscon_register_regmap() there is no cleanup
code and if cpg_mssr_probe() fails the system wouldnt boot.

Cheers,
Prabhakar
