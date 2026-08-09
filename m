Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84441368D70
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295813; cv=pass; b=guSEG1tzrfinfuT8f3XxfuzgAZiKEF78ClxOpxXMvnAZuKdbkIxfEgepZTSbIo061JKLwraPpia1v4egntAXGLslNS1uU4EiDzfc9A6YtuObezE0RfvXDfL3wD7yWTk3zARUX2hboCHnAn6yhpCfUrIPMmGH+LekjCaK/I09+M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295813; c=relaxed/simple;
	bh=Efke32iAl7xjj/OoYm7zTUFVlvQ+VHNxMFhnETZtBQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtF3X36Ij2xHcAg7557zIKaGed+OD3zVNVVpdh9MGQNIY+KIOf2XZp8t3NgahW4B/XeA8vXCPAkvZofr6FD0O0XFckhebJk27TXuZzaSBsUIquOyjLDEg8Ogky+vt5gm3Yliq13Km+KAzytjPUSzKust/hVKJxKGXvt1/X7cV+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pueMUg/7; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pueMUg/7"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f29ec73064so5552156d6.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 10:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786295808; cv=none;
        d=google.com; s=arc-20260327;
        b=PfYc1wi8d9xdOYEv5goDZp9RNArOlo4fzzwAZ+FEoDd6Fvs1q2+MJoEL+OFLKzXH0T
         A6fuTe2iM3mAlVIywwW1Hn6/C9efY1yaggTD5rMosO1NK13qn1r13e1emwrXF8fMYiUt
         2rrs57t7lHt46OpynuW8BNSa/3Kv4gXKE3KMvMg7wpsNIZnTGVjfDmp26od+Z3VXiUJA
         k4vZmLCNPkbd7aF8SY7F80sztCtAznsRnFKKUtnmArd9SV8Xaxa2pLZ3Jc5DDMOPoN+R
         KgS/gDkdFLMR6upPaT/bz0V40nsU+IZoyxwTuTN9fyG/slA21/c/C8VG/bHygw6t/u4j
         PGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU7Duwnzym7o6H9C40VXv2V+HHIGH6Z448XVA54zyEg=;
        fh=w75p9Y+QAx8joXve5IbYVhhN0Z7eJvXs/FbvBd5xGPQ=;
        b=XeXFv/l133kPYm0P3Ws1CQ/Hlcss0ZqqzWp5vfkPmQ1udmWGUu/+nLYgfskb63UgWS
         1GSC8+WPJuZoIyGWIrMcf23+otC6va0sWPKg6hdeeASHlp1QK6A7IDiQOIqf2zuulrRQ
         g/0dQWSVpVMuMFrzqebqyBAKQPMrGxNjnjBeEUClC1ZGHLDi+MPPu4ijp6RXXSJd1OFQ
         8kmLWrOHHDvci+xDEH+Y3UY8FEBJr5RbAOJd2NYV3KL0Sp4rH0Vc+vp7MtV3RZdUVlc3
         Z1NxkUBOoLS8TcNM16RMs2Dgzbk9+c1IeBb6a92Hg12KUEo0xZU8RK8apdaux2t8OxdQ
         LfIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786295808; x=1786900608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rU7Duwnzym7o6H9C40VXv2V+HHIGH6Z448XVA54zyEg=;
        b=pueMUg/76MmA2YRSJ0t3bZs3CsAreGDQPYcn51zX5ZZhhi9H5A2xIKoKansKKT5Cfw
         zO9deLoShIBR7zAinfsdYrM9cmUYSbgUc5L/yh6A5fs8sTakg8T3ZGt469dkd8UBoINg
         T0cArpSdLzzHpcoJvVhWyAsHBn5Pzw7Z2QuZMy91AhtuqoHfFEIH5Z0g98F9qsVlKKgF
         e/TLEGaQ8ixj5R4h5M2oMRwzpYOOIoU1frcnD1Vp1pPZbXEINz5Fyaay2KpUUmjeFHYN
         Us5pK3KpAyWrTGP4LZv+uin3RnabGkIc9RvubtaP83Il/EbbICUW4aR4DfhSkAyUxM+I
         7HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786295808; x=1786900608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU7Duwnzym7o6H9C40VXv2V+HHIGH6Z448XVA54zyEg=;
        b=h5o+b7EL/dkm9MaaFWOkk+7s6oawOjQOZbcfXFQvbqE/151M3ueA9mkOtEAqbrNRsb
         LLc/EAiOHiQjT6N6HtFtDQ5l/5PpJ3RMpat4+IXD05UAIseiofOOltQUUWLdmw+mQUGD
         r2urUihUq96Ir25yIi8X5ChIMW47BIezsILxf4r/RFy8zAhesIxmg2tjyEqrIxHeW98C
         28Y0CL8sMZOZLwtoELNbsMixYq6jXqsTYgHggNmBoq8FQFwrx7PgFzHa5d61/eZ6ngor
         kAYB4wxRqb3hea58jeMCobYjDrPdwoVt8/amPjgGOCLswSb0udbWP/WZEKY/2rWtYnqO
         BSlg==
