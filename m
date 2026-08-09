Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98F390CB7
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786301766; cv=pass; b=F/uHxZWabofY5NDEPgeonTk7r5SuenPzc1QJ6P3ZRHYvilE7D0Ol7YIwcTIZgSqPt6cmIPBA4KAN1MKdXSF0lNM/c4/f/Dgv4tz4eDaA42WCFhhQ9CMYx4+Tyztp+dlR38z5tcy96BDEdEEp/0BZgGtyQzcUwwt0wfFXoSlxs5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786301766; c=relaxed/simple;
	bh=IdyFU4nUNYjMMnXZPL+V9LxnoFaNd6/XEOxFvE07zBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9O0jMBhYRfGkfvhqUK+eX6RlhllHkQeH2P1YwrfCWomLBZ2E6+JNNnNY/QFdLbfZ65yJ9OkB8fHcX9zjUnQ5HniFYkJTK6LMNZqfX1n1PqtgKSvQWwyQSQci9B/3Qzhps3/pKeE/98yqtQU7e80UjKktYXd33BdJGDGJuAdzFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igKEKwhh; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igKEKwhh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1600d040e4so158755766b.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 11:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786301762; cv=none;
        d=google.com; s=arc-20260327;
        b=nufyuzumuVdXlsv8HXO3Ut9Zn3lJRLDH+WU+zeefikhGF5ydVIWqOrvH+i82ufi+0Q
         yG02wcgqzfS8ix4QlXvyTIVoO85F5lQ9QGFdx7KtOYmaSE646vBuwDwQQXiiBZw6qSeh
         aWAf2Uop/5XonkOEemzCz9VKNs0thNfCUPj63tUEGBVIxMe+nFiNVxkMYGozoIoaOofO
         j4zlDimaCCTEW0grSrp8eGkmoB3NOMMX6iv4khZuwNc/oI/oCDTv74Rw2PkJMcRT3Yo7
         USKODfFOkzQWiqge7zqtfio04dB4+DY619ncOc3n7W/8UWirGmFH/eM/09zRsnTRGVVe
         C45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fKfWVbm9KpeTwL3/mVwrfju84PrObkxu9nWfkWUyNGM=;
        fh=R/x3EseXEYY83jjC/9kRuRXr99mqMO7Tp4I7a6YZhvQ=;
        b=plt6KA6UHIWJTm+Ekjq/oVGLKD5n8BOeiFuZbDfl96/LLmyymI08BJ5m0pGbulInl1
         bUK4NNOcZmtS28jkOo6pxMkeb3jo6j2qzxVNVIbckukwByeKaHtd2KpbLK0rYhaIMBD+
         y/GB6vxU/Y0Sye16NMM3CnRGRZRPZrLk7n41hFJMjg99hJzpVIo/d9MN7xUcEDb60iuz
         2YftZ5R6GjAtw66yn9QkmOAIRQO1kfQtXu8PgBzVv+/CL3wfMAGks2fguSzdpG22lhI4
         /K0DJpxtGn3GtsfcVzZrSaNn0ev6//25jfvyfy9CSJt16nm9c+iFPvujWEYIhRenGlAg
         GiHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786301762; x=1786906562; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKfWVbm9KpeTwL3/mVwrfju84PrObkxu9nWfkWUyNGM=;
        b=igKEKwhhpKdo8JzARV0rrzII7QLKfrtD8d4H/fxhSxIhn3R/LUhblqvJE//sxEbqly
         n8LkDJhXwqnvcR2Plw0vwBtjEBFnG2WXGJk/Z7jvNNultSKm2ZzFa2SYfHpaIC/wqMYh
         +bGjTQoPMAL2m6ioYWVxYijEjesCe5G+S1VkkWH7JplrkjFcHhCeprwQkHZYBxVBNCer
         MSRXDo1NuhiO6wstx0AGfFbB3sGPu4CtSt98VNuUtsIBhdu3KZ5t+5om42dqS5sdH9fx
         vIPC2vi8T/QSzM1FI1ZSPDeUIcZnlQgVy8qF/k5JdEHTN3YJp/wWFe79vWvFgwYhMdcW
         X/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786301762; x=1786906562;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fKfWVbm9KpeTwL3/mVwrfju84PrObkxu9nWfkWUyNGM=;
        b=O9fjHHisJHwWm6Eo7TrqqhbueTYXqv+bS++wjcXGGdQCcV34CPVeMCaO3VB0Kpngo9
         PA8NZpBBXVw3Yxa4jYLgU0PSjgYp+HV/SeGwYekhje6PniWTB8sQMP4aBrk6xAXTVfap
         Kky10/IYmfTg8XjMz9gFoOyBNoL/6cPJ63pgEusE4ScZEeNNAqi5yRgfcmA7089bD2fw
         Kh9XQiTqZi7x82k3g6KPXuGypmmaiVGVjhkKLl9GeV3dW1hmduzDxQC+DCExbQu/P63h
         q9gNCnSmt3j0gKBDV9OKDzNLPaFnD0ZLaZbOSLtE4Of9UehfcL1VQCzt89pVVgTips0G
         8eLw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5yL075Ol8LtDNagkSgrJNwmSuhS9DMyGuuqw+3rAhESEMml0iW4IGmpRktJZUwQYIoWHCdRuYNUdkSfWDAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54cJeNQrH51djtchepdSRlL8k/oAJOdXLsXxoN+68Shs9CgpI
	XIRWBikSoa9AwW50LqfEJEuUAVeOscdX5rSbhW427v++l1GHNWh4iQ6Bo2wXyX4haHpWWC/Hc11
	HC0CCXV5lJPnU6CmcqxKYNx+7Xm74GWs=
