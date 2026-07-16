Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C43FFFB5
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197711; cv=pass; b=FX2bZGa9kMqzFmZRNUyFKQEMTTvpAXmt7N5QAyUJ5uLq8EP5FSAcnS0n1eXoB//OdRi5DfdyN38bsVdSfTl4YL/k9qcEBhDIWZISWBtfcPLZnGXBpHde7wuQaLmEnbcy5Dvlbk+ulaWV2N7bL3i3418em3GMEchfBelkXG3ZSBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197711; c=relaxed/simple;
	bh=9CMRtIwZMesVCw95SzVrTvn4z9Ju3sAFefPlV/JvBug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJDbswJMwIwXn9bv20DDU5OFNevUsjLoGfv8BreKPNquCBsO2C3gqwhe8+uGeJNrqp3EpCuIOJnPwJ7gD1frRiT1AUGCE3zcgfFYftDrCt/2L4sQsutOpj1bLS3FBYDZ9Q84tiDRxm87DAfLgc6VtQJorJzlVnjxc1Li8YCS/E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYWAcsUn; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYWAcsUn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f365afc5aso2649582f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 03:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784197709; cv=none;
        d=google.com; s=arc-20260327;
        b=hpeEj2IvsnvaR+WUYdfv99CP3IzSoQsOcWMoTdky8r4Jw/sPfMqLv4uylc/LoFqSd2
         WAxAkkINhHxSoUtvB8r06MOnNOeUHflgSMlC1EhJZtRN/ewQ7airaLdWmhN18Fn2DCF0
         zRtQ+1VoS0qOiq9PqKMFG+GT0R+KIhVUm1UUugLuGj+Z49P1U17ruwepC2BND5Ho4xUH
         Aai+Z2Dtl7q/Dqzu9kPLuhRYOEvcXh7CCPKcu0kphlshhVRoPq/sPcxQylhk3MjbV+z8
         j6vMP3XrJ0VcF0t+A8Ot8UH99QSdNeW19s/w1CnvV669G75mfTgfOKsOyK142dWBD7da
         VF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KOI1yzxEWrrjiX8ttD6p732AnDLyZgUaLXj0s48WNY=;
        fh=rZ+n26hdTguBlK6FTTORaZ1rqAXTBrTsdZ/+/+Q0x2Q=;
        b=ZWcI4k+Rok6evcyNM5ZPyQhX6ZOYJLFzfu/wVsHPVij1QzxXv5Qk/QavN+9CqCky+C
         7M/On5EGE+Bx7tPKn523R73Yl3MznHaSNwvmaqKtkyUwYlrjNlOHgyT5w7R5pSSGYmlJ
         SWihgnhKo+yE8NHTdn77+SxEk48LvOiUMmxUVfVk/2K4AzJWNAox8mq8K4AqB9ke8mcA
         dvOEvfznLy9CxWJHfpFlIWMBMhqMmNajl9AVgjjXRc+gZ1bJoMeQLxwCmzO4S8LRyFV8
         r2PdFyFMQLcHSweNpdTpOr7WX5fxm5YIbZ3rbHoeo81NsZM6j3W5PWWNMkbt0zvMqpqU
         eprA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197709; x=1784802509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KOI1yzxEWrrjiX8ttD6p732AnDLyZgUaLXj0s48WNY=;
        b=WYWAcsUnVdAwqOs5vyUxESIrESaVcvK1AzNtEF6hYOTLm4fEEgRiMCNGfop6hq2GvF
         0MBVKl9gEuvgzQZ0d8GMIY3tWdPE1hfWyqGEszJa7SKrDK3cKJ3Il67CprncRpkncFSK
         yxeCZ7K2DJULFP045p5gwD1eQjTczqPQOyG02VWbsgRK564EYH6va8fXIbT8tWSdnxsY
         uUUYjN2bKpRoFBPb0q7aNM6e0ZpuOp3Lho/KbPFsqqillaKynFr24nBDRg61DAfMIS/Y
         BljKPs1Nxin3pb9sieHzMCoJnFQjFsvB4GhMVAkTGCzNwJrMUUfC7NtDUJJBPrzJ2/Ks
         YtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197709; x=1784802509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KOI1yzxEWrrjiX8ttD6p732AnDLyZgUaLXj0s48WNY=;
        b=HIXgcAkEdY4qWxBTLY6Cr1/jI9oU9h7LmL91hjPb+lsdy/xF6SiqgSCtAYW56elQUX
         6PGUTm4QWYdP8OjboM5ZY5/F/9AmjLTRWtSxuN1Qx/lv9ODYztL3SdOQfXAYqK1ZB8C0
         5najbtJaEH30pwvdFgWou7e9FO/CyD7W4TS5Bq5o3IqOjXXTW6IsJDmDhhI2dc4J7Uwq
         NDs8vNV6G1PPGdlhnnXmDIo4oz/JY6MOtLebdEysRNgNx3rlcfLkgQuyYuO9w+P1scEu
         /MuAx6XXBGqJPAjuh9AloPD3cyAVgAjq15gxgDecg5CIX6xV2+FU2aujPuYM/0CQcYJj
         qtYA==
