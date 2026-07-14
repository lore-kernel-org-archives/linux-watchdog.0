Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B930BB8D
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035378; cv=pass; b=QRo9/qQHAghK8+3c37GpwuRDV7trWHUlGRuxZHg4JbyAp3bgyqFXFv4toXyIPygAyT31An2xAScbrpmy1vWrOoyd6Lg9ciIGrnIkuxN0RCQSfT5zng0A9fxfle8KIN9nmTVDm3XYCIFWT0xRkTJR/fsH1pW0BWgDuTjQPD4vRNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035378; c=relaxed/simple;
	bh=likGGf+ggWYG16RLVo/FcbajDunMZFr0fDET5ovKQVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S74nnfruCQxh0RMyoJ6h2AG7Iu+KtbxwH+aEjjAWoImVqfR8o3GBZm4IbRifIzQr328u7gaO51lVR/qcTOeyp34vZ5ymlwYpIGHNCvsIgHyDNJgDhv9YaY7TNTZfk3I6mhxlbbc/6v0jwNXtEDIvkUVd4o4ixtfch1RKJSDJYOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ38ObsO; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ38ObsO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-475881b9a4bso857694f8f.3
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 06:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035375; cv=none;
        d=google.com; s=arc-20260327;
        b=IdLadwa2mV/BDRPqh80/xP1hZg0L0SWVzd0R7DDh48Mpfc/ip+npx0gNEdsfovcEqn
         cpaIFRrpJVWYRjd3G5ue9VQilr4R061XCQ0jWeLfVI8b8tArBxhZq5Q08+z9x3lIJ/99
         npQCquZ6ylvWx7M6At+1A+iW7WtTUd1j/nv9CaH/jmiTZjdCRsOnfcwQm7Cxq6tGT4my
         8qp7RXkjm8CeezokE4S05NyY6BUGUybPObb2RBtVvUCr9HjyczfMNX+k5KrGJwxKxGCF
         wfIc+gAXpgjHZVCq2dK0uEAhkRv5efjTdn7DT+CQtN9b2gziZ7EByvDJTn/cLEKCnH9U
         3/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXEB7lD1Pe7mGc0NP7BMIVuEFyfydPaOvdXbwC8z9qY=;
        fh=VrkthkmlVscz7RCydT0LOfV6BicnBKTXvRXfTrLpNHo=;
        b=Ujx+0EhcrBh6MC9tnBkYKFssj8sIHn+9B+yV5GZ9p0bNFfR/8tdUOy9UOQzhEWJpzl
         Seux70mL+xYfv5oCn8uaft37rGMoRsT28fp2cBI4jWTljGYOQQWd2V/sAkotOK2a+Ips
         S7Vh5Rws9Mo1IQ4HxcHog5vYwHKkgEdJSmSkhR/mBQ1Op6j3/nztbhaCyMOXLw8bRx+/
         f9GmS/ueyo0ln/dpf1zQlvGszFGm6pC4CXnrQRD0hvXbabhPIXmVfUVndJCoCorYI7Xe
         0XUvP+LPNjwkOSQmpyy5nyCyA8GiewzKFjOdx/2NOmQ+NEj8pnkdMC4M9RSbZ9R9PWVp
         5ApQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035375; x=1784640175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXEB7lD1Pe7mGc0NP7BMIVuEFyfydPaOvdXbwC8z9qY=;
        b=NQ38ObsOvFwVrbqoVD24TE2/27i0bu0G7Ec30C9jBx0tt5tZWmFLfgrC6xfF3lc9zC
         rOhmbPeZv63XGOVJ53YoXHmrUS9XOg237YBc1UwYaMyrerRVilWlX8M9RmBifxbvvVy1
         PiCBANHlBCLVOr//Q5LPGatjrvj00LT1VWyWGsIHIK3qY+NNxaMLbuS2OS8i5CXk7Ynv
         N7AIzaSfRYleWMdBNJ923GpVyhD8LBoYX74SZxh0ZUowaNYuiNEkmpvJJ/CWLNMQu1b4
         JRfv5rO7p6yWdx51Yf16Ty+220qZpLoHkkENmaLb/m1hq7uZ0Oc8aEcRG4WfnOJRubTj
         PkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035375; x=1784640175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXEB7lD1Pe7mGc0NP7BMIVuEFyfydPaOvdXbwC8z9qY=;
        b=n6xbw7HBPYVAAerIp8Xbs46PJTOoTgRK0RCk2Ivrbtblsi5w3LaxFnMu32WFKx2y6y
         AxPtEOnjZBUYNsKO/SmUoZngbza7N86OiWUji42XY3jiiFFXd5lycfQSurTFRrINpUBI
         CR6uNOsKKCulLK9sB8air6v77sk+SIYQbx/GnchEjpriVE0GJDZyE/8KLnjj6UJSUMlt
         ScFB7CRsHQBYIleYdjVGfMm7gkGvkP37CLbFMJJOdAacodwact/+J5Wq5lx1bNuXa4qQ
         J9WkFg19e30PzuuddzCECG2tR3RWQOzEmyuglgJob18/kxmGJklroE34eFIDy/QnPKkE
         JbXw==
