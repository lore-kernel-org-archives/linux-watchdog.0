Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A440315F
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197753; cv=pass; b=tIBCbc94dfybVahTfDngtsx/mbden3qRNt67LfuWH/qM3naA1HhIB5f74Zs5ot6Jfzb5n/9czeHnO7pVIoiTw3I5aNIu8Pw6tjf1jzXfGJPr9vE/fC5u5AcZWtywyB6Y4gqGrdP8/cXNGkzP9B940eRmosLbN/8JO0ZmByEeAlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197753; c=relaxed/simple;
	bh=zfnHsn+znD5AFRoID/3JHCX/8uoL2W1bVn6UdULEWAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLF2hTLWH0OT32shPLD+cZG+fMUkmKlLf3WCJi4Iff3WZGycfzEjR8+ipqQkwNOfknFwbZ5Y+3+ApXODuVwYWa2NN6n0q6ts0ZSpiH7UKvcqN/bWUTH/ORhx+mgOWd37tZmG8/HOY3CNJfjpE+k11a1STJQWPyrqNk2H0DGkEhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/+X0VT0; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/+X0VT0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso3755543f8f.3
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 03:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784197750; cv=none;
        d=google.com; s=arc-20260327;
        b=lkV1fP+z6ihiXMI0vBgfk02meUBckyU98NdXLknGcgPdJn1asZyzwd2iVzI84WuWjg
         t0Aia6iw18XQTDsm019XA4M1hWax7ou1XYu+iyVPvgOsLG9BY3OwnFczoYh127mBox/z
         NBmGCuGYOnjws0+iCN6HoFblOhNFnv8rWPZtT+JI7Kw5F/vnRpJgLhQZLqrOctVVL84X
         fTNmOCeYWoYhQ9PehV9ko1IRaHk7jAMsFhrdVSJ89sZWBD7nGD8g/QFVM52OvZXMPj+s
         bvU619g6au8qutGgSB+FYs3ZXuqW7czydSlwZ7CdoACwLHzcDn/L2dOK3/LIVkGrI1CJ
         nYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F3mAXX4i2+9mnOYdzawa2y57JdnamEA+dV/8zm0oM7w=;
        fh=LiaBvx7o43loibsrG36Ih9EawiKyaKTuWhsLzS/XQRM=;
        b=sJtDCC67JV7kXLyiCfdEwvCuuuf/cAnxepyIZu79iaDZ4sJRh8arYcuKKTE4kqWzIN
         Pbf/TbYntuhXyVnSznKCeoC0WxOYL9tUtA1feLUC+wOsx+yy/r7s+piG9T7Ek5OeoWby
         bTRdGNgm+7sT+OjB9lyT3njA9xiSX8zZhYxAA4HK7Q0SFFdW8MBFKDIlJYaEAflpBDbJ
         Nm7r61y/uZlrPbMKxQonNIU+8xG0w+RiJChZqAOF1o9uLSpRIcbFTIOMCzhKvSpQO/+f
         e6Jx8YCq9feXvAJkcJMWGUuSQXV115kjUmxaRVgn8sWEvJzDMnyavbJp18WgZgooampV
         FOxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197750; x=1784802550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3mAXX4i2+9mnOYdzawa2y57JdnamEA+dV/8zm0oM7w=;
        b=h/+X0VT0PvFQvWnZ7Ol74Iq13RC3boYXbVXtNh8irtf/YdGyvxLRzUB4w4uiy2To4/
         a5VGh/NDKx0XIBj4I9bTI+tBCS54GGoOwZLvdXWnOnSGd6yjCL4pAYmpND6U9wZ3SYfE
         7zv3dl5jw73DBSrJ6KabTuCFvdb/QEgUXrfa3CNzaKq/80rYJeg/Y9O8sr+kMwRjssmR
         9zu+a6/7f/rifiv31eOoA0N7bmfPIb4EtscWoAu2yV/fiIXIou4UclRRgS2c1DoIy+dt
         A6VCyLplrCX7vSmxlovU5Hg2qJvBZ9Jd9ADm4MmXIp9d+DT1yt0G0dAq4UMV6Q8LJ9B0
         Xxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197750; x=1784802550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3mAXX4i2+9mnOYdzawa2y57JdnamEA+dV/8zm0oM7w=;
        b=naiQSAhUz1WVzV2X4qOI2hIh+tztf9M4PsMCQR3/U6vYSnPTzb5YjUSvvRTrLz00Fx
         /FGJ8cKuHJ/bKNH4GV/yjt/F8OpiEiXm5rA61VS3IZ3QIWiDMOZoZQ2XWGwG0L9GmSfn
         ybO6Nn8WCaLXnHP3TeRSm1zvyoh/GbVf9vy0Qt0dfJWKEqtcV2qniD4aJohD6N2lVkhw
         aM9wP/YwajDpqi02+JcuA3S8/ahldKJtmYsYEpRCZeYcRPjCMmdS2VuY70bXxhFPqSRJ
         8cEc2syZI5hZDmWSYqjJhjYt7bJZ+OC0FwUTJegdb2q7+KUoi1bb1HyecXD0Xhp1+v2H
         uHUA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2fRug0OycanYjaXrPEw3ftDN/Jfbopjb8RhL1zybPXH2UPhsbjJ8z1H29syj4+WTWu5o+k6Yo3MT+AbTUww==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4caZwjpAjSbPlizPPKdxhStiESyIjl55j70mAVKXOXwQYg24
	jTncc+WAk4o5jrjPsuuRJcMpKuw/6Zf9jWtvyv3k6B6k1L1EaAZsVcRXGa4dQSi5LmS5ms0mtIR
	Q8T4VuB6QFVR3fJga23gftqjOmODUU5s=
