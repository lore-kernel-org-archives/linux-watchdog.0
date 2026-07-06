Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD63C2BB3
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363904; cv=pass; b=VxqyvA6KqYoH5aoUsOVQvre59P+M26kcIICrWdm0xl6PowU0dPexjohsh27PqGnrAi4B5haqZeEePUH4fseOXIphHsy1OCP9OJNWo8fcZBPilhipKPaKJBOu/kTegJ9frGO2oRqHNLUcvj56StbTuX9F9ilNnzz43JIDMpKe99A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363904; c=relaxed/simple;
	bh=fCdq0lYopj7korz3DO/dq32zkKygeRyx2BE0Wg8f5OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZaWA4EdxX+P6RWDTh5WWpwOBHx6TbdLnIuriCeYP02DOa2zK/Eo6ZU592t7Sbl2Sg9dsPnPbaQHkBpZAmL4NmbpJw72ZrYFwwY6dd2vZT/eHa5unsEAmMHU4RV9ZSFItrCNsob1RVfbgfIcT8Hp5YS/KqE/v4WeXuKdVx+0YAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2DB+V1p; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2DB+V1p"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c2b3dc8bso23373405e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 11:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783363900; cv=none;
        d=google.com; s=arc-20260327;
        b=IYk0Skkhqpx0NO03wcR/MGG7MvelS8fdN5O73QzON9O7dhW7w6KXq6MkT1Bm3FzpAy
         fJoF68BLYOpyI2/VgMxtg/TDDhAc2wHVTx2ZRUKpj3p7op7LULmU18wVpM2n1CmXq+L2
         vN9mfS/kpT4ooulgt+wW5dNbfJqi8CVKY4YbfVDoePzMcZF2eyHA1Defobbr+sybJ9Cz
         etVSX5euU44Oq3o3+MSM9AndC9z5WnPnqX0E3yp7crq+Cjn+xKo1+xYHJILvXGJmO11M
         BeHxEQ2hsX8dnyz24mEpegiEU2KV8F0AIWUp/6I1V+UWGGy7cOr3nlJCQxzBZd5laBjr
         fEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/CSAQ86wMiX5Gp6AT84n1QfYe5hGWs1YjlnFkunec7Q=;
        fh=QZWuoU3vZUqKAkBd4m2iF82nXUjdWMmZ/T9ktIFmvG4=;
        b=eQwdfbGtgsKfoS4xnWp0lQroGAKELwentmYNS1Ppua88Sul2scyRcSjckdIQcTDpcL
         LCa3ADvQGsn+KqpM0VuFRznNNqRKZQ/dvp3wxz4baNH1UPJPMONogASFEPh+lpJpHagP
         It1Yq6FPtsSXmUhT5FWQ8xqgE7UdvU1R/Y5VN9LRBqlu7bli/FAf6z/avVmDxWJNjotV
         oGnyUJNkG34y5hBAguNFADpuVPYLIF/6IA1hCrXZnC1LiGVl5OxCNeqY1Kmsp4Zc8Ob6
         +e1FleXYnCsD/Kqga384CtU8vvufYohygw+esuER2Yf2Op2dIJ7OalX9o088Q9F6m1v6
         kX4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783363900; x=1783968700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CSAQ86wMiX5Gp6AT84n1QfYe5hGWs1YjlnFkunec7Q=;
        b=D2DB+V1pu9VZk76gbHmhZs2FWtDSxbjxD+6jk2xSBrzpA7nzl8bqO0aKfE4303aiaz
         3D9r+dis1GGFTHWYfnRfvnZGWQX3jYP0+iqKGWsYowGxafGoUOqWh2NhTNgUJ8H6vXqP
         qfQTFVBcm2UYE/nTJyTm2/E6kr68K1nIhPsZ3wR6ePFV66jqa+sEWwqvItsKYgr4Zv63
         Ik6JoFB8JxYhhN4mwBlNM9lFOUINzhgYN+Zy7g/HpON63rEZ0hiuzuUaB/sRfM6OkYfT
         bnO8xc+NI6TuiuRQui6d+XcjupSpez2q5AjaYtWi0i8+Khha5e5GhyB3lirnGjubuYto
         Tnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783363900; x=1783968700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/CSAQ86wMiX5Gp6AT84n1QfYe5hGWs1YjlnFkunec7Q=;
        b=O+Afvffc9aiCl2l7vPRh4vxpyuG8Y6S4OLFNr7pqAxZ1eipOg10x865MLV8pyhuFLJ
         PcNQGEWPfkfuXyJ3EivWAw/Ktza//56OqS3DjRCI1AvlIfBgZ3kUgkD5MPDZZ4sUbei9
         AYhkEA7SXMHSOPC2cj7J6cCZ2UcAreFKV0FKVqxUzG1vpSp241BcPBc7A8ZlRCIN1Qc7
         Fmm7pBovjy57OaqkF+34ERyFDRWbfJZwQ1LLT92pmA94boLkz02w0yGdz6qw/dxMJCh0
         T2MCFB9n0xGvdGdNYFWVPhZAEDCfkArj3C0H3bNV94f/OVs6ypRgErbUKv85f29JVBXZ
         qCWg==
