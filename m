Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CC33688A
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035654; cv=pass; b=sTbABkIW9sgWb+lOo7Ci1FB2V5QbtFmtahsDR1lLFfz6iRTkaM3o4ZwNUhxacgW8r7ZRVMooOYrmMB8HT8t7Rp3h4eUyFWxOZ6UT1JQ1NfK33mjEmfaLlcqMeNAOPnv8095Mk3ujybSsbeNndnnwfE13jc+fppSjh2mQsX/edhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035654; c=relaxed/simple;
	bh=JwVJDiR+cBjS+r4fEWc8OMyrK+FkqxIoisO4S0dbaKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXR8dd/K3qKiIknaKLp+v3B5vZCb3swlTl51CColBS+JZZpKFVHvoscVXMr/7pfHPOAMWrO05DsV3Lt54aIDThSLOF5iy4PEsN1n1IHOTZrw0EiV72Ey+Bw/kwRRWcYACwIXsp6dP0+XueyR+3/e4rvQAoz6/tKD8nmd2/6lAUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd1aObQl; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd1aObQl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472326ca506so3534235f8f.2
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 06:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035650; cv=none;
        d=google.com; s=arc-20260327;
        b=epFNY9QjyacgLRbg4s3kTj6B70zOPnYo9mCuwKlxcMpNjD95Zqq6y/TfYoKS/w8If7
         szi3xRAQFnHT8hYlvePyxbxC3ydo+KzEuL8EKN/U16cSIEzgDKC5E7YioQ/QAMS5q+U3
         eh9QDOLseuALZrKyse0iDmDnURkncGCJv30YDv+8eLZwn8qX/5ZVGwsJ0T0Ks2e6+qDr
         IP3SvIzQoj9YvelaJBtNFvRg7S/KfArd3/L0ITDYWEs0Bk12bvU1uxMS64dU9B/kWzKa
         /1Xgs3xtC7thK5UEvZnusw3Zv6vkOwLQ5QSxNUn1VITU5cx5LQsWgVfCPZGeJuzPz8qS
         lVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WRj5C4BZ8aUAwy0UDz9tsH2p/apYNMhkYQtruEiLUFg=;
        fh=Yls0s3ExlMjqR5l9H1Jgx0L8Mjw2fPgF0K2daSTqyBc=;
        b=d++Eh1oAU/+hcyxGtvb5h0Xct2SU3z0m6du2YgBlgT3qKJ7vjC9YgY1zKkZgedYbSk
         1lyxEmhoZF8EzrpENE73UCWVyDdDbcQZcGZkOMEj6I6YNrT7ZYyqSsnH8UX4by6cV3vG
         0n1vBqKbV9P1zXOayL3kGDAY+VKUoOVJcBdKh5DKowbJKa1ucbawbsJQHgj8nYo1tRbZ
         oJRP9w9sEpkxZDIwM4vGjmLsKTziBnNkU8LObTaLVdxUJOPnlULTG4SvPLyRVCg82Kuf
         BZbgc0ZL+amxBFUXQetIWy3vui+wWRShb+asrQLDntDM3y5NE76ffiCpX1yRG7yKQvXe
         fs1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035650; x=1784640450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WRj5C4BZ8aUAwy0UDz9tsH2p/apYNMhkYQtruEiLUFg=;
        b=gd1aObQl+qjxD929Ebl9GEw5vMjRAD5Ra9FjKX70snWGrmmHxmsnIeVpMD18Erdzkp
         UKkux6CpyLniULXKsfExXEZboQQVJkbJeBHN/C8OmQTYdq7wSEDnf5sj0EdAIX1xDPWH
         45N61XtWPmVHa1wbOEUhCtCTfUfV/BiihBjoUjZMsm5ffpc4a+NttdzMekEBufsYzzYM
         q9lRJ6931LUKwD/wZDr8+ZkavKK7+vUJX0St/6vsN9ETG2Fnr4macCZxiosPf4iC0Ojh
         YMF0QbXrxTkWmzl5LCmZkvMdEteA7C0TWqyYda1VrNJmvlxsro2+WdSFl9sW0dDvtlJh
         h7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035650; x=1784640450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRj5C4BZ8aUAwy0UDz9tsH2p/apYNMhkYQtruEiLUFg=;
        b=qUIj8l8+UQKW73tB/KR99pVEjZSQ6NuYXREF7WjgG9Br2TMvZ5yeeTM7rzICm2L3ud
         PVzhRYXSzFVboJ8IJkKWr+nL1CbVNrABeJZO5TyUvHW9h4lMdUpO2nOP/467t7OKYdkP
         TuOazqv3jeldgp+oM/5Qtnzn3iSagUBB3TpJoVx7P0dI7VPqLRs6MBS23v2m0QYarBma
         7C7UVup/zVCn4D1uqaebzeqEKm9OHRDlRGEkjc9GNVpNlqusgvCEWie0HtV5Tt8xp9Rh
         /jSd3wMuxE0H7GU05JZ/ZqFJSt+MkfjJYjK1U59RVqxVnU0bKeywUJru3knCSIFPZ33X
         PbKg==
