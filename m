Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC354DAF0
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577525; cv=none; b=HUfAVh879mlY7xUPmuMZscMbshKZnUa5wcn3jjZyJmJ88jeZ7aNaTB/HD9d2QpDIJ74jVYSG3nw0Nnc7IaVtcnJ8rK0QRu0QzD+FcEgfM5unMG1gATuH+3yxj8048nkReQTTu7D1O7v0aD+QsQrGF74wr0c79NA9htwRIcD68Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577525; c=relaxed/simple;
	bh=jlDHHiMVqeXgdpn1Zj7e0N2hLgqwzeWFJxceKYb+YHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bde9+xefDQ9ylPb9XM+BF31XQD7IkjMYIzDbxdIUKsFTQMbj5AdmF77+nyaKQmcxN60EQ49jRB95vUATAc+dD6bfzzbRyQv1xTrkjBYmIzJJJahoEeUpD6R73QXZeRR2PAAp1un4n0uioIzc69HsELf3E+/gIhd/iZo29JVd3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcbHzxFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcbHzxFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98141F00907
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577509;
	bh=jlDHHiMVqeXgdpn1Zj7e0N2hLgqwzeWFJxceKYb+YHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JcbHzxFvgLrpPJkR5R3XBY3y2SfCcwhDFnSiLhJ1B+/JTtnxdxndb4zLLznpRuxMr
	 zDUB6DlQP+4KRhUFQ8qZIwmbtMSg4Sa213btbd920xJW3yvf/Rn4Qzedge0V2JpjlX
	 DSseYM02zkMboFVManwZ9pkz7gBcwpL3z/fAJjcC2l/MJBjBv12ZukFan7Y5adtLR5
	 PKISREbVUR980BR6UCPR2TSmSQ7nhb1eCTbfCo2hB8HPqtX95CCZxk0cjc1OeNxXHC
	 wHby+UM/xrpkpvxH7mvJSJwmMZRLimAjK/eOXdvW4CtjMIwx6V8jFLqWrsv0qByTdb
	 TzMjmwn1jm1BA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so1142418e87.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 09:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBypwle9KLTEfGcmtwCCJ3qN9DRdVq+LXw1yncpk8WJqqr9E2nWmyV+jIzpMNp4W7sWODxIy1L4vMDdUAJjW2A==@vger.kernel.org
X-Gm-Message-State: AFuF++lwEDoXIDlxAdSnzqpZNlx8cYiypMyQLYoWZK2jQ/zu7fq/kAEI
	deoAtBTdeBSBsXoeV3UmTBnfxYwQv//tYczjivbnDVCEcqRyM9BAH+hVWOmgLWSweHdNNuQOasg
	kxMdvY8GVGWhtdeQk3iYWz354U1GAvKo=
X-Received: by 2002:a05:6512:3d10:b0:5b6:17b6:2224 with SMTP id
 2adb3069b0e04-5b8b665478emr1974764e87.23.1789577508492; Wed, 16 Sep 2026
 09:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-13-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-13-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:51:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
X-Gm-Features: AcwNN1Xrn_ibUNrql-q0n8N3iTosx-ZSLrxjHuJr9HzfGfgIlGS2dfpxQ3q588w
Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
Subject: Re: [PATCH 12/14] mfd: remove unused mcp-sa11x0/ucb1x00 driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The sa1100 platform has been removed, so these drivers are no longer
> used anywhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