X-Forwarded-Encrypted: i=1; AHgh+RrSF2sI9SZpYrXm5rWeCdGMs9Y4z1+y2S6fXKRekZSXVepueO8Cz+e04V3nh/CUySc7IDVzA+VkaEWSvl5dKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmifJsJ4gVvoj0MYxieU0u9KLO2Rr/PEAPMzoRwkBnYzKezEA6
	rDD+2IgoMYHmQJoSjWyhBPzfxOWOYx8jntaUrywAmHDdHMjiReS9Hk0GxW1+dxd6D9s0mXVbxi7
	coLRdQoQ51ZC910NMdmZ+LzytnN1pTCA=
X-Gm-Gg: AfdE7cmDAeXfIQhxvKoR44147recIiylhfHdY5VXRZ7rz9hbH2udkngWPf6AXJ9WD6w
	B0PjnYbkAjUIWpVmt5B1ng6KnCNbyXbz7TahH1v6DpXbS/kVzkI8xF6zNn0iVIROQDqDfHIUWbQ
	kBb5T84OBL8bJn4GN+O3bpD75Rv1FjAuQ3rozjAB4Hh42DIWI38s9M9PVXGzpig8fyVeZUWn+OZ
	y8sHIyTNOC8cDue5hp0Ry34F6kqNOsnEUNa/fyag7Bds05u4+MRIg7FwpFyze6ZUwf3jI1CmTX8
	o76zXV2e27Vquqi1NROMlnIdZYBO6gedxQfvOqKuSN7EEZuVXhJxKIoGNA==
X-Received: by 2002:a05:600c:4f84:b0:492:5030:5e7b with SMTP id
 5b1f17b1804b1-493df06a26emr18953135e9.10.1783363900368; Mon, 06 Jul 2026
 11:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUTDRkq-WaXNxGzBLAEY90cn1i_-UOuDkS3PBs3xKooFg@mail.gmail.com>
In-Reply-To: <CAMuHMdUTDRkq-WaXNxGzBLAEY90cn1i_-UOuDkS3PBs3xKooFg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 6 Jul 2026 19:51:13 +0100
X-Gm-Features: AVVi8CdhZOFc6S2n05FV9nlTvx9urpSzJPBcWirnqMlmue__2oziyda_FreEG6M
Message-ID: <CA+V-a8vxjms+yqzO_sfFo19nMAuhZ5aFSuBsy1Hm+0PLFio3KA@mail.gmail.com>
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

On Mon, Jul 6, 2026 at 11:08=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
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
> > +static int r9a09g077_sysc_init(struct device *dev)
> > +{
> > +       struct device_node *child, *np =3D dev->of_node;
>
> error: unused variable =E2=80=98child=E2=80=99 [-Werror=3Dunused-variable=
]
>
Oops, I will fix this in the next version.

> No need to resend yet.
>
OK, I will wait for the review of the other patches too.

Cheers,
Prabhakar
