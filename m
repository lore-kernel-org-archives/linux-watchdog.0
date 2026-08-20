Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F022D9EFB
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209278; cv=pass; b=Iql+IPODATRVodtaQ70LmwEXk+G6HCm6AtKbML6gUO8b9MDfWL6EJ5PDHAj2Kks4Q45WbxIy77khgg6KIr0j0vxHywz7q/kIQ0jX7Qbg5m4haCHVvn8vOBLYWLzAzud16iydzp/0lL2DIhJaivRY2yvlVHy0oOv/lxPtfyPf43o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209278; c=relaxed/simple;
	bh=Kty3xb0qI1jeD5aDGQBFMdTDAKANoOtIiofJOjvXrz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZD6vVJgL/eGM0k6pWpCYImltqHNc6dqxkiPOufCK1dLfWwDROIj9WwQr0/0CioYe/VBUMULknzIOthIF13yjUFm4zxn74XbQcQeWOkPCh070Ytprtyx1LDFVEcuTkrjNdc0GbZ9CWnD9CqFEi0FGYs8UGMSPMBM7HKoIUPQbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0YL0LrF; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0YL0LrF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso3208291a12.2
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 00:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787209275; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+cxd8h1vgH2JWcKzIdQoO9tHW5K77wzwADqZZ8Vm+xBNjXOC7vR6SnvfbuxCtEr38
         9GGDVgsVHPCXiKE4dJeDHIzY+Rfp1UA0OOFrxzVxmLZ+8AA4oZsbNAT82YbvaJ76XjMk
         1Q5rDaKjxivwxRk1uII+DHJ8ATa14bO1efqswJy3+IJ2UuJXSdqlb7QgUoLasSyObeD4
         WXyud9RNAzZjeX/CKiBob+Q3MJHn4py45fsWhFYQ2PmsYfATMIDEfx/h1QXDMG4vcKbk
         D8fblq4rFdER9OVJi7lt62pcLFV1lpgL4s4irX2ebwwzzvcrnLoKPrtTZ1GJ0W/4e/61
         z7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AJBG4gSSkw0lXa5DQuNF9zreM4sRStgVFPDhjCBnh9U=;
        fh=PUZNCgDWvPHOi4/N7EIDdRnFZZrHWcNUHlNpN+UlQfs=;
        b=jKDRGXErnLpxP/DNtwDYYhV/pj6FfBOwnQuN0s1GpfDLjM0srn5Et+6eg55c6qSXZQ
         qBvwZeP52lg/Vip84nev2bAbPrjOtbk/XHx1bf2CDptIiSa//s+zAlFVEU86aiLiD7mp
         k1jOEuZ1nbJaxB0MTtv4o3eEQmamBp5ZXnmjGe0JvS5FQjGAcYM//pVduE8bhq74ToKq
         bX5cXr1Hqj/4kUdR3zWxDcP9eafzaCWkf5eY0ziJh17xNbzEoS3P8fsUR6wHUH9/k6rX
         xJU4VXop69nhMMzXyi4ylIOJXDPVLzaSklX1dQcdQUDToGI8uzOK5ipuUw6R8F0D87qV
         YE9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787209275; x=1787814075; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJBG4gSSkw0lXa5DQuNF9zreM4sRStgVFPDhjCBnh9U=;
        b=r0YL0LrFjG14nYVhNtaTpnURy7obNEYKMKjuIuHLwUdooLSh6/K0JfIsbAN4i9dqbp
         L8nxOCe+j9y8bQwU6Gy4WM+757RrXXqqUpmTErWwEvVSTFRiE4n8CD+cwoYID13Y96XG
         pvjnTp56b4743esk3kAf3TghyzV0wvSxMqGebUIdsdQ+3N9zqcvqtSQcUOrBv5ouag5t
         lU/rj2e/r3yj5oZmOkmRfM/VcoOilt4rBJLCzkmX3zUGGKHSN+Ca+/bYLfbIsjUCYffx
         ZFalhXGIka5JaWRrBiTwN0JgTgmKKvqPF0mVJEDVwnnjn8oSUObJntIHI05EkLG2LNuT
         WEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787209275; x=1787814075;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AJBG4gSSkw0lXa5DQuNF9zreM4sRStgVFPDhjCBnh9U=;
        b=TI+AvzfdWkqiycAuaN78eM+gjks1WbBFZ0uP0ar+tmc/MPAgD6sNdaxQl+3ODg2BR+
         44G0u3CRl8L7b07JgagGjbqLoNfszYi5vWPZQHVNZx0LUwuY/yRFPPwLYeTerT4LgWIp
         7YrSaVCAzr32/UL3d/8DvIR7wRUizWDoGZqmt5FCDf2SqMK/qB4cyWkKXvdJUu0ZTQak
         1w6FwM1tQhmJsWPO6TitLqqjGxdK0alhpheqKRjavv9h0YMGyWDvdXHlTToRLdcMjgaG
         VX5gLZiiczJocn+KyO0d2AbQIsnlDd+MoiSNqIhOVqGSAIxeKq0xctFqTuodAxzxvFTK
         n9qw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9FJ7WnlUyVTblVeWo0/ZEMX4l4e79d7zaKELg+/6G9RL/ddZ4AP9WSpjKgqW0kJoBZBehuX7mh4I1h/12Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvA6/3KFwaDvjgk4edjlBa7BkBSgLXgl7RriS9xp9/R+YndbYV
	LZtGiKdwZW1cAZQ+4aplCVOfI9wzvbqeymMDxkgi36J4ye+ddfpG2Wdco3fVoq8m4qmV5FvieSV
	h4tP79aTXgq2EmThZaGEZ1JJM96eyQbA5Bg/5
