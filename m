Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87238C419
	for <linux-watchdog@vger.kernel.org>; Thu,  9 Apr 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723286; cv=none; b=KHsbcbLDjEz58vUAQY3UcvwV4rqcAJvc130ZPNOVM/Mjixe5vW6mZaEcyEd9KVNT4MftWhBgEMKsDLieDhptCyqVOpt/0Mu2lROoAYcZv9hhwtjFzf7rA5h1agKGtLspJNHw0S0+gbl5I/NBea9fiA6iOviYPb1j4gqistdSYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723286; c=relaxed/simple;
	bh=aTaUCr1A2I+1wqTvl3TKv6QTLEetojWJo60VzPZFc+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqmEz6KXgQMsZZoB3RzIGW3nC9FvqCEW1m3k2scYqsF40f35IuH4LlokoXU4dKABgaDj8e7IfA5s6pymhB1vMSMQItuCz6ZeR0Ck+rFmL3C4z7c+SAfxF/htMZoqrvw9WPNtfJLoT458mNGR7svXa1ogssvRqwjv0smHxg7H5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFmWyjvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFmWyjvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B8DC4CEF7
	for <linux-watchdog@vger.kernel.org>; Thu,  9 Apr 2026 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723286;
	bh=aTaUCr1A2I+1wqTvl3TKv6QTLEetojWJo60VzPZFc+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hFmWyjvjjainN0waFI5SgxxVEcVbJNwNrL0mx+XuPVAsRyyMkxghRurUAIU+4uiOf
	 fXljosaAod1JlDrJMGbseZ9MuWHidtbqP+d6gC5EYv2oJ8BKH0kdy/rebKAbU0ShkJ
	 ANEHl4nDw5Wfvrm27lOHVgA84IclOfaZ7z5Wr5XkxQtFCNzpbRADM9pBYskD/2rVQh
	 RV7WryA3gluS5oyR8WvDWPPq0YicpANCGngJcqdFAOAd3bVB4Po+JJse43tdThFCEj
	 23BvfTpLx0m7cN62ig1JkvJJZTB+ysqsXcPoVJnTO7lWAiOOhqrW7PQCrE9fP7ptz2
	 VJhgVubw101hA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79853c0f5b9so7585457b3.0
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2026 01:28:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYUcg0XNeXn9kFkkenZyB90iIm7jpJkfCXZ0psYWfzmo+q+LNSQ+ef+N50b7jK8b2SouECjBE4y5Ifb9Qdrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEAzD7D+1G8RKqELkf40l4yzuzour+gD2e9uJsGXqSUYvTfHQ
	sWEG2dCyYKKf3IUXnMKJgO5qXPSJVpvxcBzCNOJ77P+cqZiS5GiDu2BvQE/8V4bS+0rafIBCYSO
	8+aaFKiLe5oA5dm47xcjYmqfx9M2cqKo=
X-Received: by 2002:a05:690c:86:b0:79f:b903:88be with SMTP id
 00721157ae682-7adf1f63befmr26878747b3.16.1775723285630; Thu, 09 Apr 2026
 01:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Apr 2026 10:27:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLkcoSyt4ag=Vtf0HW+UhnvXAQH=RqdiZ0LB17UdURjTCg@mail.gmail.com>
X-Gm-Features: AQROBzCBPK9j1p1wyGlpXng0vuJPY67DBxyZqUb3UmeFzFxdcTXTQHWBijmLSC0
Message-ID: <CAD++jLkcoSyt4ag=Vtf0HW+UhnvXAQH=RqdiZ0LB17UdURjTCg@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 1:23=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> The pin controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl" used by the driver.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch applied to the pinctrl tree for v7.1.

Yours,
Linus Walleij
