Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744425;
	b=0cfNTkKpsT6YTAusLmd8JdvHihe0DI/b2c0ZENZL2suKn4lmwDRoMmfzF3zOOD7hMMif
	 lQN1HoauoQPsp1WwAN9z40Ql5P4fg92mdyUkf35dlgR1xjYnjaYXdfO5WOHyUg/ZF9KZP
	 xPRplpoD5ckU2qZqtPkkrmDGL8elXctL2FJjCp9ORWvAI5fj+L/CaOzoQ8tioH3rATlhK
	 2uGPCXYcvxBB/dhU+vLyVyjrBvf/SAPievPhBVX81QJyeuFuFrkDzfOK8mpR55ZPl9HUz
	 ggv1IqIPy584Xg7eM8awiy/HE6GeIr/pV+R8/tK4GN1W9gC+uD2XrInkdWmMzLtgPNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744425;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=njVjUl4hfH0EVJDDjNIsGJyGAEQpeev5QhDFleOIfKg=;
	b=R0iblLRYtq6O/pBWGy+uMgCLCpu3PpZc1xz93mZ7v6suyBpQg5lOyaSTuo/lJjESxXhm
	 9V41vAyM8GdMT2fLHvKu0soMO0fPL2J6UAXN7+mlZjGPaz9SZNYIe7psAYJys9ttrl0mR
	 qGgKWGLgzA5nWAwdxF4znjScOpPhYnq5j9RFbKbI8qDQ+H1AFAQtaHU/2CsLahQBBPQVa
	 uN69go/afmDLb95YgkpfiWAcyWyO0I6Wus7jMFfVr5uQSdCUoyrIgQ/TdC6Gr1BjO6aRR
	 Hwo9GQX6iVW1bBpe0ZsC5qga0kW2kf+uNWqlFjDTBFj3OxGzMmEA83ckaLej8pNh9bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF6606A31A;
	Fri, 23 Oct 2026 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xKAiV-00019Y-00; Fri, 23 Oct 2026 10:33:35 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id F24C3C0423; Fri, 23 Oct 2026 10:26:53 +0200 (CEST)
Date: Fri, 23 Oct 2026 10:26:53 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 4/5] MIPS: Alchemy: Use the GPIO watchdog driver on MTX-1
Message-ID: <atsaTfcvlrV_EEcK@alpha.franken.de>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-5-f.fainelli@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016221617.2223004-5-f.fainelli@gmail.com>

On Fri, Oct 16, 2026 at 03:16:16PM -0700, Florian Fainelli wrote:
> The MTX-1 watchdog is serviced by toggling GPIO 215. Describe its toggle
> algorithm and 1.6-second minimum interval through the existing software
> node properties, and register gpio-wdt instead of mtx1-wdt.
> 
> The nominal 100-second circuit reset the test board about 82 seconds after
> starting an unclean-close test over the serial console. Allow for circuit
> tolerance and console transmission time with a conservative 70-second
> hardware service margin. Keep a 100-second initial userspace timeout and
> let the core schedule keepalives for the longer userspace timeout.
> 
> Mark the watchdog always-running so the core services it before userspace
> opens the device and after a clean stop, without trying to disable the
> hardware by tristating the GPIO. Enable GPIO_WATCHDOG in the MTX-1
> defconfig.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/alchemy/board-mtx1.c   | 8 +++++++-
>  arch/mips/configs/mtx1_defconfig | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
> index 88c20c0ca96d..8543ae42af92 100644
> --- a/arch/mips/alchemy/board-mtx1.c
> +++ b/arch/mips/alchemy/board-mtx1.c
> @@ -125,13 +125,19 @@ static void __init mtx1_keys_init(void)
>  }
>  
>  static const struct property_entry mtx1_wdt_props[] = {
> +	PROPERTY_ENTRY_STRING("hw_algo", "toggle"),
> +	/* Allow for tolerance in the nominal 100-second timeout. */
> +	PROPERTY_ENTRY_U32("hw_margin_ms", 70000),
> +	PROPERTY_ENTRY_U32("hw-min-interval-ms", 1600),
> +	PROPERTY_ENTRY_U32("timeout-sec", 100),
> +	PROPERTY_ENTRY_BOOL("always-running"),
>  	/* Global number 215 is offset 15 on Alchemy GPIO 2 */
>  	PROPERTY_ENTRY_GPIO("gpios", &alchemy_gpio2_node, 15, GPIO_ACTIVE_HIGH),
>  	{ }
>  };
>  
>  static const struct platform_device_info mtx1_wdt_info __initconst = {
> -	.name = "mtx1-wdt",
> +	.name = "gpio-wdt",
>  	.id = 0,
>  	.properties = mtx1_wdt_props,
>  };
> diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
> index e28a0b1e6d52..5e060daded9d 100644
> --- a/arch/mips/configs/mtx1_defconfig
> +++ b/arch/mips/configs/mtx1_defconfig
> @@ -377,7 +377,7 @@ CONFIG_SENSORS_W83627HF=m
>  CONFIG_SENSORS_W83627EHF=m
>  CONFIG_WATCHDOG=y
>  CONFIG_WATCHDOG_NOWAYOUT=y
> -CONFIG_WDT_MTX1=y
> +CONFIG_GPIO_WATCHDOG=y
>  # CONFIG_VGA_ARB is not set
>  # CONFIG_LCD_CLASS_DEVICE is not set
>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
> -- 
> 2.53.0
> 

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
