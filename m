Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F156329D
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884556; cv=pass; b=QocEMWNPO+czqsSZeQiCfqD2a4QW5tZ0CTizlHQ2PynzKNrLmXT0Kl2zX1xAKlAk5CYC+PHVdlBbofKUxsIDjvjliGFiuIs6k06cVmOUwkALY6ZPOzhT8/yXGuUmYegLNiCi2xpxEN8X2x21EoMP3GbqKe6dv4fU1v6oFWP5p/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884556; c=relaxed/simple;
	bh=gx0WNzHrzpR5Vg5y5KJZ32oxwshPQgn8Fi9efTzEQjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxVGjbEnR6toxEadmd4mq3bxkvneAJ6TnSAfUI8mvneEWnwlvoPnzir5dWRlx8wxpUlFv3ySxA3tdA6LJw1/1n1pdY7vgZanUEA5cCWJPdPl/uLST8pD0QoMdEEmENZ1rHDflrlBkVMT2NTS53nCOrYyXNpWEeA9dOOXL7dxMEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHI7JKr2; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHI7JKr2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4843f205a5bso3031453f8f.1
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 09:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788884552; cv=none;
        d=google.com; s=arc-20260327;
        b=BNFhLx8ZmXtj06R54kAAeTo1RBER2+QbiAsyndiN4aqctuvmLgtLaod5bqklsFcBhb
         TXFZKph/MTDLEUiCFtehLycp2BZqFjuuCdXiXqZvdO/hreRnh6Vh2dgNRQowtDnKlowZ
         nEE5xU+wbze7UAhKvhKTeqgDVdBkrHiZMCg2pEd24RVPSzGUkist6J8pswyMiCpy0ii6
         A9brAQamClLuU1IkgnwgbAvtiRa+m/2XW+G/98kFctdq3wKJfShz+MV8QXqQICOxk62w
         j3YCHbtyRnW1oAD4JZH+/WEmUpOovYQZFiJZ9Rkt5EOX736d40MqG/6E4/kqhDYIrRUh
         OnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jekOF2OhfE9K8vBMYq9LG6isiwXmYjORyhfyHiOqLIA=;
        fh=X7Vp1LwJs+O/eGjm9Gj+dTvgTo3tXnNTTJIks44CO/s=;
        b=A7sgtJjys8xwvTGXTkPNYEfmVWtqz9X3qemWNmg4hWtesRfks1hzyGyPMteSW+62mj
         DzhZEqPJtLMJ/80lOf3t+YvpePRIDVeQh7HvY0EIpYKmPizNb0xEVpf9fGvBx31S0E2A
         6R/Fr1WAvdACKDa+Mzyq5O/r/r0GSx/y5hxsrFgVAFjlnCoPecQmhnwGeEsEgoeWPpTH
         sFFdraRAD06bla8b5SkjU2dKiEJ6fFngzmZlWgspL9vhb4JsQHAjmtE++W3W3JZOTSCy
         du+eg493r7wLYe347mTmcT5aGJW+8AtygvTj17Z5TtWxlLpkhlXBEVsgjBtYv20LBzrV
         tNIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884552; x=1789489352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jekOF2OhfE9K8vBMYq9LG6isiwXmYjORyhfyHiOqLIA=;
        b=MHI7JKr2kkr24YW4snLpJdEML8QbgbEuKlTVoMWeXvxapQb9bE9iEJ/apSQfsEBCyF
         6UK7QNkxSB/f9xiBqGLkw/iBAFfKmaoStMFU0SS5vDwnJAGG+tC7GH189zop7UdBzH8w
         nwK+VulVgJKrc1YU+MG+M392P5la+71HfwYsPHAQAtL6Wmj11OiTlSRr3/2FVb7gcRtK
         kzeWmmZTOwgHWcLQ2wBGrFe/9jhFTHjnktsABOgWj2M/hW1C+S4I+XMRSJOVRPGTC81W
         1m9LjXgjk7Udg7NCQtPn+rsj5TDhUg6pzer5U/kGbQZXLXNO6XY0wDlRDF54Tgi9padj
         LwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884552; x=1789489352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jekOF2OhfE9K8vBMYq9LG6isiwXmYjORyhfyHiOqLIA=;
        b=aeMT1ocI4Xj5bUfzdHeO70WZcpKcK/baoWIZUxnrAZHMHBbwgA6lLd3KTJx+BHoGbi
         JiFC79XwwTd3Mpzwg1o9MzESn4FqVy2nruSoT7CqhlA1iwhH3WBPXMdx9/aZViOLHB6G
         +R9WZvkMUVWel9Q0yfJ5/CamEIHIaKoDLk9iaGLxeO+eBsbANglbigmykTXdqVv9IYrR
         A3Ypdj2eS5++3YbIme4ekoETl12XyFjiW1SRJXS24urf60RdHYH7miFOwa4R9ID+3U8r
         fBkH0PK4HLUTNqn8wMME+A7dmT/pXIZ2cQSiLhMhg1rQn2X9mIcrTztrCUdE5Gr+Z2tf
         PLFA==
