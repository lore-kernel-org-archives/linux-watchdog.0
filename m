Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FB34040B
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161429; cv=none; b=LJypX4MCOv3OD71c02Hq4aJkiwPq7Ni+bBo4lEkOaGNqyNFjB4aHbHm2q8zghBMcs8VJNO+/DmEjj7xMuBp9HGSiaofSGXv1Jweh1IBmFyzgBI0hvyPvqGxUDwpRjVkQMaYvlyJ2IiR/e1FWXo9+dIUTPRXfGmYpwVOgO2Ey8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161429; c=relaxed/simple;
	bh=id3Dxe/P4MfWWmZiXGnhFZlAAOU9h5n9D1vsPleVvLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6NNYoXmCz527xfREeuafgI38P4oHw/PUIVgjPgXHYygC8qtA75h7OKO2W0QUoXmExsP7uW66AZLiwBhy7F2fGTthTwDOmDwPZjKw7eS/cmwH1uL9n4zJ1doy77IW8yb04+3Tp3C8YBYttKGnravE1HLOmBYnM7u9vaogPlmr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giZrlR3/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giZrlR3/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d560775ca2so10518655ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787161428; x=1787766228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7MtCs8dnl1tQU2h4oXHMcOoDEsGNNkInvX360HS1foA=;
        b=giZrlR3/rNM2qGHOvFYKZqcCCa/oVjCKZqE9dkn3Vai/VXJhaqUkOIkS7Ih7xXa25H
         6mdzKgNrI9LeRBmRVL/vVo4BquJW3jUBIJyBkv+5K19k3yeEcgppym5ivzoLcZGnuMFh
         x7Drg59I4uS3J07yZAiA+nXisYTg3ZBp2wK6GZbhbSNvafAhuCnCu2IRvbiLlEtCherz
         ICCL6gO3XWV6MDQ0qcPcN5icNlKDMOnYIjJlTx/1r3nrJ19q/rW17s+GMOJF+aEED9Ti
         kNdDa3c44N+MFGLea0wW4NK2ReTVMlIKog2C1Lgl3AQ0Ewfrft5+IvAJgh0eUkMC5AaK
         ZrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161428; x=1787766228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MtCs8dnl1tQU2h4oXHMcOoDEsGNNkInvX360HS1foA=;
        b=L0sNw7kiqOg0DOXdi3vvXer67wqzkbAVaRfwGDixHKqoSVfqfOxwqXinBKFCzQNA0z
         qRwGgjX4BXIDenxCTqqo62KVt4P+2o9oDNIhyDsdLXbgKkRyEF3s7AYiH3FT81/l6sxX
         CawTBKue1tgnizs2+dWJXtN9Fddh1CCRFaNt4KbtR0zyGYntV9kOAAxjmH6E9d3SoB0/
         JK66PqWUmIYtH1qYQWaaniCijFgwKyEXqoYzG0J6xDpSEi52v+T7oEKE7jsbBFqzGTif
         /VQtgdKFGZDnwc4iT+sFhTIU4FTTYDh8qKwyAYsMO1iRRZG5gALfzWB9c0IXXTQzZc0B
         nJ6g==
X-Forwarded-Encrypted: i=1; AHgh+Rp6xDn8rHaJoQ6HySCn4yb5nugmpyDTJtQ0iA+jZub2kJqd+PHrPHL01HtCtv2pj81vqBsULl8InyGZls746Q==@vger.kernel.org
X-Gm-Message-State: AFuF++llOloxyQExwqiQ6CGG/Q19lLUSXHL253+V+Hgz9uvMk7zQycA4
	aq+f7/PtI8JOnG5uc5ROa9pN4+IKlsN22Rdj8B+yZNC3H2v/JQSlcxq2xe5mbw==
X-Gm-Gg: AR+sD13s07hftvDijb1l0WQYKNHsJw3InWbaKuf+/4B3ofVDxW34XpmhwD+KEgvprhE
	b4o2h4SQuTK+MDBau7PHafgIzeTTcAI968kTkSLnaWErcyq0X3Mc7hTZ8Hh7yNH/6hH8kyGYNPA
	9wNyDTD8hB+YQezsvqFc2FnYhO/OOgxG6ktE1BkQRJ+2dV/zS3ZW5ogJeghWGDLIKz3uV+v0P9Y
	pA8C1KCmnWqNm9FbVqgSdIHN1o/wOes4gjELeqQ/08WrKR4D7omY+HcK/GsC3GYQCR/8nU0FlaX
	rw6yKk2phPSuy02XJoG0I6Xs5ypIvwm0cyK8Edo1bibcsZxP0lbraNafisxUovodRsyTL/tjCOb
	x3zwov/h8IufdmMaYF0qYr3VZHXJqrO4u32Tyl5s8K8eTgEXGOQLGdxy8oZAWOLu17K/fRnQHoV
	MOv600gP0hnOfLsIS7Ra0u56+ZwXIHDQnvjlvwZnDJKaJ9Ok+lfo8fL6iQSNPPYxTax4VLCTHcD
	O4bnHpIX0uEuwfJ9Oqu
X-Received: by 2002:a17:902:fda6:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d60186263bmr126123935ad.11.1787161427501;
        Wed, 19 Aug 2026 10:43:47 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e81sm30466825ad.1.2026.08.19.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:43:47 -0700 (PDT)
Date: Thu, 20 Aug 2026 02:43:43 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/7] arm: dts: mediatek: mt6589: Enable toprgu reset
 controller
Message-ID: <h6cxeranayykvjnco5vuaoccuknoiu4yiancmwugouewucb5k5@osmdfzfc5dsh>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819101853.44681-4-l.scorcia@gmail.com>

Hi,

I noticed that my Signed-off-by is still present on this patch in v4.

On Wed, Aug 19, 2026 at 12:16:24PM +0200, Luca Leonardo Scorcia wrote:
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sorry for confusing you with the v3 patch discussion. As discussed in
v3, my Signed-off-by should not be included in the sign-off chain.

Please drop my Signed-off-by from this patch.

> --- a/arch/arm/boot/dts/mediatek/mt6589.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt6589.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset/mediatek,mt6589-wdt.h>

By the way, this header is not used by any part of mt6589.dtsi,
so I think this line can simply be dropped.

Best regards,
Akari
