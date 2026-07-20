Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4023E2759
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544654; cv=pass; b=lZh+qcctUVBgDH+oqulo4tqnTI9ZuhcZA8psnP6TVYdhbr+kqOcnUekyDsaVEv8u2uy83SsBMrIC9f5tmIbBnzcsOAYeMrIKsKJBKgYfPFIccwZk7GpZtfL6nGbU00e0Xpd90YhfQBcUiGvWvqjtbMU0q+8Elu+KoWjcR/o/e/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544654; c=relaxed/simple;
	bh=6LIKfbDAVneuMSs7+f/o47O+7eA2LK8R+Sj5PDUGEII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/RSYsdPJYcuCvojt+JSzgVOREVzA9/VZaLv7pu3F48Alfwws/Wf+9xODM/FF+IbORozP1DCWvWUmacW4xSLkT1P43htbLhvggvNZeSvXCBX6idAfzn/AvyM3JNKW97kAzj/gB+tTjzGp80cqK+UPl38UUaEH884xZR44TQvGpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNB2gY/w; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNB2gY/w"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4758bd3731bso2942763f8f.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 03:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784544637; cv=none;
        d=google.com; s=arc-20260327;
        b=HmzMYB0HRxG0kKuqwJuo2iHYhwuXVtubxVMnTgUW811u/2qdCwbXlg9jMnUkrgy7ra
         4oUFI1torxYTo3SoWB5DI5fz3M2nVPlRLPN86ncZK1wTN5Ic0GKjvVO3MpklqInt93vB
         WmMXlwboVOmA3on0PbgJ69JUE3WhAHwfsJnTtIXBtUCsIgzaXPcQukiVSTkCQ2ey+TJp
         5wv/YR+TnTrACc3I8q+ZKQTv/WbwEaaC4PSsMxBJDYJHLgataUnWv2ejZpO0033IUXWH
         YxOMYB/pA2GIGVwzjGU/5oTndxwYYeI62KF8ut/PJFD9aMZl9M5oPmOWMmRNEc04UY+2
         gj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6LIKfbDAVneuMSs7+f/o47O+7eA2LK8R+Sj5PDUGEII=;
        fh=KUP0a+fFoGg2rIHFCXzdAlByciEBhvbdl2W7bF+W52Y=;
        b=HL58l6tdm+rgYcnmjLP5VviYeT/b7AL5ohs/lrOM5/zhX7oBewHwVzi3s0YePDlUkG
         knE/u/Oo9EIuqwG0LN8cUF27K8715JZhzN0ehwqN05OOfajueWJlOpeNuSAf2sEYaik+
         0GRYQiXnUhPdeuGmqx//jFv1g4wyTAqcN9NeHzpnFvs2mOuIQmPXEdii39TYtkaSFBF2
         0x1uJBBEnYiwxrSwcjyEltYGwe0k8zNOe9Q9OIpEsR/FvqqQFPsv3TlSHqOwFSbh6TBN
         Mi775C/h3fErYpTBt+z1alic5uj81ccpJdcbHSOG6AmSX3HJq+I3GRXGA7y2vTakboPI
         nJbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784544637; x=1785149437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6LIKfbDAVneuMSs7+f/o47O+7eA2LK8R+Sj5PDUGEII=;
        b=cNB2gY/wccKpu/LF7vqqY6A3quWLN/f6zMGwZEqMlcMHEoXIwiYgHXpHpRta7bFryS
         cDxLrDX1BvAEI1WtAn1sO+YOfhvRN6lBEPQVmCWaXEMVpbR3U2dxJwhzeNTQMh3j9a6A
         yDmNTX7OYcDikeBt5RdQwnC127eYSfjoH+OZnhsX24MaNH8g46fAuFrsVJzwKQEUs7sW
         S1mnWy33WxjcoPafzgNqR+PKzmy+aLdFfusY2RpM84EpWG3XBM9EAXFlUaKU7w1Qok9U
         ZPftWxlfk+amtTZv37KYookH730ft9Qotzsc2rcPkVhFpde8LXtyQH13Vs0vBA9ItPjb
         i48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544637; x=1785149437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LIKfbDAVneuMSs7+f/o47O+7eA2LK8R+Sj5PDUGEII=;
        b=WmM5vqbC2v4+7dCZIF8rZRbRMV4+nBFFVTAommxKgzZu9e5SeFFlUKVGmeKhB1CVsc
         q/cY3lcxeggnkb/+/OpZtBzEbkCokti9s10FG8Y37Ah5f8jNFwtEQjZ4O7X/OtjbkVHH
         ARmPfzbOoC42lOKt6gwoaPgwvqhc/wkYJP3BC9A2fjvOGBLmjciCNHxKtjU5qbHWrAKM
         wqvTSROvL5chYTzAkSVAaVCzqvyk5s9dSXuZ2QhSizvQgfVvS4G7dUZcbjH62wtCslcM
         PVMGzD4zhOkaCipohsXMM/9cUsLhvHV2kVXAhABsoD8ERTAPeFW3cLpHrt3buX4FwBcH
         Uhxw==
