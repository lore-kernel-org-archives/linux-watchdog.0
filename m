Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5338DC44
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448034; cv=none; b=nhPy1sFS1mjWIZZXsINU+gNaBts3szn1dC9Z71CCNracH/lD5R4WBQHCuE5188XvxmLWYRpbs6PItID44GRDE56uIAbTrD6USmYo739gpHS4Jn/cEnzekL6t8gos9glbyqTol6HiruextE+soae4itnpuU9nwAbhwT1AJaRaNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448034; c=relaxed/simple;
	bh=3zePUSKPuVEhoLen7Dlseb8ZqqhKGqql9NuBj13jea0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8IzE5WNTF8EF7B6rio8u4zpHyo4th3lsXGimQpfolO9v5uckLdtypwxu72ROXiHYe0wSnms36Pm0Sh1vCMCaHGSUOP3WyZdELNavrL1wRHiK6SlabwodQkgwpMEswDtwEFiX1CSN4FwONf711Ab1IbcHDBwS+wc74TjIelpEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T6fyRCtX; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6fyRCtX"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf959b820cso233222e0c.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785448032; x=1786052832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEcZSaSov64w+SqDtqbhCImxhflXKNQ/vSfdSGSImp0=;
        b=T6fyRCtX0BxQOQEGS9QkEgl3GVP53KWdfpNTTAGKnLi81+jmjQMjriL2lPW9MREwFv
         aPh3fSoHDvxF2rIFBO+prpR0zRT3mmx+QU7VcmUtrXXeomAm2j32syjPRwm7WF6eC/Bc
         kMFBTk+hMBalXOzhms7FBSSZPXV9/FD3rMDmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448032; x=1786052832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEcZSaSov64w+SqDtqbhCImxhflXKNQ/vSfdSGSImp0=;
        b=h9Q/lkKThfnYmjuOIje+jaNrq9bk+KU29DAkafMjPJYjZU/ZjzduOJh/+L3zZG0Gsu
         I36EOyph2pJn0nujltXZdh72gtCisBpYC9SEMY/svwBC4/AR1H8W/x7SC8JXySXPCoos
         egxA711M1V4qmWitsjWfjISHIngzEbtPZlxYdnkfEAQw8fBbDMdkjLaQn5uFoj5+bh/y
         n2J1G0fIrzLqmhutuEUOB5VtugwXi6gVlo6ACyYlHEu8Xq75bUHukuXKGq9D8Zayq4DD
         3qDFLL2MufT1+uVeYqBM1oWmbZSM9wXDLNs3HsmMglnouQ9O6bRorp8tSAD0kDsceBv+
         dlXg==
X-Forwarded-Encrypted: i=1; AHgh+RotpK1HQa3dX/f9aUu4MqFhtXi+VLiutQEb3YXw7F3alg/K3uBO8k+VK1/bbpc2wjX/4WRxMU42JY7aUyo9LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaJubdv38nvUMRwNPhlGbnqlyGLmLcT4rZEbifcuXqDrWa7Yv
	eAIZlcqBLSnNmGNrkPhj0g25xmnf/SFLIqzan4I2UV9AgSm0aYeMgHJ1y30HI4vreihKyJ11l/M
	At9g=
X-Gm-Gg: AR+sD130ECTQyXnC4Xz9L5eHWY/JRZmlQxryqErAHHXAi77jrxjyw1F5GPWENllk0QO
	pTI3WNeQ81W2q8Ymycf6gc+FucrY+TVWr09dqgZwc1V79UP2kBvKjEV3f8eycHcskjFqb294WLi
	7lI3mrO0qzejoaIVtu6gQe3hd6Ts/RTvcekL93GiVVlhN9JSYfwiB49G/wDC+sr8EwlBcxE8pVF
	39/XR2Ua0vb5VhtejlVVNpxHkhzSg6Qgi/VIWM5Jyk6PltMpMPEi8Bk+oJBcanYk8cnqD10BywP
	hd8fVQiWI9deaXWWapkxQ5tPyU3V9ujNTSuDi3c8uJNfCCjZNDo2L3pEUARkw5HvBCEow8olQPd
	VJd6i3PBKf9CzY4v1/t/6XF6lWeoAgcDjsdMfnUot4bx2VNBmVq183FYnPaQVsrInoepXfOuxCI
	5rAe2B82MHpHF4nz/xYIohBGaXqgZVMyQ8br0JCQgAxwo676+iSJRLUPdc1fKZAJtvrSxeQd9ux
	ayV/FsHjCb6iwSiessMOB6ljVE=
X-Received: by 2002:a05:6122:e461:b0:5c2:cffc:2c55 with SMTP id 71dfb90a1353d-5c365d2f929mr1739794e0c.0.1785448032103;
        Thu, 30 Jul 2026 14:47:12 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3664de7b9sm2348080e0c.3.2026.07.30.14.47.10
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:47:10 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-966e7380109so110255241.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:47:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpzQswGHPi9PptmfWPrB666klXVJHHAY7AI7n/EOG2Ppu38gj/q/Nn1RGkuv8dd6C4oywoC7knWogcG8VKfwg==@vger.kernel.org
X-Received: by 2002:a05:6102:3047:b0:740:127:c81b with SMTP id
 ada2fe7eead31-7574dca124dmr1665460137.7.1785448029188; Thu, 30 Jul 2026
 14:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com> <20260730-qcom-wdt-nmi-series-v1-1-3aa86d162914@google.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-1-3aa86d162914@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 14:46:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_7RLjcAtKk5MHiABj1rA2CTkPw2UY2gJnVzH=3Gbp5Q@mail.gmail.com>
X-Gm-Features: AUfX_mytlaDARoR1dw85A5VeD-oPperL8oh_dbbeAf-fbsBmoOf0-Vxqm2C-FZs
Message-ID: <CAD=FV=V_7RLjcAtKk5MHiABj1rA2CTkPw2UY2gJnVzH=3Gbp5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog: pretimeout: Protect governor access with
 RCU for NMI safety
To: mrungta@google.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 2:33=E2=80=AFPM Mayank Rungta via B4 Relay
<devnull+mrungta.google.com@kernel.org> wrote:
>
> From: Mayank Rungta <mrungta@google.com>
>
> Currently, watchdog_notify_pretimeout() acquires pretimeout_lock using
> spin_lock_irqsave() to safely dereference wdd->gov before invoking the
> pretimeout callback.
>
> On architectures supporting pseudo-NMIs (ARM64 GICv3), watchdog drivers
> may register their pretimeout warning interrupt (bark) as an NMI.
> Because spin_lock_irqsave() disables regular interrupts but leaves NMIs
> unmasked, if a pretimeout NMI fires while pretimeout_lock is already
> held by normal process context, attempting to re-acquire pretimeout_lock
> triggers an unrecoverable deadlock.
>
> To make pretimeout notifications completely safe to execute from NMI,
> convert read access to wdd->gov inside watchdog_notify_pretimeout() from
> a spinlock to lockless RCU. Use rcu_assign_pointer() when modifying
> wdd->gov and invoke synchronize_rcu() during governor unregister and
> pretimeout unregister routines.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  drivers/watchdog/watchdog_pretimeout.c | 47 +++++++++++++++++++---------=
------
>  include/linux/watchdog.h               |  2 +-
>  2 files changed, 27 insertions(+), 22 deletions(-)

I pre-reviewed this for Mayank. I'm not an RCU expert, but this looks
right based on my understanding. My AI was also happy with it. ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