X-Forwarded-Encrypted: i=1; AHgh+Rr48Xfux+MF9kEX1DdFhNdf6mIRqAlTYxH/mHLDph4BFHB8S6sJy+2b7N87VnrzBjOclacCjYH4+TouSGBjDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLbLG2tH0TSFZnxcFCDeAL7dBm6nW/J7KMcyq/Bs3eGo48tO4
	eSIaHIMQnV2DHG4vRn4b3/+JR8+LYcBLzwvFC96mrRPPjpptHEtcFsjlIxL0KtYdwQ4Vku3UUjs
	NRm4VrSuC5lstM0jCHALkWs8pcANvG8Y=
X-Gm-Gg: AR+sD13zw88yTsbPm0anwODHj4R1HtlMG1T9Ud0sTdhR0zCwRv+abQ09kpufw6aufe5
	cBX94ax5DJUlQTumz3mqz0aT638ZNTqbDBz7b3xrZ+fFppciC+reedCs8zaFwUFSmetQd8uQPf7
	SnbnXyLmYwxLcpfZDhCB7qKaop/ma0DwjZBis57QMkPDarMoZZFAf9l+dFIZ4fy8G34mNQxMzGR
	xsjsDaqNS4TYgG2nLFGXh5EdtzrnZVdMqg1e/it+R2XAErJHoiJYYzrT7uZucVpPfj2nRQSbNwK
	BuNvuV+WdWKyY/GzecuATZng65hFCHzl0oYGLTIFz6s9qjR2WeqQa4TTtkoPQG0=
X-Received: by 2002:ad4:5945:0:b0:8ea:fb8c:2e0a with SMTP id
 6a1803df08f44-908813800camr422497886d6.28.1786295807862; Sun, 09 Aug 2026
 10:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-4-l.scorcia@gmail.com>
 <aniv5B4jz07mI70D@buffalo-ssd> <CAORyz2KJMY6OvFQEB2GU0P7CkxothuXOCXgCcRvtiUhhPaK1ig@mail.gmail.com>
In-Reply-To: <CAORyz2KJMY6OvFQEB2GU0P7CkxothuXOCXgCcRvtiUhhPaK1ig@mail.gmail.com>
From: Akari Tsuyukusa <akkun11.open@gmail.com>
Date: Mon, 10 Aug 2026 02:16:36 +0900
X-Gm-Features: AUfX_mwSw9EQyRpwAxS44Dmd7O80H1Xy4wdfZq_kCKddFw7XIYHyFdFWMPL0V3c
Message-ID: <CAKr_iV5oi5VbnXZD-7b4XCaUuimavqYNBDO=2oM39JvYwzkwmg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset controller
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Mon, Aug 10, 2026 at 2:08=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> I apologize for the mistake - if a new revision will be necessary I'll
> correct it with the Acked-by tag.
> Thank you!
>
> Il giorno dom 9 ago 2026 alle ore 19:04 Akari Tsuyukusa
> <akkun11.open@gmail.com> ha scritto:
> >
> > On Sun, Aug 09, 2026 at 06:03:27PM +0200, Luca Leonardo Scorcia wrote:
> > > Enable the toprgu reset controller feature for the mt6589 SoC. This
> > > allows generating reset signals for the 12 subsystems managed by its
> > > top reset generation unit.
> > >
> > > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> > > Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I provided "Acked-by", not "Signed-off-by"...
> > https://lore.kernel.org/linux-mediatek/amEBgRmQktZ44jc1@buffalo-ssd/
> >
> > PS: I am also fine with this patch carrying my Signed-off-by.
> > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Sorry, I made a mistake in my previous email.
The Acked-by I mentioned was for patch 1 of the series, not this patch.
I did not provide an Acked-by for this patch.

The Signed-off-by was not what I originally provided, but I am fine
with keeping it for this patch.

Sorry for the confusion.

Best Regards,
Akari
