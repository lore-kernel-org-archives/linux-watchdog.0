Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364751AEDD
	for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070718; cv=none; b=hTliGVXValJ5dFStHugtrQFTFuZwsaD0n/55J9Tr8dzakB3Ixjqi6ZfCjYcsmeRHc3rt8e71pnP8BycdgbjjT5OnXmDTHzphATpU4rWz1TmMpxxgimxbzURzpRWmu3HCCnWLcKup+o2WCrT0hCtC5k/l9VdTGCv4P8ceoKPyKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070718; c=relaxed/simple;
	bh=H3zCP5H13vvVFVkfSQiIjCtmW1MwjHaJtfgXUw5dX60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bz74rtjouPHsEJ+2o5C4+kNG4Wq0qG1z9ZNxEjzFZOIkCC/JpzvQ5/HG+0nHR9J/6UdvXd7Vb6l3xHCzNr0FWFLDkL4sLvkF6LG3gcNXqxF+u3P2GEj2LxmJmuXWYLuj/qKEV+mMhFNtTJXhVqJluEs5ddCDtJuMqbFvF2bFj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBae+0GZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBae+0GZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c6f764f82so722644f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070716; x=1792675516; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fatwg6Ql10eF4yUkxnXRufoS1VKiolsiumheXDiVcQ=;
        b=CBae+0GZcOGJDgIX1tHi1ZOI04z/UBOJD39qMdwmRbrcq971OYnfa8TT8VgnRoH1ag
         OJqediBSk9PNcNxf82i4Uk7Zra5yHVcpOMB9B2+FzQ0UgYNkiRTKX+9nNikkJPS0/UAk
         JpBHp1SArlEB3B/2jjkhESnhoeXzz/Gu5MIplCvBguZV0WTQbb7OTA55xNB2ax8oQQaU
         mYOm1payuMenxSFnlQNKDiSfKGsV0u0lKAO1Kklmro69gOhrjc+8LNS+0z+ox/TwvVJr
         p2uvpktUHsQ+QpxC+NCvrNykld46qcz/pOkoi7G9l9iZo+xbvmnbmYWO1BJnuV9Bb6Uo
         FlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070716; x=1792675516;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fatwg6Ql10eF4yUkxnXRufoS1VKiolsiumheXDiVcQ=;
        b=Dcte6jl/ZKvV1vFn1SsbOzYzfQ/WAygg1D4kHjuO3lJ6aed+aYm0XWi16eXzlX+pCy
         lG0/MPUpjLSiw/jWZhVq6v2F+a5DL561E/f529tkxQu9P1k1QbBNZfptt0AWIya/0YxY
         iN4gm39Aw9K5LAvV44UrFZTrITgc7eNmoicimHg5ZoCLI0t8iYV4TqBRwyWVvyDQLFyt
         lTYA7mkwctHgwy91Mv4hXmNZCRjYIGd3AuA0Saf1yArWPFiRCFsIJqfLWzGR21sW+GMw
         IfDX8BxAknHHIVLGlayYQC2NBs/kO8/y7D+H0BOvImUc4pQNzHBGM+clRO84Xo7/oldi
         AgpQ==
X-Forwarded-Encrypted: i=1; AKwUvByKPMHqRAW56wsZlNUfqGY80s4THGqsjRJx5vYmunK1LrC6xAPQndIifQpSlwoOIuxinv5Fw5u9o0q/CnDdbQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ43PSSsBZ9cLia8hna2tOnPHfjI8n/TagonDL27toB/Jd6HhAd
	i2VS1DN/GkU/HuYIvTQG6wb+Rymg0HIRdratthGMRJoh+okFxK4JC1wQ
X-Gm-Gg: AYBFou0+bxGAV3vlO3s99Ic14wnR1Mn+oLsWu6z98KYZCj02OLvbw8UN7l8oSXPOPNg
	pgJOiBwvqAi6E4QEmZLk3zhIGwtxsINW3eE5194oAq7XY7YocNz4pQZ1FQLoKNw3L1ljsFujTcE
	nHGRNbGkKGyS7G9Y3cC3AdGdFbsxAzssCls8kvD8C2G2hXxz51J+r8wVyttUPcXQwLyu7CL42fs
	TmWVBU3amJ+fxvJF3ITQzj5zflQtLtqf44Dg8EROPqh5qDbJRwF7xq9woIh3ms47VPUMnHOYjQB
	z3dUz/2R9S9K64BAUxDDaVPIcRZxoAZk36ATi0E8an1BKeGKeQ91hAEC/zvblIUBP5wAAjSsJ5c
	zxDuzZFaJSdkhAa9UV1UhJA8DnPULkO5yv1UiS++3rkk+o2OoUH3uQWNnjDeNcu0x5GuCJy68Pe
	RauMK/MYV3aou3JukC5GPK29TBFmXC4/8GhCbuisoDliDz/Re6JS39PYUvpi4KzwusNA9sui+l0
	BjQpvHc/UoG/XycJVB3tzDnTB77Jo01GtPRMuy7XBOzsudlw/JMiFGjhw==
X-Received: by 2002:a05:6000:4549:b0:48d:facb:5939 with SMTP id ffacd0b85a97d-48dfacb5b8fmr147377f8f.8.1792070715607;
        Thu, 15 Oct 2026 06:25:15 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm23470807f8f.4.2026.10.15.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:25:15 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>,
 Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 02/11] irqchip: Add Cortina Systems CS75xx peripheral
 interrupt controller
In-Reply-To: <87tsmndu0p.ffs@fw13>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-2-181bb0d23f4c@gmail.com> <87tsmndu0p.ffs@fw13>
Date: Thu, 15 Oct 2026 16:25:06 +0300
Message-ID: <179207070645.418589.10399440167204506807@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Thu, Oct 15 2026 at 14:32, Thomas Gleixner wrote:
> On Tue, Oct 13 2026 at 09:07, Fil Dunsky via B4 Relay wrote:
>> +static int __init cs75xx_intc_init(struct device_node *np,
>> +				   struct device_node *parent)
>
> No line break required. You have 100 characters. Please fix that all
> over the place.

Done for the next version, the declaration and the calls in the init
function are on one or two lines now.

> Other than that this looks good.

Thanks for the review. The next version will come after v7.4-rc1, with
the interrupt controller as a series of its own (binding and driver),
split from the GPIO, I2C and watchdog patches.

Fil