X-Forwarded-Encrypted: i=1; AHgh+Rp31I0QXQooupPxz32JRa51MS/mB3QzUWePXNHLG4MfbMPHzK9wJ6D+TvBk3/GVCDaw/UtIrsEHU/rU4vdNTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhV+K3H97vqnqAkdCttmnpV2b+kzORVrAoihFTBSun/R/uAtK
	J0iovGuIbMYPooXo34vpK2ybm5oDVEtOJ/BsK+CgHm9HRKztnvj733X/gPwde6TDtAxrZvH2A5I
	C23SHQCbXcGSZwpNxDX+/VTBhQdx2w+g=
X-Gm-Gg: AfdE7cnXfc3tWBhI86nSkMWh3H1R+T7AUc8OuzRAJSEjzlq3hperBaAKVfUo99tJ/wH
	tv/eNs8nGqTkwdphStD3ocPX8EH48AuBexCMQg0h8tY0+VSSbHnNDJPnYPltqs/i520p/qMOUrb
	DDTCyL0nNg9evXG232/QSon8yX7hw+WiXK20GoXCj+pHdANAVwbR94qjJ3Yz8w4BHzOWDuk10wI
	OTWBuVvoA2urCqpJXyglo7kecB2Yh+ZvZpy4d1jD6tjwxW6+xVK7k9FLeOToWj7inNbkn6vt3Af
	Ud+n7jSwkowfIfxxCzOc4uJXcSM7gWT4mXco+q1Jtu/PIBCVX+63Pg2JwoI=
X-Received: by 2002:a05:6000:4b01:b0:475:f100:35fa with SMTP id
 ffacd0b85a97d-47f2dd439ebmr15117164f8f.55.1784035375471; Tue, 14 Jul 2026
 06:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdViSFTZZMe0SsC_aYmyZqTHCFNN0NxPVoNx5OBfwi4MLw@mail.gmail.com>
In-Reply-To: <CAMuHMdViSFTZZMe0SsC_aYmyZqTHCFNN0NxPVoNx5OBfwi4MLw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 14:22:29 +0100
X-Gm-Features: AUfX_myvAV81_pgPn9QpR6gxgV9zHgZTebLUmHf7fq4pIgaFNeNRXJt-dYDKguY
Message-ID: <CA+V-a8tXUttE088QVKn3Ovhm0tyUEAq5ehBZgTjTrozvw=YSpg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/9] clk: renesas: r9a09g077: Add SYSC regmap support
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

