Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067A47798E
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840933; cv=pass; b=Djby51rqvvVLPMnyqOR6uQ7agkiHPnCNBBFuUbSfr1CNI/JD0LnI9WRZHHLmO6jRbkhQTK57DbSmZEHoCmXZSnz0Wo+1bz0cbiV5HZq2wK0TLvuDc1k8qSlV0LpsGu3pR8C8CKVcvRPmaIBIPYxpDpWfeKST1LfEySdFryrlOws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840933; c=relaxed/simple;
	bh=vhi9ep+bQeVrexD8hO9D7KsCbKUp25LBBrjX+Y5IaQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6tNqRAp3x6RrteiJYlr4KsR2QamkeMHtcB9QpMJavWgIm5A3f1V19l04Xb+flaj6BjMhedH298Y0yO+HtwV33rw5z7B8Z1ggtNwGD7HZ9exLpP9Z81M838bTBKStZOtLkzrxKb2syDdORNEYcJHdbLeFadufs7VncauparY0Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad0ZxIPI; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad0ZxIPI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso342015466b.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 07:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787840929; cv=none;
        d=google.com; s=arc-20260327;
        b=nksPND8QZPvNakOqVxAiddoEtdG/crS2lhh9ZNJ6eyf59cfuD4fmMOy3UR3XhKYkqo
         WeFFChhcAy0gPbZB8AaTI+8X09q79i5rXhKOWRJWuk/lTEY19CqBpSb5+03YxUAiACLg
         CvBeJ3tx4mSPQdK5L+Sj/mWYeG04ZEH1+R3R3RjLGLuQfGkilP/3wI1THQq6Ko5qgop/
         E+RzoHrTrp3vTRudf5wMcoFzm2elVMsNI8mXMN/ENC4nxvZZoj/2cMbIAC5JAYbCWf7/
         LF7XZDuImlydHipAYyb0mMbcBiIxEi1SwG3G/gbFQ/Ek4ANJETobDZA2sDWVyKl+M8Zl
         QG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H7NWHYQKU4joAJPyYxanKoDvZTJs0XozDUX3Hghfkuo=;
        fh=0UmxfsQH63OoFzpkHatUHwsWVJWzPR507oa19TJBobs=;
        b=bC5H1efEeksyxnPgnug72AOViserGIcG4Lmj0odSzCv042o/+cTJ34iITbIptX+lk9
         Vg+V7K7g0GjHc6b/Q+QyJW0a4xKM/wwe55qapsAXjMWeBBWO8kbRBLPBpz+RCS4GqpJ2
         iG2gW/1jBggOUDYdr2v7gxA310bVzHPtGd24+iuL7zN1wJFjBalvS6U/ZZAg5ByaznHT
         Qzq3nXpb21RvlRm6u09zlfQOgJIGrbWWWD2ViRe0uYgNTaJDNQv0TTbad3U68iQAveoL
         Je4zSC6d1LIQXx427uuGiJM9Jws0kDjAsitZLGBYAK6i4kLB0etWH7QdafcWOKEPTJaC
         /KzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787840929; x=1788445729; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7NWHYQKU4joAJPyYxanKoDvZTJs0XozDUX3Hghfkuo=;
        b=Ad0ZxIPID+Ol7soMh/NZC59Kn55HP3nXZEokv94wlOkP6L5LvdQhbkb33O8C7/JApy
         XXq2xVzCsHHU2SEAytiAI21UaDWrnmQKWBr//sIfnS1H/8JurLfVKSsLw96MlsSw5SRs
         RWloO7hBuQmJrGKZLrbye7xRUA9XBmvoel/3VDQUfrAVCQ+lYLGZHIxTPphZ4vX7E+zq
         gKSU46alGeuhZEnCdRTqZj2qES3QJuPpwurO/gMVIAtWftPet53eUK94XDA9rvqWSWFB
         URRLOtGhjJ6MYjbkW/YMoNMP9bKx5u91OItlqQPn1Zqay1V0JU+aDao+LpvdhPaQ9vDb
         xSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787840929; x=1788445729;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H7NWHYQKU4joAJPyYxanKoDvZTJs0XozDUX3Hghfkuo=;
        b=qta1lXL+koLTmj90gPXP3/sOGPHZsMfMuzFTbVj/TV7NgCDifWaHqb4LTCqQs/e6Sf
         iZGUVqfyk4WClaLalznTFaLcbldC4pVxcDl8cWyjOL6AbvH+Ok18u2JF05PRHhgZ9pAl
         EcvvdA76dW3yIVnqIsao/gNsmOhm4tZFPac3DgJkYoKllhmRqJAsyZcjRyqM/o45bo9b
         U4Wg+B6VqJfg7OB1z7VWF6/lZQRvt0o0woqzeoDZmpkmPgEkfRKQYr1ESVW/9n6ZUQvu
         FNoYOxL/bxGKelH94L09lrmVLSh7xSSzRTdE+4K8ekjfho390l1hwRD8OPJrnDBfEvEV
         BMow==