X-Forwarded-Encrypted: i=1; AHgh+RqZOSHDC48Vn2N+FiliooxoPLAYeTWbbY18IlZSnHa9IcOB4N323sMEtdVEK9zA3DNRy8beEbDmOy75HUyOLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXECpqkAfuF2U8ZmAu9NkAzUqua9vabnqoZlDLyl0ArcGaFCJ
	48MEdE54V7ar/wQiI7AcWuUEr9Ge9UPpGDBXLIaQdfjCEIdzFA6H4NHg04BJDnVcRU+j4VbQ6/V
	Byp/uunCpQsT1o3vubDRQMvvKgN6bZ+Q=
X-Gm-Gg: AfdE7cnOsDnY4QfsYkNBCoEOARRpennQnYhnoeLTclPYRX+TW22qOCbPa9/LkZuZhqq
	unqhD56zxHR30fBg6QzFzC/ZI+/GKkCsKrQMLJg95zG8PpmRrOO22iojZJ4GD5autacrsltYfnd
	K03JjptUNbj6+VcfX6UknIf90quu/GOfdNq6JMNUewGo1VpS3OnnAkP60BQuhOCMgi7E2bfNy5w
	HTL9TzmC/AeEeMz9hLtUFg/yZ45KmcNFW4V1KpCg3+UYEor9SE76gl4bFMtasAwx72DdN7DUL45
	eUO4aXzChmDPv4Vs0eM8xr4Nz6bEAgTlwx4GjZSJZO/V0Q==
X-Received: by 2002:a05:6000:4a1d:b0:475:f0c2:5afa with SMTP id
 ffacd0b85a97d-47f488bfd4dmr12527545f8f.48.1784197708365; Thu, 16 Jul 2026
 03:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
 <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com> <CAMuHMdVQWnp3ipR8xLv3PBVax3sDrZeoH6uw6Cjygf7EZT8EgQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVQWnp3ipR8xLv3PBVax3sDrZeoH6uw6Cjygf7EZT8EgQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 16 Jul 2026 11:28:01 +0100
X-Gm-Features: AUfX_mwAsz7gRD0YYf7KOaOpLk2KMZANDyil4268FtHPqCze6MPfCsZ7dyXCIpE
Message-ID: <CA+V-a8tjT8bSy83FcOypSjry8WoVN2w=4hp7yBWNEH0mx_kj0A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/9] Add System Controller support for RZ/T2H and
 RZ/N2H SoCs
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

On Wed, Jul 15, 2026 at 9:54=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 14 Jul 2026 at 15:27, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > This series adds support for the System Controller (SYSC) blocks fo=
und on
> > > > the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical lo=
w-power
> > > > management and access control functions.
> > > >
> > > > Hardware Architecture & Dependency Challenges:
> > > > ----------------------------------------------
> > > > The SYSC in these SoCs is a multi-functional block responsible for:
> > > >     - Clock & Reset Control
> > > >     - Low Power Management
> > > >     - Clock Monitor (CLMA)
> > > >     - Access Control
> > > >
> > > > A key architectural detail is that these SYSC blocks are physically=
 located
> > > > within the CPG/MSSR (Clock Pulse Generator / Module Standby Softwar=
e Reset)
> > > > address space. While the CPG/MSSR driver is already implemented and
> > > > functional for these SoCs, the integration of SYSC adds a layer of
> > > > complexity due to a cyclic dependency:
> > > >     - SYSC requires CPG: The system controller needs a clock to ope=
rate.
> > > >     - CPG requires SYSC: Access control registers within the SYSC c=
ontain
> > > >       bits necessary to control the PLLs managed by the CPG.
> > > >
> > > > If implemented as a completely separate top-level system controller=
 node, we
> > > > would face a cyclic dependency between the CPG and SYSC drivers dur=
ing the
> > > > boot process.
> > > >
> > > > Proposed Implementation
> > > > ----------------------------
> > > > To resolve this, the SYSC blocks are represented as child nodes of =
the
> > > > CPG/MSSR controller in the device tree. The SYSC regmap is register=
ed
> > > > directly against the CPG device node. This hierarchy correctly mode=
ls the
> > > > hardware address space while allowing the drivers to share resource=
s
> > > > without deadlock.
> > > >
> > > > I am sending this as an RFC specifically to get feedback on the
> > > > implementation of the SYSC as child nodes of the CPG to resolve the
> > > > dependency cycle.
> > >
> > > Personally, I am not a big fan of subnodes.  I assume you are using
> > > subnodes because you can register only a single regmap per syscon nod=
e?
> > Yes so that the consumers don't have to specify it by indexing.
> >
> > > Would it be possible to just extend the existing clock-controller
> > > node with two more reg entries, and expose them through a single
> > > combined regmap?
> > >
> > That should be possible. Or would you prefer just to extend the sizes
> > and create a single regmap for it?
> >
> >                cpg: clock-controller@80280000 {
> >                         compatible =3D "renesas,r9a09g077-cpg-mssr";
> > -                       reg =3D <0 0x80280000 0 0x10000>,
> > -                             <0 0x81280000 0 0x10000>;
> > +                       reg =3D <0 0x80280000 0 0x20000>,
> > +                             <0 0x81280000 0 0x20000>;
>
> Yes, as they are contiguous.
> These registers are not accessed unless there's a user specified in
> the DTB, right? So there is no issue when booting an old DTB that has
> the short reg blocks.
>
By checking the size of the resources, we decide whether to create a
regmap to maintain backward compatibility.

Cheers,
Prabhakar