X-Forwarded-Encrypted: i=1; AKwUvBy+gIW2wgNvxGyFSauQnQJU+f9z6r594DA4UE6NZir2SC5gdT1H+/+Tpw4lP/DClz1jIqn4DOZ8NRtPH39Hqw==@vger.kernel.org
X-Gm-Message-State: AFuF++nyLogu+Rk0clLMQBNC3hMCFVZIeWy4Iu48VuWMbcKKx0QIrS/H
	GaOvtJ+qB+rdxSV74yhAMMiVBybbeRAkTEbLIo9cIJbUpp8RmpOBoOyFC+ZG1cxIk4HxOtuRZpe
	Io30W15wFxJvRLHOS+X40xPkuWg30PFs=
X-Gm-Gg: AYBFou3YRWnEJdz0bNd6d6oN6IpTiQFAbN+RAwmgSjdkxFNeihfAr1DRLyz3V2IRP3u
	6ewPzEhn/v5GsMZftRCKYVLOwo04ZePYaRzcDDlAAmuOd6l6xQckHDf0Um/t2GbQXxl61njIokR
	7yGL6lVY+VK1oZHPrZx0JHftFtolg4oHUc6JzKumSn13lE5wTIhyW55bcOWiXdF3JRbvfENBLDa
	6UqMmh45mx59sfUCtZkWcYobf7+Gnpl7Qg7u1Anyf/nkqGemLebRoV5LLIYT0wIAgwnaKx2kyyy
	C3+zrlWJdwrPDd4eKnha41nlo9A6DZrLQyTFmpEhrqsaqOCBDJnIgK6+tuXsD+UYCyXVNubN7IW
	V4d5R1EsLMqsGHvHDdJxt7bsqklIj6A==
X-Received: by 2002:a05:6000:29c9:b0:485:8ecc:9415 with SMTP id
 ffacd0b85a97d-4858ecc96bfmr18626346f8f.48.1788884552482; Tue, 08 Sep 2026
 09:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXBFu=W1MnEA+Eu_zzUy3qMyFRbbeLgYn0waxMdr5cAnA@mail.gmail.com>
In-Reply-To: <CAMuHMdXBFu=W1MnEA+Eu_zzUy3qMyFRbbeLgYn0waxMdr5cAnA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 8 Sep 2026 17:22:04 +0100
X-Gm-Features: AcwNN1U9H3bV0zPtcgBr5_fY5_Ex_KcZm0AWkc_KXas88ZieEy0_hzjnmDi9vSA
Message-ID: <CA+V-a8uSR2jgpYqeUxteqhSD-FuxKBT_o2519y1z35cg+3XOig@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add syscon support for Renesas RZ/T2H & RZ/N2H in
 CPG/MSSR driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Sep 8, 2026 at 1:31=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, 17 Aug 2026 at 21:25, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs
> > in the CPG/MSSR driver. The CPG/MSSR block on these SoCs is a
> > multi-function block that integrates several system-level features beyo=
nd
> > clock and reset control, including clock monitoring, write protection,
> > and peripheral configuration registers.
> >
> > For the other IP blocks to be configured a syscon support is provided i=
n
> > the CPG/MSSR driver. This allows other drivers to access the CPG/MSSR
> > registers via a regmap interface.
>
> > Lad Prabhakar (7):
> >   clk: renesas: r9a09g077: Register SYSC regmap
>
> Thanks, will queue in renesas-clk for v7.4.
>
> >   arm64: dts: renesas: r9a09g077: Adjust CPG register region sizes
> >   arm64: dts: renesas: r9a09g087: Adjust CPG register region sizes
>
> Thanks, will queue both in renesas-devel for v7.4.
>
Thank you for picking it up.

> >   dt-bindings: watchdog: renesas,r9a09g057-wdt: Add CPG/MSSR syscon
> >     support
>
> This is now in watchdog-next.
>
> >   watchdog: rzv2h: Add syscon support for WDTDCR
> >   arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
> >   arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
>
> These two have a hard dependency on the first five patches, so they
> are postponed.
>
Agreed, once I sort out the series [0] maybe we can take all the WDT
driver changes via renesas-soc due to its hard dependancy.

[0] https://lore.kernel.org/all/20260814191415.2110732-1-prabhakar.mahadev-=
lad.rj@bp.renesas.com/

Cheers,
Prabhakar