X-Gm-Gg: AR+sD12VJiRR3uj+o+1KbRGAcbdr9prfhfVP3l9rheqPPSXKsYFpzX/Z19serIWNKDk
	dNvD4HYrn44pEtrllWPo8jgoDlhwiaT3mLZciBU5qAxnXK9Xn+AoUFK7sJoI+drcorAAH6c1Zfl
	Te+UuLG97PU0kkFWPLiEIVSjm4TfgAdE38MgKI5N6lVIoqjrqnGMeNbEkARXhiGIchRUlP69vuM
	/I3KzMgEB9w3GEGzqs5Wi/aAJ1KwjW3eFQVEeY+qs4tR+r1uGXy7KOu0FL95GEWZ6UiiHQ+Z6H+
	8geaMOJiwnb4hd/TpT/cgy9td5pYs+W57nP9quEi1QLwQMLgO+SkEYhk15bNi7/nfGOGSmxzJvf
	eDv27DA8LfQ==
X-Received: by 2002:a17:907:962a:b0:c12:b58c:fd7a with SMTP id
 a640c23a62f3a-c208d4b5c1bmr643267266b.9.1786301762159; Sun, 09 Aug 2026
 11:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-4-l.scorcia@gmail.com>
 <aniv5B4jz07mI70D@buffalo-ssd> <0e4dfe8b-af67-4dcf-92fc-cd564d7c3744@roeck-us.net>
In-Reply-To: <0e4dfe8b-af67-4dcf-92fc-cd564d7c3744@roeck-us.net>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Sun, 9 Aug 2026 20:55:51 +0200
X-Gm-Features: AUfX_mw2G_pgmXXoJxjvv-8va564k6KXHRWKZyjeue4zkg_p1JWDElM0hRbQ6kQ
Message-ID: <CAORyz2+op80Tj1Ax1PD8wN9fAT5QfAev+vEPBgihvM0O-tWXPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset controller
To: Guenter Roeck <linux@roeck-us.net>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>, linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I added his Signed-off tag as he provided basically this same patch in
a separate series [1] slightly before this submission and I wanted to
acknowledge his work. As far as I understand, this attribution is
within the guidelines.

[1] https://lore.kernel.org/linux-mediatek/20260716161923.266315-8-akkun11.open@gmail.com/

Il giorno dom 9 ago 2026 alle ore 19:49 Guenter Roeck
<linux@roeck-us.net> ha scritto:
>
> On 8/9/26 10:04, Akari Tsuyukusa wrote:
> > On Sun, Aug 09, 2026 at 06:03:27PM +0200, Luca Leonardo Scorcia wrote:
> >> Enable the toprgu reset controller feature for the mt6589 SoC. This
> >> allows generating reset signals for the 12 subsystems managed by its
> >> top reset generation unit.
> >>
> >> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> >> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> >> ---
> >>   arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
> >>   1 file changed, 2 insertions(+)
> >
> > I provided "Acked-by", not "Signed-off-by"...
> > https://lore.kernel.org/linux-mediatek/amEBgRmQktZ44jc1@buffalo-ssd/
> >
> > PS: I am also fine with this patch carrying my Signed-off-by.
> > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> >
>
> That is completely inappropriate and unacceptable. You are not in the
> Sign-off chain.
>
> Guenter
>


-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