X-Forwarded-Encrypted: i=1; AHgh+RrdnD9m9jaynAy9xoBKmuYwVjAJgOn7QA8HOf1WVueW9DarsMpJb/ZJcPTcOfbsKIrw42RVJnnf1vcDK1NIZw==@vger.kernel.org
X-Gm-Message-State: AFuF++lekRg1ll/wQrdN6rjtV9/mH+nzHL1e3IJYIncKyMYm/hiyKULB
	r5zVM699R00KEUa61fASRIMtY5gEDZuZtny8XEDtu2Ws8L8jD1TDF1/Ir9pUI1UtzydWJGqCK1J
	ENdo1KpZRBFaHkEDswBeUGksD86RTo5o=
X-Gm-Gg: AR+sD11Nn4+kweY11kysjDMNTvsb5cRRO1C3H1f2ve9rDreV5U+Oq71eIiVTd+1uzzL
	IMYP/hrg97oB1Z6dqiihQ1E+AqXt+sQiMFop5ZzAw66Oaxle+M4N9FvCoTEgqVkqm177x07nl/8
	wpNL37XcufSUdCIa34v15gy0/EubqZl5eO05qyLS5cwc/LkhGPuHD6MouJTzi8WmOf2uOah/ym/
	f0maV+ZkYDTwO8UDavEZtN+0LlX79EjVAE6DJuxZIDAYsFuB1U1rQ2YIsSvZhfL4jPkPiE+LDkL
	AVwdOgxl4tW8DKsdEGVhO06ByZiIIjKJKkvPt0qwLpI=
X-Received: by 2002:a17:907:e98b:b0:c15:ee0d:9a32 with SMTP id
 a640c23a62f3a-c250c2e545amr1440724266b.21.1787840928409; Thu, 27 Aug 2026
 07:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819101853.44681-1-l.scorcia@gmail.com> <20260819101853.44681-3-l.scorcia@gmail.com>
 <20260827-clever-cherry-zebu-6a98f1@quoll>
In-Reply-To: <20260827-clever-cherry-zebu-6a98f1@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 27 Aug 2026 16:28:36 +0200
X-Gm-Features: AcwNN1WwMj244ofyHxGC6S8z0K_T3xrDTw62tkx0k_I8FGnpAKJxs0-SepEND74
Message-ID: <CAORyz2KCAzEEsCifDF4+_wKmi=M6t4EKVVqys-H5wOQqzBeVzw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] watchdog: mediatek: Add wdt/toprgu resets for mt6589
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

> >  drivers/watchdog/mtk_wdt.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > index 91d110646e16..f8208fb0f723 100644
> > --- a/drivers/watchdog/mtk_wdt.c
> > +++ b/drivers/watchdog/mtk_wdt.c
> > @@ -10,6 +10,7 @@
> >   */
> >
> >  #include <dt-bindings/reset/mt2712-resets.h>
> > +#include <dt-bindings/reset/mediatek,mt6589-wdt.h>
>
> I do not see how you use the bindings here, so my previous comments
> stay. You just ignored it and never replied. In such case:
>
> NAK

The mtk_wdt driver requires the total number of available resets to
register the reset controller. This was defined as
MT6589_TOPRGU_SW_RST_NUM in the binding header, therefore the need for
including it.
In your review for patch v4 1/7 [1] you mentioned that that define
should be dropped as it's not really a binding, so for the next
revision I'll drop that define from the binding header and move it
directly inside the driver. The include won't then be necessary.

Thank you for your help!

[1] https://lists.infradead.org/pipermail/linux-mediatek/2026-August/112272.html
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