X-Forwarded-Encrypted: i=1; AHgh+RrhkCdPmb/6OxYqil0b1JI3cvz0LWFkcfvHeZzud56WauiWkB8SVT8AcO63dpLOPtncThQz+HBE6AApxmCtdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+U0hmj7xvQgWoGICvmdJByiMy441IolYDms9xye5LrIGbu+MQ
	gQ/AeSHsOeRqoClNmjqksK2F2Uqulg28UZ4X5jbJ+vnMepDqv5A2oOZqZkgWR4JQCZ0gWb8TRn3
	B36G/rt4F9asigZRavmJxAlWyfZbh16w=
X-Gm-Gg: AfdE7cn91fhX/P77vxAEXOS+Asp07xK9vCzAACaKi1KC7jkhaEe1i/Pt/d55mUE0hLg
	7hqJi1Ja1UGbRfutQ7zv/kjc1XBCmROHFQ1vX8mPM3UKNNcmA85mppU3ql5cQrMQ+G6VmFnE4PY
	aQaRPqCfvHLgxdS997FcsThAts97aGGbEk5P2kqCvNZXPShfdz9onHOsQAIMmxtilNRFkvh4jUE
	ZHgRCpwjFmM1AMLZdQh1ek1Z8twZ46f1tWJOwhWOOvI1LIoZfgStmpMvPcjVYsNXyDSgoKVxql9
	e6OQQmGxhSypeVlQi1yEkMX36WlqgJ/Nbuj456xuYQyJc+CPEZbjoYXImBBlyQBsViILxw==
X-Received: by 2002:a05:6000:4693:b0:47f:4650:e45c with SMTP id
 ffacd0b85a97d-47f4650e4e6mr3694089f8f.12.1784035649771; Tue, 14 Jul 2026
 06:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 14:27:03 +0100
X-Gm-Features: AUfX_mz-bUh857aZKLRp6jCySBSNe_W4CR-bQsVZRSwNXqRoLizYQlsdmvEfzQc
Message-ID: <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
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

Thank you for the review.

On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > This series adds support for the System Controller (SYSC) blocks found =
on
> > the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical low-po=
wer
> > management and access control functions.
> >
> > Hardware Architecture & Dependency Challenges:
> > ----------------------------------------------
> > The SYSC in these SoCs is a multi-functional block responsible for:
> >     - Clock & Reset Control
> >     - Low Power Management
> >     - Clock Monitor (CLMA)
> >     - Access Control
> >
> > A key architectural detail is that these SYSC blocks are physically loc=
ated
> > within the CPG/MSSR (Clock Pulse Generator / Module Standby Software Re=
set)
> > address space. While the CPG/MSSR driver is already implemented and
> > functional for these SoCs, the integration of SYSC adds a layer of
> > complexity due to a cyclic dependency:
> >     - SYSC requires CPG: The system controller needs a clock to operate=
.
> >     - CPG requires SYSC: Access control registers within the SYSC conta=
in
> >       bits necessary to control the PLLs managed by the CPG.
> >
> > If implemented as a completely separate top-level system controller nod=
e, we
> > would face a cyclic dependency between the CPG and SYSC drivers during =
the
> > boot process.
> >
> > Proposed Implementation
> > ----------------------------
> > To resolve this, the SYSC blocks are represented as child nodes of the
> > CPG/MSSR controller in the device tree. The SYSC regmap is registered
> > directly against the CPG device node. This hierarchy correctly models t=
he
> > hardware address space while allowing the drivers to share resources
> > without deadlock.
> >
> > I am sending this as an RFC specifically to get feedback on the
> > implementation of the SYSC as child nodes of the CPG to resolve the
> > dependency cycle.
>
> Personally, I am not a big fan of subnodes.  I assume you are using
> subnodes because you can register only a single regmap per syscon node?
Yes so that the consumers don't have to specify it by indexing.

> Would it be possible to just extend the existing clock-controller
> node with two more reg entries, and expose them through a single
> combined regmap?
>
That should be possible. Or would you prefer just to extend the sizes
and create a single regmap for it?

               cpg: clock-controller@80280000 {
                        compatible =3D "renesas,r9a09g077-cpg-mssr";
-                       reg =3D <0 0x80280000 0 0x10000>,
-                             <0 0x81280000 0 0x10000>;
+                       reg =3D <0 0x80280000 0 0x20000>,
+                             <0 0x81280000 0 0x20000>;

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
