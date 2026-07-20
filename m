Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CE3F824A
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546059; cv=pass; b=AQBpD0ScVsxCjUOesu2AdchR1qAD3Aw5KLNeV4lp30l80inGnczvBToa9vhNJKbtGy2bs4onNFhUatyBYw4p2GvpC8rIhUO/ZMO0gjesMriqQmJap7/fzzAqp6/uj6qmIL32Se2pNuVb3DdFVO4GTOBUv4g3ito+v9+Mv/Wdkzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546059; c=relaxed/simple;
	bh=lN5CgOEVOZ+tQXbZyCc0JqrYccxDAnhxj3hOkyWwzFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2gSC06SN6yTZ6oG0YHUMBwssI7x2AnNxYroF6PeF6W2mDffk/WQlZgfRDLoUGNgKdg7KP6DhdckuAOxMBScYCzZz9xUFaAbnCW2xxi8+AIRFJphvE+SkVzQ8Gm4+0U2giX7WxJcQ73/NzZ8lCk/XxxH9b/K3h98L2C2edyBX7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/SxvIXK; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/SxvIXK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7854678cso331240f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 04:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784546055; cv=none;
        d=google.com; s=arc-20260327;
        b=SRtmC1ZTLCRGEoCHNIW/gEH6CL9uumPA46MDg0OkxxXcjfTFWO+mEYfXqpb5linG61
         kEPF+9DUcax19ox3LvH6QKB1LG8q3aGjU2tKfpTMOSXvEKxM+8oxjiJNNJm97o/UbaOG
         wAo/B3ZkMaCCBHi1386/BmNWw3rFx3Xb3AoaLCe+k5onmgUZApwVxqo7Vw2qoDfBW6Iq
         FteXOsAc7N6nr9yJjdLIB4t7ymEF7r5ZP7+45d+rCiw9Ba7qs0ys9zUDslx3VYWZ5mdI
         YI3X9RPeNMwF/AUwWNXQT8uCcMP13uDhmYRZKlLvVTIb8RlO1SS7OZ/so2/BBAuWfor4
         z8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lN5CgOEVOZ+tQXbZyCc0JqrYccxDAnhxj3hOkyWwzFk=;
        fh=PLqPVLiCDKG+fXC2CN7etgqkhfJkzDXK3ZOOIbCom7w=;
        b=UqLpSxa0zAhIdIB7l5YWZMdafTZ+kX8oRRVR7QG0wnaoExIUrzi0vMzJgZhywF4BAQ
         +NmuNBWSa2fD7Il35azXf3aRsEwzx6ueZhTTGiB1QU4T5QoXXYUUBYxN40EsJvoF52q4
         PBC6WAfF9H/7PUvUP4uTsuI0aLS9VHB2sOZGQt6RkyizvfpIb1riWa8DFe1bsAEDCOa+
         tTYJOOD5igMKNxHwTv69ra7vpOvmfgvenjLBqwb+oD5avEUl7I4qHQzEJpV6qE61fLq1
         +p07/WDYoiXPPNEtWpvf0ZRJFynFzVEBZJr55BzUFqWPRssmWptxTy5FEtlwIFDxnF18
         SFhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784546055; x=1785150855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lN5CgOEVOZ+tQXbZyCc0JqrYccxDAnhxj3hOkyWwzFk=;
        b=E/SxvIXKg5c8UoFAOev4ivn2y5aMFjX1UTvNBHABgd/ZATRyBfslWYKaqIbhPmvov4
         4NGbLWHAWVVDhxW26j9hE5bSVUdmE7YT1Ax8DQBvKTY58PYXmhwSgaWuxt1SnVbv0/Lz
         TPDHz0r94JdcnEBOh9qmJO++3n5X3uX6q8PTSO1ZAvt7Ib/cqmuDRfAbLeFEIbKbeqbi
         aRDFykKylQNtbOAbCOkjI2CJRu+p5slbh1xjRcdufryZ5vVZb05yW+kr4L866K93jrtz
         Mg/3RamfvagCadlRlXlNzcnffgz+n21/5N44YJMutj8dBZ2segJFX/M34e6sW+BeoZ3e
         qF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546055; x=1785150855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lN5CgOEVOZ+tQXbZyCc0JqrYccxDAnhxj3hOkyWwzFk=;
        b=JiYKEkziUssCaoUIWXfe6r8Q41I5pMA73ItIelXEmqts7nf3j6eQ1R9AqRNgSD9JI+
         Kad4YL2wjEuR8/9rWn4gIWzeFiROsBl74f13y+NRu7G/9AaySE6thUtITXAuQPALJK2a
         DBpN/Xz2nyrI9zvUkdzg4II4y4K8CtwV1x3SnVDeR6LXqDikFlK6Pbg4R5hUOLELdXOE
         tsQwzFfxovUYZaGv2xJII+uljF7RdH52NwInM793MXegdteqam1MMzGYJ8kwAJ93mRew
         FkqRQqwo9OUX4XvAKlK1+QyvUhSMjUtJC9FFyz0aABtac9O2ML4wLPqDnGIgEkQZfcVm
         RNRw==
