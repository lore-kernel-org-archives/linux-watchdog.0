Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 May 2013 09:17:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: dirk.eibach@gdsys.cc
Cc: linux-kernel@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] powerpc: Make Book E watchdog reset type configurable
Message-ID: <20130502161720.GA7797@roeck-us.net>
References: <1367505913-18970-1-git-send-email-dirk.eibach@gdsys.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367505913-18970-1-git-send-email-dirk.eibach@gdsys.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, May 02, 2013 at 04:45:13PM +0200, dirk.eibach@gdsys.cc wrote:
> From: Dirk Eibach <dirk.eibach@gdsys.cc>
> 
> Signed-off-by: Dirk Eibach <dirk.eibach@gdsys.cc>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/Kconfig     |   32 ++++++++++++++++++++++++++++++++
>  drivers/watchdog/booke_wdt.c |   10 +++++++++-
>  2 files changed, 41 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e89fc31..6048593 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1172,6 +1172,38 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
>  
>  	  The value can be overridden by the wdt_period command-line parameter.
>  
> +choice
> +	prompt "PowerPC Book-E Watchdog reset type"
> +	depends on BOOKE_WDT
> +	default BOOKE_WDT_RESET_CHIP
> +	help
> +	  Specify what kind of reset will be executed on watchdog timeout.
> +
Seems to me it would be much better to make this configurable via platform data 
and/or device tree.

Guenter
