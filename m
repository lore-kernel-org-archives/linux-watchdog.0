Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D234DB72
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Jul 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712908; cv=none; b=EM8f1qkg7vOU0E4HpeGl1FmeQD7KWDw44PNiIvDVv0hNPYPuwfWPTibvwV84cg75p9gPNcb3VmRsWcdMaz+dYgWqplE0ihvE9oevsGbNeOI7h7Y20ui4XQXQ2mPR3Rce10jO975v34vF9LPG+O5nmN0itwXZ5u3rk/nGI0spkc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712908; c=relaxed/simple;
	bh=r1Zf4djkyVsGdqHiqgT2yCHA+1xehfGqV1emcYl1I6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVVValDOSAl/AOyKmmyPDzVESFNXtNfJeVqBKTRnKdUQLKFh3g+exb/E6litjYuaH1Kn+UcpVDlET0/pDwaBRxDFFCxhYZayAHiqirNeQAkZ0nuv1+JlMR2kWlrQVTUm5rIAWgzoAt7F79UzDGvjDswEYXky1WTn84NjMPIwlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHubEODI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHubEODI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600B71F0155D
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Jul 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712905;
	bh=r1Zf4djkyVsGdqHiqgT2yCHA+1xehfGqV1emcYl1I6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KHubEODI5OK2JjTzLoacd+Xr01Bdn2djdhyaYl/074SiQhy7GiltXk3uOVmqYK+Jx
	 gaIBB4JvCVLuVWPwYbajMX4wyLMe20zpe2yvO2E3Zf+M/jCxYCtOb96KZAZxJygLu6
	 LdIjuylf2OpzLru6fOiYnIeUqX4b1688vkKDiuc/Clwpgiu9XPvMV7U6eLhfHANeUj
	 svnCfvd5/BhdvmEos+dlaiaungyCXAz4FGHwtAWGlWWynv1es0W6tunrIph+PFAp1c
	 dy4llZLsfp/AE70Xrsxq5ev2pLwZe9Z+2hWF2+joPs1FeVyde3GT8lRFUGCmZxJcjx
	 plVtsxTqbfDZA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b013084dc2so1033021e87.0
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Jul 2026 12:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrNDGA1M8sVJuZAGXA2LBvDK6PUE0XVc4m4cfPi/aUwL48W0Zo4tA6Ib7xAfa33bNLoCGadEAgaGjNHa0HRkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8SM3vAMOTvU/CMnl/5Ry2CFQhrOzRo0DHn1Rn0SRD1XNQwnl
	y0CS6/A4RNg4jjzkx392vOhOCRXy1G9JQPlYV3lg2PWBXllDigv3uGe1j84aKYXxr6w0Id6e3zv
	dnFOwroVvTJK3y8bwsTCOtsE1YVzAosM=
X-Received: by 2002:a05:6512:2c0e:b0:5ae:aeaa:140b with SMTP id
 2adb3069b0e04-5b0236a5c9fmr98033e87.43.1783712904103; Fri, 10 Jul 2026
 12:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:48:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLnKYrW3LzEWj47Mmi7DYL=cGZNLRzbF3w91GTs7FBCsjA@mail.gmail.com>
X-Gm-Features: AUfX_mwDu5nHkfrpKW31EzIHDBbQz-W_XVTsCEkvJgwgFKC10BW3wqwVZ3eoWUg
Message-ID: <CAD++jLnKYrW3LzEWj47Mmi7DYL=cGZNLRzbF3w91GTs7FBCsjA@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: pinctrl: apple,pinctrl: Add t6030 and
 t6031 compatibles
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 9:31=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:

> The pin controller on Apple silicon M3 Pro, Max and Ultra SoCs is
> compatible with the t8103 (M1) one. Add "apple,t6030-pinctrl" for M3 Pro
> and "apple,t6031-pinctrl" for M3 Max and Ultra as per-SoC compatibles.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch 7 applied to the pinctrl tree.

Yours,
Linus Walleij