On Mon, Jul 13, 2026 at 4:54=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add System Controller (SYSC) regmap support for the RZ/T2H SoC.
> >
> > The RZ/T2H SoC features two System Controller (SYSC) blocks that handle
> > low-power management and access control. These blocks are defined as ch=
ild
> > nodes within the Clock Pulse Generator (CPG) address space in the devic=
e
> > tree. Implement support for creating regmaps for these SYSC blocks.
> >
> > Register the regmap using of_syscon_register_regmap() against the CPG
> > device node so that consumers can access SYSC registers via the existin=
g
> > syscon phandle.
> >
> > Add a sysc_init() callback to the CPG/MSSR core to allow SoC-specific
> > initialization of the SYSC regmap.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Made use of for_each_child_of_node_scoped
> > - Moved sysc_init() to the end of the probe function
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/r9a09g077-cpg.c
> > +++ b/drivers/clk/renesas/r9a09g077-cpg.c
>
> > +static bool rzt2h_writeable_readable_sysc0(struct device *dev, unsigne=
d int reg)
> > +{
> > +       switch (reg) {
> > +       case 0x0000 ... 0x0008:
> > +       case 0x1000 ... 0x1164:
> > +       case 0x2000 ... 0x2024:
> > +       case 0x2030 ... 0x2054:
> > +       case 0x2060:
> > +       case 0x3000 ... 0x300C:
> > +       case 0x3100 ... 0x310C:
> > +       case 0x4100:
> > +       case 0x4200:
> > +               return true;
> > +
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool rzt2h_writeable_readable_sysc1(struct device *dev, unsigne=
d int reg)
> > +{
> > +       switch (reg) {
> > +       case 0x000C:
> > +       case 0x0034 ... 0x0038:
> > +       case 0x0048 ... 0x007C:
> > +       case 0x0100 ... 0x017C:
> > +       case 0x0200 ... 0x027C:
> > +       case 0x0308 ... 0x030C:
> > +       case 0x0320 ... 0x037C:
> > +       case 0x0480 ... 0x0484:
> > +       case 0x0580 ... 0x0584:
> > +       case 0x0680 ... 0x0684:
> > +       case 0x0780 ... 0x0784:
> > +       case 0x0880:
> > +       case 0x0980 ... 0x098C:
> > +       case 0x1100 ... 0x1118:
> > +       case 0x1200 ... 0x1204:
> > +       case 0x1400 ... 0x1484:
> > +       case 0x1500 ... 0x1584:
> > +       case 0x1600 ... 0x1680:
> > +       case 0x1700 ... 0x1780:
> > +       case 0x1800 ... 0x1884:
> > +       case 0x1900 ... 0x1984:
> > +       case 0x1A00 ... 0x1A84:
> > +       case 0x1B00 ... 0x1B8C:
> > +       case 0x1C00 ... 0x1C8C:
> > +       case 0x1D00 ... 0x1D8C:
> > +       case 0x3000:
> > +       case 0x3010:
> > +       case 0x3020:
> > +       case 0x3030:
> > +       case 0x4000:
> > +       case 0x5008 ... 0x500C:
> > +       case 0x5020 ... 0x503C:
> > +       case 0x5100 ... 0x5114:
> > +       case 0x6000:
> > +               return true;
> > +
> > +       default:
> > +               return false;
> > +       }
> > +}
>
> This exposes a lot of dangerous registers.  Aren't they also exported
> to userspace through drivers/base/regmap/regmap-debugfs.c?
>
Yes they are exported to userspace. I'll drop it

> > --- a/drivers/clk/renesas/renesas-cpg-mssr.h
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.h
> > @@ -178,6 +178,7 @@ struct cpg_mssr_info {
> >
> >         /* Callbacks */
> >         int (*init)(struct device *dev);
> > +       int (*sysc_init)(struct device *dev);
>
> I would rather call it "late_init" or "post_init", as it might become
> useful for other purposes, too.
>
Ok, I will rename this to post_init.

Cheers,
Prabhakar

> >         struct clk *(*cpg_clk_register)(struct device *dev,
> >                                         const struct cpg_core_clk *core=
,
> >                                         const struct cpg_mssr_info *inf=
o,
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
