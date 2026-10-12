Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077B4F3931
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839301; cv=none; b=SE+7XK3CiHB5i1CIDL9lhxWhrksQWTHexIGV8nWc2pXhddNwGPIWLAup7WRiAg/UfeuyM9S83Qw76tJU7w8I2RqRvNY3r53AAl+BnF6C0+XNz99+VawAH5uukE7JI+sfnKJ1UPJx+5sjAR7q8+Nw1l39/B2BBNmO18yHkVbmVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839301; c=relaxed/simple;
	bh=BODH/PDG1/mEjAzfIXwGyZaoRCgBSiqwtAvUwN/rUG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uug+y5wLAfE8ebzAgoBxu/DTtSVrR6xUni9t6x1HU3ar7FIOck7UfBfIBxz7xUK8MMEf7x559aTy0z/apxERTwwSt37vUK9zCteu1u3XW9UCjdyI+oO2Mb3m3/JLEPWVGYYWjiKZg0QYZSC9E1KVvMRoaMG2qd7VDyf5N5FwI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/jFpb3h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/jFpb3h"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso666910e87.0
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791839298; x=1792444098; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BODH/PDG1/mEjAzfIXwGyZaoRCgBSiqwtAvUwN/rUG4=;
        b=O/jFpb3hEmI7g6+aWcDqLODjJ7Uq+dg6o1uB9dW/FalkBqXvQAEyb+pYrIiA4thBIV
         qgFRduez5CeXwhz0mCKb9NHORTWyCoF8xnM8UbG9hdaOdN+DgBAukNasTPs+PixDvv+X
         8UEszMsbNhvpFFtssYJIFQTIDwFyE6x8z0saEuDRgFP7pQ/rFdVyVqfnqap/tRD+pFNf
         2FNwKshkB1aex1FWLykegfvigibAZlnXe+ZkmeU9D3J7PVIycRBnhqmfQxCj59ARk3mi
         fM6LJvBDY9mbQ5gUtgt1GzUa8NGD56xvcTVkd5dcyt2CptDsIMESdOOU+UKlfOJCtavs
         2BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839298; x=1792444098;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BODH/PDG1/mEjAzfIXwGyZaoRCgBSiqwtAvUwN/rUG4=;
        b=MJltWuQI+r1oYfPq/AJqMrDoNGPwpZrqgh32IiMtGWg74Zix6xDNQEYSUWGZt+CdCl
         SRE53ZjKcDV785yVa0v144lvcHbsCzoJIfNIKJ9glIoidvgplsb9r8Ug2pC0cGv0BSu3
         Y8GsprXcdJBWDrm+6mwlzHurO+TsNgb8HvPReULYV4do2uFfzG/n9lgeHAg3ewqELkQu
         yLqGc+TpgqbaTwUdkv5Ors6h/wToY/g0h64gpxAZULknP5+idwBVcMmNvbR1zs99xcWe
         ysmUMJ9hiEfCqaaemOstsKO7IEFvI7rTHwupiioqbdtEhVKiWC2CtLhvgno9sszdjSQB
         BLcg==
X-Forwarded-Encrypted: i=1; AKwUvByr2+TV0TmxwjNF0Vz7vg8Pa18/ftqpXsJR2Gd9TMjGUSQx6ouFTWMYGjzWf79SkJ0MpEi9IVacs54rzzW16Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiiLf7slN9gBX5Aa7JJYj9QzhFchT7gYaP5EMblXuySt0X+6kD
	TljWT6pPQZ3sSTYkYAadjuRsYgSC94VzRqSfMMzUVMbz7jxUvLqtJEHA
X-Gm-Gg: AYBFou0RD8259eyFBmFLJnIiC7JDPYoKL2LNhvglyXXei1q/JAvLThLB+fvp82pIDBE
	NkZNXBDCYuQyNPUXe9VJbuVVshqa4F4zSFxT9/Z1UXHSKy5aUmy0BI4b9R/XKjwt7P7xwjD3lTs
	RQeT0HiIDbs1kfirH1Mm4KryKbsd9w8x1XMuBFi9J2UmEXC3yjkGwL9K9t8++6JRQVsNnosMCun
	NOd51Jgdv3q1nhdiRPymtvUZbY6y/RF6nJQDOO4pOJOuv9YuFa85I+53+ViLyEjyTpy1WPSMCwE
	uM7a0yxO4k0A87GJ4XsGSZxx3e0B0txcebQPO+4nEnUEbhw/wqfNvqDY6cUFElxEOa02hfyKa/j
	a5lB67LLoTc6cEd/PXCLHZJXznOsmsSGSj0zmce7OET6nAoivaOABLHihUj+zKJyfRegWnqGV4M
	84ydX/GvK9zFlNGitg1TzbkCqARHD6d8+fyBADzGEZgk/856+VWxDlsJ+zsQr5kIWUYb63ec3tl
	wpmGOZKVvomEl0LO4iapkZuyHOlUgOcu1Ua5KvvphYgqrpk4YaYSeFr
X-Received: by 2002:a05:6512:3e20:b0:5bc:ddab:b793 with SMTP id 2adb3069b0e04-5bcde8cb6d0mr3744622e87.53.1791839297959;
        Mon, 12 Oct 2026 14:08:17 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcddecc3d7sm3083561e87.81.2026.10.12.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:08:17 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
In-Reply-To: <as1Dl08DwxOu-boF@monoceros>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>
 <as1Dl08DwxOu-boF@monoceros>
Date: Mon, 12 Oct 2026 23:57:33 +0300
Message-ID: <179183865387.2445720.12278001692808149938@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

Hello Uwe,

On Mon, Oct 12, 2026 at 10:32:58PM +0200, Uwe Kleine-König wrote:
> On Mon, Oct 12, 2026 at 08:32:59PM +0300, Fil Dunsky wrote:
> > +#include <linux/mod_devicetable.h>
>
> Please don't include this file. It contains a plethora of defines for
> subsystems not in use here.
>
> > [...]
> > +#include <linux/platform_device.h>
>
> You can rely on <linux/platform_device.h> to yield definitions for
> of_device_id and so drop <linux/mod_devicetable.h> without a
> replacement.
>
> The same applies to patches 6 and 7.

Thanks, dropped from the GPIO, I2C and watchdog drivers for v2.

Best regards,
Fil