X-Gm-Gg: AR+sD12za9WdVhoi0ib2hr6rHt/MMrf/5Yp/8rm+x0rNnPSV9DVJ9sKJgcSSiDfIiyS
	QBF8/KX1p4Y+LN0S4U2MHIonEFO2Oh8tbqurWlWoK3E9HyNmi7iN6Nmcm7vKuMNs4yyUc3YV6V9
	5BkOS9PFsr9hCb5hpuIN6UWoivvdQhpWOFBaL2eshahPb8eA6wo4cGCTR081BGfNV7v0rXmAiqM
	bztBhofC2OmKE7lfa44ONFIC0qJ7fI9Gkwte171I3qouXRK0+THRbUF9lynhOIcnk8+bmGZ3Ot+
	5+1oAzT5yzXDF+wengRsQUEYoO5BjMXE0w5F0QqkOEU=
X-Received: by 2002:a17:906:ee82:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c242e38bf8bmr723860066b.24.1787209275106; Thu, 20 Aug 2026
 00:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819101853.44681-1-l.scorcia@gmail.com> <20260819101853.44681-4-l.scorcia@gmail.com>
 <h6cxeranayykvjnco5vuaoccuknoiu4yiancmwugouewucb5k5@osmdfzfc5dsh>
In-Reply-To: <h6cxeranayykvjnco5vuaoccuknoiu4yiancmwugouewucb5k5@osmdfzfc5dsh>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 20 Aug 2026 09:01:03 +0200
X-Gm-Features: AcwNN1XJDhHftqNShtFzkYfbAjGi7imuQVN4JqERVqBvua6db_cDNPHETOvjtjs
Message-ID: <CAORyz2KMg1-zxSPVCiFCiC4EpVFyR9=Tcowim9vVzv-g7SS35Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] arm: dts: mediatek: mt6589: Enable toprgu reset controller
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

> Please drop my Signed-off-by from this patch.

Of course, I'll do that in the next iteration of the series.

> By the way, this header is not used by any part of mt6589.dtsi,
> so I think this line can simply be dropped.

You are right, I will remove it.

Thank you!
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
