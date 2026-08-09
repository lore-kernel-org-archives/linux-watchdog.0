Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047A30FF36
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295297; cv=pass; b=tJewmllOZexkk8QxmcWcCh9iVo8/rQ7sfkWgpHzOb0ZdqW1EVXSdZgdXtm1Vpymm8Dyto+7pS36yJ3KXndq7KBOdUmk7jJIkzbwHoR+pKKB+nSdu2s9oUhjDh6XPStauidmKqrDom2YpR7s0QYVVnX/WdFqsuUXUF8R+jAOlnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295297; c=relaxed/simple;
	bh=vE6SM6kyLtlUp8Szi7B5r+qZKdKoy0TT2JHe66YwcQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4Dnu92heHRmsmgvBanJNIxoS0x8zHo0Cp6HGLMtzA/7Xd+p173gCcRrE9rk/yK6e/Pb+vld2JHAhvalBVnitHPUTVWMTtndZCEYKc7qoWPBSuLI7Ln0/q5rJGgfAXoIiSE/93J4sXZvDVJycj4GLbT3OakmbaOqJd/wVy1oerM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg/e7hYZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg/e7hYZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so808467a12.2
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 10:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786295294; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/coDLiz2MyJIjD4knKiiwB2FNaXBfI9Z1ve0ARf57zrs2ucyzj4M4dN52Ut5Liwrn
         pLVmczkfAb0cCWfrRKmLF1SuECFZf7p2PoSzrNGwuDQBjji5ZLiyNzaVyQdGCX8uuTN2
         BY/zt92QFXD5FJRjKPsAUwbUZ8FNudzeN34A4EXOAp8MrmQcJqZtN1/pn8hF27a1kh+n
         Pu3PhEN5CT/XT8VgHQOx15LQrLvALJ8mSVZzrApITHw2mhpSImfDh9ebHBJcC1bTgdRX
         MJWJ2rQ74wainyToVbk+2mojjgAga3mji9SN7uarB/4yMx3j8AjgnO6cosBlS+2v/7Uh
         Tv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8l7N5DEp4BhX7FXyEm1h5RGW0uDs9b178Mc0RCItNl4=;
        fh=NkSaz3bgJi/7X8kaKVpWSmW81sgZ5pJiJWe1VxfVhHo=;
        b=rbDcRGn8enSddJRMtuvZE3CnpMF58UX8qc4GjxxgNtok97eYht0eWEOrHxCSg/cgXe
         EJCEmmYG99aP65hxN0wgDcij17Wg+d39jgMf53j6L0bD+cb4NQAxEpg3j055+Z5YIwDu
         74d7tsu+u7ArECimvfquPIrAodWyv+xdtZrRKGy2p/te32MjaJ2o6i5KC+jVBhRvYtnG
         l4Fylg4/lRtgnskwZxd83Dd+MklS+xC0y27zHOK+qup7WQupHda73y6nDtUnrfKHO/co
         rzK2rvC3mZpApYbTKBJK4MbZt8Ob5VuuksbrfV9+nF+mvXRAfOmrkq1rQSoWK/DAU6cQ
         oqKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786295294; x=1786900094; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l7N5DEp4BhX7FXyEm1h5RGW0uDs9b178Mc0RCItNl4=;
        b=fg/e7hYZ4CLfl7b7kANBz/93lUNiZF+l1FJG49cVAHBQ3vSj/zI/pEAy8Ry9I6rEGK
         cu4ZQxXn+7GikmwtHYnXcc8I8xvROKj/RuNuCAR+/a7N5iUCcf8fue2SIRX7kIfAHqpH
         6VvnHcFbOMm0JXadx8V5a3oAAq040RGoigHoU19UklC/zC/JTT5cxH8qxMM76B10LSLa
         Sqsd/4v+v91GIM9pdS/63cfwXu3U0fqp6xOYfZ231+SBTQm07b8OAbnfaITic9B4WGQ8
         lBJ0iSZzjBl1r1QszAE0dPbeNlTPzjbddSibgSbH84m7MS23/IGAW8RS3mj3fTyAowZs
         er+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786295294; x=1786900094;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8l7N5DEp4BhX7FXyEm1h5RGW0uDs9b178Mc0RCItNl4=;
        b=p4Yhgfn40S1LsVB2+NQTzNr2HV5KYBOwLIqVUSAyeL1b8AWlz9jOCRq2phDM4J9v2Q
         STKfE0P4/MTC9OZ4O57Ti7C7E1r3VJQ8Ijy8Du9m0Ijjq1B07SyWAUQZczBN2fJhhvrH
         ZCWlOcJ4JCh44icaQN39Z9nkYkQKRSa8uN1BP/U2yiG3XS/2gLe9IQbw9GXwyAb0PUnu
         gVbcSJubdYhZqB1v84DrZH7WufBqVNEuS2vDlPmHXVGuDO3T0i7nkH0reBkc82suMTP1
         xK4UewW6vhcTUz/QwHe7Wozm42wWqDINduHw88RNBLok+cCRWQw8TQNTfaT+qFD10K8V
         gRoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq10DGJCv/yj37x7ioBo9vwEozg7e1H4BBcEG7zqvWk8k45KIIKTj4nFkS9671p3wlr6jOsf2ui2bqgZ5Ck1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+n8yh0c3dOZbYCxhhqQuWXFo+Pt3oWUFeT4lsdZouWCVkptuN
	sxM5BQt0Ryta9+kPfatrJDScRhcd3kYltAdMaDeEuNEDLI72sSqMh+ls1aIB+o1fqSPHRQzUqdC
	ldDpeeI+YqMBT5ko764EcRvSvfxkVtZc=
