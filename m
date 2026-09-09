Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB49367B96
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974823; cv=none; b=mPTp5DRxbDjXojAI5wn2ZFjIuoc/+a8orgIZC6bZ3NwYFpmYEEqx680UNOaO0vzHvFu0YJQd+VGV0gzc89M2A/o6dHO0ZzZNMX1OuMc1o+liGE3owiRBEUenCL1rUIryHPRwpvk4x3RbcqPQwsV8XO9EMs5ZbAVivvv8G4XcZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974823; c=relaxed/simple;
	bh=SUxP5gT1ZaOy4mmgP6chw0Cr8VRY83cgnbGtN/GeIrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juba0PEXZLUnv5bkxUONe2kx0MkAELpdJM4IJ6oA4Ev5GeJdzMl39vhC5tJ7Qktne4uw8wdBnNE+rZObQrIfWrZFZW+kMl9M27PAV8HW66VIDTA4EGjuCpuEssc4D2Wb+anS8tHuazrpTkfGsKMWUSd+azwpmLFh2ynnACbgodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI6Ly9NO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI6Ly9NO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc149372c14so3225148a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974821; x=1789579621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=jI6Ly9NOhS1CJVDcDoKjwgjST/iQVlVpolh/hifxBJGV2nz6t+8GlFWLZ4bzANtEHt
         /Gubm7aHSBwsXnEHDwS28/J38FGObVki5RAT4+MKtWxDxCzdeulLhOlDre6S80gl/1TC
         7EygHVvY8rB9EzbY4vuEGBvLIXgnThM7ofFVrmOOyUnxK3+Cw8/lUB1Qrw2zcQyD28sq
         aOwfF4Jak4nLrwlBRcrBmxMV3zq77fRSSDlQwIxXNAn/g3MvLudGjEbIzxRGELLjSs75
         zSMaaTiP34sWBjEuq0+gSjLhjHao2DyO1AI08J/NXT1fTMGf7TSzj1Dp3m+TJmQDgi3k
         TF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974821; x=1789579621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=HX6IpUUvjmA/6b7J+p34MiVODXL2PYIBcmTSkn5P5JwgqeuGciGJM/HJ8K99gJ1qZw
         LRZZU9zdIEFJZ4SQSpRBo8gdF5Y/MtgJFeH174MzTLbTJJJ+W2Gl46uxmiyCcX+08NZ6
         BusD9JWPJn0TRAV4Lnu/LNrUia93SBcpE+rEwDk7RHf+CWtwWkwWvsUi1T3yqAonebpp
         qXrXXbSIyR2gMgztWrA89H1n/Cs19gaxiNp9caDA3IdmByyRkBhOB2EBT1Sx0Jgg5zFl
         /80qXAlZkATn4SJEVUClnSrE0934HawIC5Q22ulzuZ+gei8yzMl42zxdFa19VHq8fnMb
         ZzxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNcmaYSOp5tdPTa+5gWBgWkuVND/0pyL7l48g7gaZ+0LBC1dkMf0dNAVY6x/SNiBX4iOPXf5x5g//yxWOUfw==@vger.kernel.org
X-Gm-Message-State: AFuF++nnGuzm6qfEEfUdJEOLztWQH5Mcvaa3nxMJv4HW/87HH1FiRDpJ
	3oYzEMvM+XPx/KYtERiO75ACvYTHRiQx9lf/0nsTwT2nQMaBA2LJY7C/
X-Gm-Gg: AYBFou29ZFqJrIPmgMcEJ2HkWG2H1VanX1kN2wDfR0V7yVhQn3y806FZ1rBaUpAltU5
	Db4RvcENA0psg68Cm0vqFsTa0TtroyYDoimJ2wEL25dlz232kLtIKuHFkTPRps4H+XJu7JTKfMi
	QHjl7lLvgyIPq4pRF5eLb0RV5CBw2Tp/eKC1Dq/hYWil+La56oJwoDna0NfdcvL10Kqn8LdVeRv
	E45fWCQxOHb7YK/TiSVEe4EX94+yhjYmXrlIcYqTTsdh2mYW6TQKTrKfBoXO7xWtyFWWxThjlnl
	iZMbP0uM583lkAcbmo8H/ACGMf8C9jJA3O+x0hF7JmdprFgo6m4QU6HBlOZiWU/K+wweXeqFFBV
	jW4eUX+FGlMSn1d9Qve5o5sCChfktyyK110ENfQ2qs9p9/KBA+zc+q7bfmlwy2tqS6/KClA1mfP
	IhsmExPypDLOzv6QoPhjnFWJYoRzbXV2onD4pdNaArMol5ctAhfiXrK9L4ASKvKu8iOvC5qtYnw
	gUwmnIcxfoZl3hLB91ksnOHNI9QDT2JQPGvby9vbqJggc86Wrpw
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3da3a16a579mr57975715637.26.1788974820346;
        Wed, 09 Sep 2026 10:27:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm52422943eec.7.2026.09.09.10.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:26:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:26:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/14] mfd: unused driver purge
Message-ID: <aqGWjAuGXq_JHvxk@google.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As part of my cleanup of old platforms, I had a look at all drivers that
> may have become unused because the last platform_data or DT definition
> was removed, or because of unmet Kconfig dependencies.
> 
> These are all the mfd drivers I found. The first ten in the list
> actually turned out to have been unusable long before my series, and
> I have added explanations on how I determined this in each patch. The
> last four patches are still in use in linux-7.3 but become unused after
> my series [1] that I hope to get merged for 7.4.
> 
> Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
> and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
> media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
> to simplify the interdependencies: removing just the mfd driver would
> leave unselectable or broken drivers in other subsystems.  I also have
> additional patches for each of the other subsystems, currently a total
> of 300 patches, many of which still need better testing or proper
> changelog texts.
> 
> Please let me know if you all think this approach is ok, or if I should
> explode this further and turn these 14 patches into 70 individual ones
> by splitting them per subsystem.

Sounds good to me, especially if Lee makes an immutable branch from this
pull so we can all pull it in...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
