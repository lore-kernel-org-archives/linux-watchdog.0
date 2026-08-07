Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C974B04B1
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076615; cv=pass; b=XO6nOptMRQa03NucFKr5cG1Pj8qnqnQP6eAav/jGvNSJPZq4M2RKvbokeS1ESP1YVjo8I0QwWwHzcXBnNQbmx1KgxH2SWwTMtpiDwfzTYozFUs5KiIcaBdhl1q/4TCzByI4u6pk/rGyIkm7ociU0HeIfPJsJTwbxRdxITNiXc5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076615; c=relaxed/simple;
	bh=GNn9VUYDEoxt3D3oWtVIC/BJmmfwyqviE6hCTrl6dgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agPr8vYDl6LIpPSTKL1uwt1SwCVX4o01oCOQOlhhqXpwPxJrb9wgpvK2Nd/UdW1eMUNWat/+WBRzGHZw30jRE0Q4RQ989JRqTrHFbadFr96Fg8HSQUhiaM0ZQkWRiOwPLqiSD3ktPJ49a8h6Erl+8sQY8Pa+RMAdvdFE4LS45Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8Ev6BEg; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8Ev6BEg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so34076325ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 21:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786076614; cv=none;
        d=google.com; s=arc-20260327;
        b=e/SklCMAZnLbdycqQ8uGxyvbtxGn9JcdRijWsdLvQencCju0+krrUNyW4iE183NxBb
         ZNUJPRccj3Xrcp7kFEd1c677zVr0RGx2ftupsYmJBo2WPPm4z0/561BX7JiFiFR168zh
         86XBrT1uOZIpEzDcF62lV4/Svbc9IKcjtYfFYW8bffrKxyvKMXUZNUSs3/XdESY9m6rL
         2vJjgP3AbmiPuUujMftLZzIDhSbCtavEx93yVvK5Jf9zqOhHbf29n3FE+lw0i5IcObCG
         wREbBm6ZWR8FxMypzvncAmQzwXJJdSkyv8tg0JYNHgQzUQoIOlNavJQ+0jFo0MH0mFmG
         vkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WFnpsZEDa2kOT31onzxrsvAFlmUG/9w4ITWZXzCCWLw=;
        fh=HFQLtQHMYCj4Q2ZSMV720aomjNaz5YjyRrvnNiGF+kA=;
        b=N6HjjU7vK/nPHlJ3WID81o/iTy1SqPjevFjGMVpof/EMMvmb0jQ35Iw5jGijJ1puZk
         pQ4H6hfZMiORTkB6Q7PDIl89gaoVxBsSJGzDxVO98ro9z7pDAoNVm01FRjzah+eC6OnW
         7dvXUMUmw9s04XhM+d6+lAb0hGJUoduRL2AzvpBuRP469mt1lj4tvfwUWlU8Lr7/F9/L
         HBPjetgo53/OcgysJ+vi9B5+NmZlzRGalG645WOyFxkFRtvlPJYdc9GzGAMDvgAt9riK
         KMcbyUByx7WtWKDwqD2SITQ4IbXlYNdStECTqqAmxtPiI9shN0+PEDdn7mw/GRrDHK+x
         B/cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076614; x=1786681414; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFnpsZEDa2kOT31onzxrsvAFlmUG/9w4ITWZXzCCWLw=;
        b=i8Ev6BEg6XBR+BKp4UHF0TwVj6UeYx9JE/vsToJxhOJDqscSy7AkUO0mo9kO4bh9gg
         6wNcVtRjae+QN9m9yn5jpzzd0LrtoIs9aV6kzoDpJiRIIT6C41fD/8imy4BN4gMGg0uI
         zn1e23xVmHYR/aITVjfUTr2tpDRtKunVxpD16uXfzDSbTUU8gkMi+J+rYWhuRzt2dXRj
         eKTgn7Ia+w0rEa8aSEHoYXsokwgW4t2IWUPviBVHjNJ/3S519RsRCv/Uob/tLb+0yRR1
         2WhwOS3qZNiEdcJQ/RjJ4rXW/fihwohSScc8lueDzuO4ij383nXKDq/tFUI1TUsvKPqZ
         2UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076614; x=1786681414;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WFnpsZEDa2kOT31onzxrsvAFlmUG/9w4ITWZXzCCWLw=;
        b=INp1xnkr5s+IQK+xhRIIknr33lQUN6IvRmu/mh3hoVDndMPGM/uhj0LLDn79/t5oFT
         lYwkuoB3gGWU989zpHf7lED/LbVnmgwyUWwgGdCqSDtWWWx0sK61Nq4aHNyKE6Z2LOfM
         2GAxfx/fO7WLT2sVvICP0YJJSXrqngjezfUAXgJrjofua+RdkJmEEitQpkTpiOTLYudU
         KgSkO3AZlWLJMk6vOASyf0FPNxF7qdV01HuhLHYLiEwRcYAbPM4rBUtnLbxdvDBIATu7
         AaHh4TFlHaYeVCXDwd9uPYHd/HNxilMGAGwIM0Je5GimYXbadX/G6CdZkaCzV5+BJ0Ub
         Av8w==