X-Forwarded-Encrypted: i=1; AHgh+RokxOWScPIFyiTCEldlD2cmMArCDnWsdEnqS2Sj/cMIDnCJfw+PMJR8FKQNN1JJ5ZE7HuJlEmDevbJrdrb4xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62lTq0zch7tYNdYYB+JPiGY4lMDv4BC45CvnuOMKaZql/HIO7
	IxCZN5v+6cvVg0YfdoS8lIacZ6XRd41cpXPHHVOKtnhGZ6roWLFBo4MO93gNTuh7ygv7HkFyEpJ
	kqSh9RMoHXnMkcEiQ5k3TF3srZZgaEnY=
X-Gm-Gg: AR+sD11gRXLmOZVtvowGYyPsL/fUpvPJA6PFmDa/9nxbioivyysN48jpaqMplkJ1H+N
	GUCSKERRM1QoNL0wkXLuvT2YN2YNhi+1ig5C+0aOx+HcKN1Glrt7ERH+gt9goGqWR4Wtxi0mDSf
	aXULI0w6+IwqCT90TdtgzkQlLAXV6nQPrg720DvG6HJbpQXAe5gOcZygaUg1EuxZcK9YVQ2Dz8u
	cpf79Uo3eqxNT7St/KEFOP86MUqnrdOFsW/yvYN3/ncqv/H5oKYHupG+QDLHUusuwWld59f15SH
	dtZFFmEyPaEk14nRkThPM3CtDwkQEmTJUsMbBEcPyaHSo/A=
X-Received: by 2002:a05:6000:26c6:b0:47f:71a0:c060 with SMTP id
 ffacd0b85a97d-47f71a0c528mr6994984f8f.2.1784544636880; Mon, 20 Jul 2026
 03:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260720-fractal-prodigious-spoonbill-86f534@quoll>
In-Reply-To: <20260720-fractal-prodigious-spoonbill-86f534@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 20 Jul 2026 11:50:10 +0100
X-Gm-Features: AUfX_mzmB1NqSZ6NtXzORayD9TuW5BGNtCQcsQ-KypuekoZwKlJVJ80qQGr5ZIo
Message-ID: <CA+V-a8tfCL58j2TvoO1VhhDAZf=8LB89R4O0SycLghYGf7Rr4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
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

On Mon, Jul 20, 2026 at 6:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Jul 16, 2026 at 01:34:27PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move the RZ/T2H and RZ/N2H clock controller bindings from the generic
> > renesas,cpg-mssr.yaml schema into a dedicated binding.
> >
> > Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/N2H
> > system controller integrates additional functionality beyond clock and
> > module-stop control, including reset control, clock monitor support,
> > write-protection registers and other system management features.
>
> Nothing of above differences got reflected in the code, so I do not
> understand this reasoning. Binding is exactly the same as the old one.
>
A syscon regmap is implemented [0] as part of the RZ/T2H CPG driver.
Since the RZ/T2H clock driver uses this syscon wrapper, a function
pointer is implemented to handle the RZ/T2H-specific configuration.

Also, as the initial implementation used separate device tree nodes,
Geert suggested splitting this binding schema off into a dedicated
file [1].

[0] https://lore.kernel.org/all/20260716123434.2576253-3-prabhakar.mahadev-=
lad.rj@bp.renesas.com/
[1] https://lore.kernel.org/all/CAMuHMdU62updtKeBBk-vO3YP+qaWTGqHQnzKvFJbrz=
4J5eEPMQ@mail.gmail.com/
Cheers, Prabhakar

Cheers,
Prabhakar