X-Gm-Gg: AR+sD12NuIpn4EvBzQiRadq4Lt9a4vSRcHFWeLnxR9RJc+AEFhqes4GcT1jHfyfQQly
	WUBkRnHRYEthHGVst5WDrEDk8d28vCYNpNxZlliJ1l7kW/MNt5JDk8sTzDl4gxAwP25XWsGfjV5
	GDeJGPEn1oc0KWevYdvO4HldKftkONbDWE4+xit72Lxkkn5QGR241Y3ga5jG39h0l7ffHRMUsvZ
	wiF+aeQGZYXF7HO0qhWD/SIc0XRVuc4WBslAy3XsN/VuxPq1qmiCER3idyd6bJObZGQhvB4sweu
	SXv2ui1XTKWiqenebFLgJRP2o20y2SY3UETFuD4c2Alf7JA+Msm5B+UrxfTSDjxVVOPXs3F+3/c
	=
X-Received: by 2002:a05:6402:52cc:b0:69f:cb2f:7a9f with SMTP id
 4fb4d7f45d1cf-6a1f24a6398mr5908345a12.0.1786295294390; Sun, 09 Aug 2026
 10:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-4-l.scorcia@gmail.com>
 <aniv5B4jz07mI70D@buffalo-ssd>
In-Reply-To: <aniv5B4jz07mI70D@buffalo-ssd>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Sun, 9 Aug 2026 19:08:02 +0200
X-Gm-Features: AUfX_myTNLmmUZQ4XLSt8EOVRxvsoxIzUMQsNPl9nlvxlnEuIvs9heC-YuaZVok
Message-ID: <CAORyz2KJMY6OvFQEB2GU0P7CkxothuXOCXgCcRvtiUhhPaK1ig@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset controller
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

I apologize for the mistake - if a new revision will be necessary I'll
correct it with the Acked-by tag.
Thank you!

Il giorno dom 9 ago 2026 alle ore 19:04 Akari Tsuyukusa
<akkun11.open@gmail.com> ha scritto:
>
> On Sun, Aug 09, 2026 at 06:03:27PM +0200, Luca Leonardo Scorcia wrote:
> > Enable the toprgu reset controller feature for the mt6589 SoC. This
> > allows generating reset signals for the 12 subsystems managed by its
> > top reset generation unit.
> >
> > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> > Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> > ---
> >  arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
>
> I provided "Acked-by", not "Signed-off-by"...
> https://lore.kernel.org/linux-mediatek/amEBgRmQktZ44jc1@buffalo-ssd/
>
> PS: I am also fine with this patch carrying my Signed-off-by.
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
>
> Best Regards,
> Akari



-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