X-Gm-Gg: AfdE7ckQrTQgOM8GuvBg3HK3KogOgE/LE2QtSAuTIP2xEs+wWw6i9aPFIeiIAHfX+wN
	8LuV4R5niEYeMkuR8qeCWEj2Qh7gEZ+ZCQTe5C7oJ0iS1977px4qfWuHVksxFjLW2KXxkrb02H8
	dnT3FWPYWEtajRaZqNOxURrIYAP0obcCbyZk6tj9h/rxwxCUzABqeXFoQ3jwRpQnPe2/KjCdN7r
	8Tj9JVnojVMslxqqF8fO4xytTR0pEFy+sSR/ISTQYo8Xz0phPHIZurgeSSOoCpg6Qa0P+sSSdv2
	d/kDNpg7Tyu4HxO6ZhebRKbUAo9IFhfWl11fnR/PU8mtEHal61SRgX5P
X-Received: by 2002:a05:6000:2207:b0:46f:7d90:811c with SMTP id
 ffacd0b85a97d-47f4885699cmr12314144f8f.13.1784197749926; Thu, 16 Jul 2026
 03:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
 <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
 <CA+V-a8utJuuwVNy8o2zM5jHf9qXx36S79uKGtYr5O=sASh_wpg@mail.gmail.com> <CAMuHMdVT-wWtJaB1bHR3CjfjEGhVfWWKrs6YyZbahOTFSFK4Kw@mail.gmail.com>
In-Reply-To: <CAMuHMdVT-wWtJaB1bHR3CjfjEGhVfWWKrs6YyZbahOTFSFK4Kw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 16 Jul 2026 11:28:42 +0100
X-Gm-Features: AUfX_mxnpT0eulW4NwRS30WvnQ9rPIX7xQABv4l_7unRYg0H_inTZ2rnzW_HB84
Message-ID: <CA+V-a8sxPmhEziG0NmL2VdXBOS75fzLPEVq3md7Hm9y8iCtp-Q@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 9:56=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 14 Jul 2026 at 18:51, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Tue, Jul 14, 2026 at 2:27=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > This series adds support for the System Controller (SYSC) blocks =
found on
> > > > > the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical =
low-power
> > > > > management and access control functions.
> > > > >
> > > > > Hardware Architecture & Dependency Challenges:
> > > > > ----------------------------------------------
> > > > > The SYSC in these SoCs is a multi-functional block responsible fo=
r:
> > > > >     - Clock & Reset Control
> > > > >     - Low Power Management
> > > > >     - Clock Monitor (CLMA)
> > > > >     - Access Control
> > > > >
> > > > > A key architectural detail is that these SYSC blocks are physical=
ly located
> > > > > within the CPG/MSSR (Clock Pulse Generator / Module Standby Softw=
are Reset)
> > > > > address space. While the CPG/MSSR driver is already implemented a=
nd
> > > > > functional for these SoCs, the integration of SYSC adds a layer o=
f
> > > > > complexity due to a cyclic dependency:
> > > > >     - SYSC requires CPG: The system controller needs a clock to o=
perate.
> > > > >     - CPG requires SYSC: Access control registers within the SYSC=
 contain
> > > > >       bits necessary to control the PLLs managed by the CPG.
> > > > >
> > > > > If implemented as a completely separate top-level system controll=
er node, we
> > > > > would face a cyclic dependency between the CPG and SYSC drivers d=
uring the
> > > > > boot process.
> > > > >
> > > > > Proposed Implementation
> > > > > ----------------------------
> > > > > To resolve this, the SYSC blocks are represented as child nodes o=
f the
> > > > > CPG/MSSR controller in the device tree. The SYSC regmap is regist=
ered
> > > > > directly against the CPG device node. This hierarchy correctly mo=
dels the
> > > > > hardware address space while allowing the drivers to share resour=
ces
> > > > > without deadlock.
> > > > >
> > > > > I am sending this as an RFC specifically to get feedback on the
> > > > > implementation of the SYSC as child nodes of the CPG to resolve t=
he
> > > > > dependency cycle.
> > > >
> > > > Personally, I am not a big fan of subnodes.  I assume you are using
> > > > subnodes because you can register only a single regmap per syscon n=
ode?
> > > Yes so that the consumers don't have to specify it by indexing.
> > >
> > > > Would it be possible to just extend the existing clock-controller
> > > > node with two more reg entries, and expose them through a single
> > > > combined regmap?
> > > >
> > > That should be possible. Or would you prefer just to extend the sizes
> > > and create a single regmap for it?
> > >
> > >                cpg: clock-controller@80280000 {
> > I wonder wether we rename this to `sysc: system-controller` but the
> > compatiable string has "*cpg-mssr" postfix.
>
> I think the current name is fine, as clock control is the main function.
>
Ok I will keep it as is.

Cheers,
Prabhakar

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
