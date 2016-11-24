Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38039 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966044AbcKXPpC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 Nov 2016 10:45:02 -0500
Date: Thu, 24 Nov 2016 07:45:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Subject: Re: watchdog: Standardize leading tabs and spaces in Kconfig file
Message-ID: <20161124154500.GA8706@roeck-us.net>
References: <alpine.LFD.2.20.1610160808580.25776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1610160808580.25776@localhost.localdomain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Oct 16, 2016 at 08:10:37AM -0400, Robert P. J. Day wrote:
> Replace small number of lines using leading spaces with proper leading
> tabs and spaces -- purely an aesthetic fix.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fdd3228..97bf4c2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -72,16 +72,16 @@ config SOFT_WATCHDOG
>  	  module will be called softdog.
> 
>  config DA9052_WATCHDOG
> -        tristate "Dialog DA9052 Watchdog"
> -        depends on PMIC_DA9052
> -        select WATCHDOG_CORE
> -        help
> -          Support for the watchdog in the DA9052 PMIC. Watchdog trigger
> -          cause system reset.
> +	tristate "Dialog DA9052 Watchdog"
> +	depends on PMIC_DA9052
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the DA9052 PMIC. Watchdog trigger
> +	  cause system reset.
> 
> -          Say Y here to include support for the DA9052 watchdog.
> -          Alternatively say M to compile the driver as a module,
> -          which will be called da9052_wdt.
> +	  Say Y here to include support for the DA9052 watchdog.
> +	  Alternatively say M to compile the driver as a module,
> +	  which will be called da9052_wdt.
> 
>  config DA9055_WATCHDOG
>  	tristate "Dialog Semiconductor DA9055 Watchdog"
> @@ -1623,16 +1623,16 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
>  	  The value can be overridden by the wdt_period command-line parameter.
> 
>  config MEN_A21_WDT
> -       tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
> -       select WATCHDOG_CORE
> -       depends on GPIOLIB || COMPILE_TEST
> -       help
> -        Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
> +	tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
> +	select WATCHDOG_CORE
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
> 
> -	The driver can also be built as a module. If so, the module will be
> -	called mena21_wdt.
> +	  The driver can also be built as a module. If so, the module will be
> +	  called mena21_wdt.
> 
> -	If unsure select N here.
> +	  If unsure select N here.
> 
>  # PPC64 Architecture
