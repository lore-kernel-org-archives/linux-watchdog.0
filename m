Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 14 Sep 2016 15:16:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org,
        lee.jones@linaro.org, wim@iguana.be, robh+dt@kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/19] watchdog: bindings: Remove obsolete platforms from
 dt doc.
Message-ID: <20160914221609.GE14003@roeck-us.net>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 14, 2016 at 02:27:48PM +0100, Peter Griffin wrote:
> STiH415/6 SoC support is being removed from the kernel
> so update the dt bding document to reflect this.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <wim@iguana.be>
> Cc: <linux@roeck-us.net>
> Cc: <robh+dt@kernel.org>
> Cc: <linux-watchdog@vger.kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> index 039c5ca..b949039 100644
> --- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> @@ -9,8 +9,7 @@ functionality.
>  
>  Required properties
>  
> -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> -				  "st,stih415-lpc" "st,stid127-lpc"
> +- compatible 	: Should be: "st,stih407-lpc"
>  - reg		: LPC registers base address + size
>  - interrupts    : LPC interrupt line number and associated flags
>  - clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
> -- 
> 1.9.1
> 
