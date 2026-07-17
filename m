Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8D3D25CE
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272410; cv=pass; b=fdrdfnI0F6tVzYQSLOKgd+FBwD+t9cT0N4UpyXPQq+oHMmk2NJnvYfcUCF9FudygdR/4q1qNxTaHf2ejgOyluiJnF1xlK9DayKXE59djom/dFfySEYF6JVlltZO+1NJXm8mn2hBoeI2tKo5QRn2q759ivGFKUXD3aCzFd4Ox7nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272410; c=relaxed/simple;
	bh=g9+oyG6jqj4Pqj8nJndEWPVlC24dF09myG8cBJZ5TrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHM7VzVAs76VqgwyBTHRvU77m+rELUyfhmK3NXR19u148mU95m8lj5V9D1kNqJ00ua+c4Er/S7POcccdSh7/zLeH4Kyu3J0VICWRAgoJLnCy6YhCOOV3AN79EBKSCFBXgZwHwm7g4qv2XXFz8pekooiKTgewEA7yJpiKOVBfpdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6wBtMIy; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6wBtMIy"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so32504191cf.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 00:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784272408; cv=none;
        d=google.com; s=arc-20260327;
        b=mb0DUSVCNu1ZR8ypgtERhkGAvOVmb0gZ8nLgPuUWB+9G9b+1OIuTNKxtk6J9SJNnN9
         iXsMxhz+v2bt1oSKT/XKVSePZAbnIqPZt4wLO8L3bbJSupUUHFDHiDCuXt10+Y9EB+/J
         KatoQ8w/n8EEIC1+Cqw++g+GTURYnc59Haz3EKn6OPqjkUX+KzGf9c6u6/VYDWtZbz6n
         vwjmKHn12ScanCOdOr0259sMm2wiD1nWrWHfheKSZBQ7Bx3PcgLPmAZuH/Ay+LJSA4w5
         XoCKpgv6Zx0fZtbud09BixDCAk+kMgxVkMKGGW2sUOndCB1xVdxtu1KUp5n3FWOo2XxU
         X+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g9+oyG6jqj4Pqj8nJndEWPVlC24dF09myG8cBJZ5TrA=;
        fh=KStcq/BLMUNHsPQJdAok51lGDVgHi5djzN/H+8S2bPk=;
        b=awwnHJbYVFru18h5kXmyFMhb68Lb84xOJGmBiiNO2C2I8bo4NgLiWHp32o18hXzbYQ
         sNRDEprsSABp7WHPNZtq4kc7BMgsMUT67jQWm89s07VFT8HdeiPQD7NncZaYm7UgyaI8
         rWaK1pPRDPBBT+ifWTxBRDr6sIS2khKL3ODGjtbdpRNDJQM+Os8h5yPS0wHPD4v6amMB
         7jRn/D1Sdbk67fy0WtF4v6yUkKRYki5Sy8uCI3JHqDtlPuIVB8aOpWZ0b+dYeO7ml+ku
         A0/sfxFqMa/qMWfw2dO31MQnDx8OY7SX1u5s7lH9YWPj30O47LD2HwONsMby/owYLonh
         3nLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784272408; x=1784877208; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9+oyG6jqj4Pqj8nJndEWPVlC24dF09myG8cBJZ5TrA=;
        b=C6wBtMIyGruEmyuNmGbdWg+pH3Tqc1j2HgxF3s/f3hGmjR4+0WTwu2QK/5T5NMWe82
         UIyoLG4QLQGj7/S/SovPj8rrdrGhLPc8U2HL3KlsNQttztRz3giHHLxNx9K3OkshVuUI
         ++7gIBpX+WADbaRcbvv0jy/GruOw6SOo7OnhKvuGO5QYbysVp1O8N3PNIBC5VU8BL5ie
         J4h9Pi61p8O2gxG+cq17SlUmqbZ6xgiq5BGqwGC+plLBt9lobXHuOKb5vhdYltQIBX7O
         qp9z79UfqFe0J51HWETq086sPgfFu2mFok3oQ1fTJPcgkGtAjZ+MbvQfEUFOqO7rSmgm
         gJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784272408; x=1784877208;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9+oyG6jqj4Pqj8nJndEWPVlC24dF09myG8cBJZ5TrA=;
        b=oKOYzij0Xb2fesjlDE5rgUFWiHgNXsgIrlWBUu6GIeAevoZEVbP3fKSdGxDYwk9KUG
         q2ZPpNXtMad/Qr21lICAlL0OKyibegE35mL/rKo+51iNQkyfbVZEStwRMmbahthNuspu
         d6P9HXWjvxM4ff+B3+m++Bb7CcM0GdF++et1R4bfgpUfCSi/GXPGSlUeB5FNwNzhsSm5
         uDsjPYM0MRX6kV6DJ5zlhjr3fJGkSWx+ScWqRaAOiIi9p5lIftW2lfyyZDqKLAKRUqtU
         YFR3YPlLidp1Jt/zS64toiS3Ipdo/ED+ZugU5XUqwwo+o27F2wgrtg+UUyPuypvSHhMV
         qpXA==
X-Gm-Message-State: AOJu0YyOTVO9xF7MSY9jCtlPv6HUTMERdUqBDQ2+UftHEtxqWxqNFFN/
	N4O2ZLisdb5r1ph77iwR+2dhLqdrDbHQSgFi3/XfzGfRyN+nrpgTx6YYYT3PkwKDBaOoxpiac1H
	3g0QzToPU/6CBw3VUYvOOLi/I96GXWb4=
X-Gm-Gg: AfdE7ckSZsCvqr7HqNzh5WkvFiYi9R5MatbkBcaR3qdG19U9/zAp1s48Vv11KreXRF2
	nkyD4o3TeRnOBdEUFtvaAwZK6HL6l0IVD4rxBPV3nEYoTsftOOrwFc0w4Cb4tBkBDLYI03uD228
	5hCHqKrm9TqKO/Ir8DmN7Xsq2QCle+r1ArrQhN50FCtTelVk0ZRCZY1ieWs9y6EkUVWAJN3xl3Z
	VoVK+y99pL7z82fKU50zrRYcupUPVJ0oPbc2YyKGOq9I8UPm8z0euLrh+yUQH5H
X-Received: by 2002:a05:622a:551:b0:51c:135a:5b53 with SMTP id
 d75a77b69052e-5213aa6e46fmr10419721cf.11.1784272407938; Fri, 17 Jul 2026
 00:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716161923.266315-1-akkun11.open@gmail.com>
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
From: Akari Tsuyukusa <akkun11.open@gmail.com>
Date: Fri, 17 Jul 2026 16:13:16 +0900
X-Gm-Features: AUfX_myw0V2Aiz3FUrMgQlgFVz4GkSaEohB1xo8heVTI4ZdFmSeFalXVsz80Rxc
Message-ID: <CAKr_iV7_k1cAMxOeE_SmR4ydTnhs9oDAaHYp=DsZ-YAPHpqk_A@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add reset support to MT6589 wdt and remove fallback compatibles
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Roman Vivchar <rva333@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

sashiko-bot said this patch series makes a regression.
Should I add another MT6589 compatible string such as
"mediatek,mt6589-resets-wdt", insted of changing "mediatek,mt6589-wdt" ?
