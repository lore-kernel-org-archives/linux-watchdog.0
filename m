Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BC47ECC1
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842316; cv=pass; b=Yq7zDxEkcTEo/sZdMBboRaQ/em1d/SsdjRbVIHeTkxUoUrh6CoWyklYlVIDX+YTmsFGm2GbmPXa+Wt/FXUPii6E40am/v3hqKWh2X3kKrII5rM9Vva13GPRpiWIdZ9fuaDmqVXaA6qJ1b0xvUdAGMgg4Cgp7ZDwsPJ7UzB1Efpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842316; c=relaxed/simple;
	bh=JfGF6x5LOBnftc5+sP1QIIQF8KWJ2gxceLJFrGZ0Tuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiQw1l+rTGmchmmrV6kgxaarqngpwDEjFOgH+nVxHdeueZeMpnaGn4l5laFYENgcf0f1fGwUi9NcSXH7cfKTrum94jeLXWiMIDdKN/9IK+pir7lUsqEVrgUXZSE891kUDohAeAtRN0hRZiUMXIGgA6g8dBQiwNd4H54bN/2wxfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqmNN4tk; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqmNN4tk"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso346807766b.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 07:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787842305; cv=none;
        d=google.com; s=arc-20260327;
        b=pBQLZGwuGmJUElYLHoj75P82to5C15voHVya5//+NEhlQQ2ht3VaBGKp0TEYiue/38
         WxdEv47jqkouCkVX1yqYy42XAqeDdBk6ElX3EbDKcpi+1NcrwW7cVRliYV2Zw3+gRCrK
         FglIEGBpek5qUO9U0Zz8O8nfkj5lRB/IKrPlzLoq7RvV2XziVkNulnDfvezW5n5gggsz
         WO5LHYFIwhdNiapDIUrBfJGjv7R/4KhaBZ46IL76aVQ22gu7Nwsda13lmkGSGTCClyHV
         JidC6LG0f/ygR1w+5Ucy86q9gI4mGxiZtbTKzkMPrv3Ex+9Uknz8dpiUtL64994dArYE
         BEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rNAVc3KEaJO754MBwf1BXCQjtokctPSDVwjt06/SloY=;
        fh=p7upyJtnEP0RrL5jUQZAWoZMdZWaMMhIUsLwGQ405lU=;
        b=b9i2L/SfpjkxdsYRAIkvahxcdSkiBTHaGtN22uaI7Du4a/80mEiall8ZWT6/Gs3lhL
         E6k5kXUtQ75b5jTqH7ySfOaWaroTsQHfLtvdE5v2UL8Hqmw0n4BGbCvn27XB9wMNFMB3
         CRy3NOzWFxTAlOjvQRZcuVCd4vwkqqk4CRA/VuskI5hJ7nJnUPHoax2DbqXMa6TK8RHA
         JTSBkTYPJPO3pnecjMQ0y7gtGcGmdadM3yeQVTv8ZZM6zF5KKTZ5AFYouQuCSWvFa50H
         IMkSj/3GN3iV7yGZw63SP7hIf7EHB7nOqBGesHFOxlM7WNhuKXXN+o0IoFp4AVH0yR2R
         3x0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842305; x=1788447105; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNAVc3KEaJO754MBwf1BXCQjtokctPSDVwjt06/SloY=;
        b=AqmNN4tkI8x8FAfbglsXPvavrjCiggdJjyBiBhI3pen5AzsU7spp36DIUXTqk13d6Y
         is3uVyWfam1AAIpiLQdSLOOrjdFCZkpE5bnsDPu4KuOmkm1LnRNElB2qtglPd37//U2x
         +47mLJwmLvpt43Gbe6aAR7ZiikbjZPoFd1V1zbbbF7R12g2B77qdpfI7pH7qpQFtwZIf
         EwPDV7UvPrvuaft9kr2Iy3Pf26RxxmhtLFT2tjNA5yOoge6sIJQurZkYk9AIOPCRYUKH
         cGRhpKaP99NBBswbvrLl8sFQWUXttHkEpFr/zkepv9T6XQdJ5g+M309NEPaiNjFNnCIQ
         Soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842305; x=1788447105;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rNAVc3KEaJO754MBwf1BXCQjtokctPSDVwjt06/SloY=;
        b=rYCjZTMRA3y3ragIRoAx/MSxCWBF/tFkzGuyA1AdAucGOQabN9OKSunOIvpYBuVbev
         R/W2mWj2KRvgsLRtCrAYCtB/dWuWbeJHmXNwtTkOq/8xY5XEAIaWv589tlnldS84vSev
         XSdGxKEFBE3YJBnUMS/4hBa1ftOXl7yVN2R+PQbmmuaKg7lYRVo571lpiwnIK5nte/Jy
         I3v+vvwh0QpKe6PzB+QUxIWmG3DwisJ27iUFaRVqH0v73fqQ/MLN6yrhhN5zrNl5QOIy
         48PGv+VvOSNW7DstkXE2d1DnXZOa4LMORO2cykKwjG8sWcwgOAof9gKQwHVYKVPlZwIc
         sZ2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrsTcCgg5UFC+Mp58nuHDV04E3K1j614ezyl9sJ4hwE9VNCbmWPAeMfnEp1wRjhaXDY0GI1HhJzQhoR2H3k7g==@vger.kernel.org