X-Forwarded-Encrypted: i=1; AHgh+RpjQaxnWVJaWDAOvVEzK1bHriSIBFNXeVZMMCNo1mvniYDSzynaosWFCSSTBb8wHN+g13ReMuCQWY+/lhKhjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5op6B2FvE+Zjs72t/PvtDZZKQtuOUSS7EnNmH0HuDff00M7hP
	yS9gKw7oVRvPlLKrVNa/yHGZ3AhhAwwgh7qnpmfOzy4SPmhHO/lDsKLLgW7BLxo/4xW/HGGbSp3
	0ZAF6zu3H3syJyAd9+n2X5g4Bzsv0Guw=
X-Gm-Gg: AR+sD12XEYQOGsWpupp1F8H9Wj5uoM0Wgd+95+BwBST09J00zOHgh/vSwGiJBQoHHxR
	RGkKPOSTAqP+//8HqgUbQH+gkd91M54SJqk10QF3uyTAKNvFNfdn/Lxb5ohQtmJnVcqoZBtQlGM
	o3174ENApWQGMLPfLJDyxeLbkk5Ed0Dnf/DFw8OF7pgGUk7DjYlTvD9tvJxqm+1IiqIl3GiR/AL
	LE6AwOZ826UGftHcrKtPcKg4s2PYhuukUlEjJR7NrRPasvllTf51FH2UOY7NrVhchlDqCXpfP0Q
	33/syFkDiD/UG22enb7Vg6oogbO3xiBO/kEpWjZm+sOb8aUpngmcw49FmkMWZ2CmoeoK2oRlcvR
	PdiKefwSi/5vxPhd+Vrs91YcSpEEmR9ip55JgQU8/69ewH46RluP6v2GV
X-Received: by 2002:a17:903:46c7:b0:2c9:b48c:fdec with SMTP id
 d9443c01a7336-2d0ca75d2admr259114625ad.12.1786076613823; Thu, 06 Aug 2026
 21:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806062812.26523-1-phucduc.bui@gmail.com> <20260806062812.26523-2-phucduc.bui@gmail.com>
 <697f8c44-1eef-47c2-8e59-9daa65e6989e@roeck-us.net>
In-Reply-To: <697f8c44-1eef-47c2-8e59-9daa65e6989e@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 7 Aug 2026 11:23:21 +0700
X-Gm-Features: AUfX_myprYNKXNoLAW3iUOi9MfOiRmf4CQgyEzA2vGpsF5wBvkFiXiwoc1ZIH4M
Message-ID: <CAABR9nFqTWPingLM+kPknpU1OfC+2kOqELiT2Ep7wqN5JB6P5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: stm32_iwdg: Propagate -EPROBE_DEFER from
 IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your review.

> > -     if (irq <= 0)
> > +     if (irq == -EPROBE_DEFER)
> > +             return irq;
> > +     if (irq < 0)
> >               return 0;
>
>         if (irq < 0) {
>                 if (irq != -ENXIO)
>                         return irq;
>                 return 0;
>         }
>
> platform_get_irq_optional() does not return 0. and -ENXIO is returned
> if there is no interrupt.

I will send a v2 soon.

Best regards,
Phuc
