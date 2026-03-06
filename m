Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC117DFE7
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Mar 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840019; cv=none; b=k1XwdfBq4FIqqlWVEVxkn2L6rvcaARidE9aLEtdHei2F8h1JzcSKt+V2uMC5xNQHUYUgx0WzTah8YiaR6gIQU40tZcnb8y8U/wQAB44aQSJHGiS6EFuDFS+3CqtP5vZ/SzDflZSHQqSF5cxgEIgRyT9zhX8XnrBDJBkzNVZyK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840019; c=relaxed/simple;
	bh=plzyiDYL13gMDVwQr9Dj9f8cir0m0t5cKB6vFZUg2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuEi0i166b9jt/89/fKAOEPLAW1bJ1/H7zL1b3/nRfiK3Q7Xu56OMzNWIyEM8XCaRj6cdVi2ipKB1a47SkOcYQ6jqz+mhQc3kkJjp2xrYR41NrbKnpSsKaRWiu1oghBvx4iOTz6Ng+mMgpoyfiF2FaSUbll4mrru1IglLflaZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/wZENZC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/wZENZC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35980423087so3336477a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Mar 2026 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840018; x=1773444818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=N/wZENZCtnWx8XFZ0kyLD+P1jMXI1eOOU4pu38Tub9fp/sFNmGx7bJ6qd13qqxBcd+
         9FxIPe26xE++UcdJThW6DFIdREb7TCRSAGOjb6V8a0HCiCpU70tT95TNpuRqal93lshz
         5vU67DX3D6ChDH+R/zzpwpvbFk9gPuz7Wg+Km8g8Aon1r5rnFJ+/xXlE6pXG9Qg34Thq
         pZBOW1J0CnrWpASKBSjPOtVzyascg0vhc/yEqdDpDvuXRBOa5tzst5rcOBdoft+lriaU
         kTtCKnDMNFjElDDX52pUfaqOQSWk4znRHWesOW63O4+fQLkSSIyQFUsNy094v+Vog9su
         GUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840018; x=1773444818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=WMLh/R2hUEt9AJzjS3myriojdrKYTp7e4xHX/3ExMrGxB44FAXgiU+FfPfsa1IzAbC
         Lc0CK11NNGa0Pl1CIvQqPWmcmI8rQcy43ZRe52bWDAfVeGjRQZoWZotULkN2ULm7c/X2
         ZR6mM+vGnvAjyOKlFMtHoa5lMuJrF7f4GEjuNTL77lS4oxuFIwxq5fgH39BH6sVP5l4m
         hIKZk0Ti6xawcxH1b1G8qtRdzOpHNkObfDpZ86+HKcNiACx5dCJyrHUwgzCQuZba72TP
         iSkLvp1jKobpK6Bw1CmXdc997mSjm55svj3mED6Tjo4fY3NpkslDJpaiDbCw/P/52uTZ
         N8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSGGhfmP6mRMVzl0KKQh8S9kWpQoURuLJpOempSYhwUxet26WgkOFP+c+bKyPcfr3d2XIIeL/HFwywhO3mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYplglgIikElyIPNcr0x8isC42aj3YiKQ8RTf0oM7a4/iJLEUD
	ZrHyaBdo+LWVHFMRAHIVRF9fokA5l5jLr2/aaLpOO4uWuoylSG3eqtVB
X-Gm-Gg: ATEYQzwfU1f0AHyp2mLVN7SRp/rhM9o3DEN5gh8jSjJDiFuvrLW7EPRJfZYW1VqfCCE
	9pesACdfili3ok6hkAQyKObeKuvQz/bAkrVCVNFOo4AL3a2A4YFFF3vCN48L34dFvgVnj9v/JC4
	OKORl6/7U18IGoX36ZcqN+c/43PDLlZUnuRXA8KL8LGIaI8NTOvw6W11AY5q9GY83JZs6HGxHfx
	buoDTmAKJO+2kOO38gMTAFbLe/6nDLicQoKN03b7x9feCWv4TcorM8ZjHr59+V1hLq9iFlWhw3e
	IS5VF4vrjj0qMghHAqOYq13HrmFdYB1Q46KFCnV+PC9BmuRi+sxi/x83LEXGq3bbCaPCaMOtcUE
	l96BzMk7JSpSBY1BB//K+8qWBz7oIXa0UjD+4PP48Lv/5dF8Pr6hZ7MXwA/Kq0QIBz+7PUa4WSz
	Fr+M67KQBwNqCKtC28iQQRCQP/GuukW7ehrjXQ
X-Received: by 2002:a17:90b:38c4:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-359be31746amr3476775a91.24.1772840017833;
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de79f6sm6579296a91.9.2026.03.06.15.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 15:33:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/14] watchdog: convert the Kconfig dependency on
 OF_GPIO to OF
Message-ID: <07aa5d40-96b6-41a1-b8ce-22f2c2c94aed@roeck-us.net>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>

On Wed, Mar 04, 2026 at 10:02:31AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it

Actually, that isn't really true.

if GPIOLIB
...
config OF_GPIO
        def_bool y
        depends on OF
        depends on HAS_IOMEM

OF_GPIO also depends on GPIOLIB and HAS_IOMEM. I don't know why it needs
to depend on HAS_IOMEM, but the GPIOLIB dependency is real.

Guenter

> controls also provide stubs so there's really no reason to select it
> explicitly. We could simply remove the dependency but in order to avoid
> a new symbol popping up for everyone in make config - just convert it to
> requiring CONFIG_OF.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>  
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on OF
>  	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog device