X-Gm-Message-State: AFuF++mpk2xC/Us7VSVcgI0afGTJY5NVIk2vnloFevWIImGcRXtf9QyE
	YKe49O3Wh77121Gz594rQCncY6xPzQmta/HMsAkeBJvYBjuAiAEJV/PTZXquWQNn4wvb3MLZIWK
	U7f88BT5eYf8i2/aTF4AViDcQEY212W8=
X-Gm-Gg: AR+sD129cVS8GWGNrPNaKKtzUzpfC9sOH5e+E8TmSp8K/Ti5k7pmt+YqCIsUPtnvf34
	uXKCLiYDJypQfOFoXYSN4olA7mjUkiv1ve5ebmygbglvmjr7fPhddDMORsVmEURcGxBpSCEAQTH
	ydBBkGAWsAmGNWG5IMNM8TmFwZiLnr1KUSEiS/znIdTjK/zuE4gezDD4f+RbrCRim1+VPQVEWPr
	9pE28VR1aadn+JCYGleXp59TeHCK+6ayQH73CcPhBDTQYESU9NO/SUAduBka9cULaSveaZKANRm
	dTtob+8qZfBFbLZvnKwZ1VN4DDpbmSATV0E9r+bzpls=
X-Received: by 2002:a17:907:b050:10b0:c25:2688:8212 with SMTP id
 a640c23a62f3a-c252688970emr595367466b.0.1787842304808; Thu, 27 Aug 2026
 07:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-2-l.scorcia@gmail.com>
 <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll> <CAORyz2KXJf4gU46649w1ncb7TAOErdoGmfOMzwKr8b+eGdAgVA@mail.gmail.com>
 <20260812-smooth-artichoke-kittiwake-f6e85e@quoll> <409e398b-eb8f-48eb-a0d3-ed8fa811328f@kernel.org>
 <CAORyz2JbOsiDYzCw--Y-tiRXEaZ69B8S9Hjvs-j5WZmtck-ynQ@mail.gmail.com> <ca373f33-fa20-40cf-ab7b-33dd9c25bc49@kernel.org>
In-Reply-To: <ca373f33-fa20-40cf-ab7b-33dd9c25bc49@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 27 Aug 2026 16:51:31 +0200
X-Gm-Features: AcwNN1UfydGY6AWpAopJHGYjoXoxQXXnBv3_HR2BQl9Llz3VNnES3KHGvzZYgY4
Message-ID: <CAORyz2Jq-Q5CbFU5=vCffVyMmyS2KodFhomfUqyGwa1w8Q8RTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> The IDs do not describe hardware capabilities, but ABI between hardware
> (DTS) and software (Linux). If you do not have them in the software,
> then the ABI is not used. I looked at your driver patch and did not find
> usage of these.

Thank you for the clarification.
Since I'm not adding resets to any mt6589 DTS node here I can
completely omit this patch in the next revision. If anyone in the
future wants to specify a toprgu reset for a mt6589 DTS node, they may
submit the binding header together with the actual DTS reference.

Thank you,
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
