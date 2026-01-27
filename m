Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4952E2852
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Jan 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506888; cv=none; b=DuvAX5ENB90sL7/Vo6DqIpv8Ao3+0Q9oNWxSqxZPdnlcTqoAXF+lZIMzQEzLPa6S/UUQe9cHJxxHVU5YQwIF+N2F3qqDid2F9nBLYFovfDq6P23AEiLmwOM/fapsl3njr8+/vAW/xqpUjN01FPlSpBPVrTl4FPFzVdTx/eajJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506888; c=relaxed/simple;
	bh=o5tRYiCZhPJsvWOlkTTg3PRVVKQuQ8t8E/qc5ck9C+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpnRTces1D9IuSa6yi5JeDVtOTourvyOWkbDhZ7T40wCMyPBcd0Cr3bz8mTJtwIbuFhsumUxzKotI9YEZJ2FyAhPwkakuLjZgJDC9fhETIk5/7oSgfbzZKWXrkeoAkssQeycC3u+8NUhvONHFTvUtYDVaXU+BXYkYy1KbSFT5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozDaXVtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozDaXVtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D9EC2BC86
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Jan 2026 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506887;
	bh=o5tRYiCZhPJsvWOlkTTg3PRVVKQuQ8t8E/qc5ck9C+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ozDaXVtwYLUlNBBmTYwiCvT1575Q5wJcYbowlmOemHZJNFQBOVXuNs5OS8wnhOXkC
	 PkVNG1nbqM+xw7kHgseL5v+oxeVO7b85+tUfJMGjDIswqDEVrhFVB+ssOKJd/+1+Rc
	 bmeKL5IlJHHe0aKmLKWcZwViBD+U7Of+IrFcKwEpb8YKAosfeiANvnY1VX1JakbsrL
	 kLyODfWZ8kpEchUG8PhWOal/JxVQHuq50cH+n/MP6Z6zKi30+Rods/MxbD7UR/+XMN
	 f8aeJVDUQ25c3ixSDhpvEvXPXpHgeSIi7n/jA7w65nnFcigidBmiteo7CSy110mIGh
	 TMj5XMEdHvZZQ==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649523de91fso4550003d50.2
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Jan 2026 01:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmbHuVButIYdkQZ9kD0BD/bfzY7pvfgYzHlnN5UeVTRZDCxKH7SWe8OVVryoBYPHDtZXgPc/Gv1IbMKi3J9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiLUFQCqXMmV2wYV3o/FqCkkVSxO/1JIsAzvt5/gPWZFzBPVU
	oROqp7VqNyz/RFH+whCs1fCR95YhUflCFuVpRKMiY+Q2RdpbP8BDGQT1/FJIhwGtYFNkpQwfpNC
	nJdXsEcupwoYKgzlMFDz82bJuK/34mWQ=
X-Received: by 2002:a05:690e:408c:b0:63d:bfad:6c7 with SMTP id
 956f58d0204a3-6498fc3ff38mr681563d50.58.1769506887301; Tue, 27 Jan 2026
 01:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-dev-b4-aaeon-mcu-driver-v2-0-9f4c00bfb5cb@bootlin.com> <20260123-dev-b4-aaeon-mcu-driver-v2-4-9f4c00bfb5cb@bootlin.com>
In-Reply-To: <20260123-dev-b4-aaeon-mcu-driver-v2-4-9f4c00bfb5cb@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Jan 2026 10:41:14 +0100
X-Gmail-Original-Message-ID: <CAD++jLnar=EgaaqfLDRBgic6NGPY30M1kzf=8Ps9j7Z4kAme+w@mail.gmail.com>
X-Gm-Features: AZwV_QgLmP7BaRH9fF1BxEIrjgPtkrDiEeJYWc9U8rpAiPtk6YcoXHb2cAV8Lbc
Message-ID: <CAD++jLnar=EgaaqfLDRBgic6NGPY30M1kzf=8Ps9j7Z4kAme+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8PL MCU
To: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 10:55=E2=80=AFAM Thomas Perrot (Schneider Electric)
<thomas.perrot@bootlin.com> wrote:

> Add GPIO driver for the Aaeon SRG-IMX8PL embedded controller. This
> driver supports 7 GPO (General Purpose Output) pins and 12 GPIO pins
> that can be configured as inputs or outputs.
>
> The driver implements proper state management for GPO pins (which are
> output-only) and full direction control for GPIO pins. During probe,
> all pins are reset to a known state (GPOs low, GPIOs as inputs) to
> prevent undefined behavior across system reboots, as the MCU does not
> reset GPIO states on soft reboot.
>
> Co-developed-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jere=
mie.dautheribes@bootlin.com>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
> Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.=
com>

Looks Good to Me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
