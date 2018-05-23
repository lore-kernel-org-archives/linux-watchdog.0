Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43075 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933083AbeEWW3T (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 May 2018 18:29:19 -0400
Date: Wed, 23 May 2018 15:29:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180523222915.GA16779@roeck-us.net>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
 <1527107527-8093-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527107527-8093-3-git-send-email-ray.jui@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 23, 2018 at 01:32:03PM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> index de93a4d..9cd7470 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> @@ -18,6 +18,8 @@ Required properties:
>  
>  Optional properties:
>  - interrupts : Should specify WDT interrupt number.
> +timeout-sec : Should specify default WDT timeout in seconds. If unset, the
> +              default timeout in the driver is 30 seconds

That looks odd, with the changed indentation and the missing '-'
in front of 'timeout-sec'.

Guenter
