Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9ED3C0636
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015270; cv=none; b=JaKoTI4qILq8Z7nvaqDYy9CInfEm3uxI0SQFMWfUhPhVDVKlnb0e1BTOWkcUwJZSAmCJWW63FahcsRGe0KFYvNWCMlB262Pc1y4uTbU+DfyIUu9cIvSHqOfnQfgTLn67zg5O2XOw3GgUhzf6CthkzYo4YxTXSiOHqnfpE7JsQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015270; c=relaxed/simple;
	bh=Nx8bQBs95SJZiGV9sxDUOjb6cqnHHMShwIEg031kToo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUPjPcuDk+m9BWr+sL9P/PX3vzuudlnQmEyEueH/eKCDN9TNBTqs6SiGKHQs/Z2KYHc+DgEApubPDLptzMvw35F205zzo16zlDlNXDuO9tUk69HaCXkqR9pN8IQWERtMYDWqptbbcs68HPqmthZh0Ad1jXTn86C50sS1JRXEnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c383f2fcso1616654a34.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 07:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015267; x=1774620067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txsLO2jkdNhN6oBkuArfXNgiBSygoSMNA3GUMB3p1q0=;
        b=sMasZH2Z3e2GEQPRaCvKDlJmQ7Fi7qx/8MNN5Go17b7VFoSpqC8IwM4V0AjpjlNPew
         zXHEZmpGZH92MCnbrURqiUNUkTBsAUZjpAWwb5xpg73O/0ylEpaQupY/AGDOLmdIX6Q/
         dhovNMgGCYoXKWOxK9JyZfGMhHJRaeP36KAUJiglB/6njAhSNg9WyFFn6BlWJZ0ZQ8G1
         0/AxH4VkK04YqcSNnr01nW7UMqh4Oh0UKBVT5+gz4CjzG8AGav/H+qe7LWQ+LVfqFcbi
         yQ6fBVqpYzomB7lUW8D7QhS6793NME3RxeauAxSlRS4M9Oiw/0TAuzh4KlxvaIfkZvaE
         xyVw==
X-Forwarded-Encrypted: i=1; AJvYcCXnVtoo7yPtYspxrcZvF85kG8aWK366FfSrGyilxSlkVsSDJx7WlPFFZ0VisMbSjCt6o4GhqOoUnc3aXZ/dgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwT7EiDsRxNj+gAMISNVmjCAj4YRru5Uy9y84VwGSRmV01XvR
	I5XqqGHhULpcdzU02c6iV7xyLAt2NIzp6GWyr4ugGacFMUeEgmz52enLcVYw8WTX
X-Gm-Gg: ATEYQzxqs6Bhwvz+B3UpnuaX07w444b7dAv3iAB9MM/jf1Qh+Zu+zbP1OmaSk4mdR6K
	rVfoytysC2IM+24RdLM0tu2xRSZYkx/ltpeKJuaCFxNCx4GHMd4yGSK/sA/VNkDkqXltUSc6AOc
	wQqsl+htWPpwNjLziw1kquaHrDctL6jj8Qz/ecrisP8SeemyR3SgcxImeh5YLpJVDmPFnY67WC8
	KcJOt59TuAjXlEVBEFU4Mtez4dFTzAMuosKwUgfWXOkEYWCIVasrkOOSfdJgtVlSIWFaXZJj5Eh
	HWbrQ4YQlqxdZPi71tpM6fAc4Kv2EHaVe4OvDeMR3SX8HvYp+snsNYBf5VgY7EnRvPOSGbAV0vC
	ngbnSNSWshjbtMdqHXm+0g7Z6kvUQfhojD8EONM6vSQJ9LXdcBhsm4pinV+s3QOADiz7f0mBTp8
	4J69NcnhV/wVxOMwUvlzwbQkqgvlJSAQNR6FBt49/Qdc2TOvGKHC7X3TUzUszvlfDHEdppEZjbW
	rIX0V0V8U5XNBtObzIgDOjkevBjUuDE1CY1+JXs1XGekWIQB6/iHvoaadPLFh4DD2kNIHe7oQ==
X-Received: by 2002:a05:6830:380f:b0:7d7:d504:cc6d with SMTP id 46e09a7af769-7d7eaf75e44mr1878044a34.21.1774015265053;
        Fri, 20 Mar 2026 07:01:05 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eac56278sm2611602a34.12.2026.03.20.07.01.03
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c383f2fcso1616605a34.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTT5R5mmKK+xJG5WN1XKMSHByoBlbCjBMlTyw1O7XZiVp2boYUZ/H1q+4Ufingidj/mSoq1ilCCX1ytH05Wg==@vger.kernel.org
X-Received: by 2002:a05:6830:67c5:b0:7d7:d15a:ce8e with SMTP id
 46e09a7af769-7d7eb04feffmr2015751a34.32.1774015263260; Fri, 20 Mar 2026
 07:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 20 Mar 2026 10:00:26 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
X-Gm-Features: AaiRm53Q86Nf9dVOSTKn0cYEE4xmDvp3jUYoCfYFj-SX9hFNk_weUYFVfwHr6Ok
Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Initial Apple silicon M3 device trees and dt-bindings
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:23=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> Changes for the interrupt controller were sent separately in [1] and are
> picked up and in linux-next. The device trees pass make dtbs_check with
> the apple,aic2 dt-bindings change from that series.
>
> Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b732807=
6b8d@jannau.net/ [1]
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (9):
>       dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
>       dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
>       dt-bindings: watchdog: apple,wdt: Add t8122 compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
>       dt-bindings: i2c: apple,i2c: Add t8122 compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
>       dt-bindings: arm: apple: Add M3 based devices
>       arm64: dts: apple: Initial t8122 (M3) device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
>  Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    5 +
>  arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
>  arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
>  18 files changed, 1859 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