X-Forwarded-Encrypted: i=1; AHgh+Rpki724obCtb1FWZ+v0/Q3Pd3/RepI1+Izz2l9Rqpz2H9q3w47TRuoAqEnkl0FWFG8WxGMBARX+1jEh/zR8sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkU8eCc3aDCyurcmxL9iYT1JizL5JP9zbESLobC4Vl+BadrnWf
	H2s+r4OzdCGnJbjq/4+htfZ54olTsoQh0MW+zypEEUqMGCBraU8hw8303kqjppEh3bQVf/wIY0y
	5k0V+Y/bc6iOqr7hdY+Xhl8H+L35f1vA=
X-Gm-Gg: AR+sD12py++e0ehBbthkwf7PRQEfhXGvlz9oH11GT0JEwwUmatKKyOhB51vnGyoDfpy
	x1r2Ot++j4+5x4bDlafmMVQdOiB2ak0xBHTbxJW+J/EVTlPh3fhNM2dj+JKkzAatufWdXXImrDv
	SwNp4vSIDKh1iK1SNQPLhWGAe+75+WV15LzaJiCwoSo0p7HourAkT0yC3druLw3QAMkD/BAVQgz
	cI1j3ZW453a8OvRpNqUVaHdDwrj7QldCBi83HrheaCD06tSy6rxb+QQE0ZuJQeTcxv9k19cPAZz
	Mlqmi2yJ8bFhsNqfn6MfQbjIvFX8dL9BwTWrv0FwpcYPgR0=
X-Received: by 2002:a05:6000:4912:b0:473:1ccc:15c9 with SMTP id
 ffacd0b85a97d-47f6232249fmr14608346f8f.40.1784546055157; Mon, 20 Jul 2026
 04:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260720-fractal-prodigious-spoonbill-86f534@quoll> <CA+V-a8tfCL58j2TvoO1VhhDAZf=8LB89R4O0SycLghYGf7Rr4w@mail.gmail.com>
 <2323f9bd-0b1e-41be-8c8d-6906b66b625f@kernel.org>
In-Reply-To: <2323f9bd-0b1e-41be-8c8d-6906b66b625f@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 20 Jul 2026 12:13:48 +0100
X-Gm-Features: AUfX_my8cjMqflKYyG4hZniXQBlddlP-o7E0L6c407-AbtgLj1LdUoaSU0sykN0
Message-ID: <CA+V-a8sHbc9WSqmzrONjWbLY1+SSEhK3kGOjL9zmVmhSttD31g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
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

Hi Krzysztof,

On Mon, Jul 20, 2026 at 11:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 20/07/2026 12:50, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > On Mon, Jul 20, 2026 at 6:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Thu, Jul 16, 2026 at 01:34:27PM +0100, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Move the RZ/T2H and RZ/N2H clock controller bindings from the generic
> >>> renesas,cpg-mssr.yaml schema into a dedicated binding.
> >>>
> >>> Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/N2H
> >>> system controller integrates additional functionality beyond clock an=
d
> >>> module-stop control, including reset control, clock monitor support,
> >>> write-protection registers and other system management features.
> >>
> >> Nothing of above differences got reflected in the code, so I do not
> >> understand this reasoning. Binding is exactly the same as the old one.
> >>
> > A syscon regmap is implemented [0] as part of the RZ/T2H CPG driver.
> > Since the RZ/T2H clock driver uses this syscon wrapper, a function
> > pointer is implemented to handle the RZ/T2H-specific configuration.
> >
> > Also, as the initial implementation used separate device tree nodes,
> > Geert suggested splitting this binding schema off into a dedicated
> > file [1].
> >
>
> I still miss the difference. Can you point me (can be short diff) to
> actual difference in this binding?
>
Fair enough! You're right that the schema text itself doesn't differ.
I'll drop this patch in v4 and leave the bindings in
renesas,cpg-mssr.yaml (unless Geert has a different opinion).

Cheers,
Prabhakar
