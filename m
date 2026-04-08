Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29D37B02E
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633138; cv=none; b=X8j8cv4jLS6+dnE8NW+SXBT+e8Ww/SRo2vNihfuEYS/m0TakXHmHQ6iKqFiEqHbBLsmqnyFwE2hPX33/1rELHlKxUic1NcFYvT7kIRr8dKBTdtLyadkxivbVpAJl9YduI6YdbwV9w9PPxbAkY2dBBFyCQ802FMSmWkeMHUUUYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633138; c=relaxed/simple;
	bh=k0MM4f61dReWkZKsY2vkZQ3/711YvRGa40vr8D8EZaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw0De0xemOYCmSN4u3G4Ko70I1i4prhJ7+GSPkT5ttkWYFrJal50DxvmNTTA3hZ/X7Ik36oVvkA+DR0o0WvuGd4u9kWPx8O1QQhTQHcX69ZQEsR3G6/tkISXVyCVcK9w+xYENeDjxZrWvwlH5n0pBHBoWIh/1RAlnTxCz59gQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK1peRAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK1peRAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C957BC2BCB1
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633137;
	bh=k0MM4f61dReWkZKsY2vkZQ3/711YvRGa40vr8D8EZaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TK1peRAu8VLfSjmDKIrolMbyPrBSZU4s9LaD61wf0C4WQX6KvuvGinJLnUqjtzpU6
	 Tckenh2AlMvubQjes8JV+aBmF/0qT+D91zK4qGcCfUJ8G08oY/1M+6TurxgvhYNGcY
	 eE0abQdrlnbIlIv9zHzOKnN/Mf+uBsyI7FQY/Vev5IpAeASXOEfO2ZBdBT2hw2Khco
	 Z/2DfXBMpsLOEw5P8n5yFYPjFwnh+odhHcayXyqE2hc51WQ27Sp+/McbmaRy9XghQz
	 mQsE4ysEV9QNvNeGQ1s4CFV/pfrMGYrc39L2e/RGm6JCLRZ182eLZI0yDcSBxIpcVi
	 VEBFLEAbx5ckQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a337552604so4837089e87.2
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 00:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKIIuNAVlHc/v0wFYE4cMDr7O7894UA3nu0hH0e1xAtJNiEwIQKXJSLmUl0+PXaoBri/Wt2pYF0NcFlxR/cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ku9OQ2Npbf5U4wmBwSHyp6rcddPNCVbwf7HaFQFC3d9isHv1
	54NIZE/3r8zmZNBFP9/hpAiG3tDR7b1JE5w6QXMI++TrvF0dKFVU2E6lqlVvkIIwR5neQ9Pabut
	Y62c0UZEdmAsFXzdWpxMlLCezXAzOwFPEABlyGmPoUQ==
X-Received: by 2002:ac2:44d7:0:b0:5a2:a36f:3ef4 with SMTP id
 2adb3069b0e04-5a337584d52mr4484821e87.31.1775633136523; Wed, 08 Apr 2026
 00:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408053037.1867092-1-a0282524688@gmail.com> <20260408053037.1867092-2-a0282524688@gmail.com>
In-Reply-To: <20260408053037.1867092-2-a0282524688@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 8 Apr 2026 09:25:24 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
X-Gm-Features: AQROBzDYlaw0h6c8CMDzh6teyUf20He-hNaCxS9JyLVdz8XM05uU1MsXkarTiB4
Message-ID: <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: nct6694: Switch to devm_mfd_add_devices() and
 drop IDA
To: a0282524688@gmail.com
Cc: tmyu0@nuvoton.com, linusw@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 7:31=E2=80=AFAM <a0282524688@gmail.com> wrote:
>
> From: Ming Yu <a0282524688@gmail.com>
>
> Currently, the nct6694 core driver uses mfd_add_hotplug_devices()
> and an IDA to manage subdevice IDs.
>
> Switch the core implementation to use the managed
> devm_mfd_add_devices() API, which simplifies the error handling and
> device lifecycle management. Concurrently, drop the custom IDA
> implementation and transition to using pdev->id.
>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>
> ---

This does result in a nice code shrink but I'd split this commit into
two: one switching to using MFD_CELL_BASIC() with hard-coded devices
IDs and one completing the transition to devres.

Bart
