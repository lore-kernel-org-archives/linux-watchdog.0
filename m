Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222833B6E8
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750255; cv=none; b=t12zyvT7EOiwwkT9CL3PvxUnGQ8iJ7Fa6xkGFt3wdTV8OfxieOylwHwXpgvemvTWP+SS5gsR15syVeG4KtN2kYm6nkHfuW9kBikyiJsYhQ/nBjkD25sCvaM+xzpxQpCD6YovfGhYudBWAhIc7Rd0XWKDRAo+pveNb2wObT+NVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750255; c=relaxed/simple;
	bh=OsRD+F+OLtUmpRSHXSpv9UfMmwgcSUQb/xDcJZ0DHJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4HhAJTDxgMaded1PiGU/rwpTQTrLA/ZO37EX5YnOcGw2Uqo5quS3XuxCiAh2Bn+9B4tqhLm5vcMWJgJSaA02WKNsPZZ1NaWgUwXWvFitdepfgkyfFXkxt2E1SUSpJF5QvY6KPw422OvcRY6xmgFrotbOJlYubJycjVjJcWUEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDwkVR+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDwkVR+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B80F1F008A5
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750254;
	bh=OsRD+F+OLtUmpRSHXSpv9UfMmwgcSUQb/xDcJZ0DHJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bDwkVR+Mng9JjATCiFJWqiEpR38DGPgfTc3U+ctxg8/zcUPYe6TqXRRdyU3ye9pMq
	 7khAoC94ueck2dwdL60uK4E66jZOkU2aqI2OXJq7u1JJAqaw9VxhBAj0gY5spb92cW
	 +kZv5+LK8cA2iUxOwjmkOQc3O42BTz05jz5D9LL+Y5TLkTdBtzOt+1yx64SZqy9GHJ
	 d0k1ADaHIOl5pGP5HGXGaq7W+xMmorZG1E7eT9Ws81zMZExmRZp7PPjtYaLFGZKJu5
	 BC2NFnqcI9Jxzg+QNaCHVJ009FaM4bblt/P0TJik5hwb/wsdZio2QQe9VyaQGnikLr
	 f/VK0uEoxEFvA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcb2ecebb4so909303e87.2
        for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 13:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUwoyKIulzsSIx4GvBwW2Ef+K+w7LmiTjvzmzHI2hEzlF5bX1tBOJjtqREdjN1qAdnYhqub8M9li2DxDTomQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOZcAmhPDQILR4LijpdewdQkkuW64aOUQNuxX53u/YcW4qBAl9
	QKLJrFJJM9KgjpEFP8GW0HqggEqMJAmtFcP4efhV2HcfNBfjfPlmDbX1TewWd/Poz6FeQPzeetQ
	oycTrMliRunZjdofWl97CFISbiaHbhIM=
X-Received: by 2002:a05:6512:118d:b0:5b8:bc5e:b570 with SMTP id
 2adb3069b0e04-5bcde8c13ffmr2228437e87.40.1791750253189; Sun, 11 Oct 2026
 13:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
 <20261010-apple-m4-pro-max-initial-devicetrees-v1-7-781fb3f2d9f6@cyberchaos.dev>
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-7-781fb3f2d9f6@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 22:23:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+2iUkJfYQckV4G79JEErH77_mOqwGaZ6TyKGawmnFLw@mail.gmail.com>
X-Gm-Features: AclHuK9cHC-ny7H2OT1BGwCBFcKBYkyqMbq7PnfdAqUY1dh82EQN4ca3xsuP3Cs
Message-ID: <CAD++jLk+2iUkJfYQckV4G79JEErH77_mOqwGaZ6TyKGawmnFLw@mail.gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: pinctrl: apple,pinctrl: Add t6041 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:00=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> The pin controller on the Apple Silicon T604x (M4 Pro/Max) SoCs is
> compatible with t8103. Add "apple,t6041-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl".

No Signed-off-by?

Yours,
Linus Walleij
