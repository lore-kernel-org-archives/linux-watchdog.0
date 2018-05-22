Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60190 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeEVU4E (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 22 May 2018 16:56:04 -0400
Date: Tue, 22 May 2018 13:56:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180522205602.GB16363@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 22, 2018 at 11:47:16AM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> index edc4f0e..f898a86 100644
> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> @@ -19,6 +19,8 @@ Required properties:
>  
>  Optional properties:
>  - interrupts : Should specify WDT interrupt number.
> +- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
> +                default timeout is 30 seconds
>  
>  Examples:
>  
> -- 
> 2.1.4
> 
